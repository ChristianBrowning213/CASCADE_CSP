#!/usr/bin/env bash
set -euo pipefail

WORKSPACE_SERVER_PATH="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../mcp_servers_and_tools/workspace_server" && pwd)}"

echo "Building workspace server at ${WORKSPACE_SERVER_PATH}"
cd "${WORKSPACE_SERVER_PATH}"
npm install
npm run build

if [[ ! -f "build/index.js" ]]; then
  echo "Build failed: missing artifact build/index.js" >&2
  exit 1
fi

echo "Build complete: ${WORKSPACE_SERVER_PATH}/build/index.js"
