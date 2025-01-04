<#
.SYNOPSIS
Get the device name.
.DESCRIPTION
Get the name of a device by specifying the user's full name. This finds who the current and last logged in user is based on the SAMAccountName.
.PARAMETER FullName
The full name of the computer user
.EXAMPLE
Get-AssetNumber -FullName
.NOTES
Used at the Public Trustee, QLD Government.
Author: Daniel Macdonald
#>

param( [string]$FullName = "" )
#$GetName = Read-Host -Prompt "What is the user's full name?"

# Get the user's SamAccountName
$SAM = Get-ADUser -Filter {name -eq $($FullName)} | Select-Object SamAccountName   

# Load SCCM module to be able to run SCCM commands
Import-module -Name ConfigurationManager

# Change to the SCCM drive
Set-location PTO:

# Get the computer name based on the current user logged into it
$CurrentLogon = Get-CMDevice -Name * | 
Where-Object {$_.CurrentLogonUser -match $SAM.SamAccountName } |
Select-Object Name

$LastLogon = Get-CMDevice -Name * |
Where-Object {$_.LastLogonUser -match $SAM.SamAccountName } |
Select-Object Name

# Write message
Write-Output "`nThe username $($SAM.SamAccountName) is currently logged into: $($CurrentLogon.Name)"
Write-Output "The username $($SAM.SamAccountName) was last logged into: $($LastLogon.Name)"


# Return to the C: drive
#Set-Location $HOME
