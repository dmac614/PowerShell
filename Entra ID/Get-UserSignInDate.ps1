<#
    # ideas
    create an if..else statement
    if $specificSearch search for names of users
    if $allUsers search through all entra users with enabled accounts

    ToDo
    Add a parameter to the Connect-Entra command
    Allows me to connect to different Entra tenancies
#>

param(
    [string]$searchName,
    [switch]$specificSearch,
    [switch]$allUsers
)

if (-not (Get-EntraContext)) {
    $dmacEntra = "ccd5a42d-4beb-4856-b324-d3498aa10af5"
    Connect-Entra -TenantID $dmacEntra
}

$signIns = Get-Entrauser -SearchString $searchName -Property displayname, id, SignInActivity  | Select-Object -Property displayname, id -ExpandProperty SignInActivity


foreach ($item in $signIns){
    $days = ($item.lastSuccessfulSignInDateTime.date | ForEach-Object { (Get-Date) - $_.Date } ).days

    $results = [PSCustomObject][ordered]@{
        Name                 = $item.displayname
        Id                   = $item.id
        "Successful sign-in" = $item.lastSuccessfulSignInDateTime
        "Last signed-in"     = "$days days ago"
    }

    $results

}