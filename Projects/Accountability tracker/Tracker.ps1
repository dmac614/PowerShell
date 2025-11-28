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
        (Write-Output "New folder created: $folderName"),
        (New-Item -ItemType Directory -Name $folderName -Path $Path | Out-Null) 
    : "Monthly folder exists:   $Path\$folderName"


(!(Test-Path $Path\$folderName\$fileName)) ? 
        (Write-Output "New file created: $fileName"),
        (New-Item -ItemType File -Path $Path\$folderName -Name $fileName | Out-Null) 
    : "Daily file exists:       $Path\$folderName\$fileName"

#endregion


####################################


#region Monthly calendar

# Display the monthly calendar
Write-Output "`nDisplaying calendar for the month`n"
Show-Calendar -MonthOnly
#endregion


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
            
            $script:dayMonth = for ($i = 1; $i -le $d; $i++) {
                Get-Date -Month $Month -Day $i | 
                Select-Object $DateFormat}            
} 
GetDays
#endregion


####################################


if ((Get-Date).DayOfWeek -in $dayGym.DayOfWeek){ 

    "Daily habits"
    "`nHint: respond with 'Yes' or 'No'"
    [ValidateSet("Yes","No")]$q1 = Read-Host -Prompt "Did you follow the nutrition plan today?" 
    [ValidateSet("Yes","No")]$q2 = Read-Host -Prompt "Did you complete 7k steps today?"
    [ValidateSet("Yes","No")]$q3 = Read-Host -Prompt "Did you drink 1L of water with added salt today?"
    [ValidateSet("Yes","No")]$q4 = Read-Host -Prompt "Did you complete the gym session today?"

        $qht = [ordered]@{
            Q1 = $q1
            Q2 = $q2
            Q3 = $q3
            Q4 = $q4
        }

    $gymDayVariables = [ordered]@{
        "Nutrition Plan"    = $qht.Values[0]
        "7K steps"          = $qht.Values[1]
        "1L water"          = $qht.Values[2]
        "Gym session"       = $qht.Values[3]
    }

    $dailyNote = Read-Host "`nEnter notes for today"

    
    # append data to the daily file
    "`nAdded data to: $fileName"
    $gymDayVariables | Out-File -FilePath "$Path\$folderName\$fileName"
    Write-Output "Daily note: $dailyNote" | Out-File -FilePath "$Path\$folderName\$fileName" -Append

    Get-Content "$Path\$folderName\$fileName"


} elseif ((Get-Date).DayOfWeek -in $dayMonth.DayOfWeek) {
    
    "Daily habits"
    "`nHint: respond with 'Yes' or 'No'"
    [ValidateSet("Yes","No")]$q1 = Read-Host -Prompt "Did you follow the nutrition plan today?" 
    [ValidateSet("Yes","No")]$q2 = Read-Host -Prompt "Did you complete 7k steps today?"
    [ValidateSet("Yes","No")]$q3 = Read-Host -Prompt "Did you drink 1L of water with added salt today?"
    
        $qht = [ordered]@{
            Q1 = $q1
            Q2 = $q2
            Q3 = $q3
        }

    $otherDayVariables = [ordered]@{
        "Nutrition Plan"    = $qht.Values[0]
        "7K steps"          = $qht.Values[1]
        "1L water"          = $qht.Values[2]
        #"Notes"             = $dailyNote
    }

    $dailyNote = Read-Host "`nEnter notes for today"


    # append data to the daily file
    "`nAdded data to: $fileName"
    $otherDayVariables | Out-File -FilePath "$Path\$folderName\$fileName"
    Write-Output "Daily note: $dailyNote" | Out-File -FilePath "$Path\$folderName\$fileName" -Append

    Get-Content "$Path\$folderName\$fileName"


} else { Write-Error "User input failed" }



