# SQLZoo Solutions: SELECT within SELECT

This document contains my solutions to the SQLZoo ['SELECT within SELECT' section](https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
List each country name where the population is larger than that of 'Russia'.  
`world(name, continent, area, population, gdp)`

**My Solution:**

```sql
SELECT name FROM world
WHERE population >
  (
  SELECT population 
  FROM world
  WHERE name = 'Russia'
  );
```

**My Notes:**  
Use a *subquery* (in parentheses) to compare against a specific value retrieved dynamically.

---

## Problem 2
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.  

**My Solution:**

```sql
SELECT name
FROM world
WHERE continent = 'Europe'
AND gdp/population >
  (
  SELECT gdp/population
  FROM world
  WHERE name = 'United Kingdom'
  );
```

---

## Problem 3
List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.  

**My Solution:**

```sql
SELECT name, continent
FROM world
WHERE continent IN
  (
  SELECT continent
  FROM world
  WHERE name IN ('Argentina', 'Australia')
  )
ORDER BY name;
```

---

## Problem 4
Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.  

**My Solution:**

```sql
SELECT name, population
FROM world
WHERE population >
  (
  SELECT population
  FROM world
  WHERE name = 'United Kingdom'
  )
AND population <
  (
  SELECT population
  FROM world
  WHERE name = 'Germany'
  );
```

**My Notes:**  
Using two subqueries ensures the population falls within a defined range.

---

## Problem 5
Germany (population roughly 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.  
Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.  
The format should be Name, Percentage for example:  
| name    | percentage |
|---------|------------|
| Albania | 3%         |
| Andorra | 0%         |
| Austria | 11%        |
| ...     | ...        |

**My Solution:**

```sql
SELECT name, 
  CONCAT(ROUND
    (100 * population / 
      (
      SELECT population
      FROM world
      WHERE name = 'Germany'
      )
    ,0),
  '%') AS percentage
FROM world
WHERE continent = 'Europe';
```

**My Notes:**  
Percentages are calculated by multiplying by 100 and using `ROUND` (rounding) to remove decimals.
Add the percentage symbol (%) using `CONCAT` (concatenate).

---

## Problem 6
Which countries have a GDP greater than every country in Europe? Give the name only. (Some countries may have `NULL` gdp values)  

**My Solution:**

```sql
SELECT name
FROM world
WHERE gdp >
  ALL(
    SELECT gdp
    FROM world
    WHERE continent = 'Europe'
    AND gdp > 0
  );
```

**My Notes:**  
The `ALL` operator ensures GDP is compared against all European countries in the subquery.

---

## Problem 7
Find the largest country (by area) in each continent, show the continent, the name and the area:  
The above example is known as a correlated or synchronized sub-query.  
A correlated subquery works like a nested loop: the subquery only has access to rows related to a single record at a time in the outer query. The technique relies on table aliases to identify two different uses of the same table, one in the outer query and the other in the subquery.  
One way to interpret the line in the `WHERE` clause that references the two table is “… where the correlated values are the same”.  

**My Solution:**

```sql
SELECT continent, name, area
FROM world x
WHERE area >= 
  ALL(
    SELECT area 
    FROM world y
    WHERE y.continent = x.continent
    AND area > 0
  );
```

**My Notes:**  
This *correlated subquery* allows us to check the largest country **per continent** (`WHERE y.continent = x.continent`).

---

## Problem 8
List each continent and the name of the country that comes first alphabetically.  

**My Solution:**

```sql
SELECT continent, name
FROM world x
WHERE name <=
  ALL(
    SELECT name
    FROM world y
    WHERE y.continent = x.continent
  );
```

**My Notes:**  
The `ALL` operator combined with `<=` helps us select the country that appears first alphabetically per continent.

---

## Problem 9
Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.  

**My Solution:**

```sql
SELECT name, continent, population
FROM world x
WHERE 25000000 >= 
  ALL(
    SELECT population
    FROM world y
    WHERE y.continent = x.continent
  );
```

**My Notes:**  
Ensuring `ALL` countries in the continent meet the population condition filters for small-population continents.  
Use a correlated subquery.  

---

## Problem 10
Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.  

**My Solution:**

```sql
SELECT name, continent
FROM world x
WHERE population >
  ALL(
    SELECT population * 3
    FROM world y
    WHERE y.continent = x.continent
    AND y.name != x.name
  );
```

**My Notes:**  
Using `ALL` ensures the country’s population is three times larger than every other country in its continent.  
Remember to exclude self-comparison using `y.name != x.name`.

---
