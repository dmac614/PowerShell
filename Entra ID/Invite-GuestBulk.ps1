# Guests to invite
$invites = Import-Csv -Path "C:\PowerShell Dev\Testing\guestUsers.csv"

$message = "Creation of a guest account to access SharePoint resources"

foreach ($inv in $invites) {
    $invParams = @{
        InvitedUserDisplayName = $inv.name
        InvitedUserEmailAddress = $inv.email
        InviteRedirectUrl = "https://myapplications.microsoft.com"
        SendInvitationMessage = $true
        InvitedUserMessageInfo = @{
            CustomizedMessageBody = $message
        }
    }
    
    New-EntraInvitation @invParams
}


