"""Stable wrapper entrypoint for CASCADE research MCP server."""

from __future__ import annotations

import argparse
import asyncio
import importlib.util
import inspect
import os
import sys
from pathlib import Path
from typing import Iterable

try:
    from dotenv import load_dotenv
except Exception:  # pragma: no cover - optional fallback for minimal environments
    load_dotenv = None


_UPSTREAM_RELATIVE_PATH = Path("mcp_servers_and_tools/research_server/src/research_mcp.py")
_REQUIRED_ENV_VARS = ("OPENAI_API_KEY", "SUPABASE_URL", "SUPABASE_SERVICE_KEY")


def _candidate_repo_roots() -> Iterable[Path]:
    explicit_root = os.getenv("CASCADE_REPO_ROOT")
    if explicit_root:
        yield Path(explicit_root).expanduser().resolve()

    cwd = Path.cwd().resolve()
    yield cwd
    yield from cwd.parents

    current_file = Path(__file__).resolve()
    yield from current_file.parents


def _find_upstream_server() -> tuple[Path | None, Path | None]:
    seen: set[Path] = set()
    for candidate in _candidate_repo_roots():
        if candidate in seen:
            continue
        seen.add(candidate)
        upstream_file = candidate / _UPSTREAM_RELATIVE_PATH
        if upstream_file.exists():
            return candidate, upstream_file
    return None, None


def _load_optional_env_files(repo_root: Path) -> None:
    if load_dotenv is None:
        return

    possible_env_files = (
        repo_root / ".env",
        repo_root / "mcp_servers_and_tools/research_server/.env",
    )
    for env_file in possible_env_files:
        if env_file.exists():
            load_dotenv(env_file, override=False)


def _missing_required_env_vars() -> list[str]:
    return [name for name in _REQUIRED_ENV_VARS if not os.getenv(name)]


def _load_upstream_module(upstream_file: Path):
    spec = importlib.util.spec_from_file_location("cascade_upstream_research_mcp", upstream_file)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"Unable to load upstream module spec from {upstream_file}")

    module = importlib.util.module_from_spec(spec)
    original_sys_path = list(sys.path)
    sys.path.insert(0, str(upstream_file.parent))
    try:
        spec.loader.exec_module(module)
    finally:
        sys.path[:] = original_sys_path
    return module


def _run_upstream(upstream_file: Path) -> int:
    module = _load_upstream_module(upstream_file)
    main_func = getattr(module, "main", None)

    if callable(main_func):
        result = main_func()
        if inspect.isawaitable(result):
            asyncio.run(result)
    else:
        raise RuntimeError(
            "Upstream research server does not expose main(); "
            "expected callable main in research_mcp.py."
        )
    return 0


def run(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        prog="cascade-research",
        description="Run the CASCADE research MCP server via a stable wrapper.",
    )
    parser.add_argument(
        "--check",
        action="store_true",
        help="Validate wrapper configuration and exit.",
    )
    parser.add_argument(
        "--print-upstream-path",
        action="store_true",
        help="Print detected upstream server path and exit.",
    )
    args = parser.parse_args(argv)

    repo_root, upstream_file = _find_upstream_server()
    if upstream_file is None:
        sys.stderr.write(
            "Unable to locate upstream research server. "
            "Set CASCADE_REPO_ROOT to your CASCADE checkout path.\n"
        )
        return 2

    if args.print_upstream_path:
        print(str(upstream_file))
        return 0

    if repo_root is not None:
        _load_optional_env_files(repo_root)

    missing_vars = _missing_required_env_vars()
    if missing_vars:
        missing_msg = ", ".join(missing_vars)
        sys.stderr.write(
            f"Missing required environment variables: {missing_msg}. "
            "Populate a .env file or shell environment before starting cascade-research.\n"
        )
        return 2

    if args.check:
        print("cascade-research wrapper check: OK")
        return 0

    try:
        return _run_upstream(upstream_file)
    except ModuleNotFoundError as exc:
        sys.stderr.write(
            f"Missing Python dependency: {exc.name}. "
            "Install wrapper dependencies first (pip install -e cascade_mcp_pack/research).\n"
        )
        return 2
    except Exception as exc:  # pragma: no cover - defensive for runtime startup failures
        sys.stderr.write(f"Failed to start cascade-research: {exc}\n")
        return 2


def main() -> int:
    return run()


if __name__ == "__main__":
    raise SystemExit(main())
