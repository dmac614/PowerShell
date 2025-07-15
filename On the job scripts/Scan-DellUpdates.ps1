<#
.SYNOPSIS
Scan computer for Dell updates

.DESCRIPTION
Utilise Dell CLI tools to scan a computer for Dell updates 

- Documentation:
https://www.dell.com/support/manuals/en-uk/command-update/dellcommandupdate_311_ug/command-line-interface-reference?guid=guid-92619086-5f7c-4a05-bce2-0d560c15e8ed&lang=en-us
- Syntax: dcu-cli.exe /option -option=value 

.NOTES
Author: Daniel Macdonald

Example of what the log file will say when updates are avilable
<-- "Number of applicable updates for the current system configuration: 2" -->
The first query will match if the log file contains 1+ update(s)
The second query will match when the dcuApplyUpdate.log file installs the updates
#>
    param(
        [string]$TextPattern = [regex]'Number of applicable updates .+ [1-9]{1,2}',
        [string]$FinishedUpdates = 'Finished installing the updates.',
        
        # Necessary folder locations
        [string]$64BitLocation = 'C:\Program Files\Dell\CommandUpdate',
        [string]$32BitLocation = 'C:\Program Files (x86)\Dell\CommandUpdate',
        [string]$TempFolder = 'C:\Temp'
    )
            # Navigate to dcu-cli location
            if      (Test-Path -Path $64BitLocation) { Set-Location $64BitLocation } 
            elseif  (Test-Path -Path $32BitLocation) { Set-Location $32BitLocation } 
            else    { Write-Error "Dell Command | Update is not installed on this computer. " -ErrorAction Stop }

            # Verify Temp folder exists
            try {
                if (!(Test-Path -Path $TempFolder)) {
                    New-Item -Path ${env:SystemDrive}\ -Name Temp -ItemType Directory
                    Write-Output "$TempFolder has been created"
                } 
                else {
                    Write-Output "The $TempFolder directory for the log files already exists."
                }
            } 
            catch {
                Write-Error "Could not create $TempFolder folder"
                Write-Error "The fully qualified error ID is: $($_.FullyQualifiedErrorId)" 
                Write-Error "Error at line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)" -ErrorAction Stop
            }

            Write-Output "Scanning the computer for updates..."

            # Display app version and scan the computer for updates
            .\dcu-cli.exe /version
            .\dcu-cli.exe /scan -outputlog=C:\temp\dcuScan.log -silent

            # Read the log file
            $LogFile = Get-Content "$TempFolder\dcuScan.log"
            $LogFile

            # Apply available updates
            if ($LogFile -match $TextPattern) {

                # Message to the host
                Write-Output "`nUpdates are available. Applying updates to the system..."
                
                # Apply updates
                .\dcu-cli.exe /applyUpdates -outputlog=C:\temp\dcuApplyUpdate.log -silent -autoSuspendBitLocker=enable -reboot=disable

                # Get the content of the update log file
                $UpdateFile = Get-content "$TempFolder\dcuApplyUpdate.log"
                $UpdateFile
                
                if ($UpdateFile -match $FinishedUpdates) {
                    # Write a message to the host if the dcuApplyUpdate.log file contains a regular expression 
                    Write-Output "`nUpdates have been installed successfully. `nConsider restarting your computer to complete the installation.`n"
                }
            } 
            else {
                Write-Output "`nNo updates are available.`nThis system is up to date."
            }
