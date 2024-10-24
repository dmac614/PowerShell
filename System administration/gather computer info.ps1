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

    # Gather specs about the computer system
    "Gathering information...`n"

    "Specifications about the computer system."
    Get-ComputerInfo | 
    Select-Object csname,csusername,CsDomain,OsName,osversion,BiosSeralNumber,BiosSMBIOSBIOSVersion,CsManufacturer,CsModel,@{
        n='CsTotalPhysicalMemory';
        e={ '{0:N2}' -f ($_.CsTotalPhysicalMemory/1GB) }
    }

    # Gather disk size and free space
    "Disk information in gigabytes.`n"
    Get-CimInstance -ClassName Win32_LogicalDisk -Filter "drivetype=3" | 
    Select-object DeviceID,
    @{
        n='size';
        e={ '{0:N2}' -f ($_.size/1gb) }
    },
    @{
        n='freespace';
        e={ '{0:N2}' -f ($_.freespace/1gb) }
    }
}

# Invoke the function
ComputerDetails
