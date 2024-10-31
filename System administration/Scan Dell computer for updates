<#

# Information about the progam
# Documentation
https://www.dell.com/support/manuals/en-uk/command-update/dellcommandupdate_311_ug/command-line-interface-reference?guid=guid-92619086-5f7c-4a05-bce2-0d560c15e8ed&lang=en-us

1. Install location: %programfiles%\Dell\CommandUpdate | 'C:\program files\Dell\CommandUpdate' 
2. Process name: dcu-cli.exe

# Syntax
dcu-cli.exe /option -option=value 

#>

# Example of what the log file will say when updates are avilable
# <-- "Number of applicable updates for the current system configuration: 2" --> #

# The first query will match if the log file contains 1+ update(s)
# The second query will match when the dcuApplyUpdate.log file installs the updates
$TextPattern = [regex]'Number of applicable updates .+ [1-9]{1,2}'
$FinishedUpdates = 'Finished installing the updates.'

# Dell Command Update folder locations
$64BitLocation = 'C:\Program Files\Dell\CommandUpdate'
$32BitLocation = 'C:\Program Files (x86)\Dell\CommandUpdate'

# Navigate to dcu-cli location
if (Test-Path -Path $64BitLocation) {

    # Change folder path
    Set-Location $64BitLocation

} elseif (Test-Path -Path $32BitLocation) {

    # Change folder path
    Set-Location $32BitLocation

} else {
    Write-Host "`nDell Command | Update is not installed on this computer. " -ForegroundColor Red
}

# Message to the host
Write-Host "`nScanning the computer for updates...`n" -ForegroundColor Yellow

# Display app version and scan the computer for updates
.\dcu-cli.exe /version
.\dcu-cli.exe /scan -outputlog=C:\temp\dcuScan.log -silent

# Read the log file
$LogFile = Get-Content C:\temp\dcuScan.log
$LogFile

# Apply available updates
if ($LogFile -match $TextPattern) {

    # Message to the host
    Write-Host "`nUpdates are available. Applying updates to the system...`n" -ForegroundColor Yellow  
    
    # Apply updates
    .\dcu-cli.exe /applyUpdates -outputlog=C:\temp\dcuApplyUpdate.log -silent -autoSuspendBitLocker=enable -reboot=disable

    # Get the content of the update log file
    $UpdateFile = Get-content C:\temp\dcuApplyUpdate.log
    $UpdateFile
    
    if ($UpdateFile -match $FinishedUpdates) {
        # Write a message to the host if the dcuApplyUpdate.log file contains a regular expression 
        Write-Host "`nUpdates have been installed successfully. `nConsider restarting your computer to complete the installation.`n" -ForegroundColor Green
    }
} 

else {
    Write-Host "`nNo updates are available.`nThis system is up to date." -ForegroundColor Green
}
