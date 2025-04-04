# SQLZoo Solutions: SELECT within SELECT

This document contains my solutions to the SQLZoo ['SELECT within SELECT' section](https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
List each country name where the population is larger than that of Russia.

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
Use a subquery (in parentheses) to compare against a specific value retrieved dynamically.

---

## Problem 2
Show the countries in Europe with a per capita GDP greater than United Kingdom.

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
Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

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
Percentages are calculated by multiplying by 100 and rounding to remove decimals.

---

## Problem 6
Which countries have a GDP greater than every country in Europe? (Some countries may have NULL GDP values.)

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
Find the largest country (by area) in each continent. Show the continent, the name, and the area.

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
This correlated subquery allows checking the largest country per continent dynamically.

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
The `ALL` operator combined with `<=` helps to select the country that appears first alphabetically per continent.

---

## Problem 9
Find the continents where all countries have a population <= 25 million. Then find the names of the countries associated with these continents. Show name, continent, and population.

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
Ensuring `ALL` countries in the continent meet the condition filters for small-population continents.

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
Remember to exclude self-comparison with `y.name != x.name`.

---
