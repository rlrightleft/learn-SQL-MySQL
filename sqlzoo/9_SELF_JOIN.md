# SQLZoo Solutions: Self JOIN

This document contains my solutions to the SQLZoo ['Self JOIN' section](https://sqlzoo.net/wiki/Self_join) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
How many stops are in the database?

**My Solution:**

```sql
SELECT COUNT(id)
FROM stops;
```

---

## Problem 2
Find the ID for the stop 'Craiglockhart'.

**My Solution:**

```sql
SELECT id
FROM stops
WHERE name = 'Craiglockhart';
```

---

## Problem 3
Give the id and the name for the stops on the '4' 'LRT' service.

**My Solution:**

```sql
SELECT stops.id, stops.name
FROM stops
  JOIN route ON (stops.id = stop)
WHERE route.num = '4'
  AND route.company = 'LRT';
```

---

## Problem 4
Show services that link London Road (149) and Craiglockhart (53).

**My Solution:**

```sql
SELECT company, num, COUNT(*)
FROM route 
WHERE (stop = 149 OR stop = 53)
GROUP BY company, num
HAVING COUNT(*) = 2;
```

---

## Problem 5
Show services from Craiglockhart to London Road.

**My Solution:**

```sql
SELECT a.company, a.num, a.stop, b.stop
FROM route a 
  JOIN route b ON (a.company = b.company AND a.num = b.num)
WHERE a.stop = 53
  AND b.stop = 149;
```

---

## Problem 6
Show services between 'Craiglockhart' and 'London Road'.

**My Solution:**

```sql
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a 
  JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart'
  AND stopb.name = 'London Road';
```

---

## Problem 7
List services which connect stops 115 ('Haymarket') and 137 ('Leith').

**My Solution:**

```sql
SELECT DISTINCT a.company, a.num
FROM route a
  JOIN route b ON (a.num = b.num AND a.company = b.company)
WHERE a.stop = 115
  AND b.stop = 137;
```

---

## Problem 8
List services that connect 'Craiglockhart' and 'Tollcross'.

**My Solution:**

```sql
SELECT a.company, a.num
FROM route a
  JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart'
  AND stopb.name = 'Tollcross';
```

---

## Problem 9
List stops reachable from 'Craiglockhart' by taking one bus, including the stop itself.

**My Solution:**

```sql
SELECT stopb.name, a.company, a.num
FROM route a
  JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart'
  AND (b.pos >= a.pos OR a.pos >= b.pos);
```

---

## Problem 10
Find routes involving two buses from 'Craiglockhart' to 'Lochend'.

**My Solution:**

```sql
SELECT 
  bus1.num, 
  bus1.company,      
  stops.name,        
  bus2.num,          
  bus2.company       
FROM (
  SELECT start1.num, start1.company, stop1.stop
  FROM route AS start1
    JOIN route AS stop1 ON start1.num = stop1.num
      AND start1.company = stop1.company
      AND start1.stop != stop1.stop
  WHERE start1.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart')
) AS bus1
JOIN (
  SELECT start2.num, start2.company, start2.stop
  FROM route AS start2
    JOIN route AS stop2 ON start2.num = stop2.num
      AND start2.company = stop2.company
      AND start2.stop != stop2.stop
  WHERE stop2.stop = (SELECT id FROM stops WHERE name = 'Lochend')
) AS bus2
  ON bus1.stop = bus2.stop
JOIN stops ON bus1.stop = stops.id
ORDER BY bus1.num, bus1.company, stops.name, bus2.num, bus2.company;
```

**My Notes:**  
- Use two subqueries for bus routes from Craiglockhart to a transfer stop, and from transfer to Lochend.
- Join on matching transfer stop IDs.

---

