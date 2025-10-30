# Career Connect tenant ID
Connect-MgGraph -TenantId "252ffc8e-c412-4e63-bc41-bff0cf4958c9"

# Device to test with
$DeviceID = "26a4d4fe-c271-4111-82fc-fe9eeacd5b3d"
Get-MgDeviceManagementManagedDevice -ManagedDeviceId $DeviceID | Select-Object -Property *

# Device properties
$DeviceProps = @(
    ""
)

#####################
# Device compliance #
#####################

# Grace period expired
$Today = (Get-Date)
Get-MgDeviceManagementManagedDevice -All | 
? { $_.ComplianceGracePeriodExpirationDateTime -lt $Today } |
Select-Object DeviceName,OperatingSystem,ComplianceState,ComplianceGracePeriodExpirationDateTime | sort ComplianceGracePeriodExpirationDateTime

# All noncompliant devices #

$AllNonCompliant = Get-MgDeviceManagementManagedDevice -All | 
? { $_.ComplianceState -eq "noncompliant" -or $_.ComplianceState -eq "inGracePeriod"} |
Select-Object DeviceName,OperatingSystem,ComplianceState,ComplianceGracePeriodExpirationDateTime

## Noncompliant Windows devices ##
Get-MgDeviceManagementManagedDevice -All | 
? { $_.OperatingSystem -eq "Windows" -and $_.ComplianceState -eq "noncompliant" -or $_.ComplianceState -eq "inGracePeriod"} |
Select-Object DeviceName,ComplianceState,ComplianceGracePeriodExpirationDateTime

## Noncompliant Android devices ##
Get-MgDeviceManagementManagedDevice -All | 
? { $_.OperatingSystem -eq "Android" -and $_.ComplianceState -eq "noncompliant" -or $_.ComplianceState -eq "inGracePeriod"} |
Select-Object DeviceName,OperatingSystem,ComplianceState,ComplianceGracePeriodExpirationDateTime

## Noncompliant iOS devices ##
## Results are Windows devices ##
Get-MgDeviceManagementManagedDevice -All | 
? { $_.OperatingSystem -eq "iOS" -and $_.ComplianceState -eq "noncompliant" -or $_.ComplianceState -eq "inGracePeriod"} |
Select-Object DeviceName,OperatingSystem,ComplianceState,ComplianceGracePeriodExpirationDateTime
