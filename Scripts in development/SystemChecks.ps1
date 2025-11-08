# Testing #

# Clear temp folder #
$LocalAppDataTemp = "${env:LOCALAPPDATA}\temp"
$TestFolder = "C:\PowerShell Dev\Data\1"

$GetTempData = Get-ChildItem $LocalAppDataTemp
$FolderCount = $LocalAppDataTemp.Count

if ($GetTempData.count -gt 0) {
    Write-Output "`n$($LocalAppDataTemp) contains $($GetTempData.count) items`nPerforming directory cleanup"
    $GetTempData | Remove-Item -Recurse -ErrorAction SilentlyContinue
    $FolderCount--
}

#  #
