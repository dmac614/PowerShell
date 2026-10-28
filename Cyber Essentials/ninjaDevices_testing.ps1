



function name {
    $downloads = "${env:USERPROFILE}\Downloads\"
    $devices = Get-ChildItem $downloads | Where-Object { $_.Name -match 'devices' } | Sort-Object LastWriteTime | Select-Object -Last 1
    # Devices CSV -- import the objects
    $ninjaDevicesFile = Import-Csv -Path $devices.FullName

    foreach ($obj in $ninjaDevicesFile){

        $str1 = $obj.'Device Role'
        $str2 = $obj.'OS Name' 
        $str3 = $obj.'OS Build Number'
        $str4 = $obj.'OS Release Id'
        $str5 = $obj.'Device Make' 
        
        $concat = [string]::Concat("$str1 - ","$str2 - ","$str3 - ","$str4 - ","$str5")
        $concat | Group-Object -Property $str5
    }

}

