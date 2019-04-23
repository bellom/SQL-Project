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