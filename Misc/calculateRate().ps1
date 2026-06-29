param(
    [int]$hourly = 25,
    [int]$hoursPerDay,
    [int]$daysWorked,
    [int]$weeksWorked
)

function calculateRate() {

    $daily = $hourly * $hoursPerDay
    if ($daily -ne 0) {
        "Daily earning: $daily"
    } else {"Equation was not calculated"}

    $weekly = $daily * $daysWorked
    if ($weekly -ne 0) {
        "Weekly earning: $Weekly"
    } else {"Equation was not calculated"}

    
    $monthly = $weekly * $weeksWorked
    if ($monthly -ne 0) {
        "Monthly earning: $monthly"
    } else {"Equation was not calculated"}

}

calculateRate
