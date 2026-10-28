$downloads = "${env:USERPROFILE}\Downloads\"
$ninjaDevicesFile = Get-ChildItem $downloads | Where-Object { $_.Name -match 'devices' } | Sort-Object LastWriteTime | Select-Object -Last 1

# Devices CSV -- import the objects
$devices = Import-Csv -Path $ninjaDevicesFile.FullName | Select-Object "Organization","Device Role","OS Name","OS Build Number","OS Release Id","Device Make","Device Model","System Name"


$deviceGroups = $devices | 
    ForEach-Object {
        [PSCustomObject]@{

        Org = [PSCustomObject]@{
            Org = $_.Organization
            }


        Device = [PSCustomObject]@{
            Role = $_."Device Role"
            Make = $_."Device Make"
            Model = $_."Device Model"
            SystemName = $_."System Name"
            }

        OS = [PSCustomObject]@{
            Name = $_."OS Name"
            Build = $_."OS Build Number"
            Release = $_."OS Release Id"
            }
        }
}

# Displaying the output
$formattedDevices = $devices |
Group-Object "Device Role","Device Make","OS Name","OS Build Number","OS Release Id" |
Select-Object @{
        Name='Count'
        Expression={$_.Count}
    },  @{
        Name='Role'
        Expression={$_.Group[0].'Device Role'}
    }, @{
        Name='Make'
        Expression={$_.Group[0].'Device Make'}
    }, @{
        Name='OSName'
        Expression={$_.Group[0].'OS Name'}
    }, @{
        Name='Build'
        Expression={$_.Group[0].'OS Build Number'}
    }, @{
        Name='Release'
        Expression={$_.Group[0].'OS Release Id'}
    } |
Sort-Object Role,Count -Descending |
Format-Table -AutoSize

Write-Output "The organisation is: $($devices.Organization[0])"
$formattedDevices
