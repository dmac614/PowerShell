$driverPath = "C:\Drivers"
$driverFile = "C:\Temp\CNLB0MA64.INF"
$msiFile    = "C:\temp\EWPrint.Setup.msi"
$msiLog     = "C:\temp\msiInstallLog.txt"
$printerScript  = "C:\Temp\Add-UACPrinters.ps1"


$printers = get-printer | ? { $_.name -match "UAC_" }
if ($printers -and $printers.name.count -eq 7) {
    "EW printers are already installed"
    Break

} else { "Continuing script to install printers" } 


# Check if C:\Drivers exists, copy the .inf
try {
    
    if (! (Test-Path $driverPath) ){
        New-Item -ItemType Directory -Path $driverPath -ErrorAction Stop | Out-Null
    }

    Copy-item $driverFile -Destination $driverPath -ErrorAction Stop
    Write-Output "Created $driverPath `n$driverPath contains the .inf file"
    
} catch {

    Write-Error $_.Exception.Message

}


# Install the msi file and create a log file
$installMSi = Start-Process -FilePath $msiFile -ArgumentList "/I /qn /norestart /L*V $msiLog" -Wait -PassThru
"EW Print installer exit code: $($installMSi.ExitCode)"
    if ($installMSi.ExitCode -in 0,3010){
        "EW Print installed successfully"
    
    } else { Write-Warning "EW Print install failed" }

# "Waiting 5 minutes for the .msi to install"
# Start-Sleep -Seconds 180

# Run the script to install printers
Start-Process -FilePath $printerScript -Wait

if ($printers -and $printers.name.count -eq 7) {
    "UAC printers are now installed"
}
