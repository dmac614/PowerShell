$downloads = "${env:USERPROFILE}\Downloads\"
$zipFolder = get-childitem -Path $downloads | Where-Object { $_.name -match "DevicesWithInventory"} | Sort-Object LastWriteTime | Select-Object -Last 1
$destinationFolder = $downloads
function ExtractCSV {
    Expand-Archive -Path $zipFolder -DestinationPath $destinationFolder
}

ExtractCSV

$devicesCSV = get-childitem -Path $downloads | Where-Object { $_.name -match "DevicesWithInventory" -and $_.Extension -eq '.csv'} | Sort-Object LastWriteTime | Select-Object -Last 1

$importDevicesCSV = Import-Csv -Path $devicesCSV | Select-Object -Property "Manufacturer","OS","OS version","Model"


$formattedDevices = $importDevicesCSV |
Group-Object "Manufacturer","OS","OS version" |
Select-Object @{
        Name='Count'
        Expression={$_.Count}
    }, @{
        Name='Manufacturer'
        Expression={$_.Group[0].Manufacturer}
    }, @{
        Name='OS'
        Expression={$_.Group[0].'OS'}
    }, @{
        Name='OS version'
        Expression={$_.Group[0].'OS version'}
    }, @{
        Name='Model'
        Expression={$_.Group[0].Model}
    } |
Sort-Object "OS Version" |
Format-Table -AutoSize

$formattedDevices