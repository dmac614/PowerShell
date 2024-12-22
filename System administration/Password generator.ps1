<# 

This script works with Powershell 7 but not Powershell 5.1. 

#>

# Store all possible password characters
$lowercaseArray = 'a'..'z'
$uppercaseArray = 'A'..'Z'
$symbolsArray = '/','?','$','[','%','!','.',';','+',']','{','#'
$numbers = '0'..'9'
$passwordLength = 16

# Empty array to store the password in
$password = @()

# Add data to the empty array 
$password += $lowercaseArray | get-random -count 5
$password += $uppercaseArray | get-random -count 5
$password += $numbers | get-random -count 3
$password += $symbolsArray | get-random -count 3

# Generate a random password
$password = $password | Get-Random -count $password.Count
$generatePassword = -join $password

$generatePassword
