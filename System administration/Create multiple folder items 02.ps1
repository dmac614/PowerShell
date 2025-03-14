<#
.SYNOPSIS
Creates multiple folders

.DESCRIPTION
Uses a foreach loop to create multiple folders. Joins the file path with the file directory + file name.

.NOTES
Author: Daniel Macdonald

#>

# File names
$files = @(<file names>)

# Directory for new files
$directory = <directory name>

# Loop to create new files 
ForEach ($file in $files) {
	# Combine directory and file names to create file path
	$filePath = Join-path -Path $directory -ChildPath $file
	
	# Create the file
	New-item -type file -path $filePath -Force -Verbose
}

# Output a message of completion to the screen
Write-Host "File creation complete."
