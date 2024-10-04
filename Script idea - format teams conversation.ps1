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

# The file containing the teams conversation
$teamsChat = get-content -path "C:\users\macdond_a\documents\My Files\PowerShell\teamschat.txt" -raw

# Get names of the two having a conversation
$user = read-host -prompt "Enter the name of the user"
$yourname = read-host -prompt "Enter your name"

