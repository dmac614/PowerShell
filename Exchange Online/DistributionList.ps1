$names = @("name1","name2")

# Obtain the UPN from Entra
foreach ($user in $names) {
    get-entrauser -searchstring $user | select displayname,userprincipalname
}



# Create a new DL
New-DistributionGroup -name "Retail Sales Team" -displayname "Retail Sales Team" -PrimarySmtpAddress "RetailSalesTeam@xyz.co.uk"

# Array of users to add
$addToDL = @("UPN@xyz.co.uk","UPN@xyz.co.uk")

# Add users to the DL
foreach ($user in $addToDL) {
    Add-DistributionGroupMember -Identity RetailSalesTeam@xyz.co.uk -Member $user
}