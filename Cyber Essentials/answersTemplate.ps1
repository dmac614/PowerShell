
$commonAnswers = @{
    "2.9" = "Microsoft 365, Exchange Online, SharePoint Online`nTwitter, Facebook, LinkedIn"
    "4.1.1" = "Windows Firewall is deployed via Intune"
    "4.2.1" = "Default passwords are changed during the commissioning process via the management interface of the device concerned"
    "4.5" = "Aspire manage our firewalls and ensure that a fully documented change request process is followed including business authorisation"
    "4.6" = "Aspire have periodic customer meetings to determine customer requirements. If the customer has informed us that a service is not needed we will pro-actively go in to securely disable the service. Our ticketing system ensures continuity of events so we know if any changes have happened- services are reviewed at defined intervals, account managers or members of the service desk can trigger reviews when appropriate- and our service desk procedures ensure that the issue cannot be closed until a resolution is in place"
    "4.8" = "Allowed inbound connections are approved by director level - this is documented internally and recorded into the systems. Associated risks are reviewed regularly, and kept up to date. There is no use of VPN, FTP and our mail is through Microsoft, therefore as it being SaaS based MFA is enforced for security. No unnecessary ports are open on the firewall."
    "4.9" = "The configurations are accessible to access control lists restricted to Aspire offices"
    "4.11" = "An IP allow list is the only way to access the firewall remotely - unless youre on the network itself, all other external access is blocked"
    "5.1" = "Yes. All unnecessary services which can be disabled are disabled during the commissioning process for all devices by our IT provider. Unnecessary software is also removed."
    "5.6" = "Password changes can be completed internally as well as using our 3rd party IT supplier. When a compromise occurs; Aspire or ourselves would access the device remotely/physically and complete a password reset. End user accounts can be managed remotely via 365, all endpoints can be managed remotely (laps is used for admin credentials, which is set to renew password frequently), network devices can be accessed remotely"
    "5.8" = "Attack surface reduction policy in Intune"
    "5.10" = "Username and password; PIN; Windows Hello for Business"
    "6.2.1" = "Microsoft Edge v. {0}; Google Chrome v. {1}"
    "6.2.2" = "CrowdStrike Windows Sensor v. {0}"
    "6.2.3" = "Microsoft 365 Apps for Business - Microsoft Outlook"
    "6.2.4" = "Microsoft 365 Apps for Business"
    "6.4" = "The patches are applied within 14 days and there is a 7-day grace period"
    "6.4.1" = "Ninja RMM manages daily updates on all devices"
    "6.7" = "We have no unsupported software in the business, all software within the business is supported."
    "7.1" = "Yes, all users are provided with a user account - when a new user is due to start, a request is sent in to our IT supplier by an approved manager for the creation of the user. Credentials are then forwarded securely to the approved manager for the new user. Licenses are applied once the user is created, this is all mentioned within the email template we use to send to our IT supplier for the creation of the new user."
    "7.3" = "When staff leave the business, their accounts are disabled - the accounts themselves are blocked from being logged in and the mailbox would get shared with their account manager for access before the full account is then converted to a shared mailbox. Licenses are removed and access to all shared files/folders/locations are revoked."
    "7.4" = "Permissions to file systems are restricted to group based access. Users must be in the correct group to get access, if not they are not able to get to the files. Permissions are granted by an approved user in the business who will contact IT support and ask them to give the permissions needed to the user. Administrative rights are restricted to IT support only, any user needing administrative rights will need to contact IT support and have their request approved before administrative credentials are used by IT support."
    "7.5" = "Yes. An approved user will submit a request to IT support and confirm with them that all details in the request are correct. IT will then grant administrative rights to the required user, and will remove the rights from them as and when it is necessary (this is either specified in the original request or can be removed by opening another IT support request asking for the permission to be revoked by an approved member of staff). If third party support need administrative rights they will access the devices at the same time as IT support, who will input the credentials as necessary and will not share them with the third party support. Requests are recorded by IT company through ticketing system. A ticket it created when the approved user contacts with the request, and the record of the contact from the approved user are kept as well by IT company (both call recordings and emails, however the approved user contacts IT company). This process is on record with both IT company and Diona Construction and is reviewed annually"
    "7.6" = "All user accounts are restricted from carrying out administrative tasks. All administrative tasks require password entry in order to be completed, and those credentials are kept with IT support. A request must be made with IT support in order for them to input the administrative credentials."
    "7.7" = "Administrative accounts do not have email accounts attached to them. All administrative accounts are controlled by IT support, who have to be contacted for their use. All administrative tasks are carried out by IT support."
    "7.10" = "Password complexity requirements including length, upper and lower case letters and numbers must be met for password to be set. All accounts are set to lock out completely after 5 unsuccessful login attempts, and account can only be unlocked by IT support after a request by an approved user. IT will investigate the source of the attempted hacking and take appropriate steps to prevent the attempts in the future."
    "7.11" = "Passwords have a minimum length requirement of 12 characters & no maximum length. Password complexity is enforced (Mixed case + numerals required) users receive regular training and updates on password security."
    "7.12" = "Users receive regular training on password security. We enforce a minimum length of 12 characters and encourage use of passphrases over passwords wherever practical. There is a company approved password manager for storing infrequently used, complex passwords. We do not expire passwords routinely. We enforce only minimal password complexity rules (mixed case + numeral)"
    "7.16" = "Conditional Access policies in Entra ID"
}

function Get-Answer {
    param(
        [string]$questionNo,
        [switch]$showQs,
        [Object[]]$Arguments
    )

    if ($showQs) {
        $commonAnswers 
        return
    }

    if (-not $commonAnswers.ContainsKey($questionNo)) {
    throw "Question $questionNo not found."
}

    $answer = $commonAnswers[$questionNo]

    if ($Arguments) {
        $answer = $answer -f $Arguments
    }

    $answer | Set-Clipboard
    return $answer
}
