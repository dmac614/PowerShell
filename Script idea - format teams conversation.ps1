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





# Idea
Get the content of the conversation which is stored in a file
Get the name of the user and your name

Put $user + time on the same line
Put $yourname + time on the same line
Remove text that contains "... by $user" / "... by $yourname"
Remove text that contains "has context menu"
Remove text that contains "... reaction"

#>


<#
https://learn.microsoft.com/en-us/dotnet/standard/base-types/regular-expression-language-quick-reference
https://learn.microsoft.com/en-us/dotnet/standard/base-types/character-classes-in-regular-expressions#word-character-w
https://learn.microsoft.com/en-us/dotnet/api/system.string.endswith?view=net-8.0
https://www.sharepointdiary.com/2021/11/powershell-string-manipulation-comprehensive-guide.html

get-help select-string -full
get-help about_Regular_Expressions
#>


# Location of the Teams chat 
$ConversationFile = "C:\Users\macdond_a\Documents\My Files\PowerShell\teams1.txt"


# Main function to run individual functions
function CleanUpConversation {

    # Get the names of the two having a conversation
    function global:Conversation {
        $TheirName = read-host -prompt "Enter the name of the user"
        $YourName = read-host -prompt "Enter your name"
    }

    # Contains expressions to look for and replace in the conversation
    function global:StringExpressions {
        # Query expressions in the conversation 
        $TimePattern    = [regex]'\d{1,2}:\d{2} [AP]M'
        $Reaction       = [regex]'\d \w{1,8} reaction.' 
        $ByTheirName    = [regex]"\w* by $($TheirName)"
        $ByYourName     = [regex]"\w* by $($YourName)"
        $Number1        = [regex]'\d{1} \s'
        $ContextMenu    = "has context menu"
        $LastRead       = "Last read"

        $replacements = @{
        # Replace common text in the chat
        $ContextMenu        = $null
        $Reaction           = $null
        $Number1            = $null
        $LastRead           = $null
        $ReplaceTheirName   = [regex]"$($TheirName)+\s$($TimePattern)"
        $ReplaceYourName    = [regex]"$($TimePattern)+\s$($YourName)"
        }
    }

# 
    function global:ReplaceFileValues {
        # Display chat contents 
        $FileContents = get-content -path $ConversationFile
            
        # Foreach loop to replace the text
        Foreach ($item in $replacements.Keys) {
            $FileContents = $FileContents -replace $item, $replacements[$item]
        }
        
        # Update the replaced content in the file 
        Set-content -path $ConversationFile -value $FileContents
        Get-content -path $ConversationFile
    }
} 

# Call the function
CleanUpConversation
