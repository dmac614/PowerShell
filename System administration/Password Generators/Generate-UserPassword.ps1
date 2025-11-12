<# 
This script works with Powershell core but not Windows Powershell. 
#>
#region Generate a password based on account type
function GenerateUserPassword {

    $lowercaseArray = 'a'..'z'
    $uppercaseArray = 'A'..'Z'
    $symbolsArray = @('/','?','$','[','%','!','.',';','+',']','{','#')
    $numbers = '0'..'9'

    # Empty array to store the User Account password
    $UserPassword  = @()

    # Get random characters for the password
    $UserPassword += $lowercaseArray    | get-random -count 5
    $UserPassword += $uppercaseArray    | get-random -count 5
    $UserPassword += $numbers           | get-random -count 1
    $UserPassword += $symbolsArray      | get-random -count 1

    # Join the characters together
    $User = $UserPassword | Get-Random -Count $UserPassword.Count
    $GenerateUserPassword = -join $User

    # Generate the password
    $GenerateUserPassword
}

#endregion add characters to password array

GenerateUserPassword
