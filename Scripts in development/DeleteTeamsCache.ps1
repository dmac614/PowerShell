$TeamsClassic = "${env:USERPROFILE}\AppData\Roaming\Microsoft\Teams"
$TeamsNew = "${env:USERPROFILE}\AppData\Local\Packages\MSTeams_8wekyb3d8bbwe"

$Warning = "The classic version of Teams is installed`nUpgrade to the new version" 

if (Test-Path $TeamsClassic) { Write-Warning $Warning -WarningAction Stop }
if (Test-Path $TeamsNew) 
    {
        Get-Process -Name ms-teams -ErrorAction SilentlyContinue | Stop-Process 
        Remove-Item -Path $TeamsNew -Recurse -Force
        Start-Sleep -Seconds 5
        Start-Process ms-teams 
    }   else { Write-Output "Teams is possibly not installed" }
