# Convert emails to user IDs

<#

Enter email addresses x
I add them to ids.txt x
run the wrapstrings function x
I store the emails in a variable x

$variable | ForEach-Object { get-entrauser -UserId $_ | select displayName,id } | clip
- write the output
- ensure the ids.txt count is the same as the output 
- if not, print who is missing


I would need to be connected to Entra ID before running this
#>

param(
    [array]$values
)

# IDs.txt file
$Path = 'C:\PowerShell Dev\PowerShell\Misc\IDs.txt'
$Strings = Get-Content -Path $Path

# The values are added to IDs.txt
Add-Content -Path $Path -Value $values


function WrapStrings {

    process {

        
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
}

## not working; the values in the ids.txt are not being wrapped
WrapStrings | Set-Content -Path $Path
