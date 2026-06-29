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

