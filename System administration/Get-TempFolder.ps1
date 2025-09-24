<#
.SYNOPSIS
Creates the Temp folder if it doesn't exist

.DESCRIPTION
Creates the Temp folder if it doesn't exist

.NOTES
Author: Daniel Macdonald

#>
function Get-TempFolder {
    param(
        [string]$TempFolder = 'C:\Temp'
    )       
    # If the Temp folder doesn't exist, create it
    if (! (Test-Path -Path $TempFolder)) {
        New-Item -Path ${env:SystemDrive}\ -Name Temp -ItemType Directory
        Write-Output "`n$TempFolder has been created"
    } 
    else {
        Write-Output "$TempFolder already exists."
    }
}
