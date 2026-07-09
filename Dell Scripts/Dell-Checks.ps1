<#
    Upload this script and the dotnet .exe file to the C:\Temp folder
    dotnet .exe is located C:\Temp\Software

    Install dotnet 8
    # https://dotnet.microsoft.com/en-us/download/dotnet/8.0

#>

$comments = @(
    "Info: Dell Command Update should be on v5.5-5.7",
    "Info: .NET Desktop Runtime should be greater than version 8.0.7",
    "Info: checking software versions..."
)

$comments

$dotnetInstaller    = "C:\Temp\windowsdesktop-runtime-8.0.10-win-x64.exe"
$dotnetLog          = "C:\temp\dotnetRuntimeInstall.txt"
$dotnetAppPath      = "C:\Program Files\dotnet\dotnet.exe"


# Check DCU is installed
$64bitSoftware = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
$32bitSoftware = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"

$dcu = Get-ItemProperty $32bitSoftware,$64bitSoftware | ? { $_.displayname -match "dell command" }
if ($dcu) { 
    "Info: Dell Command Update is installed"

    if ($dcu.DisplayVersion -ge 5.5) {
        "Info: app is v5.5 or greater"  

        } else { 
            "Warning: app version: $($dcu.DisplayVersion) -- upgrade required"
            "Info: ensure .NET Desktop Runtime 8.0 with version greater than 8.0.7 is installed"
        }

} else { "Warning: install Dell Command Update" }


# Check .NET is installed
$dotnetRegPath = "HKLM:\SOFTWARE\dotnet\Setup\InstalledVersions\x64\sharedhost"
if (test-path $dotnetRegPath){
    
    $dotnetVersion = (Get-ItemProperty $dotnetRegPath).Version
    "Info: dotnet is installed: version $dotnetVersion"

    try {

        if ($dotnetVersion -lt 8.0.8){
            
            "Warning: microsoft .NET Desktop Runtime 8.0 with version greater than 8.0.7 (x64) needs to be installed for this installation"
            Start-Process -FilePath $dotnetInstaller -ArgumentList "/install /quiet /norestart /log $dotnetLog" -Wait

            $dotnetRuntimes = & "C:\Program Files\dotnet\dotnet.exe" --list-runtimes
            if ($dotnetRuntimes -match "Microsoft.WindowsDesktop.App 8\.0\.7") {
                "Required dotnet version is installed"
            
            } else { "Required dotnet version not found" } 
            
            
        } else { "The correct version of dotnet is installed" }
    

    } catch [System.Exception] {
        $error[0]
    }


} else { 
    
    "Warning: HKLM:\SOFTWARE\dotnet doesnt exist; dotnet is not installed`nInstalling now..."

    try {

        Start-Process -FilePath $dotnetInstaller -ArgumentList "/install /quiet /norestart /log $dotnetLog" -Wait
    
            $dotnetRuntimes = & "C:\Program Files\dotnet\dotnet.exe" --list-runtimes
            if ($dotnetRuntimes -match "Microsoft.WindowsDesktop.App 8\.0\.7") {
                "Required dotnet version is installed"
                
            } else { "Required dotnet version not found"; $error[0] } 

    } catch [System.Exception] { $error[0] }

}
