# JSON data of the NBA live scores
$URi = 'https://cdn.nba.com/static/json/liveData/scoreboard/todaysScoreboard_00.json'

# Get NBA scores content and convert it from JSON to a PSCustomObject
$LiveScores = Invoke-WebRequest -Uri $URi
$WebContent = $LiveScores.Content
$objData = $WebContent | ConvertFrom-Json

<# Data
$objData.scoreboard.games
$objData.scoreboard.games.gameleaders
#>

# Home teams and their game leaders
$HomeTeam = $objData.scoreboard.games.hometeam
$HomeLeaders = $objData.scoreboard.games.gameleaders.homeleaders

# Away teams and their game leaders
$AwayTeam = $objData.scoreboard.games.awayteam
$AwayLeaders = $objData.scoreboard.games.gameleaders.awayleaders
 

# Home Team
Write-Host "`nHOME TEAMS" -ForegroundColor Green
$HomeTeam | Select-Object wins,losses,teamName,score | Format-Table
Write-Host "AWAY TEAMS" -ForegroundColor Green
$AwayTeam | Select-Object score,teamName,wins,losses | Format-Table

# Away Team
Write-Host "GAME LEADERS: Points, Rebounds, and Assists." -ForegroundColor Green
$leadersH = @($HomeLeaders)
$leadersA = @($AwayLeaders)
$allLeaders = $leadersH + $leadersA
$allLeaders | Select-Object Name,Points,Rebounds,Assists | Sort-Object Points -Descending | Format-Table
