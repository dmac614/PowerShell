<#
.SYNOPSIS
Short description of the script. 

.DESCRIPTION
Longer description of the script with more details.

.NOTES
Author: Daniel Macdonald

#>

# Enter the user's name
$GetName = Read-Host -Prompt "What is the user's full name?"

# Get the user's SamAccountName
$SAM = Get-ADUser -Filter {name -eq $GetName} | Select-Object SamAccountName   

# Load SCCM module to be able to run SCCM commands
Import-module -Name ConfigurationManager

# Change to the SCCM drive
Set-location PTO:

# Get the computer name based on the current user logged into it
$CurrentLogon = Get-CMDevice -Name * | ? {$_.CurrentLogonUser -match $SAM.SamAccountName } | Select-Object Name
$LastLogon = Get-CMDevice -Name * | ? {$_.LastLogonUser -match $SAM.SamAccountName } | Select-Object Name

# Write message
Write-Output "`nThe username $($SAM.SamAccountName) is currently logged into: $($CurrentLogon.Name)"
Write-Output "The username $($SAM.SamAccountName) was last logged into: $($LastLogon.Name)"


# Return to the C: drive
Set-Location $HOME
