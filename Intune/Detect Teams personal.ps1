    <#
        This works at present
        Future proof way is to use the PackageName opposed to the DisplayName
        - Get-StartApps will provide the AppID
    #>

# Detect MicrosoftTeams personal
$AppName = "Microsoft Teams personal"
$DetectTeams = Get-AppProvisionedPackage -online | ? { $_.DisplayName -eq 'MicrosoftTeams' }

    try {
        if ($DetectTeams) { 
            Write-Output "$AppName has been detected on this computer`nRemoving app" 
            $DetectTeams | Remove-AppProvisionedPackage -Online -AllUsers

                $VerifyRemoval = Get-AppProvisionedPackage -Online | ? { $_.DisplayName -eq 'MicrosoftTeams' }
                if ($null -eq $VerifyRemoval) {
                    Write-Output "$AppName has been removed from this computer"
                } else { Write-Output "$AppName was not removed" }
        } 
        else { 
            Write-Output "$AppName is not installed on this computer" 
        }
    } catch {
        Write-Error "Error occured when detecting $AppName"
        Write-Error $Error[0] -ErrorAction Stop
    }