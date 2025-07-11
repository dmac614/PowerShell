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

#region
    <#  
        Check the PowerShell repository
        Trust PSGallery
    #>
    $PSGallery = Get-PSRepository
    try {
        if ($PSGallery.Name -eq "PSGallery" -and $PSGallery.InstallationPolicy -eq "Untrusted") {
            Set-PSRepository -Name $PSGallery.Name -InstallationPolicy Trusted
            Write-Output "Installation Policy is now set to 'Trusted'"
        }
        else {
            Write-Output "Installation Policy is set to 'Trusted'"
        }
    }
    catch [System.Exception] {
        Write-Error "Could not configure the PowerShell package management repository" 
        Write-Error "The fully qualified error ID is: $($_.FullyQualifiedErrorId)" 
        Write-Error "Error at line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)" -ErrorAction Stop
    }
#endregion

#region
    <#
        Check for the PsWindowsUpdate module
    #>
    $UpdatesModule = Get-Module -ListAvailable | ? { $_.name -match 'PsWindowsUpdate' }
    try {
        # If null -- install the module
        if ([string]::IsNullOrEmpty($UpdatesModule)) {
            Write-Output "Installing the module 'PsWindowsUpdate'" 
            Install-Module -Name PsWindowsUpdate -Verbose
            Write-Output "Module has successfully been installed"
        } 
        else {
            Write-Output "The module $(($UpdatesModule).Name) is already installed. Importing the module:"
            Import-Module -Name PsWindowsUpdate -Verbose
            Write-Output "Module successfully imported"
            }
        }
    catch [System.Exception] {
        Write-Error "Failed to install 'PsWindowsUpdate'"
        Write-Error "The fully qualified error ID is: $($_.FullyQualifiedErrorId)" 
        Write-Error "Error at line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)" -ErrorAction Stop
        }
#endregion


