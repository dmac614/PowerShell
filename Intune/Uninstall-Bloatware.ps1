<#
.SYNOPSIS
Remove 'bloatware' application packages that get installed for every new user. 
.DESCRIPTION
Detect 'bloatware' packages on the OS using the AppxProvisionedPackage cmdlet; remove all detected packages; store the process in a log file found in the C:\Windows\Temp directory. Using the AppxProvisionedPackage cmdlet uninstalls the packages for each new user account on the system. 
.PARAMETER <parameter>
No parameters are used for this script
.EXAMPLE
Uninstall-Bloatware.ps1

.NOTES
Learned how to debug to figure out what was not working within the script
The Write-LogEntry function was passed to me from some engineers from Dell

Author: Daniel Macdonald
#>

#region logs

    # Collect logs
    function Write-LogEntry {
        param (
            [parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string]$Value,
            [parameter(Mandatory = $false)][ValidateNotNullOrEmpty()][string]$FileName = "Debloat-Logs.log",
            [switch]$Stamp
        )

        #Build Log File appending System Date/Time to output
        $script:LogFile = Join-Path -Path ${env:windir} -ChildPath $("Temp\$FileName")
        $Time = (Get-Date -Format "HH:mm:ss")
        $Date = (Get-Date -Format "dd-MM-yyyy")

        If ($Stamp) {
            $LogText = "$($Date) @ $($Time): $($Value)"
        }
        else {
            $LogText = "$($Value)"   
        }
        
        Try {
            Out-File -InputObject $LogText -Append -NoClobber -Encoding Default -FilePath $LogFile -ErrorAction Stop
        }
        Catch [System.Exception] {
            Write-Warning -Message "Unable to add log entry to $LogFile.log file. Error message at line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
        }
    }

#endregion logs

#region identify packages

#App packages to identify
[string[]]$Packages = @(
    "4505Fortemedia.FMAPOControl",
    "5A894077.McAfeeSecurity",
    "Clipchamp.Clipchamp",
    "DolbyLaboratories.DolbyAudio",
    "E046963F.LenovoCompanion",
    "E0469640.LenovoUtility",
    "Microsoft.AV1VideoExtension",
    "Microsoft.AVCEncoderVideoExtension",
    "Microsoft.BingNews",
    "Microsoft.BingSearch",
    "Microsoft.BingWeather",
    "Microsoft.DevHome",
    "Microsoft.Windows.DevHome",
    "Microsoft.MicrosoftAccessoryCenter",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.MixedReality.Portal",
    "Microsoft.MPEG2VideoExtension",
    "Microsoft.Office.OneNote",
    "Microsoft.OutlookForWindows",
    "Microsoft.Paint",
    "Microsoft.People",
    "Microsoft.PowerAutomateDesktop",
    "Microsoft.Todos",
    "Microsoft.WindowsAlarms",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.WindowsMaps",
    "Microsoft.WindowsSoundRecorder",
    "Microsoft.WindowsStore",
    "Microsoft.Xbox.TCUI",
    "Microsoft.XboxGameOverlay",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.YourPhone",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
    "MicrosoftCorporationII.QuickAssist",
    "Mirkat.Mirkat",
    "RealtekSemiconductorCorp.RealtekAudioControl",
    "Microsoft.549981C3F5F10", # Cortana
    "microsoft.windowscommunicationsapps", # Mail and calendar
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.GamingApp" # Xbox app
)

# Store detected apps
$DetectedApps = @()

function DetectPackages 
{
    # Log entry
    Write-LogEntry -Stamp -Value "Username is: $($env:USERNAME)"
    Write-LogEntry -Stamp -Value "Hostname is: $($env:COMPUTERNAME)"
    Write-LogEntry -Stamp -Value "---------- Checking for provisioned packages"

        # App detection counter
        [int]$AppsDetectedCounter = 0

            foreach ($App in $Packages) 
            {
                $AppsExist = Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -match "$($App)" }
                if ($AppsExist) 
                {
                    try 
                    {
                        # Detecting apps
                        Write-LogEntry -Stamp -Value "'$App' detected"
                        $script:DetectedApps += $AppsExist
                        $script:AppsDetectedCounter++
                    }

                    catch [System.Exception] 
                    {
                        Write-LogEntry -Stamp -Value "ERROR: Failed to detect provisioned packages"
                        Write-LogEntry -Stamp -Value "The fully qualified error ID is: $($_.FullyQualifiedErrorId)"
                        Write-LogEntry -Stamp -Value "Error at line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
                    }
                } 

                else {
                    Write-LogEntry -Stamp -Value "Did not detect '$App'"
                }
            } #end foreach

            # Log detected apps
            if ($AppsDetectedCounter -eq 0) 
            { 
                Write-LogEntry -Stamp -Value "No apps were detected for removal"
                Write-Output                 "Script completed `nSee log file at: '$LogFile'"
                Exit 0
            }
            else {
                Write-LogEntry -Stamp -Value "$($script:AppsDetectedCounter)/$(($Packages).Count) provisioned packages detected for removal"
            }
} #end function

    # invoke function
    DetectPackages

#endregion identify and remove packages


#region remove packages
function RemovePackages 
{    
    # Log entry
    Write-LogEntry -Stamp -Value "---------- Attempting to remove detected provisioned packages"

    # App removed counter
    [int]$AppsRemovedCounter = 0

            foreach ($DetectedApp in $DetectedApps) 
            {
                try 
                {
                    $DetectedApp | Remove-AppxProvisionedPackage -Online -AllUsers
                    $script:AppsRemovedCounter++

                    # Verifying removal
                    $VerifyExists = Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -match $DetectedApp.DisplayName }

                        # $VerifyExists should be null to confirm apps have been removed 
                        if ($null -eq $VerifyExists)
                        {
                            Write-LogEntry -Stamp -Value "Removed '$($DetectedApp.DisplayName)' successfully"
                        }
                        else 
                        {
                            Write-LogEntry -Stamp -Value "Failed to remove '$($DetectedApp.DisplayName)'"
                        }
                }

                catch [System.Exception] 
                {
                    Write-LogEntry -Stamp -Value "ERROR: Unable to remove provisioned packages"
                    Write-LogEntry -Stamp -Value "The fully qualified error ID is: $($_.FullyQualifiedErrorId)"
                    Write-LogEntry -Stamp -Value "Error at line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
                }
            }

            # Removed apps counter
            # This part does not work as I intended
            # Example output is: '6/ provisioned packages removed'
            Write-LogEntry -Stamp -Value "$($AppsRemovedCounter)/$($AppsDetectedCounter) provisioned packages removed"

}

    # Invoke the function
    RemovePackages 

#endregion remove packages
#>

# See log file message
Write-Output "Script completed `nSee log file at: '$LogFile'"
