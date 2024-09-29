<#
.SYNOPSIS
Creates multiple folders

.DESCRIPTION
Uses a foreach-object loop to create multiple folders. 

.NOTES
Author: Daniel Macdonald

#>

# Folder names to be created
$folders = @("Entra ID","Windows Administration","Active Directory") 

foreach ($item in $folders) {
  new-item -type directory -path "C:\Powershell Scripts\" -name $item 
}
