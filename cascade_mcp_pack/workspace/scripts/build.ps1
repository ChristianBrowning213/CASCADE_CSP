param(
    [string]$WorkspaceServerPath = ""
)

$ErrorActionPreference = "Stop"

if (-not $WorkspaceServerPath) {
    $WorkspaceServerPath = Join-Path $PSScriptRoot "..\..\..\mcp_servers_and_tools\workspace_server"
}

$ResolvedPath = (Resolve-Path $WorkspaceServerPath).Path
Write-Host "Building workspace server at $ResolvedPath"

Push-Location $ResolvedPath
try {
    npm install
    npm run build
    $BuildArtifact = Join-Path $ResolvedPath "build\index.js"
    if (-not (Test-Path $BuildArtifact)) {
        throw "Build failed: missing artifact $BuildArtifact"
    }
    Write-Host "Build complete: $BuildArtifact"
}
finally {
    Pop-Location
}
