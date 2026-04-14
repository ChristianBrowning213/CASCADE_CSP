param(
    [string]$WorkspaceServerPath = "",
    [string[]]$NodeArgs = @()
)

$ErrorActionPreference = "Stop"

if (-not $WorkspaceServerPath) {
    $WorkspaceServerPath = Join-Path $PSScriptRoot "..\..\..\mcp_servers_and_tools\workspace_server"
}

$ResolvedPath = (Resolve-Path $WorkspaceServerPath).Path
$Entrypoint = Join-Path $ResolvedPath "build\index.js"
if (-not (Test-Path $Entrypoint)) {
    throw "Missing build artifact: $Entrypoint. Run build.ps1 first."
}

Write-Host "Starting workspace server: $Entrypoint"
node $Entrypoint @NodeArgs
