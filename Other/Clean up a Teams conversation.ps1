<#

.SYNOPSIS
Clean up a Teams conversation

.DESCRIPTION
Remove text and tidy up the format fron an unorganised Teams conversation. Query regular expressions in the conversation and replace them as empty strings.

.NOTES
Author: Daniel Macdonald

Future plans to add to this script:
Put the names + the subsequent time of the sent message on the same line
Paste the conversation into a text box; save this to a file; read from the file

#>

# Location of conversation
$ConversationFile = "C:\PS Demo\Working with files\teams1.txt"


# Get the names of the two having a conversation
function Conversation {
    $script:MyName         = read-host -prompt "Enter your name"
    $script:TheirName      = read-host -prompt "Enter the name of the user"
}

function StringExpressions {
    # Expressions to query in the conversation 
    $script:ContextMenu    = "has context menu"
    $script:LastRead       = "Last read"
    $script:Today          = [regex]'\bToday\b'
    $script:num1           = [regex]'\b1\b'
    $script:Reaction       = [regex]'\d \w{1,8} reaction.' 
    $script:ByMyName       = [regex]"\w*.+ by $($MyName)"
    $script:ByTheirName    = [regex]"\w*.+ by $($TheirName)"

    $script:Replacements = @{
    # Replace common text in the chat
    $ContextMenu    = $null
    $Reaction       = $null
    $Today          = $null
    $num1           = $null
    $LastRead       = $null
    $ByMyName       = $null
    $ByTheirName    = $null
    }
}


# Re-write the file with the removed text
function ReplaceFileValues {
    # Display chat contents 
    try {
        $FileContents = get-content -path $ConversationFile
    } catch {
        Write-error "Failed to read file: $ConversationFile"
        return
    }
        
    # Foreach loop to replace the text
    Foreach ($item in $Replacements.Keys) {
        $FileContents = $FileContents -replace $item, $Replacements[$item]
    }
    
    # Update the replaced content in the file 
    try {
        Set-content -path $ConversationFile -value $FileContents
    } catch {
        Write-error "Failed to overwrite file: $ConversationFile"
    }
}

# Contain each function inside the main function
function TeamsConversation {
    Conversation
    StringExpressions
    ReplaceFileValues
}

# Run the main functionc
TeamsConversation
