Import-Module PSCalendar

$Table = [pscustomobject]@{
    "Follow nutrition plan" = ""
    "Drink 3L water" = ""
    "Take vitamins" = ""
    "Workout" = ""
    "Check-in" = ""
    "Follow sleep pattern" = ""
}

Show-Calendar 

$Table

# write up a command to get all of the dates which Tuesdays, Fridays, and Saturdays fall on for a month

<#

    Testing

    # Lists all the days in the month for 2025 and 2026
    $months = 1..12
    $daysInMonth = [system.datetime]::DaysInMonth
    foreach ($m in $months) { $daysInMonth.Invoke(2025,$m) }
    foreach ($m in $months) { $daysInMonth.Invoke(2026,$m) }

    $dateNow = [system.datetime]::now


#>


#     $Nov = 11
#     $daysInMonth = [system.datetime]::DaysInMonth
#     $DateFormat = @('DayOfWeek','Day','Month','Year')
#     foreach ($m in $Nov) { }
#         $daysInMonth.Invoke(2025,$Nov)
        

#     #region List the days for one week
#     $Nov = 11
#     $DateFormat = @('DayOfWeek','Day','Month','Year')
#     $d = [system.datetime]::DaysInMonth(2025,$Nov)
#             for ($i = 1; $i -le 7; $i++) {
#                 Get-Date -Month $Nov -Day $i | Select-Object $DateFormat
#             }
#     #endregion


#     #region List the days of a single month
#     $Nov = 11
#     $DateFormat = @('DayOfWeek','Day','Month','Year')
#     $d = [system.datetime]::DaysInMonth(2025,$Nov)
#             for ($i = 1; $i -le $d; $i++) {
#                 Get-Date -Month $Nov -Day $i | Select-Object $DateFormat
#             }
#     #endregion
            

#     #region List the days of the entire year

#     #$daysInMonth.Invoke(2025,$Nov)
#     #$daysInMonth = [system.datetime]::DaysInMonth(2025,$m)
    
#     $Months = 1..12
#     $DateFormat = @('DayOfWeek','Day','Month','Year')
#     foreach ($m in $Months) { 
#         $d = [system.datetime]::DaysInMonth(2025,$m)
#             for ($i = 1; $i -le $d; $i++) {
#                 Get-Date -Month $m -Day $i | Select-Object $DateFormat
#             }
#     }
#     #endregion
            



#     # Display the calendar month option
#     $Nov = 11
#     $DateFormat = @('DayOfWeek','Day')
#     $Display = Get-Date
    
#     function DisplayDate {
        
#         $d = [system.datetime]::DaysInMonth(2025,$Nov)
#         $Display.GetDateTimeFormats()[-1]
#         for ($i = 1; $i -le $d; $i++) {
#             Get-Date -Month $Nov -Day $i | 
#             % ($_.DayOfWeek) { 
#                 $CustomDays = [pscustomobject]@{
#                     Sunday = $i[0]
#                     Monday = $i[0]
#                     Tuesday = $i[2]
#                     Wednesday = $i[3]
#                     Thursday = $i[4]
#                     Friday = $i[5]
#                     Saturday = $i[6]
#                 }
#                 Write-Output $CustomDays | ft
#         }
#     }
# } DisplayDate


# $Table = [pscustomobject]@{
#     "Follow nutrition plan" = ""
#     "Drink 3L water" = ""
#     "Take vitamins" = ""
#     "Workout" = ""
#     "Check-in" = ""
#     "Follow sleep pattern" = ""
# }

#     function DisplayDate-Week {

#     $Nov = 11
#     $Display = Get-Date
#     Write-Output "Week 1 - $($Display.GetDateTimeFormats()[-1])"
#     $DateFormat = @('DayOfWeek','Day')

#     $d = [system.datetime]::DaysInMonth(2025,$Nov)
#             for ($i = 1; $i -le 7; $i++) {
#                 Get-Date -Month $Nov -Day $i | Select-Object $DateFormat
#             }
    
#     }   DisplayDate-Week