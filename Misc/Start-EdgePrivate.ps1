<#

    .EXAMPLE
    # To open an inprivate Edge window
    .\Start-EdgePrivate.ps1 -openWindow

    # To close the current inprivate Edge window (the inprivate Edge window has to be in focus)
    .\Start-EdgePrivate.ps1 -closeWindow

#>

param(
    [switch]$openWindow,
    [switch]$closeWindow
)

    if ($openWindow) {

        & "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --inprivate --window-name="365 Tenant" "https://admin.microsoft.com"

    }

    if ($closeWindow) {
        
        try {

            #powershell.exe
            $inPriv = get-process msedge | Where-Object { $_.MainWindowTitle -match '365 Tenant' }
            $inPriv.CloseMainWindow()
        
        } catch {
            "The browser is not in focus or it is not open"
        }

    }

