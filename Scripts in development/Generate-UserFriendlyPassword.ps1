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

#region variables
    param( 
        [regex]$RegEx = "\d{1,2}\.\s",
        [string[]]$WordList = @("Dance","Earth","Flame","Ghost","Heart","Ivory","Jelly","Knife","Lemon","Magic","Night","Olive","Pearl","Quiet","River","Stone","Tiger",
        "Unity","Vivid","Water","Xerox","Yacht","Zebra","Blaze","Cloud","Dream","Equal","Frost","Grape","Honey","Ideal","Juice","Kneel","Latch","Metal","Nurse","Oasis","Paint","Quilt","Realm","Scale","Taper","Urban","Voice","Wheat","Xenon","Yield","Alder","Beach","Bloom","Blaze","Brook","Cedar","Chive","Cloud","Coast","Coral","Daisy","Dunes","Earth","Fawnz","Flora","Frost","Gorse","Grass","Hazel","Honey","Icier","Ivory","Junco","Larch","Lotus","Maple","Mossy","Ocean","Olive","Onion","Petal","Ponds","Quartz","Rainy","River","Rocks","Rosey","Sands","Seeds","Sheep","Shore","Snowy","Sprig","Stone","Storm","Tides","Trees","Tulip","Vines","Wheat")
    )
#end region

    foreach ($Word in $WordList) {
        $Modified = $Word -replace "^$RegEx", ""
        $AddToString = '"' + $Modified + '",'
        Write-Output $AddToString
    }