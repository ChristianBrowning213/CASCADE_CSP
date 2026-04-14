# cascade-workspace MCP packaging notes

`cascade-workspace` uses the existing upstream Node server as source of truth:
`mcp_servers_and_tools/workspace_server`

## Build (Windows)

```powershell
powershell -ExecutionPolicy Bypass -File cascade_mcp_pack/workspace/scripts/build.ps1
```

## Build (Linux/macOS)

```bash
bash cascade_mcp_pack/workspace/scripts/build.sh
```

## Run (Windows)

```powershell
powershell -ExecutionPolicy Bypass -File cascade_mcp_pack/workspace/scripts/run.ps1
```

## Run (Linux/macOS)

```bash
bash cascade_mcp_pack/workspace/scripts/run.sh
```

## Required environment variables

- `PROJECT_ROOT`: absolute project/workspace root path
- `CODE_STORAGE_DIR`: generated code directory
- `SAVED_FILES_DIR`: directory used by `save_file`
- `FORBIDDEN_PATH`: path blocked from workspace agent access

## Python environment selector (workspace server behavior)

- `ENV_TYPE`: one of `conda`, `venv`, `venv-uv`
- `CONDA_ENV_NAME`: required when `ENV_TYPE=conda`
- `VENV_PATH`: required when `ENV_TYPE=venv`
- `UV_VENV_PATH`: required when `ENV_TYPE=venv-uv`

## Recommended values for LLMCSP

- `PROJECT_ROOT=<llmcsp_workspace_root>`
- `CODE_STORAGE_DIR=<llmcsp_workspace_root>/generated_code`
- `SAVED_FILES_DIR=<llmcsp_workspace_root>/saved_files`
- `FORBIDDEN_PATH=<llmcsp_workspace_root>/orchestrator`
- `ENV_TYPE=venv` (or your preferred supported type)

## Build smoke check

After building, verify artifact presence:

```bash
bash cascade_mcp_pack/workspace/scripts/check-build.sh
# or on Windows:
powershell -ExecutionPolicy Bypass -File cascade_mcp_pack/workspace/scripts/check-build.ps1
```
