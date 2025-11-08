# Get processes started in the last 10 minutes
Get-Process | 
? { $_.StartTime -ge (get-date).AddHours(-0.2) } | 
Select-object ProcessName,StartTime | Sort-Object StartTime -Descending