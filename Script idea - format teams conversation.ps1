<#

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

