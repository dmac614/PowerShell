<#
    If a Windows client returns with the OS Release Id '24H2' = it needs to be upgraded
#>

$downloads = "${env:USERPROFILE}\Downloads\"
$ninjaDevicesFile = Get-ChildItem $downloads | Where-Object { $_.Name -match 'devices' } | Sort-Object LastWriteTime | Select-Object -Last 1

# Devices CSV -- import the objects
$devices = Import-Csv -Path $ninjaDevicesFile.FullName | Select-Object "Organization","Device Role","OS Name","OS Build Number","OS Release Id","Device Make","Device Model","System Name"





function Get-Upgrade {
    param(
        [switch]$Laptop,
        [switch]$Desktop,
        [switch]$Server
    )

    # Windows Laptops
    if ($laptop){
        $laptopProperties = $ninjaDevicesFile | Select-Object $props | Where-Object { $_.'Device role' -match "Windows Laptop"} | Sort-Object 'os build number'
    
        foreach($obj in $laptopProperties){
            if($obj.'OS Name' -match "Windows 10"){
                Write-Output "Upgrade to Windows 11: $($obj.'System name')"
            }

            if ($obj.'os release id' -lt '25H2'){
                Write-Output "Upgrade OS for: $($obj.'System name')"
            }
        }
    }
        
    # Windows Desktop
    if ($desktop){
        $desktopProperties = $ninjaDevicesFile | Select-Object $props | Where-Object { $_.'Device role' -match "Windows Desktop"} | Sort-Object 'os build number'
    
        foreach($obj in $desktopProperties){
            if($obj.'OS Name' -match "Windows 10"){
                Write-Output "Upgrade to Windows 11: $($obj.'System name')"
            }

            if ($obj.'os release id' -lt '25H2'){
                Write-Output "Upgrade OS for: $($obj.'System name')"

            }
        }
    }

    if ($Server){
        $serverProperties = $ninjaDevicesFile | Select-Object $props | Where-Object { $_.'Device role' -match "Windows Server" } | Sort-Object 'os build number'

        # foreach($obj in $serverProperties){
        #     if($obj.'OS Name' -match "Windows 10"){
        #         Write-Output "Upgrade to Windows 11: $($obj.'System name')"
        #     }

        #     if ($obj.'os release id' -lt '25H2'){
        #         Write-Output "Upgrade OS for: $($obj.'System name')"

        #     }
        # }
    }


} #end function



function Format-Devices {
    param(
        [switch]$displayLaptops,
        [switch]$displayDesktops,
        [switch]$displayServer
    )

    $downloads = "${env:USERPROFILE}\Downloads\"
    $devices = Get-ChildItem $downloads | Where-Object { $_.Name -match 'devices' } | Sort-Object LastWriteTime | Select-Object -Last 1

    # Devices CSV -- import the objects
    $ninjaDevicesFile = Import-Csv -Path $devices.FullName

    # csv data #
    $props = @(
        "Organization",
        "Device Role",
        "OS Name",
        "OS Build Number",	
        "OS Release Id",
        "Device Make",
        "Device Model",
        "System Name"
    )


    if ($displayLaptops){
        $laptopProperties = $ninjaDevicesFile | Select-Object $props | Where-Object { $_.'Device role' -match "Windows Laptop"} | Sort-Object 'os build number'
        $laptopProperties
    }

    if ($displayDesktops){
        $desktopProperties = $ninjaDevicesFile | Select-Object $props | Where-Object { $_.'Device role' -match "Windows Desktop"} | Sort-Object 'os build number'
        $desktopProperties
    }

    if ($displayServer){
        $serverProperties = $ninjaDevicesFile | Select-Object $props | Where-Object { $_.'Device role' -match "Windows Server" } | Sort-Object 'os build number'
        $serverProperties
    }
}