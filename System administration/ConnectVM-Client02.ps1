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
function Connect-VirtualMachine 
{
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory=$False)][string]$vmName = "Client02-dmac (Win11)"
    )

    # Start the VM
    Write-Output "Attempting to start '$vmName'"
    $GetVM = Get-VM -Name $vmName

    If ($GetVM.State -eq 'Off')
    {
        try 
        {
            # Start Virtual Machine
            Start-VM -Name $vmName -WarningAction Stop
            Write-Output "'$vmName' has started"
            Write-Output "Starting VM services. Wait 10s"
            Start-Sleep -Seconds 10

            # Open the VM Window
            Write-Output "Running '$vmName' process"
            & ${env:WinDir}\system32\VmConnect.exe 'DMAC-PF3DE7NR' 'Client02-dmac (Win11)'
        } 
        catch 
        {
            Write-Output "Could not start '$vmName'"
            Write-Output $_.Exception.Message
        }
    }
    
    ElseIf ($GetVM.State -eq 'Running')
    {
        try 
        {
            # the error is here: I need to check if the process window is open or not
            $CheckVM = (Get-Process).MainWindowTitle.Contains("Client02-dmac (Win11) on DMAC-PF3DE7NR - Virtual Machine Connection")
            if ($CheckVM)
            {
                Write-Output "VM window is already open"
            }
            else
            {
                Write-Output "Running '$vmName' process"
                & ${env:WinDir}\system32\VmConnect.exe 'DMAC-PF3DE7NR' 'Client02-dmac (Win11)'
            }
        } 
        catch 
        {
            Write-Output "Could not open '$vmName'"
            Write-Output $_.Exception.Message
        }
    }
}

# Call function
Connect-VirtualMachine 
