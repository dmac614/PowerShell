$test1 = @('one', 'two', 3)
$test2 = @('one', 'one ', 3, 9)

$test2 | ForEach-Object {
    if ( $_ -notin $test1) { Write-Output $_ } 
}

# Output: 
# one (includes whitespace)
# 9