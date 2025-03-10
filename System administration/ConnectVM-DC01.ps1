<#
.SYNOPSIS
Start Hyper-V VM
.DESCRIPTION
Automate the process of starting my Domain Controller Virtual Machine for AD experience. Enter a PowerShell remote session with the local admin account.
.PARAMETER vmName
The name of the Domain Controller server
.PARAMETER localadmin
The name of the local administrator account to authenticate with
.EXAMPLE
ConnectVM-DC01.ps1

.NOTES
Author: Daniel Macdonald

#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$False)][string]$vmName = "dc01",
    [Parameter(Mandatory=$False)][string]$localadmin = "devlab\dmacdonald"
)

# Start the dc01 VM
Write-Output "$vmName will now start"
Start-VM -Name $vmName

# Messages
Write-Output "$vmName has started."
Write-Output "Starting services. Wait 15s"
Start-Sleep -Seconds 15

# Remote on to dc01 via PowerShell
$PSLab = enter-pssession -ComputerName dc01 -Credential $localadmin 
$PSLab
