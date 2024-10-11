<#


Today
Hello Sasha - are you free for a remote ses... by Daniel MacDonald
2:44 pm
Daniel MacDonald
Hello Sasha - are you free for a remote session regarding the CM add-in?
Sure. Thanks! by Sasha McCarthy
Sasha McCarthy
2:44 pm
Sure. Thanks!
Surprised Surprised Surprised by Sasha McCarthy
Sasha McCarthy
2:48 pm
You’re amazing!!!!!! by Sasha McCarthy
Sasha McCarthy
2:49 pm
You’re amazing!!!!!!
The add-in is back, can you verify it's wor... by Daniel MacDonald
2:49 pm
Daniel MacDonald
The add-in is back, can you verify it's working?
Smile   Smile by Daniel MacDonald
2:49 pm
Daniel MacDonald
 
It just didn't 'check in on close'. by Sasha McCarthy
Sasha McCarthy
2:52 pm
It just didn't 'check in on close'.
The rest worked perfectly. by Sasha McCarthy
Sasha McCarthy
2:52 pm
The rest worked perfectly.
PWR\PT BN 2024 DJAG Communications Communit... by Daniel MacDonald
2:55 pm
Daniel MacDonald
PWR\PT BN 2024 DJAG Communications Community presentation.DOCX
Is this the file you were checking in? I di... by Daniel MacDonald
2:55 pm
Daniel MacDonald
Is this the file you were checking in? I didnt pay attention
No. That one was the one I saved from my de... by Sasha McCarthy
Sasha McCarthy
2:55 pm
No. That one was the one I saved from my desktop earlier today. I saved in a CED calendar. 

1
It does look like my CM was just slow. by Sasha McCarthy
Sasha McCarthy
2:55 pm
It does look like my CM was just slow.
Its saved in now. by Sasha McCarthy
Sasha McCarthy
2:55 pm
Its saved in now.
You did great! Thanks for your help by Sasha McCarthy
Sasha McCarthy
2:56 pm
You did great! Thanks for your help

1
Thanks for the kind words  by Daniel MacDonald
2:56 pm
Daniel MacDonald
Thanks for the kind words 
You are super welcome! by Sasha McCarthy
Sasha McCarthy
2:57 pm
You are super welcome!

Have a great day!You're the bestThank you!


<#
    .Add in later
$num1           = [regex]'\b1\b' 
$num1           = $null

#>

# Location of conversation
$ConversationFile = "C:\Users\macdond_a\Documents\My Files\PowerShell\teamschat.txt"


# Expressions to query in the conversation 
$ContextMenu    = "has context menu"
$LastRead       = "Last read"
$Reaction       = [regex]'\d \w{1,8} reaction.' 
$ByMyName       = [regex]"\w*.+ by $($MyName)"
$ByTheirName    = [regex]"\w*.+ by $($TheirName)"


# Get the names of the two having a conversation
function Conversation {
    $script:MyName = "Daniel Macdonald"
    $script:TheirName = read-host -prompt "Enter the name of the user"
}


function StringExpressions {
    $script:Replacements = @{
    # Replace common text in the chat
    $ContextMenu    = $null
    $Reaction       = $null
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

# Run the main function
TeamsConversation
