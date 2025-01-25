class FullBody1
{
    [string]$ExerciseName
    [int]$Weight
    [int]$Reps
    [string]$Notes

    # Primary Constructor
    FullBody1(
        [string]$ExerciseName,
        [int]$Weight,
        [int]$Reps
        ){
            $this.ExerciseName = $ExerciseName
            $this.Weight = $Weight
            $this.Reps = $Reps
    }
}

$LyingLegCurl1 = [FullBody1]::new("Lying Leg Curl",54,8)
$LyingLegCurl2 = [FullBody1]::new("Lying Leg Curl",54,4)


$LyingLegCurl1,$LyingLegCurl2
