<#
    if SendInvitationMessage = true

    $message = "enter an invite message"
    InvitedUserMessageInfo = @{
        CustomizedMessageBody = $message
    }
#>

$inviteURL = "https://myapplications.microsoft.com/?tenantid=ccd5a42d-4beb-4856-b324-d3498aa10af5"

$invParams = @{
	InvitedUserDisplayName = "dmac gmail"
	InvitedUserEmailAddress = "macdonaldd116@gmail.com"
	InviteRedirectUrl = $inviteURL
	SendInvitationMessage = $false
}

New-EntraInvitation @invParams