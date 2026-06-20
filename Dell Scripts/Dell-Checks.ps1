<#
    Upload this script and the dotnet .exe file to the C:\Temp folder
    dotnet .exe is located C:\Temp\Software

    Install dotnet 8
    # https://dotnet.microsoft.com/en-us/download/dotnet/8.0

#>

$comments = @(
    "Dell Command Update should be on v5.5-5.7",
    ".NET Desktop Runtime should be on version 8.0.7 or greater",
    "Checking software versions...",
    ""
)

$comments

# Check DCU is installed
$64bitSoftware = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
$32bitSoftware = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"

$dcu = Get-ItemProperty $32bitSoftware,$64bitSoftware | ? { $_.displayname -match "dell command" }
if ($dcu) { 
    "Dell Command Update is installed"

    if ($dcu.DisplayVersion -ge 5.5) {
        "App is v5.5 or greater"  

        } else { 
            "App version: $($dcu.DisplayVersion) -- upgrade required"
            "Ensure .NET Desktop Runtime 8.0 with version greater than 8.0.7 is installed"
        }

} else { "Install Dell Command Update" }


#TODO
# turn this into a try/catch
# Check .NET is installed
$dotnetRegPath = "HKLM:\SOFTWARE\dotnet\Setup\InstalledVersions\x64\sharedhost"
if (test-path $dotnetRegPath){
    
    $dotnetVersion = (Get-ItemProperty $dotnetRegPath).Version
    "Dotnet is installed: version $dotnetVersion"

    if ($dotnetVersion -lt 8.0.7){
        
        "Microsoft .NET Desktop Runtime 8.0 with version greater than 8.0.7 (x64) needs to be installed for this installation"
        #& "C:\Temp\windowsdesktop-runtime-8.0.7-win-x64.exe" /install /quiet /norestart /log C:\temp\dotnetRuntimeInstall.txt
    }

} else { "HKLM:\SOFTWARE\dotnet doesnt exist; dotnet is not installed" }
