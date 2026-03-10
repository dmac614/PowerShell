
function deleteTeamsCache() {
    
    param(
        [parameter(Mandatory)]
        [string]$username
    )

    $regexPattern = [regex]"MSTeams\w\d.+8wekyb3d8bbwe"
    $newTeamsPath = Get-ChildItem "C:\Program Files\WindowsApps\" | Where-Object { $_.name -match $regexPattern } -OutVariable teamsVersion
    $teamsCache = "C:\Users\$username\AppData\Local\Packages\MSTeams_8wekyb3d8bbwe"
    $fullPath = Join-Path $teamsVersion.FullName -ChildPath "ms-teams.exe"

    
    if ($newTeamsPath.Length -eq 1) {
        
        "new Teams is installed: $($teamsVersion.Name)"
        "Proceeding to empty the cache folder then restart ms-teams"
        
        Get-Process -Name ms-teams -ErrorAction SilentlyContinue | Stop-Process -Confirm
        Remove-Item -Path $teamsCache -Recurse -Force -ErrorAction SilentlyContinue | Wait-Process # testing this line
        
        "The cache folder is now empty. Reopen the Teams app"
        
    } else { "Could not locate MSTeams in the WindowsApps folder"  }

}

deleteTeamsCache