# Search for mailboxes using keywords
$mailboxParams = @(
    "PrimarySmtpAddress",
    "UserPrincipalName",
    "RecipientTypeDetails",
    "IsInactiveMailbox",
    "AccountDisabled"
)

get-mailbox -anr "<keyword>"
get-mailbox -anr "paul" | Select-Object $mailboxParams | Tee-Object -Variable mailbox
$mailbox.PrimarySmtpAddress


# Add users to the allow/block list
# Use the -allow or -block switch
New-TenantAllowBlockListItems -ListType Sender -Entries "lottierobb@tiscali.co.uk" -NoExpiration -Block 


# Msg trace
function Get-MsgTrace {
    [CmdletBinding()]
    param(
        [string]$recipientEmail,
        [string]$sendingEmail,
        [string]$subject,

        [switch]$chooseDate,
        [switch]$lastTenDays,
        [switch]$lastThreeMonths,

        [switch]$onlySender,
        [switch]$onlyRecipient
    )

    $ninetyDaysAgo  = (Get-Date).AddDays(-90),
    $tenDaysAgo     = (Get-Date).AddDays(-10),
    $today          = [datetime]::UtcNow
    $enterDate      = [datetime]::new(2026,01,01)

    switch(CustomSearch){

        $lastTenDays {
            StartDate   = $tenDaysAgo
            EndDate     = $today
        }

        $lastThreeMonths {
            StartDate   = $ninetyDaysAgo
            EndDate     = $today
        }

        $chooseDate {
            StartDate   = 
            EndDate     = 
        }

    }

    if ($lastTenDays -and $onlySender){
        $Send = @{ SenderAddress = $sendingEmail}
        Get-MessageTraceV2 -StartDate $tenDaysAgo -EndDate $today $Send
    } 


}


