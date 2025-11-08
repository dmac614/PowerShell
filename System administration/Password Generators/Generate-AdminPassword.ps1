<# 
This script works with Powershell core but not Windows Powershell. 
#>
#region Generate a password based on account type
function GenerateAdminPassword {

    $lowercaseArray = 'a'..'z',
    $uppercaseArray = 'A'..'Z',
    $symbolsArray = @('/','?','$','[','%','!','.',';','+',']','{','#'),
    $numbers = '0'..'9'

    # Empty array to store the User Account password
    $AdminPassword = @()

    # Get random characters for the password
    $AdminPassword += $lowercaseArray   | get-random -count 5
    $AdminPassword += $uppercaseArray   | get-random -count 5
    $AdminPassword += $numbers          | get-random -count 3
    $AdminPassword += $symbolsArray     | get-random -count 3

    # Join the characters together
    $Admin = $AdminPassword | Get-Random -Count $AdminPassword.Count
    $GenerateAdminPassword = -join $Admin

    # Generate the password
    $GenerateAdminPassword
}

#endregion add characters to password array

GenerateAdminPassword
