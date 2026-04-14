$ErrorActionPreference = "Stop"

$PackRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$MemoryPath = Join-Path $PackRoot "memory"
$ResearchPath = Join-Path $PackRoot "research"

Write-Host "Installing cascade-memory wrapper from $MemoryPath"
python -m pip install -e $MemoryPath

Write-Host "Installing cascade-research wrapper from $ResearchPath"
python -m pip install -e $ResearchPath

Write-Host "Python wrappers installed."
