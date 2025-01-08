<#
.SYNOPSIS
Get the serial number of a Dell monitor.

.DESCRIPTION
Utilise Dell CLI tools to gather the serial number of a Dell monitor.
The second script is separate due to the current user (of the PShell console) being my admin account which is unlicensed and unable to open the Word document.

.NOTES
Author: Daniel Macdonald

#>


## First script -- run PShell as admin ##

param([string]$Workstation = "1.00")


# Regular expression for the serial number
$SerialNumber = [regex]",(.{7}),"

# Get the workstation number

# cd to 'C:\Program files\Dell\Dell Display Manager 2'
.\ddm.exe /Log C:\temp\dell\"ddm$($Workstation)".txt /1:readassetattributes /2:readassetattributes

# Pause to buy time for the above command to gather the serial number(s)
Start-Sleep -Seconds 5

# Create variable to match the content with the regex
$File = Get-Content -path C:\temp\dell\"ddm$($Workstation)".txt

# 
Start-Sleep -Seconds 3

# Create a word doc when the regex is matched
if ($file -match $SerialNumber) { 
	New-Item -path "C:\temp\dell\ddm$($Workstation).docx" -ItemType file
	#Get-content -path "C:\temp\dell\ddm$($Workstation).txt" | clip
}


## Second script -- run a normal PShell session ##

param([string]$Workstation = "1.00")

# Enter the same workstation number 
#$Workstation = Read-Host -Prompt "DDM number?"

# Copy the serial number data
$TxtFileContent = get-content -path C:\temp\dell\ddm$($Workstation).txt | clip

# Start the Word document process
Start-process -filepath C:\temp\dell\ddm$($Workstation).docx
