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

#region FullBody1 Class
class FullBody1 {
    [string]$Exercise
    #[int]$Reps
    #[int]$Weight
    #[string]$Notes

    FullBody1([string]$Exercise) {
        $this.Exercise = $Exercise
        #$this.Reps = $Reps
        #$this.Weight = $Weight
    }
    #I MAY REMOVE THIS: This method performs an action
    #[void] DisplayExercise() {
    #   Write-Host "Exercise: $($this.Exercise)"
        #Write-Host "Reps: $($this.Reps)"
        #Write-Host "Weight: $($this.Weight)"
    }
}

#FullBody1 new Objects
$LyingLegCurl = [FullBody1]::new('Lying Leg Curl')
$SeatedLegCurl = [FullBody1]::new('Seated Leg Curl')
$SeatedRow = [FullBody1]::new('Seated Row')
$SeatedCableRow = [FullBody1]::new('Seated Cable Row')
$InclineBench = [FullBody1]::new('Incline Bench Press')
$InclineFly = [FullBody1]::new('Incline Fly (dumbbell)')
$StandingCalf = [FullBody1]::new('Standing Calf Raise')
#endregion


#region Workout
function Get-Workout {
    param (
        [array]$Workouts = @(
            Write-Host "1. $FB1" -ForegroundColor Blue
            Write-Host "2. $FB2" -ForegroundColor Green
            Write-Host "3. $Arms" -ForegroundColor Yellow
            Write-Host "4. Exit`n" -ForegroundColor Red
        )
    )
    # Display the workouts
    $Workouts
    # Get input to select a workout
    $WhichWorkout = Read-Host -prompt "Which workout did you perform today?"
    
    Switch ($WhichWorkout) {
        1 {
            Write-Host "You chose: $($FB1)" -ForegroundColor Blue
            $LyingLegCurl,$SeatedLegCurl,$SeatedRow,$SeatedCableRow,$InclineBench,$InclineFly,$StandingCalf # Find an easier way to write this
        }

        2 {
            Write-Host "You chose: $($FB1)" -ForegroundColor Green
        }

        3 {
            Write-Host "You chose: $($Arms)" -ForegroundColor Yellow
        }

        4 {
            Write-Host "Exiting the program." -ForegroundColor Red
            exit 0
        }

        Default {
            Write-Host "Invalid choice: try again." -ForegroundColor Red
        }
    }
}

Get-Workout
#endregion

