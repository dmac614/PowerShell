<#
.SYNOPSIS
Install Windows updates 

.DESCRIPTION
Install Windows updates 

.NOTES
Author: Daniel Macdonald

-------------- unfinished --------------

## Tasks ##
Check for the installed module: PsWindowsUpdate
If it's installed, continue/import the module
Else, install the module

#>
    [Cmdletbinding()]
    param ()

    $UpdatesModule = Get-Module -Name PsWindowsUpdate 
        try {
            # Check for the module
            if ($UpdatesModule) {
                "The module $(($UpdatesModule).Name) is already installed. Importing the module:"
                Import-Module -Name $UpdatesModule.Name -Verbose
                "Module successfully imported"
            } 
            else {
                "Installing the module $($UpdatesModule.Name)" 
                Install-Module -Name $UpdatesModule.Name
            }
        } 
        catch [System.Exception] {
            "ERROR: Failed to install $($UpdatesModule.Name)"
            "The fully qualified error ID is: $($_.FullyQualifiedErrorId)"
        }
