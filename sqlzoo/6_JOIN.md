# SQLZoo Solutions: JOIN

This document contains my solutions to the SQLZoo ['JOIN operation' section](https://sqlzoo.net/wiki/The_JOIN_operation) and the ['Old JOIN Tutorial'](https://sqlzoo.net/wiki/Old_JOIN_Tutorial) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
The first example shows the goal scored by a player with the last name 'Bender'. The `*` says to list all the columns in the table - a shorter way of saying `matchid, teamid, player, gtime`.  
Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: `teamid = 'GER'`.  

**My Solution:**

```sql
SELECT matchid, player
FROM goal 
WHERE teamid = 'GER';
```

---

## Problem 2
From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.  
Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.  
Show id, stadium, team1, team2 for just game 1012.  

**My Solution:**

```sql
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;
```

---

## Problem 3
You can combine the two steps into a single query with a JOIN.  
`SELECT *  
  FROM game JOIN goal ON (id=matchid)`
The `FROM` clause says to merge data from the goal table with that from the game table. The `ON` says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say
`ON (game.id=goal.matchid)`.  
The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.  
Modify it to show the player, teamid, stadium and mdate for every German goal.  

**My Solution:**

```sql
SELECT player, teamid, stadium, mdate
FROM game
  JOIN goal ON (id = matchid)
WHERE teamid = 'GER';
```

**My Notes:**  
The `JOIN...ON` clause merges rows from multiple tables based on a common column.

---

## Problem 4
Use the same `JOIN` as in the previous question.  
Show the team1, team2 and player for every goal scored by a player called Mario `player LIKE 'Mario%'`.  

**My Solution:**

```sql
SELECT team1, team2, player
FROM game
  JOIN goal ON (game.id = goal.matchid)
WHERE player LIKE 'Mario%';
```

---

## Problem 5
The table eteam gives details of every national team including the coach. You can `JOIN` goal to eteam using the phrase `goal JOIN eteam on teamid=id`.  
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes `gtime<=10`.  

**My Solution:**

```sql
SELECT player, teamid, coach, gtime
FROM goal
  JOIN eteam ON (goal.teamid = eteam.id)
WHERE gtime <= 10;
```

---

## Problem 6
To `JOIN` game with eteam you could use either `game JOIN eteam ON (team1=eteam.id)` or `game JOIN eteam ON (team2=eteam.id)`.  
Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id.  
List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.  

**My Solution:**

```sql
SELECT mdate, teamname
FROM game
  JOIN eteam ON (game.team1 = eteam.id)
WHERE coach = 'Fernando Santos';
```

---

## Problem 7
List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'.  

**My Solution:**

```sql
SELECT player
FROM game
  JOIN goal ON (game.id = goal.matchid)
WHERE stadium = 'National Stadium, Warsaw';
```

---

## Problem 8
The example query shows all goals scored in the Germany-Greece quarterfinal.  
Instead show the name of all players who scored a goal against Germany.  

**My Solution:**

```sql
SELECT DISTINCT player
FROM game
  JOIN goal ON game.id = goal.matchid
WHERE teamid != 'GER'
AND (team1 = 'GER' OR team2 = 'GER');
```

**My Notes:**  
Using `teamid != 'GER'` excludes German players.  
`DISTINCT` prevents duplicate player names.

---

## Problem 9
Show teamname and the total number of goals scored.  

**My Solution:**

```sql
SELECT teamname, COUNT(*)
FROM goal
  JOIN eteam ON goal.teamid = eteam.id
GROUP BY teamname;
```

---

## Problem 10
Show the stadium and the number of goals scored in each stadium.  

**My Solution:**

```sql
SELECT stadium, COUNT(gtime)
FROM game
  JOIN goal ON game.id = goal.matchid
GROUP BY stadium;
```

---

## Problem 11
For every match involving 'POL', show the matchid, date and the number of goals scored.  

**My Solution:**

```sql
SELECT matchid, mdate, COUNT(gtime)
FROM game
  JOIN goal ON game.id = goal.matchid
WHERE (team1 = 'POL'
  OR team2 = 'POL')
GROUP BY matchid;
```

---

## Problem 12
For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'.  

**My Solution:**

```sql
SELECT matchid, mdate, COUNT(teamid)
FROM goal
  JOIN game ON (goal.matchid = game.id)
WHERE teamid = 'GER' 
AND (team1 = 'GER' OR team2 = 'GER')
GROUP BY matchid;
```

---

## Problem 13
List every match with the goals scored by each team as shown. This will use "`CASE WHEN`" which has not been explained in any previous exercises.  

| mdate         | team1 | score1 | team2 | score2 |
|---------------|-------|--------|-------|--------|
| 1 July 2012   | ESP   | 4      | ITA   | 0      |
| 10 June 2012  | ESP   | 1      | ITA   | 1      |
| 10 June 2012  | IRL   | 1      | CRO   | 3      |
| ...           | ...   | ...    | ...   | ...    |

Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could `SUM` this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.  

**My Solution:**

```sql
SELECT 
  mdate,
  team1,
  SUM(CASE WHEN teamid = team1 THEN 1
           ELSE 0
           END) AS score1,
  team2,
  SUM(CASE WHEN teamid = team2 THEN 1
           ELSE 0
           END) AS score2
FROM game
  LEFT JOIN goal ON game.id = goal.matchid
GROUP BY mdate, matchid, team1, team2;
```

**My Notes:**  
`LEFT JOIN` ensures matches with **no goals** are included.  
`SUM()` counts the goals for each team.  
`CASE WHEN` differentiates between goals for team1 and team2.  

> From SQLZoo:
> `CASE` allows you to return different values under different conditions.  
> If no conditions match (and there is no `ELSE`) then `NULL` is returned.  
> `CASE WHEN condition1 THEN value1   
>       WHEN condition2 THEN value2    
>       ELSE def_value   
>  END`   

---

# Old JOIN Tutorial: Table Tennis Olympics

Here are my solutions and notes for a related SQLZoo section, the ['Old JOIN Tutorial'](https://sqlzoo.net/wiki/Old_JOIN_Tutorial).

---

## Problem 1
Show the athelete (who) and the country name for medal winners in 2000.  
`ttms(games,color,who,country)  
country(id,name)`     

**My Solution:**

```sql
SELECT who, country.name
FROM ttms
  JOIN country ON (ttms.country = country.id)
WHERE games = 2000;
```

---

## Problem 2
Show the who and the color of the medal for the medal winners from 'Sweden'.  
`ttms(games,color,who,country)  
country(id,name)`   

**My Solution:**

```sql
SELECT who, color
FROM ttms
  JOIN country ON (ttms.country = country.id)
WHERE name = 'Sweden';
```

---

## Problem 3
Show the years in which 'China' won a 'gold' medal.  
`ttms(games,color,who,country)  
country(id,name)`  

**My Solution:**

```sql
SELECT games
FROM ttms
  JOIN country ON (ttms.country = country.id)
WHERE name = 'China'
AND color = 'gold';
```

---

## Women's Singles Table Tennis Olympics

---

## Problem 4
Show who won medals in the 'Barcelona' games.  
`ttws(games,color,who,country)  
games(yr,city,country)`  

**My Solution:**

```sql
SELECT who
FROM ttws
  JOIN games ON (ttws.games = games.yr)
WHERE city = 'Barcelona';
```

---

## Problem 5
Show which city 'Jing Chen' won medals. Show the city and the medal color.  
`ttws(games,color,who,country)  
games(yr,city,country)`    

**My Solution:**

```sql
SELECT city, color
FROM ttws
  JOIN games ON (ttws.games = games.yr)
WHERE who = 'Jing Chen';
```

---

## Problem 6
Show who won the gold medal and the city.  
`ttws(games,color,who,country)  
games(yr,city,country)`  

**My Solution:**

```sql
SELECT who, city
FROM ttws
  JOIN games ON (ttws.games = games.yr)
WHERE color = 'gold';
```

---

## Table Tennis Men's Doubles

---

## Problem 7
Show the games and color of the medal won by the team that includes 'Yan Sen'.  
`ttmd(games,color,team,country)  
team(id,,name)`  

**My Solution:**

```sql
SELECT games, color
FROM ttmd
  JOIN team ON (ttmd.team = team.id)
WHERE name = 'Yan Sen';
```

---

## Problem 8
Show the 'gold' medal winners in 2004.  
`ttmd(games,color,team,country)  
team(id,,name)`   

**My Solution:**

```sql
SELECT name
FROM ttmd
  JOIN team ON (ttmd.team = team.id)
WHERE color = 'gold'
AND games = 2004;
```

---

## Problem 9
Show the name of each medal winner country 'FRA'.  
`ttmd(games,color,team,country)  
team(id,,name)`   

**My Solution:**

```sql
SELECT name
FROM ttmd
  JOIN team ON (ttmd.team = team.id)
WHERE country = 'FRA';
```

---
