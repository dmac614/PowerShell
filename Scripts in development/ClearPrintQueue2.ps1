$Spool = Get-Service Spooler
$SpoolPath = "C:\Windows\System32\spool\PRINTERS"

function ClearPrintQueue() {

        Write-Output "Stopping $(($Spool).Name)`nEmptying $SpoolPath"
        Stop-Service $Spool
        Get-ChildItem $SpoolPath | Remove-Item
        Start-Service $Spool
        
        $SpoolProc = Get-Process -ProcessName spoolsv
        if ($SpoolProc.StartTime -gt $(Get-Date).AddSeconds(-120)) { Write-Output "Spooler has restarted successfully" } else { Write-Error "An error occurred" }
    }   

ClearPrintQueue