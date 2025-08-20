# Define Python version
$pythonVersion = "3.13.7"
$installerUrl = "https://www.python.org/ftp/python/3.13.7/python-3.13.7-amd64.exe"
$installerPath = "$env:TEMP\python-installer.exe"
$pythonInstallDir = "$env:ProgramFiles\Python$($pythonVersion.Replace('.', ''))"

# Check if Python is already installed
if (Get-Command python -ErrorAction SilentlyContinue) {
    Write-Host "Python already installed at: $(Get-Command python)"
} else {
    # Download Python installer
    Write-Host "Downloading Python..."
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

    # Install Python silently
    Write-Host "Installing Python..."
    Start-Process -Wait -FilePath $installerPath -ArgumentList `
        "/quiet InstallAllUsers=1 PrependPath=1 Include_test=0"

    # Cleanup
    Remove-Item $installerPath
}

# Verify Python is on PATH
$env:Path += ";$pythonInstallDir\Scripts;$pythonInstallDir"

# Upgrade pip and install packages
$pythonPath = "C:\Program Files\Python312\python.exe"

& "$pythonPath" -m ensurepip --upgrade
& "$pythonPath" -m pip install --upgrade pip
& "$pythonPath" -m pip install pandas numpy openpyxl

# Confirm installation
& "$pythonPath" --version
& "$pythonPath" -c "import pandas, numpy, openpyxl; print(f'pandas: {pandas.__version__} | numpy: {numpy.__version__} | openpyxl: {openpyxl.__version__}')"

# Define Python paths
$pythonDir = "C:\Program Files\Python312"
$scriptsDir = "$pythonDir\Scripts"

# Get current PATH environment variable
$envPath = [Environment]::GetEnvironmentVariable("Path", "Machine")

# Only add if not already present
if (-not $envPath.Contains($pythonDir)) {
    [Environment]::SetEnvironmentVariable("Path", "$envPath;$pythonDir", "Machine")
}
if (-not $envPath.Contains($scriptsDir)) {
    [Environment]::SetEnvironmentVariable("Path", "$envPath;$scriptsDir", "Machine")
}

Write-Host "Python and Scripts folders added to system PATH. You may need to restart PowerShell or log out and back in for changes to take effect."



