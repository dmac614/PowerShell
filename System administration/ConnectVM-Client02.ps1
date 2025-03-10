<#
.SYNOPSIS
Start Hyper-V VM
.DESCRIPTION
Automate the process of starting a Win11 client VM
.PARAMETER vmName
The name of the Win11 machine
.EXAMPLE
ConnectVM-Client02.ps1

.NOTES
Author: Daniel Macdonald

#>
[CmdletBinding()]
param (
    [Parameter(Mandatory=$False)][string]$vmName = "Client02-dmac (Win11)"
)

# Start the VM
Write-Output "$vmName will now start"
Start-VM -Name $vmName

# Messages
Write-Output "$vmName has started"
Write-Output "Starting services. Wait 15s"
Start-Sleep -Seconds 15

# Open the VM Window
Write-Output "Running $vmName process"
C:\WINDOWS\system32\VmConnect.exe 'DMAC-PF3DE7NR' 'Client02-dmac (Win11)'

# Remote on to Client02 via PowerShell
#$PSLab = enter-pssession -ComputerName $vmName -Credential AzureAD\Globaladmin
#$PSLab
