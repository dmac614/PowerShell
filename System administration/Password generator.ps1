# Store all possible password characters
$lowercaseArray = 'a'..'z'
$uppercaseArray = 'A'..'Z'
$symbolsArray = '/','?','$','[','%','!','.',';','+',']','{','#'
$numbers = '0'..'9'
$passwordLength = 16

# Empty array to store the password in
$generatePassword = @()

# Add data to the empty array 
$generatePassword += $lowercaseArray | get-random -count 5
$generatePassword += $uppercaseArray | get-random -count 5
$generatePassword += $numbers | get-random -count 3
$generatePassword += $symbolsArray | get-random -count 3

# Generate a random password
$generatePassword = $generatePassword | Get-Random -count $generatePassword.Count
$password = -join $generatePassword

$password
