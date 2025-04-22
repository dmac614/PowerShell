## Unfinished ##

# Modify the call to Microsoft Graph
# More Data values will be added

function Get-GraphAPI {
param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateSet("v1.0", "Beta")]
    [string]$Version,
    [Parameter(Mandatory=$true, Position=1)]
    [ValidateSet("Users", "Groups", "DeviceManagement/ManagedDevices")]
    [string]$Data
    )   
        # Auth to graph
        Write-Output "Connecting to Graph..."
        Start-Sleep -Seconds 5
        Connect-MgGraph -NoWelcome

        # Pause for 5
        Write-Output "Pulling data in 5s..."
        Start-Sleep -Seconds 5

        # Get Graph data
        $Objects = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/$Version/$Data"
        #$Objects.value # testing this
}
