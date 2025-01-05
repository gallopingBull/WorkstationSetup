@echo off
echo Starting software installation process...

:: Run the PowerShell script
powershell.exe -Command "Start-Process powershell -ArgumentList '-NoExit -ExecutionPolicy Bypass -File \"%~dp0InstallFiles\RunInstallations.ps1\" -CurrentDirectory "%~dp0"' -Verb RunAs"

echo Software installation process complete.
pause
