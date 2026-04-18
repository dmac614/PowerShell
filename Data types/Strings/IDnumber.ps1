param(
    [int]$ticketID
)

function addTicketID() {
$firstFile = "C:\PowerShell Dev\PowerShell\Data types\Strings\firstResponse.txt"
$secondFile = "C:\PowerShell Dev\PowerShell\Data types\Strings\secondResponse.txt"

$noResponse = Write-Output "As we have not received a response on this ticket we will now be closing it.

If you still require assistance can you please call 03301242701 when you have a moment and quote reference $ticketID so that we can assist you.

Thanks very much"
    
$ticketClosure = Write-Output "Advised the customer to call us when they have availability and quote reference $ticketID so that we can assist"
    
    $noResponse | Out-File -FilePath $firstFile
    $ticketClosure | Out-File -FilePath $secondFile

    Start-Process -FilePath $firstFile
    Start-Process -FilePath $secondFile

}

addTicketID
