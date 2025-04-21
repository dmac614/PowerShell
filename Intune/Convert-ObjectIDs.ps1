<#

** Unfinished **

## Plan
This is a script for converting Object IDs to the name of an object 

Run a command that outputs Object IDs, use the name property to return the IDs
(Get-DistributionGroupMember -Identity 'all company').name
Store the IDs in a file
Run this function to convert the IDs 
No doubt will have to be adapted depending on what object IDs are needing converted

Figure out a way to give results based on the objects being Users, Groups, or Devices
-- Use conditions 

#>

function Convert-ObjectIDs {

    # Store the IDs in a text file
    $IDs = Get-Content -Path '.\Working with files\IDs.txt'
    $IDs | ForEach-Object { Get-User -Identity $_ } | Select-Object Name,DisplayName
    # $IDs | ForEach-Object { Get-[Group] -Identity $_ } | Select-Object Name,DisplayName
    # $IDs | ForEach-Object { Get-[Device] -Identity $_ } | Select-Object Name,DisplayName

}
