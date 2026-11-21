<#
  See my notes from the below repository on creating the enterprise app + client secret
  https://github.com/dmac614/Useful-Commands/blob/main/Microsoft%20365%20administration/Microsoft-Graph.ps1
#>

# This is the appID of the enterprise email app
$emailAppClientCreds = Get-Credential -UserName "ca27430e-3f11-40e7-a74b-1dc9aebfc4f1"

# Connect to the Entra ID tenant with the enterprise app-only permissions  
Connect-MgGraph -TenantId "ccd5a42d-4beb-4856-b324-d3498aa10af5" -ClientSecretCredential $emailAppClientCreds

# Sender email address
$senderEmail = "global@dmac.ml"
$senderEmail1 = "bduncanson@dmac.ml"

# Email body 
$emailParams = @{

	# The content of the email 
    Message = @{
        Subject = "Sending an email from Microsoft Graph Powershell"
        Body    = @{
            ContentType = "HTML"
            Content     = "<p>This is a test email from dmac admin."
        }

		# The recipient of the email; these are properties of the emailObject
        ToRecipients = @(
            @{
                emailAddress = @{
                   Address = "dmacdonald@dmac.ml"
                }
            }
        )
    }
	# This is true by default
    saveToSentItems = $true
}

# Send the email to the recipient from the sending address
Send-MgUserMail -UserId $senderEmail -BodyParameter $emailParams
