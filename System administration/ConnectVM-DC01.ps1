<#
.SYNOPSIS
Run Hyper-V VM
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
function Connect-VirtualMachine 
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$False)][string]$vmName = "dc01",
        [Parameter(Mandatory=$False)][string]$localadmin = "devlab\dmacdonald"
    )

    # Start the VM
    Write-Output "Attempting to start '$vmName'"
    $GetVM = Get-VM -Name $vmName

    if ($GetVM.State -eq 'Off') 
    {
        try 
        {
            # Start Virtual Machine
            Start-VM -Name $vmName -ErrorAction Stop
            Write-Output "'$vmName' has started."
            Write-Output "Starting services. Wait 15s"
            Start-Sleep -Seconds 15

            # Remote on to dc01 via PowerShell
            $PSLab = enter-pssession -ComputerName $vmName -Credential $localadmin 
        }
        catch 
        {
            Write-Error "'$vmName' failed to start"
            Write-Error $Error[0] -ErrorAction Stop
        }
    }
}

# Call function
Connect-VirtualMachine 
