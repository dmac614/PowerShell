<#
.SYNOPSIS
Gather information about a Windows computer system. 

.DESCRIPTION
The following script gathers information about the system specifications.
Information such as the computer name; logged on username; domain name; OS and OS version; BIOS info; manufacturer make and model; memory and disk size.
Memory and disk information is divided into gigabytes. 

.NOTES
Author: Daniel Macdonald

#>

# Function which contains the commands to gather the information
function ComputerDetails {
    
        $CompInfoProps = @(
            "csname","csusername","CsDomain","OsName","osversion","BiosSeralNumber","BiosSMBIOSBIOSVersion","CsManufacturer","CsModel",
            @{n='CsTotalPhysicalMemory'; e={ '{0:N2}' -f ($_.CsTotalPhysicalMemory/1GB) }}
        ),

        $DiskProps = @(
            "DeviceID",
            @{n='Size';e={ '{0:N2}' -f ($_.Size / 1GB) }},
            @{n='FreeSpace';e={ '{0:N2}' -f ($_.FreeSpace / 1GB) }}
        )
    
    # Gather specs about the computer system
    Write-Output "Specifications about the computer system:"

    # Computer specs
    Get-ComputerInfo | Select-Object $CompInfoProps
    
    # Disk space
    Write-Output "Disk information in gigabytes:`n"
    Get-CimInstance -ClassName Win32_LogicalDisk -Filter "drivetype=3" | Select-object $DiskProps
} # end function

# Invoke the function
ComputerDetails
