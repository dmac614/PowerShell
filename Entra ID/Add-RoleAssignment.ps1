<#
    The user's objectID and the roleID are required
    Use Get-EntraDirectoryRoleTemplate to see all the role templates
    - Roles must be activated first before a user can be assigned to one
    - Get-MgDirectoryRole only displays active roles i.e roles which at least one user is assigned to
#>


param(
    [string]$displayName
)

# Store the user in a variable 
get-entrauser -all | Where-Object { $_.displayname -match $displayname } -OutVariable $user

Get-EntraDirectoryRoleTemplate | select id,displayname,description | sort displayname


# Store the role in a variable
$roleId = New-MgDirectoryRole -roleTemplateId "5d6b6bb7-de71-4623-b4af-96380a352509"
$roleId | select id,DisplayName,Description

# Verify role exists
Get-MgDirectoryRole | Format-List

# Required syntax 
# "https://graph.microsoft.com/v1.0/directoryObjects/5d6b6bb7-de71-4623-b4af-96380a352509"
$UserObjectId = @{ "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($user.id)" }

# Assign the role to the user
New-MgDirectoryRoleMemberByRef -DirectoryRoleId $roleId.id -BodyParameter $UserObjectId