<#

** Unfinished **

## Plan
This is a script for converting Object IDs to the name of an object 

e.g Convert-ObjectIDs -Type User

#>

function Convert-ObjectIDs {
    param(
        [string][ValidateSet("User","Group","Device")]$Type,
        [string]$IDs = "C:\PS Demo\Working with files\IDs.txt"
    )
    
    switch ($Type) { 
        "User" { 
            Get-Content -Path $IDs | ForEach-Object { Get-MgUser -UserId $_ } | Select-Object DisplayName 
        }
        "Group" { 
            Get-Content -Path $IDs | ForEach-Object { Get-MgGroup -GroupId $_ } | Select-Object DisplayName 
        }
        "Device" { 
            Get-Content -Path $IDs | ForEach-Object { Get-MgDevice -DeviceId $_ } | Select-Object DisplayName 
        }
    }
}
