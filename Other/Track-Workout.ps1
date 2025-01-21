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
    #[datetime]$Date
    [string]$Exercise
    #[int]$Reps
    [string]$FirstSet
    [string]$SecondSet
    #[int]$Weight
    #[string]$Notes

    FullBody1(
    [string]$Exercise,
    [string]$FirstSet,
    [string]$SecondSet
    ){
        #$this.Date = $Date
        $this.Exercise = $Exercise
        #$this.Reps = $Reps
        $this.FirstSet = $FirstSet
        $this.SecondSet = $SecondSet
        #$this.Weight = $Weight
        #$this.Notes = $Notes
        #Add these params to the FullBody1() constructor
    }
}

#FullBody1 new Objects
$LyingLegCurl = [FullBody1]::new('Lying Leg Curl','8 reps @ 54KG','4 reps @ 54KG')
$SeatedLegCurl = [FullBody1]::new('Seated Leg Curl','','')
<# TODO: Add the remaining exercises as objects 
$SeatedRow = [FullBody1]::new('Seated Row','','')
$SeatedCableRow = [FullBody1]::new('Seated Cable Row','','')
$InclineBench = [FullBody1]::new('Incline Bench Press','','')
$InclineFly = [FullBody1]::new('Incline Fly (dumbbell)','','')
$StandingCalf = [FullBody1]::new('Standing Calf Raise','','')
#>
#endregion


#region DisplayWorkout
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
            $LyingLegCurl,$SeatedLegCurl
            #,$SeatedRow,$SeatedCableRow,$InclineBench,$InclineFly,$StandingCalf 
            # Find an easier way to write this
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
#endregion
