param(
    [switch]$openWindow,
    [switch]$closeWindow
)

    if ($openWindow) {

        & "C:\Program Files\Google\Chrome\Application\chrome.exe" --incognito --window-name="365 Tenant" --window-position=2200,100 --window-size=1600,900 "https://admin.microsoft.com"

    }

    if ($closeWindow) {
        
        try {

            #powershell.exe
            $inPriv = get-process chrome | Where-Object { $_.MainWindowTitle -match '365 Tenant' }
            $inPriv.CloseMainWindow()
        
        } catch {
            "The browser is not in focus or it is not open"
        }

    }

