## unfinished ##

function Get-GraphDevices {
    param(
        [Parameter(Mandatory, Position=0)]
        [ValidateSet("v1.0", "Beta")]
        [string]$Version
        )
    
            # Auth to graph
            Write-Output "Connecting to Graph..."
            Start-Sleep -Seconds 5
            Connect-MgGraph -NoWelcome
    
            # Pause for 5s
            Write-Output "Pulling device data in 5s..."
            Start-Sleep -Seconds 5
    
            # Get device data
            $Devices = Invoke-MgGraphRequest -Method get -Uri "https://graph.microsoft.com/$Version/DeviceManagement/ManagedDevices"

            $Devices.value | 
            Select-Object @(
            'deviceName',
            'userPrincipalName',
            'deviceEnrollmentType',
            'osVersion',
            'complianceState',
            'id',
            'azureADDeviceId',
            'lastSyncDateTime',
            'joinType'
            )
    }
