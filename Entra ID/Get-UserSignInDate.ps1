# $signIn = get-entrauser -UserId $globalAdminUserId -Property SignInActivity  | Select-Object -ExpandProperty SignInActivity

# $signIn.lastSignInRequestId

# $signInDmac = get-entrauser -UserId $dmacUserId -Property displayname,SignInActivity  | Select-Object -Property displayname -ExpandProperty SignInActivity

# $dates = (get-date).Date - $signInDmac.lastSuccessfulSignInDateTime

# Write-Output "$($signInDmac.displayname) last signed-in $($dates.days) days ago"
# Write-Output "This user last signed-in $($dates.days) days ago"


# $twoUsers = @(
#     $dmacUserId
#     $globalAdmin
# )

# foreach ($i in $twoUsers) {
#     $t = Get-EntraUser -UserId $i -Property SignInActivity,displayname | Select-Object -Property displayname -ExpandProperty SignInActivity
   
#     $dates2 = (get-date).Date - $t.lastSuccessfulSignInDateTime
   
#     Write-Output "$($t.displayname) last signed-in $($dates2.days) days ago"
# }

param(
    [string]$searchName
)

$signIns = Get-Entrauser -SearchString $searchName -Property displayname, id, SignInActivity  | Select-Object -Property displayname, id -ExpandProperty SignInActivity


foreach ($item in $signIns){
    $days = (Get-Date).Date - $item.lastSuccessfulSignInsDateTime # error occuring here


    $results = @{
        Name                 = $item.displayname
        Id                   = $item.id
        "Successful sign-in" = $item.lastSuccessfulSignInsDateTime
    }

    Write-Output ("{0} last signed-in {1} days ago" -f $item.displayname, $days.days)
}






# if ($days.Days -eq 0){

#     Write-Output ("{0} last signed-in {1} days ago" -f $signIns.displayname, $days.days)

# } else {
#     Write-Output ("{0} last signed-in {1} days ago" -f $signIns.displayname, $days.days)

# }
