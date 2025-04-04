# SQLZoo Solutions: SELECT from World

This document contains my solutions to the SQLZoo ['SELECT from World' section](https://sqlzoo.net/wiki/SELECT_from_WORLD_Tutorial) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
Show the name, continent, and population of all countries.

**My Solution:**

```sql
SELECT name, continent, population 
FROM world;
```

---

## Problem 2
Show the name for the countries that have a population of at least 200 million.

**My Solution:**

```sql
SELECT name 
FROM world
WHERE population >= 200000000;
```

---

## Problem 3
Give the name and the per capita GDP for those countries with a population of at least 200 million.

**My Solution:**

```sql
SELECT name, gdp/population
FROM world
WHERE population >= 200000000;
```

**My Notes:**  
Per capita GDP is the GDP divided by the population (`gdp/population`).

---

## Problem 4
Show the name and population in millions for the countries of the continent South America.

**My Solution:**

```sql
SELECT name, population/1000000
FROM world
WHERE continent = 'South America';
```

---

## Problem 5
Show the name and population for France, Germany, and Italy.

**My Solution:**

```sql
SELECT name, population
FROM world
WHERE name IN ('France','Germany','Italy');
```

---

## Problem 6
Show the countries which have a name that includes the word 'United'.

**My Solution:**

```sql
SELECT name
FROM world
WHERE name LIKE '%United%';
```

---

## Problem 7
Show the countries that are big by area (more than 3 million sq km) or big by population (more than 250 million). Show name, population, and area.

**My Solution:**

```sql
SELECT name, population, area
FROM world
WHERE area > 3000000
  OR population > 250000000;
```

---

## Problem 8
Show the countries that are big by area or big by population but not both. Show name, population, and area.

**My Solution:**

```sql
SELECT name, population, area
FROM world
WHERE area > 3000000
  XOR population > 250000000;
```

---

## Problem 9
Show the name, population in millions, and GDP in billions for the countries of South America, rounded to two decimal places.

**My Solution:**

```sql
SELECT 
  name, 
  ROUND(population/1000000, 2), 
  ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = 'South America';
```

**My Notes:**  
`ROUND(f, p)` returns f rounded to p decimal places.  
Dividing by `1000000.0` or `1000000000.0` prevents integer division.

---

## Problem 10
Show the name and per-capita GDP (rounded to the nearest 1000) for countries with GDP of at least one trillion.

**My Solution:**

```sql
SELECT name, ROUND(gdp/population, -3)
FROM world
WHERE gdp >= 1000000000000;
```

---

## Problem 11
Show the name and capital where the name and the capital have the same number of characters.

**My Solution:**

```sql
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);
```

**My Notes:**  
`LENGTH(s)` returns the number of characters in string s.

---

## Problem 12
Show the name and capital where the first letters of each match, and the name and capital are not the same word.

**My Solution:**

```sql
SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1)
  AND name <> capital;
```

**My Notes:**  
`LEFT(s, n)` extracts n characters from the start of string `s`.

---

## Problem 13
Find the country that has all the vowels (a, e, i, o, u) in the name with no spaces.

**My Solution:**

```sql
SELECT name
FROM world
WHERE name LIKE '%a%' 
  AND name LIKE '%e%' 
  AND name LIKE '%i%' 
  AND name LIKE '%o%' 
  AND name LIKE '%u%'
  AND name NOT LIKE '% %';
```

---

