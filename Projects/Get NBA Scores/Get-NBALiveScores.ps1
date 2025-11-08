<#
.SYNOPSIS
Get NBA games' live scores 
.DESCRIPTION
Invoke a website request to get the NBA live scores from a JSON file. Convert the JSON to a PSCustomObject and gather the game data such as the home teams, away teams, and their statistics leaders.
Convert the PSCustomObjects to CSV to reformat the object data to make it more readable. Display the game leaders in descending order by most points scored by a player.
.PARAMETER <parameter>
Description of the parameter
.EXAMPLE
ScriptName -<parameter>

.NOTES
Author: Daniel Macdonald
JSON data being used
  $objData.scoreboard.games
  $objData.scoreboard.games.gameleaders
#>
#region store data in variables
# JSON data of the NBA live scores
$URi = 'https://cdn.nba.com/static/json/liveData/scoreboard/todaysScoreboard_00.json'

# Get NBA scores content and convert it from JSON to a PSCustomObject
$LiveScores = Invoke-WebRequest -Uri $URi
$WebContent = $LiveScores.Content
$objData = $WebContent | ConvertFrom-Json
#endregion store data in variables

#region data for home and away teams & players
# Home teams and their game leaders
$HomeTeam = $objData.scoreboard.games.hometeam
$HomeLeaders = $objData.scoreboard.games.gameleaders.homeleaders

# Away teams and their game leaders
$AwayTeam = $objData.scoreboard.games.awayteam
$AwayLeaders = $objData.scoreboard.games.gameleaders.awayleaders
#endregion data for home and away teams & players
 
#region reformatting game scores using CSV files
$HomeTeam | Select-Object wins,losses,teamName,score | ConvertTo-Csv | Out-File "C:\PowerShell Dev\PowerShell\Projects\Get NBA Scores\homeTeam.csv"
$AwayTeam | Select-Object score,teamName,wins,losses | ConvertTo-Csv | Out-File "C:\PowerShell Dev\PowerShell\Projects\Get NBA Scores\awayTeam.csv"

$homeCSV = Import-Csv -Path "C:\PowerShell Dev\PowerShell\Projects\Get NBA Scores\homeTeam.csv"
$awayCSV = Import-Csv -Path "C:\PowerShell Dev\PowerShell\Projects\Get NBA Scores\awayTeam.csv"

# Required help here: start
$maxLength = [math]::Max($homeCSV.count, $awayCSV.count)

while ($homeCSV.Count -lt $maxLength) { $homeCSV += [PSCustomObject]@{ wins=''; losses=''; teamName=''; score=''; }}
while ($awayCSV.Count -lt $maxLength) { $awayCSV += [PSCustomObject]@{ score=''; teamName=''; wins=''; losses=''; }}

# Intialise empty array for new PSCustomObject hashtable
$merged = @()

# Create a new hash table based on the CSV objects
for ( $i=0; $i -lt $maxLength; $i++ ) {
    $merged += [PSCustomObject]@{
        'Wins (home)' = $homeCSV[$i].Wins
        'Losses (home)' = $homeCSV[$i].Losses
        'Home Team' = $homeCSV[$i].teamName
        'Game Score (home)' = $homeCSV[$i].Score
        'Game Score (away)' = $awayCSV[$i].score
        'Away Team' = $awayCSV[$i].teamName
        'Wins (away)' = $awayCSV[$i].Wins
        'Losses (away)' = $awayCSV[$i].Losses
    }
}

$merged | Export-Csv -Path "C:\PowerShell Dev\PowerShell\Projects\Get NBA Scores\mergedTeams.csv" # Required help here: end
Import-CSV -Path "C:\PowerShell Dev\PowerShell\Projects\Get NBA Scores\mergedTeams.csv" | Format-Table
#endregion reformatting game scores using CSV files

#region stat leaders
# All stats leaders
Write-Host "GAME LEADERS: Points, rebounds, and assists." -ForegroundColor Green
$leadersH = @($HomeLeaders)
$leadersA = @($AwayLeaders)
$StatsLeaders = $leadersH + $leadersA

$StatsLeaders | 
Select-Object Name,Points,Rebounds,Assists |
Sort-Object Points -Descending | 
Format-Table @{n='Player';e={$_.name}},
@{n='Points';e={$_.points}},
@{n='Rebounds';e={$_.rebounds}},
@{n='Assists';e={$_.assists}}
#endregion stat leaders
