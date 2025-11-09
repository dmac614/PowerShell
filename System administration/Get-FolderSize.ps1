<#
.SYNOPSIS
Short description of the script. 
.DESCRIPTION
Longer description of the script with more details.
.PARAMETER <parameter>
Description of the parameter
.EXAMPLE
Get-FolderSize.ps1 -Path C:\Temp


.NOTES
Author: Daniel Macdonald

The .NET objects work with PowerShell 7+
The length property only works on files, not on folders

#>

## 
param(
        [Parameter(Mandatory)]
        [string]$Path,
        [string]$FormattedNumber = "{0:N}"
)

function FolderSize {
    param(
        [Parameter(Mandatory)]
        [string]$Path,
        [string]$FormattedNumber = "{0:N}"
    )
        
    if ($PSEdition -ne "Core") {
        $Pwsh = (Get-Command pwsh.exe -ErrorAction SilentlyContinue).Source
        if (-not $Pwsh) {
            Write-Error "PowerShell 7 is required to run the .NET objects in this script"
            return 
        }
        
        # Still not working as intended
        # A new window is opened and the rest of the script runs there opposed to the $PSCommandPath
        # Read more about Start-Process
        # Test this: $ProcObj = [system.diagnostics.processstartinfo]::new()
        Write-Output "Starting PowerShell 7"
        $argList = @{
            ExecutionPolicy = 'Bypass'
            File = $PSCommandPath
            Path = $Path
            Wait = $true
        }

        <# another possiblity to use
        $argList = @(
            '-NoProfile',
            '-ExecutionPolicy', 'Bypass',
            '-File', "`"$PSCommandPath`"",
            '-Path', "`"$Path`"")
        #>
            Start-Process -FilePath $Pwsh -ArgumentList @argList -NoNewWindow
            return
    }


    # File and folder enumeration configs  
    $opt = [IO.EnumerationOptions]::new()
    $opt.AttributesToSkip = [IO.FileAttributes]::None
    $opt.IgnoreInaccessible = $true
    $opt.RecurseSubdirectories = $true

    if (-not (Test-Path $Path)) { 
        Write-Error "The path entered does not exist: $Path" -ErrorAction Stop
    }

    try {
        # This is not returning the full length of the specified file. Something is missing
        $dinfo = [IO.DirectoryInfo]::new($Path)
        $Size = $dinfo.EnumerateFileSystemInfos("*",$opt) | Measure-Object -Property Length -Sum
    }

    catch {
        Write-Error $Error[0] -ErrorAction Stop
    }

    $Bytes = [pscustomobject]@{
        Gigabytes = "$($FormattedNumber -f ($Size.Sum / 1GB))"
        Megabytes = "$($FormattedNumber -f ($Size.Sum / 1MB))"
        Kilobytes = "$($FormattedNumber -f ($Size.Sum / 1KB))"    
    }


        if ($Size.Count -eq 0){
            Write-Output "The folder is empty"
        } else {
            Write-Output "There are $($Size.Count) items in this folder. The folder size is:"
            $Bytes
        }
}

FolderSize -Path $Path -FormattedNumber $FormattedNumber