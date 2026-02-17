<#
    To do:
    create a function to track if the day is a gym day or not


    create the switch statement
    -- write the pseudocode
    -- test with this
    
#>
#region Check for required module
function CheckForModule($m) {
    if (Get-Module | ? { $_.name -eq $m }) {
        Write-Host "Imported the PSCalendar module"
    }

    else {
        try {

            if (Get-Module -ListAvailable | ? { $_.name -eq $m }) {
                "Located module: importing $m"
                Import-Module -Name $m
            }
                
            elseif (Get-Module -ListAvailable | ? { $_.name -ne $m }) {
                "Module is not installed: installing $m"
                Install-Module $m
            }
        }
        catch { Write-Error $Error[0] }
    }
} 

CheckForModule("PSCalendar")
#endregion


#region FileData
# file name i.e 28 November 2025_Tracker.csv
$currentDay = (Get-Date).ToLongDateString() 
$currentMonth = "$((Get-Date).Month)"
$currentYear = "$((Get-Date).Year)"

# file names
$fileName = $currentDay + "_Tracker.csv"
$previousFileName = "$($specifyDate.ToLongDateString())_Tracker.csv"

# root directory for saving files
$Path = "C:\PowerShell Dev\PowerShell\Projects\Accountability tracker\Tracker Data"

# Create the full path when tracking the current day file
$currentFolderPath = Join-Path -Path $Path -ChildPath "$currentYear\$currentMonth"
$currentFullPath = Join-Path -Path $currentFolderPath -ChildPath $fileName

# Create the full path when tracking the previous day file
$previousFolderPath = Join-Path -Path $Path -ChildPath "$($specifyDate.Year)\$($specifyDate.Month)"
$previousFullPath = Join-Path -Path $previousFolderPath -ChildPath $previousFileName
#endregion

####################################

#region functions for testing files and folders

# Test the folder path exists 
function checkFolderExistence($path) {

    $directoryExists = [System.IO.Directory]::Exists($path)
        if ($directoryExists){
            "Path exists: $path"
        } else {
            "Path created: $path"
            New-Item -ItemType Directory -Path $Path | Out-Null
        }
}


# Test the absolute path the file will exist in 
function checkFileExistence($file) {

    $fileExists = [System.IO.File]::Exists($file)
        if ($fileExists) {
            "Daily file exists: $file"
        } else {
            "File created: $file"
            New-Item -ItemType File -Path $file | Out-Null
        }
}

#endregion

####################################

#region tracking the current or previous day
do {
    [string]$whichDay = Read-Host -Prompt "`nAnswer with 'Current' or 'Previous'`nAre you tracking a previous day or the current day?"
} until ($whichDay -in ("Current","Previous"))

# Tracking the current day
$dayMatch = $currentDay -eq (Get-Date).ToLongDateString()
if ($whichDay -eq "Current" -and $dayMatch) {

    # Test the folder path
    checkFolderExistence($currentFolderPath)

    # Test current day file
    checkFileExistence($currentFullPath)

}

# Tracking the previous day
elseif ($whichDay -eq "Previous") {

    # Enter the date to track. Format 29 November 2025
    [datetime]$specifyDate = Read-Host "Date syntax: 29 November 2025`nWhich date do you want to track?"

    try {
        # Test the previous day folder path
        checkFolderExistence($previousFolderPath)

        # Test the previous day file
        checkFileExistence($previousFullPath)

    } catch { 
        
        Write-Error $Error[0] 
    
    }
}
#endregion

####################################

#region Monthly calendar

# # Display the monthly calendar
Write-Output "`nDisplaying calendar for the month`n"
Show-Calendar -MonthOnly
#endregion

####################################

#region Get the gym day dates

# Dates of the current month
function Get-CurrentDays() {
    param(
        $Month = (Get-Date).Month,
        $Year = (Get-Date).Year 
    )    

    $DateFormat = @('DayOfWeek','Day','Month','Year')
    $GymDays = @('Thursday', 'Friday', 'Sunday')
    $d = [system.datetime]::DaysInMonth($Year,$Month)
            $script:currentDayGym = for ($i = 1; $i -le $d; $i++) {
                Get-Date -Month $Month -Day $i | ? {$_.DayOfWeek -in $GymDays}  | 
                Select-Object $DateFormat }
        
            $script:currentDayMonth = for ($i = 1; $i -le $d; $i++) {
                Get-Date -Month $Month -Day $i | 
                Select-Object $DateFormat}            
} 


# Dates of the previous month
function Get-PreviousDays() {

    $DateFormat = @('DayOfWeek','Day','Month','Year')
    $GymDays = @('Thursday', 'Friday', 'Sunday')
    $d = [system.datetime]::DaysInMonth($specifyDate.Year,$specifyDate.Month)
            $script:previousDayGym = for ($i = 1; $i -le $d; $i++) {
                Get-Date -Month $specifyDate.Month -Day $i | ? {$_.DayOfWeek -in $GymDays}  | 
                Select-Object $DateFormat }
        
            $script:previousDayMonth = for ($i = 1; $i -le $d; $i++) {
                Get-Date -Month $specifyDate.Month -Day $i | 
                Select-Object $DateFormat}       
}

# it makes sense to use this, but i dont want to copy and paste chatgpt code

# function Get-DayInfo {
#     param(
#         [datetime]$Date = (Get-Date),
#         [string[]]$GymDays = @('Thursday','Friday','Sunday')
#     )

#     $isGymDay = $Date.DayOfWeek -in $GymDays

#     [PSCustomObject]@{
#         Date       = $Date
#         DayOfWeek  = $Date.DayOfWeek
#         Day        = $Date.Day
#         Month      = $Date.Month
#         Year       = $Date.Year
#         IsGymDay   = $isGymDay
#     }
# }

#endregion

####################################

#region User input

# Read questions (gym days)
function Read-GymQuestions() {

    [string[]]$gymQuestions = @(
        "Did you follow the nutrition plan?",
        "Did you complete the daily step count?",
        "Did you drink 2L of water with added salt?",
        "Did you complete the gym session?"
    )

    $script:answersStore1 = @()
    foreach ($q in $gymQuestions) {
        do {
            [String[]]$answer = Read-Host $q
                if ($answer -eq "yes" -or $answer -eq "no"){
                    $answersStore1 += $answer
                }
        } until ($answer -in ("yes","no"))
    }

    # Display the answers in an ordered hashtable
    $script:gymAnswers = [ordered]@{
        "Nutrition Plan"    = $answersStore1[0]
        "Daily steps"       = $answersStore1[1]
        "Daily water"       = $answersStore1[2]
        "Gym session"       = $answersStore1[3]
    }
}

function Read-OtherQuestions() {

    [string[]]$gymQuestions = @(
        "Did you follow the nutrition plan?",
        "Did you complete the daily step count?",
        "Did you drink 2L of water with added salt?"
    )

    $script:answersStore2 = @()
    foreach ($q in $gymQuestions) {
        do {
            [String[]]$answer = Read-Host $q
                if ($answer -eq "yes" -or $answer -eq "no"){
                    $answersStore2 += $answer
                }
        } until ($answer -in ("yes","no"))
    }

    # Display the answers in an ordered hashtable
    $script:otherAnswers = [ordered]@{
        "Nutrition Plan"    = $answersStore2[0]
        "Daily steps"       = $answersStore2[1]
        "Daily water"       = $answersStore2[2]
    }
}


function dailyNote($saveLocation) {
    $dailyNote = Read-Host "`nEnter notes for today"
    [float]$weighIn = Read-Host "Daily weigh-in (KG)"
    "Daily note: $dailyNote"        | Out-File -FilePath $saveLocation -Append
    "Daily weigh-in (KG): $weighIn" | Out-File -FilePath $saveLocation -Append
}

function Save-DayFile() {

    param(
        $fileData,
        [string]$saveLocation
    )

    $fileData | Out-File -FilePath $saveLocation # error saving
    "Added data to: $saveLocation"
}

$matchGymDayofWeek = ((Get-Date).DayOfWeek -in $currentDayGym.DayOfWeek)
$matchNonGymDay = ((Get-Date).DayOfWeek -in $currentDayMonth.DayOfWeek)

$matchPreviousGymDayofWeek = ((Get-Date).DayOfWeek -in $previousDayGym.DayOfWeek)
$matchPreviousNonGymDay = ((Get-Date).DayOfWeek -in $previousDayMonth.DayOfWeek)




## work on creating the switch statement
## verify the switch statements and the follow if/else statements match
## go over the switch statements before running the script
## run individual parts from the switch statements

## this is erroing -- it does straight to default
## something wrong with the switch expression?

$Current = $whichDay -eq "current"
$Previous = ($whichday -eq "previous")

switch ($whichDay)
{
    $matchGymDayofWeek {
        Get-CurrentDays

        "`nHint: respond with 'Yes' or 'No'"
        Read-GymQuestions

        Save-DayFile -fileData $gymAnswers -saveLocation $("$currentFullPath\$fileName")
        dailyNote("$currentFullPath\$fileName") 
    }

    $matchNonGymDay {
        Get-CurrentDays

        "`nHint: respond with 'Yes' or 'No'"
        Read-OtherQuestions

        Save-DayFile -fileData $otherAnswers -saveLocation $("$currentFullPath\$fileName")
        dailyNote("$currentFullPath\$fileName") 
    }

    $matchPreviousGymDayofWeek {
        Get-PreviousDays

        "`nHint: respond with 'Yes' or 'No'"
        Read-GymQuestions

        Save-DayFile -fileData $gymAnswers -saveLocation $($previousFullPath)
        dailyNote($previousFullPath)
    }

    $matchPreviousNonGymDay {
        Get-PreviousDays

        "`nHint: respond with 'Yes' or 'No'"
        Read-OtherQuestions

        Save-DayFile -fileData $otherAnswers -saveLocation $($previousFullPath)
        dailyNote($previousFullPath)
    }

    Default { Write-Error $Error[0] }
}




# switch ($whichDay -eq "Previous") 
# {
#     $matchPreviousGymDayofWeek {
#         Get-PreviousDays

#         "`nHint: respond with 'Yes' or 'No'"
#         Read-GymQuestions

#         Save-DayFile -fileData $gymAnswers -saveLocation $($previousFullPath)
#         dailyNote($previousFullPath)
#     }

#     $matchPreviousNonGymDay {
#         Get-PreviousDays

#         "`nHint: respond with 'Yes' or 'No'"
#         Read-OtherQuestions

#         Save-DayFile -fileData $otherAnswers -saveLocation $($previousFullPath)
#         dailyNote($previousFullPath)
#     }

#     Default { Write-Error $Error[0] }
# } 