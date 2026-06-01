<#
    Use this command to find the available roles
    Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq 'Global Administrator'"

#>

# Create a role assigned group
$params = @{
	DisplayName = "Global administrators role"
	Description = "This group assigns the Global administrators role"
	MailNickname = "GArole"
 	MailEnabled = $false
	SecurityEnabled = $true
	IsAssignableToRole = $true
}

$group = New-EntraGroup @params

# Get a role definition
$role = Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq 'Global Administrator'"

# Assign the role to the group
$assignRole = New-MgRoleManagementDirectoryRoleAssignment -DirectoryScopeId '/' -RoleDefinitionId $role.Id -PrincipalId $group.Id


# Assign an owner to the role group to manage access
$global = get-entrauser -all | Where-Object {$_.displayname -match "global" }
Add-EntraGroupOwner -GroupId $ga.Id -OwnerId $global.id

