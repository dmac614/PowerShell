<#
.SYNOPSIS
List processes using the most memory

.DESCRIPTION
This script gathers the top 10 WorkingSet (memory) processes in descending order. The custom property object divides the memory proprty by 1GB and displays this as a percentage.

.NOTES
Author: Daniel Macdonald

#>

$highestRAM = get-process | Sort-Object WorkingSet -Descending -Top 10 | Select-Object name,@{
    n='Memory';
    e={'{0:P1}' -f ($_.WorkingSet / 1GB) }
}
