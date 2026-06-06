param($username)

$userPath           = "C:\users\"
$downloadedFileName = (get-childitem $userPath\$username\downloads | Sort-Object LastWriteTime)[-1].FullName
#$downloadedFileName = (get-childitem C:\users\D_Macdonald\downloads | Sort-Object LastWriteTime)[-1].FullName


function Get-TempFolder {
    param(
        [string]$Global:TempFolder = 'C:\Temp'
    )       
    # If the Temp folder doesn't exist, create it
    if (! (Test-Path -Path $TempFolder)) {
        New-Item -Path ${env:SystemDrive}\ -Name Temp -ItemType Directory
        Write-Output "`n$TempFolder has been created"
    } 
    else {
        Write-Output "$TempFolder already exists."
    }
}

Get-TempFolder
Copy-Item -Path $downloadedFileName -Destination $Global:TempFolder

$leaf = $downloadedFileName | Split-Path -leaf

try {

    if (Test-Path $Global:TempFolder\$leaf){
        Write-Output "The file copied successfully"
    }

} catch [System.Exception] {
    Write-Output $Error[0]
}