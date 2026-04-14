# CASCADE MCP servers: env schema + tools

## `cascade-memory`

Entrypoint: `python -m cascade_memory_mcp.server`

Required env vars:

- `OPENAI_API_KEY`
- `SUPABASE_DATABASE_URL`

Optional env vars:

- `MEM0_USE_LLM` (default `true`)
- `MEM0_LLM_MODEL` (default `gpt-4o-mini`)
- `ENABLE_GRAPH_MEMORY` (default `true`)
- `NEO4J_URI` (required only when graph memory enabled)
- `NEO4J_USER` (required only when graph memory enabled)
- `NEO4J_PASSWORD` (required only when graph memory enabled)
- `HOST` (default `127.0.0.1`)
- `PORT` (default `8053`)
- `CASCADE_REPO_ROOT` (recommended when running outside repo checkout)

Exposed tools:

- `search_memory`
- `save_to_memory`

## `cascade-research`

Entrypoint: `python -m cascade_research_mcp.server`

Required env vars:

- `OPENAI_API_KEY`
- `SUPABASE_URL`
- `SUPABASE_SERVICE_KEY`

Optional env vars:

- `TRANSPORT` (upstream default behavior is `sse` if unset)
- `HOST` (default `127.0.0.1`)
- `PORT` (default `8052`)
- `OPENAI_EMBEDDING_MODEL`
- `OPENAI_SUMMARY_MODEL`
- `GENERATE_CODE_SUMMARY`
- `USE_KNOWLEDGE_GRAPH` (`true`/`false`)
- `NEO4J_URI` (required only when `USE_KNOWLEDGE_GRAPH=true`)
- `NEO4J_USER` (required only when `USE_KNOWLEDGE_GRAPH=true`)
- `NEO4J_PASSWORD` (required only when `USE_KNOWLEDGE_GRAPH=true`)
- `CASCADE_REPO_ROOT` (recommended when running outside repo checkout)

Exposed tools:

- `extract_code_from_url`
- `retrieve_extracted_code`
- `quick_introspect`
- `runtime_probe_snippet`
- `parse_local_package`
- `query_knowledge_graph`

## `cascade-workspace`

Entrypoint:
`node <CASCADE>/mcp_servers_and_tools/workspace_server/build/index.js`

Required env vars:

- `PROJECT_ROOT`
- `FORBIDDEN_PATH`
- `CODE_STORAGE_DIR`
- `SAVED_FILES_DIR`
- `ENV_TYPE` (`conda`, `venv`, or `venv-uv`)

Environment-specific required vars:

- If `ENV_TYPE=conda`: `CONDA_ENV_NAME`
- If `ENV_TYPE=venv`: `VENV_PATH`
- If `ENV_TYPE=venv-uv`: `UV_VENV_PATH`

Exposed tools:

- `execute_code`
- `read_file`
- `install_dependencies`
- `check_installed_packages`
- `check_package_version`
- `save_file`
- `execute_shell_command`
- `create_and_execute_script`

## Optional external server: `cascade-tavily`

This pack does not bundle Tavily. Use an external MCP server/wrapper and add it through LLMCSP overrides with its own API key and install flow.
