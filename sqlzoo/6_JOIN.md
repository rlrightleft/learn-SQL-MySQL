# SQLZoo Solutions: JOIN

This document contains my solutions to the SQLZoo ['JOIN operation' section](https://sqlzoo.net/wiki/The_JOIN_operation) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
Show the matchid and player name for all goals scored by Germany.

**My Solution:**

```sql
SELECT matchid, player
FROM goal 
WHERE teamid = 'GER';
```

---

## Problem 2
Show id, stadium, team1, team2 for just game 1012.

**My Solution:**

```sql
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;
```

---

## Problem 3
Show the player, teamid, stadium, and match date for every German goal.

**My Solution:**

```sql
SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id = matchid)
WHERE teamid = 'GER';
```

**My Notes:**  
The `JOIN` keyword merges rows from multiple tables based on a common column.

---

## Problem 4
Show the team1, team2, and player for every goal scored by a player called Mario.

**My Solution:**

```sql
SELECT team1, team2, player
FROM game JOIN goal ON (game.id = goal.matchid)
WHERE player LIKE 'Mario%';
```

---

## Problem 5
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes.

**My Solution:**

```sql
SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON (goal.teamid = eteam.id)
WHERE gtime <= 10;
```

---

## Problem 6
List the dates of the matches and the name of the team in which Fernando Santos was the team1 coach.

**My Solution:**

```sql
SELECT mdate, teamname
FROM game JOIN eteam ON (game.team1 = eteam.id)
WHERE coach = 'Fernando Santos';
```

---

## Problem 7
List the player for every goal scored in a game where the stadium was National Stadium, Warsaw.

**My Solution:**

```sql
SELECT player
FROM game JOIN goal ON (game.id = goal.matchid)
WHERE stadium = 'National Stadium, Warsaw';
```

---

## Problem 8
Show the name of all players who scored a goal against Germany.

**My Solution:**

```sql
SELECT DISTINCT player
FROM game JOIN goal ON game.id = goal.matchid
WHERE teamid != 'GER'
AND (team1 = 'GER' OR team2 = 'GER');
```

**My Notes:**  
Using `teamid != 'GER'` ensures exclusion of German players.  
`DISTINCT` prevents duplicate player names.

---

## Problem 9
Show teamname and the total number of goals scored.

**My Solution:**

```sql
SELECT teamname, COUNT(*)
FROM goal JOIN eteam ON goal.teamid = eteam.id
GROUP BY teamname;
```

---

## Problem 10
Show the stadium and the number of goals scored in each stadium.

**My Solution:**

```sql
SELECT stadium, COUNT(gtime)
FROM game JOIN goal ON game.id = goal.matchid
GROUP BY stadium;
```

---

## Problem 11
For every match involving Poland, show the matchid, date, and the number of goals scored.

**My Solution:**

```sql
SELECT matchid, mdate, COUNT(gtime)
FROM game JOIN goal ON game.id = goal.matchid
WHERE team1 = 'POL' OR team2 = 'POL'
GROUP BY matchid;
```

---

## Problem 12
For every match where Germany scored, show matchid, match date, and number of goals scored by Germany.

**My Solution:**

```sql
SELECT matchid, mdate, COUNT(teamid)
FROM goal JOIN game ON (goal.matchid = game.id)
WHERE teamid = 'GER' 
AND (team1 = 'GER' OR team2 = 'GER')
GROUP BY matchid;
```

---

## Problem 13
List every match with the goals scored by each team.

**My Solution:**

```sql
SELECT 
  mdate,
  team1,
  SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
  team2,
  SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game LEFT JOIN goal ON game.id = goal.matchid
GROUP BY mdate, matchid, team1, team2;
```

**My Notes:**  
`LEFT JOIN` ensures matches with no goals are included.  
`CASE WHEN` differentiates between goals for team1 and team2.  
`SUM()` counts the goals for each team.

---

# Old JOIN Tutorial: Table Tennis Olympics

---

## Problem 1
Show the athlete and the country name for medal winners in 2000.

**My Solution:**

```sql
SELECT who, country.name
FROM ttms JOIN country ON (ttms.country = country.id)
WHERE games = 2000;
```

---

## Problem 2
Show who and the color of the medal for winners from Sweden.

**My Solution:**

```sql
SELECT who, color
FROM ttms JOIN country ON (ttms.country = country.id)
WHERE name = 'Sweden';
```

---

## Problem 3
Show the years in which China won a gold medal.

**My Solution:**

```sql
SELECT games
FROM ttms JOIN country ON (ttms.country = country.id)
WHERE name = 'China'
AND color = 'gold';
```

---

# Women's Singles Table Tennis Olympics

---

## Problem 4
Show who won medals in the Barcelona games.

**My Solution:**

```sql
SELECT who
FROM ttws JOIN games ON (ttws.games = games.yr)
WHERE city = 'Barcelona';
```

---

## Problem 5
Show the city and medal color where Jing Chen won medals.

**My Solution:**

```sql
SELECT city, color
FROM ttws JOIN games ON (ttws.games = games.yr)
WHERE who = 'Jing Chen';
```

---

## Problem 6
Show who won the gold medal and the city.

**My Solution:**

```sql
SELECT who, city
FROM ttws JOIN games ON (ttws.games = games.yr)
WHERE color = 'gold';
```

---

# Table Tennis Men's Doubles

---

## Problem 7
Show the games and color of the medal won by the team that includes Yan Sen.

**My Solution:**

```sql
SELECT games, color
FROM ttmd JOIN team ON (ttmd.team = team.id)
WHERE name = 'Yan Sen';
```

---

## Problem 8
Show the gold medal winners in 2004.

**My Solution:**

```sql
SELECT name
FROM ttmd JOIN team ON (ttmd.team = team.id)
WHERE color = 'gold'
AND games = 2004;
```

---

## Problem 9
Show the name of each medal-winning country FRA.

**My Solution:**

```sql
SELECT name
FROM ttmd JOIN team ON (ttmd.team = team.id)
WHERE country = 'FRA';
```

---
