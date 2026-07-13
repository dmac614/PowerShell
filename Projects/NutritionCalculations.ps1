[int]$lowDays = 3
$file = 'C:\PowerShell Dev\Testing\items.csv'
$importedFile = Import-Csv $file


$keyNames = foreach ($n in $importedFile.name){
    Write-Output $n
}


$updatedValues = @()
$calculate = foreach ($v in $importedFile.value){
        [int]$v * $lowDays
    }

$updatedValues += $calculate


$newValues = @()
for ($i = 0; $i -lt $importedFile.Count; $i++) {
    <# Action that will repeat until the condition is met #>
    $newValues += [ordered]@{

        #$importedFile.name = $updatedValues[$i]
        #$keyNames[1] = $updatedValues[$i]
    }
}

$newValues