$ErrorActionPreference = "Stop"

$PackRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$RepoRoot = (Resolve-Path (Join-Path $PackRoot "..")).Path

$env:CASCADE_REPO_ROOT = $RepoRoot

Write-Host "Smoke test: cascade-memory help"
python -m cascade_memory_mcp.server --help | Out-Null

Write-Host "Smoke test: cascade-research help"
python -m cascade_research_mcp.server --help | Out-Null

Write-Host "Python wrapper smoke tests passed."
