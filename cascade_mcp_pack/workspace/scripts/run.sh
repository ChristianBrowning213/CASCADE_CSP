#!/usr/bin/env bash
set -euo pipefail

WORKSPACE_SERVER_PATH="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../mcp_servers_and_tools/workspace_server" && pwd)}"
ENTRYPOINT="${WORKSPACE_SERVER_PATH}/build/index.js"

if [[ ! -f "${ENTRYPOINT}" ]]; then
  echo "Missing build artifact: ${ENTRYPOINT}. Run build.sh first." >&2
  exit 1
fi

echo "Starting workspace server: ${ENTRYPOINT}"
node "${ENTRYPOINT}" "${@:2}"
