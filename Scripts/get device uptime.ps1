<#
.SYNOPSIS
Retrieves the uptime of a Windows system. 

.DESCRIPTION
The following cmdlets retriev information about when the Windows computer system was last booted. There are cmdlets for Powershell v5 and v6+.

.NOTES
Author: Daniel Macdonald

#>


## The following methods work in PowerShell v5 and v6+

# Method one
Get-ComputerInfo -Property OsLastBootUpTime

# Method two
(Get-CimInstance -ClassName win32_operatingsystem).LastBootUpTime


## The following method works in PowerShell v6+

$DevUptime = get-uptime | select-object days,hours
$DevUptime = get-uptime | select-object totalhours 
