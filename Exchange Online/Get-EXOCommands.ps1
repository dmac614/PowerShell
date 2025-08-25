<#
.SYNOPSIS
Retrieve EXO commands from the temporary module
.DESCRIPTION
The EXO v3 module has less cmdlets to use at first glance. Additional cmdlets are stored in local appdata and can be identified by searching for the commands of the module.
.PARAMETER <parameter>
No parameters are used for this script
.EXAMPLE
Get-EXOCommands

.NOTES
Author: Daniel Macdonald
#>

# Function to split the tmp module name and search for its commands
function Get-EXOCommands {
    $ModuleName = Get-ConnectionInformation | Select-Object ModuleName
    $Split = $ModuleName.ModuleName.Split("$env:LOCALAPPDATA\Temp\")

    Get-Command -Module $Split
}

# Evoke the function
Get-EXOCommands
