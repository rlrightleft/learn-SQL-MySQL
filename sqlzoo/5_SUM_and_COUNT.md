# SQLZoo Solutions: SUM and COUNT

This document contains my solutions to the SQLZoo ['SUM and COUNT' section](https://sqlzoo.net/wiki/SUM_and_COUNT) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
Show the total population of the world.

**My Solution:**

```sql
SELECT SUM(population)
FROM world;
```

**My Notes:**  
`SUM()` is an aggregate function that calculates the total population across all rows.

---

## Problem 2
List all the continents - just once each.

**My Solution:**

```sql
SELECT DISTINCT continent
FROM world;
```

**My Notes:**  
`DISTINCT` removes duplicate values, ensuring each continent appears only once.

---

## Problem 3
Give the total GDP of Africa.

**My Solution:**

```sql
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';
```

**My Notes:**  
Using `SUM()` with `WHERE` filters the sum to only African countries.

---

## Problem 4
How many countries have an area of at least 1,000,000?

**My Solution:**

```sql
SELECT COUNT(name)
FROM world
WHERE area >= 1000000;
```

**My Notes:**  
`COUNT()` counts the number of rows matching the condition.

---

## Problem 5
What is the total population of Estonia, Latvia, and Lithuania?

**My Solution:**

```sql
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');
```

---

## Problem 6
For each continent show the continent and number of countries.

**My Solution:**

```sql
SELECT continent, COUNT(name)
FROM world
GROUP BY continent;
```

**My Notes:**  
`GROUP BY` groups rows by continent, and `COUNT()` counts how many countries exist per continent.

---

## Problem 7
For each continent show the continent and number of countries with populations of at least 10 million.

**My Solution:**

```sql
SELECT continent, COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent;
```

**My Notes:**  
Applying `WHERE` before `GROUP BY` ensures only countries meeting the condition are counted.

---

## Problem 8
List the continents that have a total population of at least 100 million.

**My Solution:**

```sql
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;
```

**My Notes:**  
The `HAVING` clause filters groups after aggregation.

---

# Nobel Prize Aggregate Problems

---

## Problem 1
Show the total number of prizes awarded.

**My Solution:**

```sql
SELECT COUNT(winner)
FROM nobel;
```

---

## Problem 2
List each subject - just once.

**My Solution:**

```sql
SELECT DISTINCT subject
FROM nobel;
```

---

## Problem 3
Show the total number of prizes awarded for Physics.

**My Solution:**

```sql
SELECT COUNT(winner)
FROM nobel
WHERE subject = 'Physics';
```

---

## Problem 4
For each subject show the subject and the number of prizes.

**My Solution:**

```sql
SELECT subject, COUNT(winner)
FROM nobel
GROUP BY subject;
```

---

## Problem 5
For each subject show the first year that the prize was awarded.

**My Solution:**

```sql
SELECT subject, yr
FROM nobel x
WHERE yr <= 
  ALL(
    SELECT yr
    FROM nobel y
    WHERE y.subject = x.subject
  )
GROUP BY subject;
```

---

## Problem 6
For each subject show the number of prizes awarded in the year 2000.

**My Solution:**

```sql
SELECT subject, COUNT(winner)
FROM nobel
WHERE yr = 2000
GROUP BY subject;
```

---

## Problem 7
Show the number of different winners for each subject.

**My Solution:**

```sql
SELECT subject, COUNT(DISTINCT winner)
FROM nobel
GROUP BY subject;
```

---

## Problem 8
For each subject show how many years have had prizes awarded.

**My Solution:**

```sql
SELECT subject, COUNT(DISTINCT yr)
FROM nobel
GROUP BY subject;
```

---

## Problem 9
Show the years in which three prizes were given for Physics.

**My Solution:**

```sql
SELECT yr
FROM nobel
WHERE subject = 'Physics'
GROUP BY yr
HAVING COUNT(winner) = 3;
```

---

## Problem 10
Show winners who have won more than once.

**My Solution:**

```sql
SELECT winner
FROM nobel
GROUP BY winner
HAVING COUNT(winner) > 1;
```

---

## Problem 11
Show winners who have won more than one subject.

**My Solution:**

```sql
SELECT winner
FROM nobel
GROUP BY winner
HAVING COUNT(DISTINCT subject) > 1;
```

---

## Problem 12
Show the year and subject where 3 prizes were given (from year 2000 onwards).

**My Solution:**

```sql
SELECT yr, subject
FROM nobel
WHERE yr >= 2000
GROUP BY yr, subject
HAVING COUNT(winner) = 3;
```

---
