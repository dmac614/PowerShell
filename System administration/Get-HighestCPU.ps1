<#
.SYNOPSIS
List processes using the most CPU.

.DESCRIPTION
This script gathers the top 10 CPU processes in descending order. The custom property object divides the CPU proprty by 1KB and displays this as a percentage.

.NOTES
Author: Daniel Macdonald

#>

function Get-HighestCPU {
    
        $SortObjProps = @{
            Property = "CPU"
            Descending = $true 
        },

        $CPUProps = @{
            First = 10
            Property = @(
                "Name",
                @{n='CPU';e={ '{0:P1}' -f ($_.CPU / 1KB) }}
            )
        }
  
    # List the top 10 processes with the highest CPU
    Get-Process | Sort-Object @SortObjProps  | Select-Object @CPUProps
}

Get-HighestCPU