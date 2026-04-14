# cascade-memory MCP wrapper

Thin wrapper package for CASCADE's upstream memory server at:
`mcp_servers_and_tools/memory_server/src/memory_mcp.py`

## Entrypoint

```bash
python -m cascade_memory_mcp.server
```

## Notes

- This package does not fork memory logic. It delegates execution to upstream CASCADE code.
- Set `CASCADE_REPO_ROOT` when running outside the CASCADE repository checkout.

## Quick checks

```bash
python -m cascade_memory_mcp.server --help
python -m cascade_memory_mcp.server --check
```
