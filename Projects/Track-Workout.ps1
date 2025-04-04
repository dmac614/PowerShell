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
$Upper_Chest    = "Upper #1: Chest and Biceps"
$Legs           = "Legs and Delts"
$Upper_Back     = "Upper #2: Back and Triceps"
#endregion

#region WorkoutTemplate class
class WorkoutTemplate 
{
    # Properties
    [string]$Exercise
    [ValidateRange(0,150)][double]$Weight
    [ValidateRange(1,50)][int]$Reps
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

    # Empty constructor for adding a new set
    WorkoutTemplate(){}

    # Primary Constructor
    WorkoutTemplate(
        [string]$Exercise,
        [double]$Weight,
        [int]$Reps
        ){
            $this.Exercise = $Exercise
            $this.Weight = $Weight
            $this.Reps = $Reps
    }
}
#endregion


#region WorkoutTemplate instance: Upper_Chest
$InclineBenchPress              = [WorkoutTemplate]::new("Incline Bench Press",20,9)
$InclineBenchPress1             = $InclineBenchPress.AddSet("Incline Bench Press",20,9)

$InclineChestFly                = [WorkoutTemplate]::new("Incline Chest Fly",12.5,10)
$InclineChestFly1               = $InclineChestFly.AddSet("Incline Chest Fly",12.5,10)

$ChestPress                     = [WorkoutTemplate]::new("Chest Press",67.5,8)

$BicepCurl                      = [WorkoutTemplate]::new("Bicep Curl",20.4,5)

$StandingCalves                 = [WorkoutTemplate]::new("Standing Calf Raise",18,10)
$StandingCalves1                = $StandingCalves.AddSet("Standing Calf Raise",18,10)


# Upper1 workout
$Upper1 = @()

$Upper1 += $InclineBenchPress,$InclineBenchPress1,$InclineChestFly,$InclineChestFly1,$ChestPress,$BicepCurl,$StandingCalves,$StandingCalves1
#endregion Upper_Chest


#region WorkoutTemplate instance: Legs
$SeatedLegPress                 = [WorkoutTemplate]::new("Seated Leg Press",108,14)

$LegExt                         = [WorkoutTemplate]::new("Leg Extension", 52.3,10)

$LyingLegCurl                   = [WorkoutTemplate]::new("Lying Leg Curl",53.4,7)
$LyingLegCurl1                  = $LyingLegCurl.AddSet("Lying Leg Curl",53.4,5)

$LateralRaise                   = [WorkoutTemplate]::new("Lateral Raise",8,8)
$LateralRaise1                  = $LateralRaise.AddSet("Lateral Raise",8,8)

$OHeadPress                     = [WorkoutTemplate]::new("Overhead Press",16,5)
$OHeadPress1                    = $OHeadPress.AddSet("Overhead Press",16,5)


# LegsDelts workout
$LegsDelts = @()

$LegsDelts += $SeatedLegPress,$LegExt,$LyingLegCurl,$LyingLegCurl1,$LateralRaise,$LateralRaise1,$OHeadPress,$OHeadPress1
#endregion Legs


#region WorkoutTemplate instance: Upper_Back
$PullUp                         = [WorkoutTemplate]::new("Pull Ups",0,7)

$LatPD                          = [WorkoutTemplate]::new("Lat Pulldown",50,11)
$LatPD1                         = $LatPD.AddSet("Lat Pulldown",50,7)

$SR_Upper_Back                  = [WorkoutTemplate]::new("Seated Row Machine (upper back)",65,6)
$SR_Upper_Back1                 = $SR_Upper_Back.AddSet("Seated Row Machine (upper back)",65,6)

$TriPD                          = [WorkoutTemplate]::new("Tricep Pushdown",20,10)

$RearDelt                       = [WorkoutTemplate]::new("Rear Delt Row",12,10)
$RearDelt1                      = $LatPD.AddSet("Rear Delt Row",12,10)

$StandingCalves                 = [WorkoutTemplate]::new("Standing Calf Raise",18,10)
$StandingCalves1                = $StandingCalves.AddSet("Standing Calf Raise",18,10)


# Upper2 workout
$Upper2 = @()

$Upper2 += $PullUp,$LatPD,$LatPD1,$SR_Upper_Back,$SR_Upper_Back1,$TriPD,$RearDelt,$RearDelt1,$StandingCalves,$StandingCalves1
#endregion Upper_Back


#region Inactive exercises
<#
$SRCable,$SRCable1,$SeatedLegCurl,$SeatedLegCurl1

$SRCable                        = [WorkoutTemplate]::new("Seated Row Cable",31.8,10)
$SRCable1                       = $SRCable.AddSet("Seated Row Cable",31.8,10)

$SeatedLegCurl                  = [WorkoutTemplate]::new("Seated Leg Curl",20,11)
$SeatedLegCurl1                 = $SeatedLegCurl.AddSet("Seated Leg Curl",53,6)
#>
#endregion Inactive exercises



#region Get-Workout
function Get-Workout {

    [array]$Workouts = @(
        Write-Host "`n1. $Upper_Chest" -ForegroundColor Green
        Write-Host "2. $Legs" -ForegroundColor Green
        Write-Host "3. $Upper_Back" -ForegroundColor Green
        Write-Host "4. Exit`n" -ForegroundColor Green
        )

    # Get input to select a workout
    $script:WhichWorkout = Read-Host -prompt "Which workout did you perform?"
    
    Switch ($WhichWorkout) {
        1 {
            Write-Host "`nWorkout performed: $($Upper_Chest)" -ForegroundColor Green
            $Upper1
        }

        2 {
            Write-Host "`nWorkout performed: $($Legs)" -ForegroundColor Green
            $LegsDelts
        }

        3 {
            Write-Host "`nWorkout performed: $($Upper_Back)" -ForegroundColor Green
            $Upper2
        }

        4 {
            Write-Host "`nNo workout performed. `nExiting the program.`n" -ForegroundColor Red
        }

        Default {
            Write-Host "`nInvalid choice: try again." -ForegroundColor Red
            Get-Workout
        }
    }
}


Get-Workout
#endregion



#region UpdateWorkout
function Update-Workout { 

    #$WorkoutChoice = Read-Host -Prompt "Modify values from: $($WhichWorkout)"


}

# Call function
#Update-Workout

#ModifyWeight() {}
#ModifyReps() {}
#endregion
