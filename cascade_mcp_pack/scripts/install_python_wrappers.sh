#!/usr/bin/env bash
set -euo pipefail

PACK_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MEMORY_PATH="${PACK_ROOT}/memory"
RESEARCH_PATH="${PACK_ROOT}/research"

echo "Installing cascade-memory wrapper from ${MEMORY_PATH}"
python -m pip install -e "${MEMORY_PATH}"

echo "Installing cascade-research wrapper from ${RESEARCH_PATH}"
python -m pip install -e "${RESEARCH_PATH}"

echo "Python wrappers installed."
