<#
.SYNOPSIS
Calculate the size of the localappdata temp folder
.DESCRIPTION
This script is used to clear storage on the disk for when large amounts of data gets stored in the localappdata temp folder. If the localappdata temp folder is over 5GB it will be emptied. 
.EXAMPLE
Get-TempFolderItems

.NOTES
Author: Daniel Macdonald

#>
function Get-TempFolderSize {
    param(
        [string]$TempFolderPath = "${env:localappdata}\Temp",
        [string]$FormattedNumber = "{0:N}"
    )

    # Get all items in the appdata\local\temp folder
    $Items = Get-ChildItem -Path $TempFolderPath -Recurse
    
    # Calculate the size of the folder
    $TotalSize = $Items | 
    Measure-Object -Property Length -Sum |
    Select-Object @{name="Folder size (GB)";expression={$_.Sum / 1GB} }

        # Empty folder when greater than 1gb
        if ($TotalSize.'Folder size (GB)' -ge 5){ 
        Write-Output "The $TempFolderPath folder is $(($FormattedNumber) -f $TotalSize.'Folder size (GB)')GB`nProceeding to empty the folder"
        $Items | Remove-Item -Recurse -Verbose *>&1 | Out-File "$TempFolderPath\EmptyFolderLog.txt"
        Write-Output "Read the log file at $TempFolderPath\EmptyFolderLog.txt"
        }
        else { 
            Write-Output "The $TempFolderPath folder is $(($FormattedNumber) -f $TotalSize.'Folder size (GB)')GB"
            "$TempFolderPath is less than 5GB in size"
        }
}

Get-TempFolderSize
