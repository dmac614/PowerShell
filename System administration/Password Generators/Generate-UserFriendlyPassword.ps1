<#
.SYNOPSIS
Generate a password that is user friendly, readable, and secure
.DESCRIPTION
Combines a word with X letters, another word with X letters, and two numbers. These are separated by a hyphen -
Example of a password: Word-test-00

# Expand the script:
Add $ThreeLetters and $SevenLetters variables
Update the word list with three and seven letter words
.EXAMPLE
Generate-UserFriendlyPassword.ps1
.NOTES
Author: Daniel Macdonald

#>
#region Variables and data
param( $Num = '0'..'9' )
    
    # This file contains the words to generate passwords with
    $Content = Get-Content -Path ".\WordList.txt"
    
    # Password criteria
    $FourLetters = $Content | Where-Object { $_.Length -eq 4 } | Get-Random
    $FiveLetters = $Content | Where-Object { $_.Length -eq 5 } | Get-Random 
    $SixLetters  = $Content | Where-Object { $_.Length -eq 6 } | Get-Random
    
    $TwoNumbers  = $Num     | Get-Random -Count 2
#endregion

#region Generate the password
    $Content | Get-Random | ForEach-Object {

        if ($_.Length -match $FourLetters.Length) {
            $Pass1 = Write-Output "$_-" "$( ($SixLetters).ToLower() )-" "$( $TwoNumbers | Join-String )"
            $Pass1 | Join-String
        }
        
        elseif ($_.Length -match $FiveLetters.Length) {
            $Pass2 = Write-Output "$_-" "$( ($FiveLetters).ToLower() )-" "$( $TwoNumbers | Join-String )"
            $Pass2 | Join-String
        }
        
        elseif ($_.Length -match $SixLetters.Length) {
            $Pass3 = Write-Output "$_-" "$( ($FourLetters).ToLower() )-" "$( $TwoNumbers | Join-String )"
            $Pass3 | Join-String
        } 
    }
#endregion