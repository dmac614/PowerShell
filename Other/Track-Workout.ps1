<#
.SYNOPSIS
Short description of the script. 
.DESCRIPTION
Longer description of the script with more details.
.PARAMETER <parameter>
Description of the parameter
.EXAMPLE
ScriptName -<parameter>

.NOTES
Author: Daniel Macdonald


#idea

Workout Tracker

Full body (1): Hamstrings; incline chest; back thickness 
Full body (2): Quads; inner chest; back width
Arms: Triceps; biceps; Front delt; side delt; rear delt
- store in separate hashtables

Get input from the user -- which workout did you do (date)?
If they did workout X, retrieve respective hashtable
Ask the user how many reps and weight they lifted on exercise X
-- add the input data to the respective empty array
Make changes to the data: change reps and weight on each exercise 
Write the new data to the hashtable



Save the workouts to a file named with the date of the workout


Date of workout | Exercise | Sets x Reps | Weight (KG) | Notes

Monitor progress: you have increased exercise X by X KG since (date) 
#>
[cmdletbinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$WorkoutDate
)

# TODO: rough idea
#Get-Content -Path "C:\pathtofile\$WorkoutDate.csv"


#region Variables
$FB1  = "Full Body 1"
$FB2  = "Full Body 2"
$Arms = "Arms"
#endregion

#region First workout
$FullBody1 = [PSCustomObject]@{
    "Lying Leg Curl" = @{
        Reps = @()
        Weight = @()
    }
    "Seated Leg Curl" = @{
        Reps = @()
        Weight = @()
    }
}
#endregion

#region Display workout options
function Show-Workouts {
    Write-Output "1. $FB1"
    Write-Output "2. $FB2"
    Write-Output "3. $Arms"
    Write-Output "4. Exit"
}
function Get-Workout {
    param (
        [array]$Workouts
        # TODO: List the above workouts
        # TODO: Fix the above function -- potentially no need for 
    )


    [int]$script:WhichWorkout = Read-Host -prompt "Which workout did you perform today?"
    Switch ([int]$script:WhichWorkout) {
        1 {
            Write-Output "You chose: $($FB1)"
            $FullBody1.'Lying Leg Curl'
            $FullBody1.'Seated Leg Curl'
        }
    }
}
        
<#
2 { $FullBody2 }
3 { $Arms }
4 { exit 0 }
Default { Write-Output "Invalid choice: try again." }
#>

#endregion

#region 
