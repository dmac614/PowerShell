## length only works on files, not on folders

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

    if (-not (Test-Path $Path)) { 
        Write-Error "The path entered does not exist: $Path" -ErrorAction Stop
    }

    try {
        # This doesnt recurse -- still testing
        $Files = [IO.Directory]::EnumerateFiles($Path,"*", [System.IO.SearchOption]::AllDirectories)

        $Size = $Files | Measure-Object -Property Length -Sum
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