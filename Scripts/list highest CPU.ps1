﻿<#
.SYNOPSIS
List processes using the most CPU.

.DESCRIPTION
This script gathers the top 10 CPU processes in decending order. The custom property object divides the CPU proprty by 1KB and displays this as a percentage.

.NOTES
Author: Daniel Macdonald

#>

$highestCPU = get-process | sort-Object CPU -Descending -Top 10 | Select-Object name,@{
    n='CPU';
    e={ '{0:P1}' -f ($_.CPU / 1KB) }
}