﻿<#
.SYNOPSIS
Calculates my weight.

.DESCRIPTION
Uses a formula to calculate my weight in pounds and in stone displaying both results in two decimal places.

.NOTES
Author: Daniel Macdonald

#>

function WeightMeasurements {
# Variables
$weight_kg = 76
$date = get-date

# Prompt the user for their name
$Name = read-host -Prompt "What is your name?"

# Convert kilograms to pounds: kg * 2.2045 = lbs
$GetPounds = '{0:n2}' -f ($weight_kg * 2.2045)

# Convert kilograms to stone: kg * 0.157473 = stone 
$GetStone = '{0:n2}' -f ($weight_kg * 0.157473)


# Write a message to the user
"Hello $name. Today is $date.`nYou weigh $GetPounds in pounds and you weigh $GetStone in stone."
}

WeightMeasurements 