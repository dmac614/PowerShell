<#
.SYNOPSIS
Install Windows updates 

.DESCRIPTION
Install Windows updates. The verbose output is displayed on the screen and saved in a log file: %localappdata%\Temp\UpdatesOutput.log

.NOTES
Author: Daniel Macdonald
#>  
    [Cmdletbinding()]
    param (
        $LogFile = "UpdatesOutput.log"
    )

#region
    <#  
        Check the NuGet package provider is installed
        Install NuGet
    #>
    $NuGet = (Get-PackageProvider).name
    try {
        if ($NuGet -notcontains "NuGet"){
            Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Verbose
        }
        else {
            Write-Output "The package provider NuGet is installed"
        }
    } 
    catch [System.Exception] {
        Write-Error "Could not install the package provider NuGet" 
        Write-Error "The fully qualified error ID is: $($_.FullyQualifiedErrorId)" 
        Write-Error "Error at line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)" -ErrorAction Stop
    }
#end

#region
    <#  
        Check the PowerShell repository
        Trust PSGallery
    #>
    $PSGallery = Get-PSRepository
    try {
        if ($PSGallery.Name -eq "PSGallery" -and $PSGallery.InstallationPolicy -eq "Untrusted") {
            Set-PSRepository -Name $PSGallery.Name -InstallationPolicy Trusted -Verbose
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
        Install it if it's missing
    #>
    $UpdatesModule = Get-Module -ListAvailable | Where-Object { $_.name -match 'PsWindowsUpdate' }
    try {
        # If null -- install the module
        if ([string]::IsNullOrEmpty($UpdatesModule)) {
            Write-Output "Installing the module 'PsWindowsUpdate'" 
            Install-Module -Name PsWindowsUpdate -Verbose
            Write-Output "Module successfully installed"

            # Import the installed module
            Import-Module -Name PsWindowsUpdate -Verbose
            Write-Output "Module successfully imported"
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

#region
        <#
            Check for updates to install
            Allow the user to manually reboot
            Store verbose output in a log file
        #>
            Get-WindowsUpdate -Download -AcceptAll -Verbose 4>&1 | Tee-Object -FilePath "$env:LOCALAPPDATA\Temp\$LogFile"
            Get-WindowsUpdate -Install -AcceptAll -IgnoreReboot -Verbose 4>&1 | Tee-Object -FilePath "$env:LOCALAPPDATA\Temp\$LogFile"
#endregion
