# Get Microsoft Graph user data

function Get-GraphUsers {
param(
    [Parameter(Mandatory, Position=0)]
    [ValidateSet("v1.0", "beta")]
    [string]$Version
    )

    # Auth to graph
    Write-Output "Connecting to Graph..."
    Start-Sleep -Seconds 5
    Connect-MgGraph -NoWelcome

    # Pause for 10s
    Write-Output "Pulling user data in 5s..."
    Start-Sleep -Seconds 5

    # Get user data
    $Users = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/$Version/users"
    $Users.value | 
    Select-Object @(
        'displayName',
        'id',
        'refreshTokensValidFromDateTime',
        'signInSessionsValidFromDateTime',
        'accountEnabled'
    )
}
