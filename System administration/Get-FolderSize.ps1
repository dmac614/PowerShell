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

    #$Sum = @()
    $GCI = Get-ChildItem -Path $Path -File -Recurse
    $Size = $GCI | Measure-Object -Property Length -Sum

    $Bytes = [pscustomobject]@{
        Gigabytes = "$($FormattedNumber -f ($Size.Sum / 1GB))"
        Megabytes = "$($FormattedNumber -f ($Size.Sum / 1MB))"
        Kilobytes = "$($FormattedNumber -f ($Size.Sum / 1KB))"    
    }

    Write-Output "There are $($Size.Count) items in this folder. The folder size is:"
    $Bytes
}

FolderSize -Path $Path -FormattedNumber $FormattedNumber