<#
.SYNOPSIS
Run checks on the Windows system. 

.DESCRIPTION
Change this

.NOTES
Author: Daniel Macdonald

#>

# Get username
$Username = $env:username

function GreetHost {
# Hour of the day
$hour = (get-date).hour

# Greetings message depending on the time of day
if (($hour -ge 0) -and ($hour -le 11 )) {
    Write-Host "Good morning $username"
    }
elseif (($hour -ge 12) -and ($hour -le 16)) {
    Write-Host "Good afternoon $username"
    }
else {
    Write-Host "Good evening $username"
    }
}

# call function
GreetHost



# Add these in somewhere

# Clear recycle bin
Clear-RecycleBin -driveletter C -Confirm


# Delete temp files
(get-childitem -Path $env:localappdata\temp).count

get-childitem -Path $env:localappdata\temp | Remove-Item -Recurse


# Check Timezone; Set Timezone if it's incorrect
$timezone = (Get-TimeZone).id

if ($timezone -match "E. Australia Standard Time") {
    Write-host "The timezone is set correctly on this computer."
}
else {
    Set-TimeZone -id "E. Australia Standard Time"
}



# Get uptime of the device
function DeviceUptime {

    # Device last boot time
    $LastBoot = (get-ciminstance -classname win32_operatingsystem).LastBootUpTime
    
    # Current time and date
    $CurrentDate = get-date
    
    # Time difference from last boot to current time
    $Uptime = ($CurrentDate - $LastBoot).totaldays
    $UptimeFormatted = $Uptime.ToString("F2")
    
    # Tell the host the device uptime
    Write-host "Your device was last restarted $UptimeFormatted days ago."
    
    if ($Uptime -ge 3) {
        Write-warning "Your computer is about to be restarted."
        Restart-computer -Confirm
    } else {
        Write-host "Consider starting your computer in the next couple of days."
        }
    }
    
    # Call function
    DeviceUptime
