<#

# Teams conversation
Charles Cook
3:21 pm
too many project behind the scene, alot of breakage.
not enough people on the desk either by Daniel MacDonald
3:21 pm
Daniel MacDonald
not enough people on the desk either
1 Laugh reaction.
1
yeah John is the gate keeper by Charles Cook
Charles Cook
3:22 pm
yeah John is the gate keeper
now you know! by Charles Cook
Charles Cook
3:22 pm
now you know!
Can I call you about GPO when you are back by Daniel MacDonald
3:46 pm
Daniel MacDonald
Can I call you about GPO when you are back
yeah sure by Charles Cook
Charles Cook
4:06 pm
yeah sure
has context menu


has context menu


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

function CleanUpConversation {

# Location of the Teams chat 
$ConversationFile = "C:\PS Demo\Working with files\teamschat.txt"


# Get the names of the two having a conversation
$TheirName = read-host -prompt "Enter the name of the user"
$YourName = read-host -prompt "Enter your name"

# Regex to query the time messages were sent 
$TimePattern    = [regex]'\d{1,2}:\d{2} [PA]M'
$Reaction       = [regex]'\d \w{1,8} reaction.' 
$ContextMenu    = "has context menu"
$Number1        = "1"

# Replace common text in the chat
$replacements = @{

$ContextMenu        = $null
$Reaction           = $null
$Number1            = $null
$ReplaceTheirName   = [regex]'($TheirName)+\s($TimePattern)'
$ReplaceYourName    = [regex]'($TimePattern)+\s($YourName)'

}

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



CleanUpConversation
