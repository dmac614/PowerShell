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

#\d{1,2}.
#\d{1,2}\W

    param( 
        [regex]$RegEx = "\d{1,2}\.\s" 
    )

    foreach ($Word in $WordList) {
        $Modified = $Word -replace "^$RegEx", ""
        Write-Output $Modified
    }