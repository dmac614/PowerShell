<#
.SYNOPSIS
List processes using the most CPU.

.DESCRIPTION
This script gathers the top 10 CPU processes in descending order. The custom property object divides the CPU proprty by 1KB and displays this as a percentage.

.NOTES
Author: Daniel Macdonald

#>

$highestCPU = get-process | Sort-Object CPU -Descending | Select-Object -First 10 name,@{
    n='CPU';
    e={ '{0:P1}' -f ($_.CPU / 1KB) }
}
