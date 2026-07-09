param(
    [string]$keyword,
    [string[]]$users,

    [switch]$single,
    [switch]$multiple
)

    $mailboxParams = @(
        "Name",
        "DisplayName",
        "PrimarySmtpAddress",
        "UserPrincipalName",
        "RecipientTypeDetails",
        "IsInactiveMailbox",
        "AccountDisabled"
    )

    if ($single){

        try {
            Get-Mailbox -anr $keyword | Select-Object $mailboxParams | Tee-Object -Variable mailbox
            ""
            $mailbox.PrimarySmtpAddress
            


        } catch [System.Exception] { $error[0] }

    }


    if ($multiple) {

        try {
            $users | ForEach-Object {
                Get-mailbox -anr $_ | Select-Object $mailboxParams
            }
        


        } catch [System.Exception] { $error[0] }

    }