# LLMCSP override examples

Copy the JSON into `~/.llmcsp/mcp_overrides.json` and replace placeholders.

## Local-path overrides

```json
{
  "cascade-memory": {
    "source": {
      "type": "path",
      "path": "C:/path/to/CASCADE/cascade_mcp_pack/memory"
    },
    "install": {
      "kind": "python"
    },
    "entrypoint": ["python", "-m", "cascade_memory_mcp.server"],
    "env": {
      "CASCADE_REPO_ROOT": "C:/path/to/CASCADE",
      "OPENAI_API_KEY": "...",
      "SUPABASE_DATABASE_URL": "postgresql://...",
      "NEO4J_URI": "bolt://localhost:7687",
      "NEO4J_USER": "neo4j",
      "NEO4J_PASSWORD": "...",
      "ENABLE_GRAPH_MEMORY": "true"
    }
  },
  "cascade-research": {
    "source": {
      "type": "path",
      "path": "C:/path/to/CASCADE/cascade_mcp_pack/research"
    },
    "install": {
      "kind": "python"
    },
    "entrypoint": ["python", "-m", "cascade_research_mcp.server"],
    "env": {
      "CASCADE_REPO_ROOT": "C:/path/to/CASCADE",
      "OPENAI_API_KEY": "...",
      "SUPABASE_URL": "...",
      "SUPABASE_SERVICE_KEY": "...",
      "SUPABASE_DATABASE_URL": "...",
      "USE_KNOWLEDGE_GRAPH": "false",
      "TRANSPORT": "stdio"
    }
  },
  "cascade-workspace": {
    "source": {
      "type": "path",
      "path": "C:/path/to/CASCADE/mcp_servers_and_tools/workspace_server"
    },
    "install": {
      "kind": "node"
    },
    "entrypoint": [
      "node",
      "C:/path/to/CASCADE/mcp_servers_and_tools/workspace_server/build/index.js"
    ],
    "env": {
      "PROJECT_ROOT": "C:/Users/<you>/.llmcsp/workspaces/default",
      "CODE_STORAGE_DIR": "C:/Users/<you>/.llmcsp/workspaces/default/generated_code",
      "SAVED_FILES_DIR": "C:/Users/<you>/.llmcsp/workspaces/default/saved_files",
      "FORBIDDEN_PATH": "C:/Users/<you>/.llmcsp/workspaces/default/orchestrator",
      "ENV_TYPE": "venv",
      "VENV_PATH": "C:/Users/<you>/.llmcsp/venv"
    }
  }
}
```

## Notes

- `CASCADE_REPO_ROOT` is recommended for `cascade-memory` and `cascade-research` wrappers so they can locate upstream CASCADE server code robustly.
- For `cascade-workspace`, run `npm run build` in `mcp_servers_and_tools/workspace_server` before first launch.
