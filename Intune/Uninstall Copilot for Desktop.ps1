# Uninstall Copilot for Desktop
$copilotDesktop = "C:\Program Files (x86)\Microsoft\Copilot\Application"
$copilotProcess = Get-Process -name mscopilot -ErrorAction SilentlyContinue
$transcriptFile = "C:\Windows\Temp\uninstall-CopilotForDesktop.txt"

Start-Transcript -Path $transcriptFile -Append

# Stop the process if its running
if ($copilotProcess) {
    Stop-Process -Name mscopilot -Force -ErrorAction SilentlyContinue
}

# Uninstall the application
if (Test-Path ($copilotDesktop)) {

    Write-Output "Copilot for Desktop is installed. Removing app..."
    & "C:\Program Files (x86)\Microsoft\Copilot\Application\147.0.3912.60\Installer\copilot_setup.exe" --uninstall --mscopilot --channel=stable --system-level --verbose-logging | Wait-Process

    if (!(Test-Path $copilotDesktop)) {
        Write-Output "Copilot for desktop has been uninstalled"
    } else {
        Write-Error "The application was not uninstalled" -ErrorAction Stop
    }

} else {

    Write-Output "Copilot for Desktop is not installed on this system"
}

Stop-Transcript
