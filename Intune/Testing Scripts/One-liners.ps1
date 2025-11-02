# My personal tenant
Connect-MgGraph -TenantId "ccd5a42d-4beb-4856-b324-d3498aa10af5"

####################


# Career Connect tenant ID
Connect-MgGraph -TenantId "252ffc8e-c412-4e63-bc41-bff0cf4958c9"

# Device to test with
$DeviceID = "26a4d4fe-c271-4111-82fc-fe9eeacd5b3d"
Get-MgDeviceManagementManagedDevice -ManagedDeviceId $DeviceID | Select-Object -Property *

# Device properties
$DeviceProps = @("")


