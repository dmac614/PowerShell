#region Check for required module
function CheckForModule($m) {
    if (Get-Module | ? { $_.name -eq $m }) {
        Write-Host "Module is imported"
    }

    else {
            try {

                if (Get-Module -ListAvailable | ? { $_.name -eq $m }) {
                    "Located module: importing $m"
                    Import-Module -Name $m
                }
                
                elseif (Get-Module -ListAvailable | ? {$_.name -ne $m}) {
                    "Module is not installed: installing $m"
                    Install-Module $m
                }
            } catch { Write-Error $Error[0] }
    }
} 

CheckForModule("PSCalendar")
#endregion

####################################

#region FileData
$dateData = @((Get-Date).ToShortDateString(),
            (Get-Date).Month,(Get-Date).Year)

$folderName = "$((Get-Date).Month)_" + "$((Get-Date).Year)"
$fileName = "$((Get-Date).ToLongDateString())" + "_Tracker.csv"
$Path = "C:\PowerShell Dev\PowerShell\Projects\Accountability tracker\Tracker Data"


(!(Test-Path $Path\$folderName)) ? 
        (Write-Output "Creating folder: $folderName",
        New-Item -ItemType Directory -Name $folderName -Path $Path | Out-Null ) 
    : "$Path\$folderName"


(!(Test-Path $Path\$folderName\$fileName)) ? 
        (Write-Output "Creating file: $fileName",
        New-Item -ItemType File -Path $Path\$folderName -Name $fileName | Out-Null ) 
    : "$Path\$folderName\$fileName"

#endregion


#################### working with the calendar ####################

# Display the monthly calendar
Write-Output "`nDisplaying calendar for the month`n"
Show-Calendar -MonthOnly



####################################


#region Get the gym day dates of any month

function GetDays() {
    param(
        $Month = (Get-Date).Month
    )    

    $DateFormat = @('DayOfWeek','Day','Month','Year')
    $GymDays = @('Tuesday', 'Friday', 'Saturday')
    $d = [system.datetime]::DaysInMonth(2025,$Month)
            $script:dayGym = for ($i = 1; $i -le $d; $i++) {
                Get-Date -Month $Month -Day $i | ? {$_.DayOfWeek -in $GymDays}  | 
                Select-Object $DateFormat }
            
            $script:dayMonth = for ($i = 1; $i -le $d; $i++) {Get-Date -Month $Month -Day $i | Select-Object $DateFormat}            
} 
GetDays
#endregion

####################################



##################### User input ####################
#$dayGym = for ($i = 1; $i -le $d; $i++) { Get-Date -Month $Month -Day $i | ? {$_.DayOfWeek -in $GymDays} | Select-Object $DateFormat }

$gymDayVariables = [pscustomobject]@{
    "Nutrition Plan"    = ""
    "7K steps"          = ""
    "1L water"          = ""
    "Gym session"       = ""
}

$otherDayVariables = [pscustomobject]@{
    "Nutrition Plan"    = ""
    "7K steps"          = ""
    "1L water"          = ""
}

if ((Get-Date).DayOfWeek -match $dayGym){ 
    $gymDayVariables
     
} elseif ((Get-Date).DayOfWeek -match $dayMonth) {
    $otherDayVariables
}



#$dailyNote = Read-Host "Enter notes for today"















############################################################


<#


$DailyVariables = @( 
    "Follow nutrition plan",
    "Drink 3L water",
    "Take vitamins",
    "Follow sleep pattern",
    "Workout",
    "Check-in"
    )


# Change all completed variables to Yes
#function AllCompleted() {}

function CreateResults() {
    param(
        [ValidateSet("Yes", "No")]
        [string]$AllCompleted
    )
    
    #($weekly in $WeeklyVariables)
    #"Weekly variables"      = $weekly
    

    $completed  = $AllCompleted
    $notes      = "Notes"
    $Results    = @()

    foreach ($daily in $DailyVariables) {

            $dailyObjects = [pscustomobject]@{  
                "Daily variables"       = $daily
                "Completed"             = if ($daily -eq $DailyVariables[4] -or $daily -eq $DailyVariables[5]) {$null} else {$AllCompleted}
                "Notes"                 = $notes
        }
    
    $Results += $dailyObjects
                    
    }


    $Results

} #endfunction

# Call function
CreateResults -AllCompleted Yes










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
    # $Nov = 11
    # $DateFormat = @('DayOfWeek','Day','Month','Year')
    # $GymDays = @('Tuesday', 'Friday', 'Saturday')
    # $d = [system.datetime]::DaysInMonth(2025,$Nov)
    #         for ($i = 1; $i -le $d; $i++) {
    #             Get-Date -Month $Nov -Day $i | ? {$_.DayOfWeek -in $GymDays}  | Select-Object $DateFormat
    #         }
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