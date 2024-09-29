<#
.SYNOPSIS
Creates multiple user accounts in Active Directory.

.DESCRIPTION
Creates multiple user accounts from corresponding user data csv file which stores the data into the hash table values. 

.NOTES
Author: Daniel Macdonald

1. Add this code in later to check for duplicate accounts

	# Check for a duplicate username i.e an existing account
	if (Get-ADUser -Filter {SamAccountName -eq $row.SamAccountName}) {

		# Write a warning if a username exists
		Write-Warning -Message "An account with username $($Property.Username) already exists."
		}

	else { # Continue from (New-ADUser @UserParams) }


2. Parameters to consider
		-AccountExpirationDate

#>

# Import AD Module
Import-Module -Name ActiveDirectory

# NewUsers CSV File
$CSVData = Import-CSV -Path "C:\PowerShellScripts\Bulk Create AD Users_data.csv"

# ForEach to loop through each row in the CSV file
foreach ($row in $CSVData) {

	# User account parameters
	$UserParams = @{

		Name = $row.Name
		GivenName = $row.FirstName
		Surname = $row.Surname
    DisplayName = $row.Name
		Email = $row.EmailAddress
    Company = $row.Company
    SamAccountName = $row.SamAccountName
    UserPrincipalName = $row.UserPrincipalName
		Path = $row.Path
    AccountPassword = (ConvertTo-SecureString -AsPlainText $row.Password -Force)
    Enabled = $True 
    ChangePasswordAtLogon = $False 
	}

# Create new user accounts with the hashtable data
New-ADUser @UserParams

# When the user is created
Write-Host "The user $($row.SamAccountName) is created." -ForegroundColor Green
}
