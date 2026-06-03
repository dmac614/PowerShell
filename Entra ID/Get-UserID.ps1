param(
    [string]$string
)

function userID() {

    Get-EntraUser -SearchString $string | Select-Object displayname,id
}

userID