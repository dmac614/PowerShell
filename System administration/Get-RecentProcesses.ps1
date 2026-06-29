# Get processes started in the last 10 minutes
Get-Process | 
? { $_.StartTime -ge (get-date).AddHours(-0.2) } | 
Select-object ProcessName,StartTime -First 20 | Sort-Object StartTime -Descending