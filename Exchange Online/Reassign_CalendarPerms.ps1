function Reassign_CalendarPerms {
    <#
    .SYNOPSIS
    Removes then reassigns permissions to a calendar
    .DESCRIPTION
    Checks a user has access to a mailbox's calendar by the user's display name; removes this access and confirms the removal; waits 10 minutes before reassigning the same access
    You will need to authenticate to EXO using the 'Connect-ExchangeOnline -UserPrincipalName [admin acc] -LoadCmdletHelp' cmdlet
    .PARAMETER MailboxUPN
    This identifies the mailbox which has the calendar folder
    .PARAMETER UserDisplayName
    This displays the name of the user who has access to the calendar folder
    .PARAMETER Calendar
    This switch parameter adds the identified mailbox together with the calendar syntax i.e 'Mailbox@domain.com:\calendar'
    .EXAMPLE
    Reassign_CalendarPerms -MailboxUPN 'Mailbox@domain.com' -Calendar -UserDisplayName 'Jane Doe' 
    .NOTES
    Author: Daniel Macdonald
    #>
    [CmdletBinding()]
        param(
            [Parameter(Mandatory)][string]$MailboxUPN,
            [Parameter(Mandatory)][string]$UserDisplayName,
            [ValidateSet("Yes", "No")][string]$Question,
            [switch]$Calendar
        )
    
        # Concatenate the mailbox with the calendar syntax
        if ($Calendar) { $MailboxUPN = $MailboxUPN + ':\calendar' }
    
        ##### Script #####
    
        # Phase 1: get permissions; remove them
        try {
            Write-Output "Getting '$MailboxUPN' permissions for '$UserDisplayName'"
    
            # List user's permissions 
            $ConfirmPerms = Get-MailboxFolderPermission -Identity $MailboxUPN | Where-Object { $_.User -match $UserDisplayName } 
            if ($ConfirmPerms) { 
                Write-Output "'$UserDisplayName' has '$(($ConfirmPerms).AccessRights)' access."
                Write-Output "Do you want to remove '$(($ConfirmPerms).AccessRights)' permissions for '$UserDisplayName' on the '$MailboxUPN' calendar?"
                $Question = Read-Host -Prompt "Yes or no"
    
                if      ($Question -eq 'No' ) { Return }
                elseif  ($Question -eq 'Yes') { Remove-MailboxFolderPermission -Identity $MailboxUPN -User $UserDisplayName -Confirm:$false }
            }
            else { 
                Write-Output "Could not retrieve permissions"
                Return
            }
            
        }
        catch [System.Exception] {
            Write-Error "Exception encountered"
            Write-Error $Error[0] -ErrorAction Stop
        }
    
        # Phase 2: confirm removal; reassign permissions
        try {
            $ReConfirmPerms = Get-MailboxFolderPermission -Identity $MailboxUPN | Where-Object { $_.User -match $UserDisplayName } 
            if ($null -eq $ReConfirmPerms) {
                Write-Output "Permissions have been removed."
            }
        
            # Wait 10 mins before reassigning permissions
            Write-Output "Reassigning permissions in 10 minutes."
            Start-Sleep -Seconds 180
            Write-Output "Reassigning permissions in 7 minutes."
            Start-Sleep -Seconds 120
            Write-Output "Reassigning permissions in 5 minutes."
            Start-Sleep -Seconds 120
            Write-Output "Reassigning permissions in 3 minutes."
            Start-Sleep -Seconds 180
        
            # Add permissions
            Write-Output "Assigning '$(($ConfirmPerms).AccessRights)' permissions for '$UserDisplayName' on the '$MailboxUPN' calendar"
            Add-MailboxFolderPermission -Identity $MailboxUPN -User $UserDisplayName -AccessRights $(($ConfirmPerms).AccessRights)
        
            $ConfirmPerms = Get-MailboxFolderPermission -Identity $MailboxUPN | Where-Object { $_.User -match $UserDisplayName } 
            if ($ConfirmPerms) { Write-Output "`nPermissions have successfully been reassigned." }
            else { Write-Output "Could not reassign permissions." }
        }
        catch [System.Exception] {
            Write-Error "Exception encountered"
            Write-Error $Error[0] -ErrorAction Stop
        }
    }
