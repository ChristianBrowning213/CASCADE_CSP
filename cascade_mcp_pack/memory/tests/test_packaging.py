import os
import subprocess
import sys
from pathlib import Path


WRAPPER_ROOT = Path(__file__).resolve().parents[1]
WRAPPER_SRC = WRAPPER_ROOT / "src"
REPO_ROOT = Path(__file__).resolve().parents[4]
if str(WRAPPER_SRC) not in sys.path:
    sys.path.insert(0, str(WRAPPER_SRC))


def _subprocess_env() -> dict[str, str]:
    env = os.environ.copy()
    existing_pythonpath = env.get("PYTHONPATH", "")
    env["PYTHONPATH"] = str(WRAPPER_SRC) + (os.pathsep + existing_pythonpath if existing_pythonpath else "")
    env["CASCADE_REPO_ROOT"] = str(REPO_ROOT)
    return env


def test_wrapper_module_importable():
    import cascade_memory_mcp.server as server

    assert callable(server.main)


def test_help_flag():
    env = _subprocess_env()
    result = subprocess.run(
        [sys.executable, "-m", "cascade_memory_mcp.server", "--help"],
        capture_output=True,
        text=True,
        env=env,
    )
    assert result.returncode == 0
    assert "usage:" in result.stdout.lower()


def test_missing_env_is_friendly():
    env = _subprocess_env()
    env.pop("OPENAI_API_KEY", None)
    env.pop("SUPABASE_DATABASE_URL", None)
    result = subprocess.run(
        [sys.executable, "-m", "cascade_memory_mcp.server"],
        capture_output=True,
        text=True,
        env=env,
    )
    assert result.returncode == 2
    assert "Missing required environment variables" in result.stderr
    assert "Traceback" not in result.stderr
