<#
    Install Dell Command Update from the internet

    Potential URLS
    1. This downloads the .exe instantly 
    https://downloads.dell.com/FOLDER11914128M/1/Dell-Command-Update-Windows-Universal-Application_9M35M_WIN_5.4.0_A00.EXE
    https://dl.dell.com/FOLDER13309588M/1/Dell-Command-Update-Windows-Universal-Application_C8JXV_WIN64_5.5.0_A00.EXE # access denied to server error

    https://learn.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadfile?view=net-9.0
    https://garytown.com/dell-command-update-install-manage-via-powershell
    https://github.com/gwblok/garytown


    Identifying the incompatible "Dell Command | Update for Windows 10" app
    Each identifying number appears to be different (based on the app version)


    Is the manufacturer dell? 
    Is DCU installed?
    - ensure incompatible DCU is not installed
    - if no, download and install it
    - if yes, get the version, determine if the version is ok, possibly download and install the latest version
    Check for updates


#>

# Confirm it's a Dell system
if (! (Get-CimInstance -ClassName Win32_ComputerSystem).Manufacturer -match 'Dell') 
        { Write-Error "This is not a Dell system" -ErrorAction Stop }


#region Temp folder
# The installer file will be downloaded here 
function Get-TempFolder {
    param(
        [string]$TempFolder = 'C:\Temp',
        [string]$script:AppName = "Dell Command | Update Windows Universal"
    )       
        # Verify Temp folder exists
        if (! (Test-Path -Path $TempFolder)) {
            New-Item -Path ${env:SystemDrive}\ -Name Temp -ItemType Directory
            Write-Output "$TempFolder has been created`nProceeding to download $AppName"
        } else {
            Write-Output "$TempFolder already exists."
            Write-Output "Proceeding to download $AppName"
        }
    }

    # evoke function
    Get-TempFolder
#endregion

#region
function IncompatibleDCU {
    param(
        $IncompatibleApp = "Dell Command | Update for Windows 10"
    )

    # Container for the app ID required for msiexec
    $AppIdentifyingNumber = @()

        # Check if the incompatible app is installed
        $CheckForApp = Get-CimInstance -ClassName Win32_Product | ? { $_.name -eq $IncompatibleApp }
        if ($CheckForApp) {
            Write-Output "Incompatible app '$IncompatibleApp' detected`nPreparing for uninstallation"
            $AppIdentifyingNumber += $CheckForApp.IdentifyingNumber

            try {
                # Uninstall the app silently
                msiexec.exe /X "$AppIdentifyingNumber" /qn
                Write-Output "Uninstalling $IncompatibleApp`nWaiting 60 seconds to complete the uninstall"
                Start-Sleep -Seconds 60

                $ReCheckApp = Get-CimInstance -ClassName Win32_Product | ? { $_.name -eq $IncompatibleApp }
                if ($ReCheckApp.Name -notmatch $IncompatibleApp){
                    Write-Output "$IncompatibleApp successfully uninstalled"
                } else {
                    Write-Output "$IncompatibleApp is still installed"
                }

            } catch [System.Exception] {
                    Write-Error $Error[0] -ErrorAction Stop
                }
        } else {
            Write-Output "$IncompatibleApp is not installed`nProceed to download $AppName"
        }
    }

    # evoke function
    IncompatibleDCU
#endregion


#region
function Get-DCU {
        [string]$dl = "https://downloads.dell.com/FOLDER11914128M/1/Dell-Command-Update-Windows-Universal-Application_9M35M_WIN_5.4.0_A00.EXE"
        [string]$FileName = $dl.split("https://downloads.dell.com/FOLDER11914128M/1/")
        [string]$DownloadPath = "${env:SystemDrive}\Temp" # -- use $TempFolder instead

        # Combine the file name and the download path
        # This will download the file to C:\Temp
        $CombinedPath = Join-Path -Path $DownloadPath -ChildPath $FileName.Trim()

    <#
        Fix the logic
        Check if the file exists first
        -- Avoid searching the full C: drive as its searching through GBs of data
        Then proceed to download it: change lines 23 & 27
    #>

        try {
            # Create .NET object to download the DCU .exe file
            $WebDownload = New-Object Net.WebClient
            $WebDownload.DownloadFile($dl, $CombinedPath) | 

            # Validate download of the DCU .exe file
            $FileExists = Get-ChildItem -Path C:\ -Recurse -Filter $FileName.Trim() -ErrorAction SilentlyContinue
            if ($FileExists -match $FileName.Trim()){
                Write-Output "$AppName is downloaded and available to be installed"
            }
            else {
                Write-Output "$AppName is not downloaded"
            }
        }
        catch [System.Exception] {
            Write-Error "Could not install $AppName" 
            Write-Error $Error[0] -ErrorAction Stop
    }

}
    # evoke function
    Get-DCU -Verbose
#endregion
