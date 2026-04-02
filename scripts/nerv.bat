@echo off
setlocal

:: NERV-CODE Windows Entry Script
:: Launches the NERV-CODE CLI from the installation directory

set "SCRIPT_DIR=%~dp0"
set "CLI_PATH=%SCRIPT_DIR%dist\cli.js"

:: Check if Node.js is available
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Node.js is not installed or not in PATH.
    echo Please install Node.js >= 18 from https://nodejs.org/
    exit /b 1
)

:: Check if cli.js exists
if not exist "%CLI_PATH%" (
    echo Error: cli.js not found at %CLI_PATH%
    echo Please run install.ps1 first.
    exit /b 1
)

:: Launch NERV-CODE
node "%CLI_PATH%" %*

endlocal
