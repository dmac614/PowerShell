<# 

This script works with Powershell 7 but not Powershell 5.1. 

#>


#region all possible password characters
$lowercaseArray = 'a'..'z'
$uppercaseArray = 'A'..'Z'
$symbolsArray = '/','?','$','[','%','!','.',';','+',']','{','#'
$numbers = '0'..'9'
$passwordLength = 16
#endregion all possible password characters

#region add characters to password array
# Empty array to store the password in
$password = @()

$password += $lowercaseArray | get-random -count 5
$password += $uppercaseArray | get-random -count 5
$password += $numbers | get-random -count 3
$password += $symbolsArray | get-random -count 3
#endregion add characters to password array

#region generate a password
$password = $password | Get-Random -count $password.Count
$generatePassword = -join $password

$generatePassword
#endregion generate a password
