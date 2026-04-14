param(
    [string]$WorkspaceServerPath = ""
)

$ErrorActionPreference = "Stop"

if (-not $WorkspaceServerPath) {
    $WorkspaceServerPath = Join-Path $PSScriptRoot "..\..\..\mcp_servers_and_tools\workspace_server"
}

$ResolvedPath = (Resolve-Path $WorkspaceServerPath).Path
$BuildArtifact = Join-Path $ResolvedPath "build\index.js"

if (-not (Test-Path $BuildArtifact)) {
    throw "Missing build artifact: $BuildArtifact"
}

Write-Host "Workspace build artifact found: $BuildArtifact"
