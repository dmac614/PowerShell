<#
.SYNOPSIS
Install Windows updates 

.DESCRIPTION
Install Windows updates 

.NOTES
Author: Daniel Macdonald

#>

# Set execution policy
Set-ExecutionPolicy remotesigned

# Install then import module
Install-module -name pswindowsupdate | Import-Module pswindowsupdate

# Get updates, accept them, then install them
Get-WindowsUpdate -AcceptAll -Install -Verbose
