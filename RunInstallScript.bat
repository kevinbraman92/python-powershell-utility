@echo off
set SCRIPT=script/install_python_and_packages.ps1

:: Run the PowerShell script with execution policy bypass
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%"

pause