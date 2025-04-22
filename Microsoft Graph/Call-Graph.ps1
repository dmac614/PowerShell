## Unfinished ##

# Modify the call to Microsoft Graph
# More Data values will be added

function Get-GraphAPI {
param(
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateSet("v1.0", "beta")]
    [string]$Version,
    [Parameter(Mandatory=$true, Position=1)]
    [ValidateSet("users", "groups", "devicemanagement/manageddevices")]
    [string]$Data
    )   
        # Auth to graph
        Write-Output "Connecting to Graph..."
        Start-Sleep -Seconds 2
        Connect-MgGraph -NoWelcome

        # Pause for 10s
        Write-Output "Pulling data in 10s..."
        Start-Sleep -Seconds 10

        # Get Graph data
        $Objects = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/$Version/$Data"
        #$Objects.value # testing this
}
