# CASCADE MCP Pack

Packaging layer for CASCADE MCP servers with stable IDs, stable entrypoints, and LLMCSP-ready local path integration.

## Included servers

1. `cascade-memory` (Python wrapper)
2. `cascade-research` (Python wrapper)
3. `cascade-workspace` (Node upstream build/run docs + scripts)
4. `cascade-tavily` is documented as an external dependency (not bundled here)

## Stable server IDs and entrypoints

- `cascade-memory`: `python -m cascade_memory_mcp.server`
- `cascade-research`: `python -m cascade_research_mcp.server`
- `cascade-workspace`: `node <CASCADE>/mcp_servers_and_tools/workspace_server/build/index.js`

## Phase 0 survey baseline

Upstream source trees used by this pack:

- `mcp_servers_and_tools/memory_server`
  - `.env.example`
  - `pyproject.toml`
  - `README.md`
  - `src/memory_mcp.py`
- `mcp_servers_and_tools/research_server`
  - `.env.example`
  - `pyproject.toml`
  - `README.md`
  - `src/research_mcp.py`
  - `src/research_server_utils.py`
- `mcp_servers_and_tools/workspace_server`
  - `package.json`
  - `README.md`
  - `src/index.ts`
  - `build/index.js`

Current upstream entrypoints:

- Memory: `src/memory_mcp.py` (now exposes `main()` and remains script-runnable)
- Research: `src/research_mcp.py` (`async main()` already present)
- Workspace: `build/index.js` after `npm run build`

Upstream env templates:

- `mcp_servers_and_tools/memory_server/.env.example`
- `mcp_servers_and_tools/research_server/.env.example`

## Windows-first quick start

1. Install Python wrappers:
```powershell
powershell -ExecutionPolicy Bypass -File cascade_mcp_pack/scripts/install_python_wrappers.ps1
```
2. Build workspace server:
```powershell
powershell -ExecutionPolicy Bypass -File cascade_mcp_pack/workspace/scripts/build.ps1
```
3. Run wrapper smoke checks:
```powershell
powershell -ExecutionPolicy Bypass -File cascade_mcp_pack/scripts/smoke_test_python_wrappers.ps1
```

## Cross-platform quick start

1. Install Python wrappers:
```bash
bash cascade_mcp_pack/scripts/install_python_wrappers.sh
```
2. Build workspace server:
```bash
bash cascade_mcp_pack/workspace/scripts/build.sh
```
3. Run wrapper smoke checks:
```bash
bash cascade_mcp_pack/scripts/smoke_test_python_wrappers.sh
```

## Smoke test commands per server

- `cascade-memory`
```bash
python -m cascade_memory_mcp.server --help
python -m cascade_memory_mcp.server --check
```
- `cascade-research`
```bash
python -m cascade_research_mcp.server --help
python -m cascade_research_mcp.server --check
```
- `cascade-workspace`
```bash
node -e "require('fs').accessSync('mcp_servers_and_tools/workspace_server/build/index.js')"
```

## LLMCSP integration

See:

- `cascade_mcp_pack/LLMCSP_OVERRIDES_EXAMPLES.md`
- `cascade_mcp_pack/SERVERS.md`

## Directory map

- `cascade_mcp_pack/scripts`: install + smoke helper scripts
- `cascade_mcp_pack/memory`: Python wrapper package for memory server
- `cascade_mcp_pack/research`: Python wrapper package for research server
- `cascade_mcp_pack/workspace`: Node workspace server build/run wrappers and docs
