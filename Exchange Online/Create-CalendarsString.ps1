param(
    [string[]]$mailboxes
)

foreach ($m in $mailboxes) {
    -join ($m, ":\calendar") 
} 