# SQLZoo Solutions: SELECT Basics

This document contains my solutions for the SQLZoo ['SELECT Basics' section](https://sqlzoo.net/wiki/SELECT_basics) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
The example uses a `WHERE` clause to show the population of 'France'.  
Modify it to show the population of Germany.

**Solution:**

```sql
SELECT population 
FROM world
WHERE name = 'Germany';
```

**My Notes:**  
Strings should be in `single quotes` to distinguish them from SQL keywords or column names.

---

## Problem 2
The word `IN` allows us to check if an item is in a list.  
The example shows the name and population for the countries 'Brazil', 'Russia', 'India' and 'China'.  
Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.

**Solution:**

```sql
SELECT name, population 
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');
```

**My Notes:**  
Use `IN` for a list — great for matching multiple values in a `WHERE` clause.  
Separate items using a comma `,`.

---

## Problem 3
Which countries are not too small and not too big?  
`BETWEEN` allows range checking (inclusive of boundary values).  
The example below shows countries with an area of 250,000–300,000 sq. km.  
Modify it to show the country and the area for countries with an area between 200,000 and 250,000.

**Solution:**

```sql
SELECT name, area 
FROM world
WHERE area BETWEEN 200000 AND 250000;
```

**My Notes:**  
Use `BETWEEN ... AND` for an `inclusive` range — includes both boundary values.

---
