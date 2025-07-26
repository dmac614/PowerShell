<#
    ## unfinished ##

    Install Dell Command Update from the internet

    Potential URLS
    1. This downloads the .exe instantly 
    https://downloads.dell.com/FOLDER11914128M/1/Dell-Command-Update-Windows-Universal-Application_9M35M_WIN_5.4.0_A00.EXE
    https://dl.dell.com/FOLDER13309588M/1/Dell-Command-Update-Windows-Universal-Application_C8JXV_WIN64_5.5.0_A00.EXE # access denied to server error

    https://learn.microsoft.com/en-us/dotnet/api/system.net.webclient.downloadfile?view=net-9.0
    https://garytown.com/dell-command-update-install-manage-via-powershell
    https://github.com/gwblok/garytown
#>
#region Temp folder
function Get-TempFolder {
    param(
        [string]$TempFolder = 'C:\Temp',
        [string]$script:AppName = "Dell Command | Update Windows Universal"
    )       
    # Verify Temp folder exists
    if (! (Test-Path -Path $TempFolder)) {
        New-Item -Path ${env:SystemDrive}\ -Name Temp -ItemType Directory
        Write-Output "$TempFolder has been created"
        Write-Output "Proceeding to download $AppName"
    } 
    else {
        Write-Output "$TempFolder already exists."
        Write-Output "Proceeding to download $AppName"
    }
}
    # evoke function
    Get-TempFolder
#endregion

#region
function Get-DCU {
    param(
        [string]$dl = "https://downloads.dell.com/FOLDER11914128M/1/Dell-Command-Update-Windows-Universal-Application_9M35M_WIN_5.4.0_A00.EXE",
        [string]$FileName = $dl.split("https://downloads.dell.com/FOLDER11914128M/1/"),
        [string]$DownloadPath = "${env:SystemDrive}\Temp" # -- use $TempFolder instead
    )
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
            $WebDownload.DownloadFile($dl, $CombinedPath)

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
            Write-Error "The fully qualified error ID is: $($_.FullyQualifiedErrorId)" 
            Write-Error "Error at line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)" -ErrorAction Stop
    }

}
    # evoke function
    Get-DCU -Verbose
#endregion
