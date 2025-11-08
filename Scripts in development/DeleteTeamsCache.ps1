# Testing #

$TeamsClassic = "${env:USERPROFILE}\AppData\Roaming\Microsoft"
$TeamsNew = "${env:USERPROFILE}\AppData\Local\Packages\MSTeams_8wekyb3d8bbwe"


Test-Path $TeamsClassic
(Test-Path $TeamsNew).GetHashCode()
(Test-Path $TeamsClassic).GetHashCode()

# Learn a simpler way to write this
$TeamsClassic -xor $TeamsNew | ForEach-Object {
    Test-Path $_
    if ($_.GetHashCode() ) {
        Write-Output $_.ToString()
    }
}



$TeamsClassic.CompareTo($TeamsNew)
$TeamsNew.Equals($TeamsClassic)
