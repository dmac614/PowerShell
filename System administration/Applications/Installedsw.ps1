function listInstalledSoftware(){

    $32bitSoftware = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $64bitSoftware = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
    
    Get-ItemProperty $32bitSoftware, $64bitSoftware 

}

listInstalledSoftware | ft DisplayName,DisplayVersion,InstallLocation, UninstallString
listInstalledSoftware | Sort-Object displayname | ft DisplayName,UninstallString