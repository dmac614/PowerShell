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
$FB1  = "Full Body #1"
$FB2  = "Full Body #2"
$Arms = "Arms"
#endregion

#region WorkoutTemplate class
class WorkoutTemplate 
{
    # Properties
    [string]$ExerciseName
    [ValidateRange(1,150)]
    [double]$Weight
    [ValidateRange(1,30)]
    [int]$Reps
    [string]$Notes

    # Methods
    [void]ModifyWeight() { 
        $this.Weight = [double](Read-Host -prompt "Enter the new weight")
    }

    [void]ModifyReps() {
        $this.Reps = [int](Read-Host -prompt "Enter the new reps")
      }

    [WorkoutTemplate] AddSet(
        [string]$name,
        [double]$weight,
        [int]$reps
        ){
          return [WorkoutTemplate]::new($name,$weight,$reps)
    }

    # Empty constructor
    WorkoutTemplate(){}

    # Primary Constructor
    WorkoutTemplate(
        [string]$ExerciseName,
        [double]$Weight,
        [int]$Reps
        ){
            $this.ExerciseName = $ExerciseName
            $this.Weight = $Weight
            $this.Reps = $Reps
    }
}

#region WorkoutTemplate instance: FullBody1
#$FullBody1 = @()
$LyingLegCurl                   = [WorkoutTemplate]::new("Lying Leg Curl",53,8)
$LyingLegCurl1                  = $LyingLegCurl.AddSet("Lying Leg Curl",53,6)

$SeatedLegCurl                  = [WorkoutTemplate]::new("Seated Leg Curl",20,11)
$SeatedLegCurl1                 = $SeatedLegCurl.AddSet("Seated Leg Curl",53,6)

$SeatedRowCable                 = [WorkoutTemplate]::new("Seated Row Cable",31.8,10)
$SeatedRowCable1                = $SeatedRowCable.AddSet("Seated Row Cable",31.8,10)

$SeatedRowMachine_UpperBack     = [WorkoutTemplate]::new("Seated Row Machine (upper back)",65,6)
$SeatedRowMachine_UpperBack1    = $SeatedRowMachine_UpperBack.AddSet("Seated Row Machine (upper back)",65,6)

$InclineBenchPress              = [WorkoutTemplate]::new("Incline Bench Press",20,9)
$InclineBenchPress1             = $InclineBenchPress.AddSet("Incline Bench Press",20,9)

$InclineChestFly                = [WorkoutTemplate]::new("Incline Chest Fly",12.5,10)
$InclineChestFly1               = $InclineChestFly.AddSet("Incline Chest Fly",12.5,10)

$StandingCalves                 = [WorkoutTemplate]::new("Standing Calf Raise",18,10)
$StandingCalves1                = $StandingCalves.AddSet("Standing Calf Raise",18,10)


# FullBody1 workout
$FullBody1 = $LyingLegCurl,$LyingLegCurl1,$SeatedLegCurl,$SeatedLegCurl1,$SeatedRowCable,$SeatedRowCable1,$SeatedRowMachine_UpperBack,$SeatedRowMachine_UpperBack1,$InclineBenchPress,$InclineBenchPress1,$InclineChestFly,$InclineChestFly1,$StandingCalves,$StandingCalves1
# plan: make an empty array; add the results of the workout to the array; call the array

$FullBody1
#endregion


#region Get-Workout
function Get-Workout {
    param (
            [array]$Workouts = @(
            Write-Host "`n1. $FB1" -ForegroundColor Blue
            Write-Host "2. $FB2" -ForegroundColor Green
            Write-Host "3. $Arms" -ForegroundColor White
            Write-Host "4. Exit`n" -ForegroundColor Red
        )
    ) 
    # Display the workouts
    $Workouts

    # Get input to select a workout
    $WhichWorkout = Read-Host -prompt "Which workout did you perform today?"
    
    Switch ($WhichWorkout) {
        1 {
            Write-Host "`nYou chose: $($FB1)" -ForegroundColor Blue
            $FullBody1
        }

        2 {
            Write-Host "`nYou chose: $($FB2)" -ForegroundColor Green
        }

        3 {
            Write-Host "`nYou chose: $($Arms)" -ForegroundColor White
        }

        4 {
            Write-Host "`nNo workout performed. `nExiting the program.`n" -ForegroundColor Red
            exit 0
        }

        Default {
            Write-Host "Invalid choice: try again." -ForegroundColor Red
        }
    }
}

Get-Workout
#endregion



#region UpdateWorkout
# function Update-Workout { }
#ModifyWeight() {}
#ModifyReps() {}
#endregion
