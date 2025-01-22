<#
.SYNOPSIS
Display the remaining disk space
.DESCRIPTION
Utilise the LogicalDisk CIM instance to display the overall disk size and the remaining disk space. 
.EXAMPLE
Get-DiskSpace.ps1
.NOTES
Author: Daniel Macdonald
#>

# Display disk size and space
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "drivetype=3" | 
Select-object DeviceID,
@{n='Size';e={ '{0:N2}' -f ($_.Size / 1GB) }},
@{n='FreeSpace';e={ '{0:N2}' -f ($_.FreeSpace / 1GB) }}
