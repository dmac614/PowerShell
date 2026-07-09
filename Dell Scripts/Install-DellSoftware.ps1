# syntax: "C:\TEMP\Latitude_XXXX_X.XX.X.exe"

# upload the DCU exe to the user's temp folder

param(
    [switch]$DCU
)

if ($DCU){

    $dcuInstallPath = "C:\Program Files\Dell\CommandUpdate\"
    $dcuInstaller = "C:\TEMP\Dell-Command-Update-Windows-Universal-Application_FGK9X_WIN64_5.7.0_A00.EXE"
    $logFile = "C:\TEMP\DellSoftware.txt"
        
        $installSW = Start-Process -FilePath $dcuInstaller -ArgumentList "/s /l=$logFile" -Wait -PassThru -Verbose
        if (Test-Path $dcuInstallPath) { 
            "DCU is installed"
        } else { "DCU not found" }

}