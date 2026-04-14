#!/usr/bin/env bash
set -euo pipefail

WORKSPACE_SERVER_PATH="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../mcp_servers_and_tools/workspace_server" && pwd)}"
BUILD_ARTIFACT="${WORKSPACE_SERVER_PATH}/build/index.js"

if [[ ! -f "${BUILD_ARTIFACT}" ]]; then
  echo "Missing build artifact: ${BUILD_ARTIFACT}" >&2
  exit 1
fi

echo "Workspace build artifact found: ${BUILD_ARTIFACT}"
