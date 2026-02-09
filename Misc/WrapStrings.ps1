# This method ensures the last item does not end with a comma
$Strings = Get-Content -Path 'C:\PowerShell Dev\PowerShell\Misc\IDs.txt'

function WrapStrings {
    for ($i = 0; $i -lt $Strings.Count; $i++) {
        if ($i -eq $Strings.Count - 1) {
            # Last item, no comma
            '"' + $Strings[$i] + '"'
        }
        else {
            '"' + $Strings[$i] + '",'
        }
    }
}

# Copy strings to clipboard
WrapStrings | clip