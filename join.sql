-- Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal WHERE teamid = 'GER'

-- Show id, stadium, team1, team2 for just game 1012
SELECT id,stadium,team1,team2 FROM game where id = 1012

-- Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT goal.player,goal.teamid, game.stadium, game.mdate
  FROM game 
   JOIN goal 
   ON (game.id = goal.matchid)
where goal.teamid = 'GER'

-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
select team1, team2, player from game
 join goal 
 on game.id = goal.matchid
 where player like 'Mario%'

--  Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, eteam.coach, gtime
  FROM goal 
 join eteam
 on goal.teamid = eteam.id
 WHERE gtime<=10

-- List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
select mdate, eteam.teamname from game 
join eteam
on team1 = eteam.id
where coach = 'Fernando Santos'

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
select player from goal join game
on goal.matchid = game.id
where stadium = 'National Stadium, Warsaw'

-- Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER' ) AND (goal.teamid <>'GER')

-- Show teamname and the total number of goals scored.
SELECT teamname, count(teamid)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname

-- For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid,mdate, COUNT(teamid)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid,mdate
 
--  For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
select matchid, mdate, count(teamid)from game 
join goal on matchid = id
where teamid = 'GER'
group by matchid, mdate

-- Sort your result by mdate, matchid, team1 and team2.
SELECT mdate, team1,
  SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
  team2,
  SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, team1, team2
ORDER BY mdate, matchid, team1, team2;
