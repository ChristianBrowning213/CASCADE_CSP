# cascade-research MCP wrapper

Thin wrapper package for CASCADE's upstream research server at:
`mcp_servers_and_tools/research_server/src/research_mcp.py`

## Entrypoint

```bash
python -m cascade_research_mcp.server
```

## Notes

- This package does not fork research logic. It delegates execution to upstream CASCADE code.
- Set `CASCADE_REPO_ROOT` when running outside the CASCADE repository checkout.

## Quick checks

```bash
python -m cascade_research_mcp.server --help
python -m cascade_research_mcp.server --check
```
