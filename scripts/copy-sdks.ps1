# NERV-CODE SDK Copy Script
# Copies Anthropic internal SDKs from node_modules_sourcemap to node_modules
# This is required because the SDKs are restored from sourcemap and need to be in the proper location

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

$src = "node_modules_sourcemap/@anthropic-ai"
$dest = "node_modules/@anthropic-ai"

$sdkList = @("bedrock-sdk", "vertex-sdk", "foundry-sdk")

foreach ($sdk in $sdkList) {
    $sdkSrc = Join-Path $src $sdk
    $sdkDest = Join-Path $dest $sdk

    if (Test-Path $sdkSrc) {
        Write-Host "[COPY] $sdk"

        # Ensure destination directory exists
        if (-not (Test-Path $dest)) {
            New-Item -ItemType Directory -Force -Path $dest | Out-Null
        }

        # Copy SDK to destination
        Copy-Item -Recurse -Force $sdkSrc $sdkDest
    } else {
        Write-Host "[SKIP] $sdk not found in node_modules_sourcemap" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "SDK copy completed." -ForegroundColor Green
