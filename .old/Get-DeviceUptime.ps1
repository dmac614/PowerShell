<#
.SYNOPSIS
Retrieves the uptime of a Windows system. 

.DESCRIPTION
The following cmdlets retrieve information about when the Windows computer system was last booted. There are cmdlets for Powershell v5 and v6+.

.NOTES
Author: Daniel Macdonald

#>


## The following methods work in PowerShell v5 and v6+

# Method one
Get-ComputerInfo -Property OsLastBootUpTime

# Method two
(Get-CimInstance -ClassName win32_operatingsystem).LastBootUpTime


## The following method works in PowerShell Core
get-uptime

# Format the total hours to a number with two decimal places
$DevUptime =  '{0:N2}' -f (get-Uptime).TotalHours
"Your device has been up for $DevUptime hours."

# Format the total days to a number with two decimal places
$DevUptime =  '{0:N2}' -f (get-Uptime).TotalDays
"Your device has been up for $DevUptime days."
