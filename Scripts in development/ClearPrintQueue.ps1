<#
    If the computer has been online for more than 24 hours: restart it
    If the computer has been online for less than 24 hours:
    - stop the spooler service; clear the print queue; restart the service
#>
$Spool = Get-Service Spooler
$SpoolPath = "C:\Windows\System32\spool\PRINTERS"
$DeviceUptime = (Get-CimInstance -ClassName win32_operatingsystem).LastBootUpTime


if ($DeviceUptime.Timeofday.TotalHours -gt 24) { 
        
    Write-Output "Restarting $([Environment]::MachineName) in 30 seconds`nAfter the restart, attempt to print again"
    System.Diagnostics.Process.Start("shutdown", "/r /t 60")

} elseif ($DeviceUptime.Timeofday.TotalHours -lt 24) {
        
    Write-Output "Stopping $(($Spool).Name)`nEmptying $SpoolPath"
    Stop-Service $Spool
    Get-ChildItem $SpoolPath | Remove-Item
    Start-Service $Spool
    
    $SpoolProc = Get-Process -ProcessName spoolsv
    if ($SpoolProc.StartTime -gt $(Get-Date).AddSeconds(-120)) { Write-Output "Spooler has restarted successfully" } else { Write-Error "An error occurred" }

}