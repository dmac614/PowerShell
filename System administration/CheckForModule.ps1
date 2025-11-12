function CheckForModule($m) {
    if (Get-Module | ? { $_.name -eq $m }) {
        Write-Host "Module is imported"
        break
    }

    else {
            try {

                if (Get-Module -ListAvailable | ? { $_.name -eq $m }) {
                    "Located module: importing $m"
                    Import-Module -Name $m -Verbose
                }
                
                elseif (Get-Module -ListAvailable | ? {$_.name -ne $m}) {
                    "Module is not installed: installing $m"
                    Install-Module $m -Verbose
                }
            } catch { Write-Error $Error[0] }
    }
} 

CheckForModule("powershell-yaml")