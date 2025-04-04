# SQLZoo Solutions: COVID-19 Window Functions (LAG)

This document contains my solutions to the SQLZoo ['Window LAG' (COVID-19 Data) section](https://sqlzoo.net/wiki/Window_LAG) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
The example uses a WHERE clause to show the cases in 'Italy' in March 2020.  
Modify the query to show data from Spain.

**My Solution:**

```sql
SELECT 
  name, DAY(whn), confirmed, deaths, recovered
FROM covid
WHERE name = 'Spain'
  AND MONTH(whn) = 3 
  AND YEAR(whn) = 2020
ORDER BY whn;
```

---

## Problem 2
Show confirmed cases for the day before, using `LAG`.

**My Solution:**

```sql
SELECT 
  name, DAY(whn), confirmed,
  LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
FROM covid
WHERE name = 'Italy'
  AND MONTH(whn) = 3 
  AND YEAR(whn) = 2020
ORDER BY whn;
```

---

## Problem 3
Show the number of new cases for each day in Italy, March 2020.

**My Solution:**

```sql
SELECT 
  name, DAY(whn), 
  (
  confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
  ) AS new_cases
FROM covid
WHERE name = 'Italy'
  AND MONTH(whn) = 3 
  AND YEAR(whn) = 2020
ORDER BY whn;
```

**My Notes:**  
`LAG()` allows comparing to the previous row's confirmed cases.

---

## Problem 4
Show the number of new cases in Italy for each week in 2020 (Monday only).

**My Solution:**

```sql
SELECT 
  name, 
  DATE_FORMAT(whn,'%Y-%m-%d') AS date, 
  (
  confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
  ) AS new_cases
FROM covid
WHERE name = 'Italy'
  AND WEEKDAY(whn) = 0 
  AND YEAR(whn) = 2020
ORDER BY whn;
```

**My Notes:**  
Filter with `WEEKDAY(whn) = 0` to get Monday's data.

---

## Problem 5
Show the number of new cases in Italy for each week using `JOIN`.

**My Solution:**

```sql
SELECT 
  tw.name, 
  DATE_FORMAT(tw.whn,'%Y-%m-%d') AS date, 
 (tw.confirmed - lw.confirmed) AS new_cases_each_week
FROM covid tw 
  LEFT JOIN covid lw 
    ON DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn 
    AND tw.name = lw.name
WHERE tw.name = 'Italy'
  AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn;
```

**My Notes:**  
Using `JOIN` with `DATE_ADD()` to compare weekly data.

---

## Problem 6
Add a column to show the ranking for deaths due to COVID on 2020-04-20.

**My Solution:**

```sql
SELECT 
  name,
  confirmed,
  RANK() OVER (ORDER BY confirmed DESC) rc,
  deaths,
  RANK() OVER (ORDER BY deaths DESC) deaths_rank
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC;
```

---

## Problem 7
Show the infection rate ranking (cases per 100,000) for countries with population over 10 million.

**My Solution:**

```sql
SELECT 
   world.name,
   ROUND(100000 * confirmed / population, 2) rate,
   RANK() OVER (ORDER BY rate) rank
FROM covid 
JOIN world ON covid.name = world.name
WHERE whn = '2020-04-20' 
  AND population > 10000000
ORDER BY population DESC;
```

**My Notes:**  
Calculate infection rates using population data from `world` table.

---

## Problem 8
For each country with at least 1000 new cases in a single day, show the date of the peak number of new cases.

**My Solution:**  
_(No solution given in original SQL. Placeholder for future completion.)_

---

