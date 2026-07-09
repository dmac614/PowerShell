# Still to be created as a script #

# Use Search-anr.ps1 to get the UPNs
# Join UPN + calendar syntax to create the appropriate string

# "email address" = the user getting access to the calendars

# List the perms of the calendars
foreach ($m in $cals) { Get-EXOMailboxFolderPermission -Identity $m | ? {$_.user -ne "email address"} | ft }


# Assign the perms
foreach ($m in $cals) { Add-MailboxFolderPermission -Identity $m -User "email address" -AccessRights editor -SharingPermissionFlags delegate }