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
Select-Object DeviceName,OperatingSystem,ComplianceState,ComplianceGracePeriodExpirationDateTime | 
Sort-Object ComplianceGracePeriodExpirationDateTime

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


#################
# Sync devices  #
#################

# Synced in the last 8 hours
$EightHours = (Get-Date).AddHours(-8)
Get-MgDeviceManagementManagedDevice -All | 
? { $_.LastSyncDateTime -gt $EightHours } | 
Select-Object DeviceName,OperatingSystem,LastSyncDateTime | Sort-Object LastSyncDateTime



##########################
# Added from personal PC #
##########################



# Check when a device last checked-in
Get-MgDeviceManagementManagedDevice | select DeviceName,id,LastSyncDateTime

# Devices synced in the last 8hrs 
$8hrs = (Get-Date).AddHours(-8)
Get-MgDeviceManagementManagedDevice | ? { $_.LastSyncDateTime -ge $8hrs } | select devicename,id,LastSyncDateTime

# Devices synced more than 30 days ago
$ThirtyDays = (Get-Date).AddDays(-30)
Get-MgDeviceManagementManagedDevice | ? { $_.LastSyncDateTime -lt $ThirtyDays } | select devicename,id,LastSyncDateTime


# Android devices #
$AndroidProps = @('ManagedDeviceName','ManagedDeviceOwnerType','OSVersion','SerialNumber','ComplianceState','EnrollmentProfileName','EnrolledDateTime','LastSyncDateTime')
Get-MgDeviceManagementManagedDevice -All | ? { $_.OperatingSystem -eq "Android" } | Select $AndroidProps

# iOS devices 
$iOSProps = @('ManagedDeviceName','ManagedDeviceOwnerType','OSVersion','SerialNumber','ComplianceState','EnrollmentProfileName','EnrolledDateTime','LastSyncDateTime')
Get-MgDeviceManagementManagedDevice -All | ? { $_.OperatingSystem -eq "iOS" } | Select $iOSProps