#Requires -Version 5.1

<#
.SYNOPSIS
    NERV-CODE Windows Installation Script
.DESCRIPTION
    Installs NERV-CODE on Windows systems with Node.js >= 18
.EXAMPLE
    powershell -ExecutionPolicy Bypass -File install.ps1
#>

param(
    [switch]$SkipBunInstall
)

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"  # Speed up Web requests

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$InstallDir = $ScriptDir
$CliPath = Join-Path $InstallDir "dist\cli.js"

# Installation paths
$ProgramDataDir = "$env:LOCALAPPDATA\Programs\NERV-CODE"
$BinDir = Join-Path $ProgramDataDir "bin"
$NervExe = Join-Path $BinDir "nerv.bat"

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

    $bunInstallScript = @"
    const { execSync } = require('child_process');
    try {
        execSync(' powershell -ExecutionPolicy Bypass -Command "irm bun.sh/install.ps1|iex"', {stdio: 'inherit'});
    } catch (e) {
        console.error('Failed to install Bun:', e.message);
        process.exit(1);
    }
"@

    try {
        # Use official Bun installation script
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
        $env:Path = "$env:Path;$PathToAdd"  # Update current session
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
Write-Step 1 5 "Checking prerequisites..."

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
if (-not $bunVersion -and -not $SkipBunInstall) {
    Install-Bun
    $bunVersion = Test-Command "bun"
}

if ($bunVersion) {
    Write-Success "Bun v$bunVersion detected"
} else {
    Write-Warn "Bun not detected. Will try npm as fallback for installation"
}

# ============================================
# Step 2: Install Dependencies
# ============================================
Write-Step 2 5 "Installing dependencies..."

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
    exit 1
}
Write-Success "Dependencies installed"

# ============================================
# Step 3: Restore Internal SDKs
# ============================================
Write-Step 3 5 "Restoring internal SDKs..."

& "$ScriptDir\scripts\copy-sdks.ps1"

Write-Success "SDKs restored"

# ============================================
# Step 4: Build
# ============================================
Write-Step 4 5 "Building NERV-CODE..."

if ($bunVersion) {
    bun run build.ts
} else {
    # Fallback: try npm run build
    npm run build
}

if ($LASTEXITCODE -ne 0) {
    Write-Err "Build failed"
    exit 1
}

if (-not (Test-Path $CliPath)) {
    Write-Err "Build failed — cli.js not found at $CliPath"
    exit 1
}
Write-Success "Build completed: $CliPath"

# ============================================
# Step 5: Create Command and Setup PATH
# ============================================
Write-Step 5 5 "Setting up NERV command..."

# Create installation directory and copy files
if (-not (Test-Path $BinDir)) {
    New-Item -ItemType Directory -Force -Path $BinDir | Out-Null
}

# Copy the built CLI to installation directory
$destCliPath = Join-Path $ProgramDataDir "dist\cli.js"
$destScriptsDir = Join-Path $ProgramDataDir "scripts"

if (-not (Test-Path (Join-Path $ProgramDataDir "dist"))) {
    New-Item -ItemType Directory -Force -Path "$ProgramDataDir\dist" | Out-Null
}
Copy-Item -Recurse -Force "$InstallDir\dist" "$ProgramDataDir\"
Copy-Item -Recurse -Force "$InstallDir\scripts" "$ProgramDataDir\"

# Create nerv.bat in bin directory
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
Write-Host "You can also run directly from the installed location:" -ForegroundColor Yellow
Write-Host "  $NervExe" -ForegroundColor Gray
Write-Host ""
