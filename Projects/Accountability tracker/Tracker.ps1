#region Check for required module
function CheckForModule($m) {
    if (Get-Module | ? { $_.name -eq $m }) {
        Write-Host "Module is imported"
        break
    }

    else {
            try {

                if (Get-Module -ListAvailable | ? { $_.name -eq $m }) {
                    "Located module: importing $m"
                    Import-Module -Name $m -Verbose
                }
                
                elseif (Get-Module -ListAvailable | ? {$_.name -ne $m}) {
                    "Module is not installed: installing $m"
                    Install-Module $m -Verbose
                }
            } catch { Write-Error $Error[0] }
    }
} 

CheckForModule("PSCalendar")
#endregion


##################### Testing a pscustomobject ####################
$Variables = @( 
    "Follow nutrition plan",
    "Drink 3L water",
    "Take vitamins",
    "Workout",
    "Check-in",
    "Follow sleep pattern"
    )

# Change all completed variables to Yes
function AllCompleted() {}


function CreateResults() {
    param(
        [ValidateSet("Yes", "No")]
        [string]$AllCompleted
    )
    
    $Results = @()
    foreach ($item in $Variables) {
        
        $completed  = $AllCompleted
        $notes      = "Notes"

        $trackerObjects = [pscustomobject]@{   
            "Variables to complete" = $item
            "Completed"             = $AllCompleted
            "Notes"                 = $notes
        }
        
        $Results += $trackerObjects
    }
    
    
    $Results

} #endfunction

# Call function
CreateResults -AllCompleted Yes

################################################################################



#################### working with the calendar ####################

# Display the monthly calendar
$CurrentMonth = (Get-Date).Month
Write-Output "Displaying calendar for the month"
Show-Calendar -MonthOnly



# write up a command to get all of the dates which Tuesdays, Fridays, and Saturdays fall on for a month
$Nov = 11

function GymDays([int]$Month) {
    $DateFormat = @('DayOfWeek','Day','Month','Year')
    $GymDays = @('Tuesday', 'Friday', 'Saturday')
    $d = [system.datetime]::DaysInMonth(2025,$Month)
            for ($i = 1; $i -le $d; $i++) {
                Get-Date -Month $Month -Day $i | ? {$_.DayOfWeek -in $GymDays}  | Select-Object $DateFormat
            }
} GymDays(10)


############################################################


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
    $Nov = 11
    $DateFormat = @('DayOfWeek','Day','Month','Year')
    $GymDays = @('Tuesday', 'Friday', 'Saturday')
    $d = [system.datetime]::DaysInMonth(2025,$Nov)
            for ($i = 1; $i -le $d; $i++) {
                Get-Date -Month $Nov -Day $i | ? {$_.DayOfWeek -in $GymDays}  | Select-Object $DateFormat
            }
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