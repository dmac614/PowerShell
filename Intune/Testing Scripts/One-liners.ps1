# Connect to Graph
$dmacTenant = "ccd5a42d-4beb-4856-b324-d3498aa10af5"
Connect-MgGraph -TenantId $dmacTenant
Connect-MgGraph -TenantId ""


####################


# Compliant device properties
$DeviceProps = @("DisplayName","id","IsCompliant")

# Locate the device
# By Displayname

$displayName = "LOM-CYV8DS3"
Get-MgDevice -All | where { $_.DisplayName -eq $displayName } | Format-List $DeviceProps


# Multiple devices

$multipleDisplayNames = @(
    "LOM-CYV8DS3",
    "LOM-FTV8DS3"
)

foreach ($item in $multipleDisplayNames) { 
    Get-MgDevice -all | ? {$_.DisplayName -eq $item } | Format-List $DeviceProps 
}