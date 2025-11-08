<#
.SYNOPSIS
List processes using the most memory

.DESCRIPTION
This script gathers the top 10 WorkingSet (memory) processes in descending order. The custom property object divides the memory proprty by 1GB and displays this as a percentage.

.NOTES
Author: Daniel Macdonald

#>

function Get-HighestRAM {

        $SortObjProps = @{
            Property = "WorkingSet"
            Descending = $true
        },

        $MemoryProps = @{
            First = 10
            Property = @(
                "Name",
                @{n='Memory';e={'{0:P1}' -f ($_.WorkingSet / 1GB) }}
            )
        }
    
    # List the top 10 processes with the highest memory
    Get-Process | Sort-Object @SortObjProps | Select-Object @MemoryProps
}

Get-HighestRAM