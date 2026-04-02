#Requires -Version 5.1

<#
.SYNOPSIS
    NERV-CODE Windows 一键安装脚本
.DESCRIPTION
    从 GitHub 下载 NERV-CODE 并在 Windows 上安装
.EXAMPLE
    irm https://raw.githubusercontent.com/805979518/NERV-CODE/main/install.ps1 | iex
#>

param(
    [string]$RepoUrl = "https://github.com/805979518/NERV-CODE",
    [string]$Branch = "main"
)

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

function Write-Step($Number, $Total, $Message) {
    Write-Host ""
    Write-Host "[$Number/$Total] $Message" -ForegroundColor Cyan
}

function Write-Success($Message) {
    Write-Host "  [OK] $Message" -ForegroundColor Green
}

function Write-Warn($Message) {
    Write-Host "  [WARN] $Message" -ForegroundColor Yellow
}

function Write-Err($Message) {
    Write-Host "  [ERROR] $Message" -ForegroundColor Red
}

function Test-Command($Command) {
    Get-Command $Command -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Version
}

function Get-NodeVersion() {
    $nodeExe = Get-Command node -ErrorAction SilentlyContinue
    if ($nodeExe) {
        $version = node --version
        return $version -replace 'v', ''
    }
    return $null
}

function Install-Bun() {
    Write-Host ""
    Write-Host "Bun not found. Installing Bun..." -ForegroundColor Yellow
    try {
        powershell -ExecutionPolicy Bypass -Command "irm bun.sh/install.ps1|iex"
        Write-Success "Bun installed successfully"
    } catch {
        Write-Err "Failed to install Bun. Please install manually from https://bun.sh"
        throw
    }
}

function Add-ToPath($PathToAdd) {
    $currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -notlike "*$PathToAdd*") {
        [System.Environment]::SetEnvironmentVariable("Path", "$currentPath;$PathToAdd", "User")
        $env:Path = "$env:Path;$PathToAdd"
        return $true
    }
    return $false
}

# ============================================
# MAIN INSTALLATION PROCESS
# ============================================

Clear-Host
Write-Host ""
Write-Host "==============================================" -ForegroundColor DarkRed
Write-Host "   NERV CODE — MAGI System Online" -ForegroundColor DarkRed
Write-Host "==============================================" -ForegroundColor DarkRed
Write-Host ""
Write-Host "NERV-CODE Windows Installer" -ForegroundColor Red
Write-Host "Base: Claude Code v2.1.88 (Restored Source)" -ForegroundColor Gray
Write-Host ""

# ============================================
# Step 1: Check Prerequisites
# ============================================
Write-Step 1 6 "Checking prerequisites..."

$nodeVersion = Get-NodeVersion
if (-not $nodeVersion) {
    Write-Err "Node.js is not installed or not in PATH"
    Write-Host "Please install Node.js >= 18 from https://nodejs.org/" -ForegroundColor Yellow
    exit 1
}

$nodeMajor = [int]($nodeVersion.Split('.')[0])
if ($nodeMajor -lt 18) {
    Write-Err "Node.js >= 18 required (found v$nodeVersion)"
    exit 1
}
Write-Success "Node.js v$nodeVersion detected"

# Check for Bun
$bunVersion = Test-Command "bun"
if (-not $bunVersion) {
    Install-Bun
    $bunVersion = Test-Command "bun"
}

if ($bunVersion) {
    Write-Success "Bun v$bunVersion detected"
} else {
    Write-Warn "Bun not detected. Will try npm as fallback"
}

# ============================================
# Step 2: Download NERV-CODE from GitHub
# ============================================
Write-Step 2 6 "Downloading NERV-CODE from GitHub..."

$TempDir = Join-Path $env:TEMP "NERV-CODE-$(Get-Random)"
New-Item -ItemType Directory -Force -Path $TempDir | Out-Null

Write-Host "  Downloading to $TempDir..." -ForegroundColor Gray
try {
    # Download as zip
    $ZipUrl = "$RepoUrl/archive/refs/heads/$Branch.zip"
    $ZipPath = Join-Path $TempDir "nerv-code.zip"

    Write-Host "  URL: $ZipUrl" -ForegroundColor Gray
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $ZipUrl -OutFile $ZipPath -UseBasicParsing

    # Extract
    Write-Host "  Extracting..." -ForegroundColor Gray
    Expand-Archive -Path $ZipPath -DestinationPath $TempDir -Force

    # Find extracted folder
    $ExtractedDirs = Get-ChildItem -Path $TempDir -Directory | Where-Object { $_.Name -like "NERV-CODE*" }
    if ($ExtractedDirs) {
        $ScriptDir = $ExtractedDirs[0].FullName
    } else {
        throw "Could not find extracted NERV-CODE folder"
    }

    Write-Success "Downloaded and extracted"
} catch {
    Write-Err "Failed to download: $_"
    Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue
    exit 1
}

# ============================================
# Step 3: Install Dependencies
# ============================================
Write-Step 3 6 "Installing dependencies..."

Set-Location $ScriptDir

if ($bunVersion) {
    Write-Host "  Using Bun to install..." -ForegroundColor Gray
    bun install
} else {
    Write-Host "  Using npm to install (legacy peer deps)..." -ForegroundColor Gray
    npm install --legacy-peer-deps
}

if ($LASTEXITCODE -ne 0) {
    Write-Err "Failed to install dependencies"
    Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue
    exit 1
}
Write-Success "Dependencies installed"

# ============================================
# Step 4: Restore Internal SDKs
# ============================================
Write-Step 4 6 "Restoring internal SDKs..."

& "$ScriptDir\scripts\copy-sdks.ps1"

Write-Success "SDKs restored"

# ============================================
# Step 5: Build
# ============================================
Write-Step 5 6 "Building NERV-CODE..."

if ($bunVersion) {
    bun run build.ts
} else {
    npm run build
}

if ($LASTEXITCODE -ne 0) {
    Write-Err "Build failed"
    Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue
    exit 1
}

if (-not (Test-Path "$ScriptDir\dist\cli.js")) {
    Write-Err "Build failed — cli.js not found"
    exit 1
}
Write-Success "Build completed"

# ============================================
# Step 6: Create Command and Setup PATH
# ============================================
Write-Step 6 6 "Setting up NERV command..."

# Installation paths
$ProgramDataDir = "$env:LOCALAPPDATA\Programs\NERV-CODE"
$BinDir = Join-Path $ProgramDataDir "bin"
$NervExe = Join-Path $BinDir "nerv.bat"

# Create directories
if (-not (Test-Path $BinDir)) {
    New-Item -ItemType Directory -Force -Path $BinDir | Out-Null
}
if (-not (Test-Path "$ProgramDataDir\dist")) {
    New-Item -ItemType Directory -Force -Path "$ProgramDataDir\dist" | Out-Null
}
if (-not (Test-Path "$ProgramDataDir\scripts")) {
    New-Item -ItemType Directory -Force -Path "$ProgramDataDir\scripts" | Out-Null
}

# Copy built files
Copy-Item -Recurse -Force "$ScriptDir\dist" "$ProgramDataDir\"
Copy-Item -Recurse -Force "$ScriptDir\scripts" "$ProgramDataDir\"

# Create nerv.bat
$batContent = @"
@echo off
setlocal
set "CLI_PATH=%ProgramDataDir%\dist\cli.js"
node "%ProgramDataDir%\dist\cli.js" %*
endlocal
"@

Set-Content -Path $NervExe -Value $batContent -Encoding ASCII
Write-Success "Created $NervExe"

# Add to PATH
$pathAdded = Add-ToPath $BinDir
if ($pathAdded) {
    Write-Success "Added $BinDir to system PATH"
    Write-Host "  Note: You may need to restart your terminal for changes to take effect." -ForegroundColor Yellow
} else {
    Write-Success "$BinDir is already in PATH"
}

# Cleanup temp
Remove-Item -Path $TempDir -Recurse -Force -ErrorAction SilentlyContinue

# ============================================
# Completion
# ============================================
Write-Host ""
Write-Host "==============================================" -ForegroundColor DarkRed
Write-Host "   MAGI System — All Systems Nominal" -ForegroundColor DarkRed
Write-Host "==============================================" -ForegroundColor DarkRed
Write-Host ""
Write-Host "NERV-CODE installed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Usage:" -ForegroundColor White
Write-Host "  nerv              # Interactive mode" -ForegroundColor Gray
Write-Host "  nerv --version    # Show version" -ForegroundColor Gray
Write-Host "  nerv --help       # Show help" -ForegroundColor Gray
Write-Host "  nerv -p 'hello'   # Print mode" -ForegroundColor Gray
Write-Host ""
Write-Host "Note: Restart your terminal before first use to update PATH." -ForegroundColor Yellow
Write-Host ""
