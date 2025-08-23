<#
    As I learn more about Classes in my Nutrition Plan project
    I realise that this needs revised

    This project will be updated in future
#>


class WorkoutTemplate
{
    # Properties
    [string]$ExerciseName
    [ValidateRange(1,150)]
    [int]$Weight
    [ValidateRange(1,30)]
    [int]$Reps
    [string]$Notes

    # Methods
    [void]ModifyWeight() { 
        $this.Weight = [int](Read-Host -prompt "Enter the new weight")
    }

    [void]ModifyReps() {
        $this.Reps = [int](Read-Host -prompt "Enter the new reps")
      }

    [WorkoutTemplate] AddSet(
        [string]$name,
        [int]$weight,
        [int]$reps
        ){
          return [WorkoutTemplate]::new($name,$weight,$reps)
    }

    # Empty constructor
    WorkoutTemplate(){}

    # Primary Constructor
    WorkoutTemplate(
        [string]$ExerciseName,
        [int]$Weight,
        [int]$Reps
        ){
            $this.ExerciseName = $ExerciseName
            $this.Weight = $Weight
            $this.Reps = $Reps
    }
}
