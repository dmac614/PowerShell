$copyPaste = @{
    keeperCreds = "cyber essentials client credentials"
    ticketTitle = "Cyber Essentials assessment" 
    ticketNotes = "{0} Cyber Essentials assessment is ready to be assessed"
    workRequired = "Review the assessment questionnaire in the IASME portal and provide any feedback if more information about the customer's estate is required"
    updateCustomer = "I have emailed you with outstanding questions to answer for the Cyber Essentials questionnaire which contains a link to the IASME portal. Please answer them at your earliest convenience."
    DefenderVersion = "defender antivirus definition updates"
    certificate = "Please see attached the issued Cyber Essentials certificate.`n`nThanks for your patience throughout."
    validation = "The Validation Request email has been sent to your inbox now. Please validate the answers so we can proceed with the assessment.`n`nThanks"
}



function Get-Note {
    param(
        [string]$questionNo,
        [switch]$showQs,
        [Object[]]$Arguments
    )

    if ($showQs) {
        $copyPaste 
        return
    }

    if (-not $copyPaste.ContainsKey($questionNo)) {
    throw "Question $copyPaste not found."
}

    $answer = $copyPaste[$questionNo]

    if ($Arguments) {
        $answer = $answer -f $Arguments
    }

    $answer | Set-Clipboard
    return $answer
}