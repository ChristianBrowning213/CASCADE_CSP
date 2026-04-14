#!/usr/bin/env bash
set -euo pipefail

PACK_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "${PACK_ROOT}/.." && pwd)"

export CASCADE_REPO_ROOT="${REPO_ROOT}"

echo "Smoke test: cascade-memory help"
python -m cascade_memory_mcp.server --help >/dev/null

echo "Smoke test: cascade-research help"
python -m cascade_research_mcp.server --help >/dev/null

echo "Python wrapper smoke tests passed."
