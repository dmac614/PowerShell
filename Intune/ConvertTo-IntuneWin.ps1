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
# Variables 
[string]$IntuneUtil = "C:\MicrosftWin32ContentPrepTool\IntuneWinAppUtil.exe"
[string]$Source = "C:\MicrosftWin32ContentPrepTool\Apps"
[string]$Output = "C:\MicrosftWin32ContentPrepTool\Intune files"

# The downloaded item
$DownloadedFileName = (get-childitem ${env:USERPROFILE}\downloads | sort LastWriteTime)[-1].FullName | Split-Path -Leaf

# Move item from Downloads
Move-Item "${env:USERPROFILE}\Downloads\$DownloadedFileName" C:\MicrosftWin32ContentPrepTool\Apps\ -Verbose

# Convert to .intunewin file
& $IntuneUtil -c $Source -s $DownloadedFileName -o $Output

# Open th directory
Write-Output "Opening the '$Output' directory"
Explorer $Output
