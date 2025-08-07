<#
.SYNOPSIS
Convert an installer file to an .intunewin file 
.DESCRIPTION
Convert an installer file to an .intunewin file 
.PARAMETER IntuneUtil
This is the path to the Intune utility .exe file
.PARAMETER Source
This is the folder for installer files
.PARAMETER AppExe
This is the name of the file that is to be converted to an .intunewin file
.PARAMETER Output
This is the folder for .intunewin files

.EXAMPLE
.\ConvertTo-IntuneWin.ps1 -AppExe "SophosConnect_2.3.3(IPsec_and_SSLVPN).msi"

.NOTES
Author: Daniel Macdonald

#>
[CmdletBinding()]
param(
    [string]$IntuneUtil = "C:\MicrosftWin32ContentPrepTool\IntuneWinAppUtil.exe",
    [string]$Source = "C:\MicrosftWin32ContentPrepTool\Apps",    
    [Parameter(Mandatory)][string]$AppExe,
    [string]$Output = "C:\MicrosftWin32ContentPrepTool\Intune files"
)
# Move item from Downloads
Move-Item "${env:USERPROFILE}\Downloads\$AppExe" C:\MicrosftWin32ContentPrepTool\Apps\ -Verbose

# Convert to .intunewin file
& $IntuneUtil -c $Source -s $AppExe -o $Output

# Open th directory
Write-Output "Opening the '$Output' directory"
Explorer $Output
