<#
.SYNOPSIS
Trim text in a Teams conversation
.DESCRIPTION
Remove text and tidy up the formatting in an unorganised Teams conversation. Query regular expressions in the conversation and replace them as empty strings.
.PARAMETER MyName
An invariable param as I'll always be in the conversation
.PARAMETER TheirName
The name of the person in the conversation
.EXAMPLE
Trim-TeamsConversation.ps1 -TheirName <String>

.NOTES
Author: Daniel Macdonald
#>

# Location of conversation
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$MyName = "Daniel MacDonald",

    [Parameter(Mandatory=$true)]
    [string]$TheirName
)

# Location of conversation
$ConversationFile = "C:\Users\macdond_a\Documents\My Files\PowerShell\teamschat.txt"

function StringExpressions {
    # Expressions to query in the conversation 
    $script:ContextMenu    = "has context menu"
    $script:LastRead       = "Last read"
    $script:Today          = [regex]'\bToday\b'
    $script:num1           = [regex]'^\b1$'
    $script:Reaction       = [regex]'\d .+ reaction.' 
    $script:ByMyName       = [regex]"\w*.+ by $($MyName)"
    $script:ByTheirName    = [regex]"\w*.+ by $($TheirName)"

    $script:Replacements = @{
    # Replace expressions in the conversation
    $ContextMenu    = $null
    $Reaction       = $null
    $Today          = $null
    $num1           = $null
    $LastRead       = $null
    $ByMyName       = $null
    $ByTheirName    = $null
    }
}


# Update the conversation file with the replaced expressions
function ReplaceFileValues {
    # Get content of the conversation 
    try {
        $FileContents = get-content -path $ConversationFile
    } catch {
        Write-error "Failed to read file: $ConversationFile"
        return
    }
        
    # Foreach loop to replace the expressions
    Foreach ($item in $Replacements.Keys) {
        $FileContents = $FileContents -replace $item, $Replacements[$item]
    }
    
    # Write to the conversation file  
    try {
        Set-content -path $ConversationFile -value $FileContents
    } catch {
        Write-error "Failed to overwrite file: $ConversationFile"
    }
}

# Contain each function inside the main function
function TeamsConversation {
    StringExpressions
    ReplaceFileValues
}

# Run the main function
TeamsConversation
