# SQLZoo Solutions: SELECT Name

This document contains my solutions to the SQLZoo ['SELECT Names' section](https://sqlzoo.net/wiki/SELECT_names) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
You can use `WHERE name LIKE 'B%'` to find the countries that start with "B".  
The `%` is a wild-card it can match any characters.  
Find the country that start with Y.  

**My Solution:**

```sql
SELECT name 
FROM world
WHERE name LIKE 'Y%';
```

**My Notes:**  
The `LIKE` operator with 'Y%' matches any country name that starts with Y. 
Use `%` as a wildcard to match any number of any characters.

---

## Problem 2
Find the countries that end with y.

**My Solution:**

```sql
SELECT name 
FROM world
WHERE name LIKE '%y';
```

**My Notes:**  
The `%` wildcard before y matches names ending with y.

---

## Problem 3
Luxembourg has an x - so does one other country. List them both.  
Find the countries that contain the letter x.  

**My Solution:**

```sql
SELECT name 
FROM world
WHERE name LIKE '%x%';
```

**My Notes:**  
You can use `%` before and after a letter to match it anywhere in the string.

---

## Problem 4
Iceland, Switzerland end with land - but are there others?  
Find the countries that end with land.

**My Solution:**

```sql
SELECT name
FROM world
WHERE name LIKE '%land';
```

---

## Problem 5
Columbia starts with a C and ends with ia - there are two more like this.  
Find the countries that start with C and end with ia.  

**My Solution:**

```sql
SELECT name
FROM world
WHERE name LIKE 'C%'
AND name LIKE '%ia';
```

**My Notes:**  
Combining `LIKE` conditions with `AND` allows filtering names by both prefixes and suffixes.

---

## Problem 6
Greece has a double e - who has a double o?  
Find the country that has oo in the name.  

**My Solution:**

```sql
SELECT name 
FROM world
WHERE name LIKE '%oo%';
```

---

## Problem 7
Bahamas has three a - who else?  
Find the countries that have three or more a in the name.  

**My Solution:**

```sql
SELECT name 
FROM world
WHERE name LIKE '%a%a%a%';
```

---

## Problem 8
India and Angola have an n as the second character. You can use the underscore as a single character wildcard.  
`SELECT name FROM world  
WHERE name LIKE '_n%'  
ORDER BY name  `  
Find the countries that have "t" as the second character.

**My Solution:**

```sql
SELECT name 
FROM world
WHERE name LIKE '_t%';
```

**My Notes:**  
The underscore `_` acts as a wildcard for a single character.

---

## Problem 9
Lesotho and Moldova both have two o characters separated by two other characters.  
Find the countries that have two "o" characters separated by two others.  

**My Solution:**

```sql
SELECT name 
FROM world
WHERE name LIKE '%o__o%';
```

**My Notes:**  
Using `__` (two underscores) ensures exactly two characters exist between the o's.

---

## Problem 10
Cuba and Togo have four characters names.  
Find the countries that have exactly four characters.  

**My Solution:**

```sql
SELECT name 
FROM world
WHERE name LIKE '____';
```

**My Notes:**  
Each underscore `_` represents one character, ensuring exactly four characters.

---

## Problem 11
The capital of Luxembourg is Luxembourg. Show all the countries where the capital is the same as the name of the country.  
Find the country where the name is the capital city.  

**My Solution:**

```sql
SELECT name
FROM world
WHERE name = capital;
```

---

## Problem 12
The capital of Mexico is Mexico City. Show all the countries where the capital has the country together with the word "City".  
Find the country where the capital is the country plus "City".  

**My Solution:**

```sql
SELECT name
FROM world
WHERE capital = CONCAT(name, ' City');
```

**My Notes:**  
The `CONCAT` (short for concatenate) function appends ' City' to the country name. 
Use `CONCAT` to combine multiple strings.

---

## Problem 13
Find the capital and the name where the capital includes the name of the country.  

**My Solution:**

```sql
SELECT capital, name
FROM world
WHERE capital LIKE CONCAT('%', name, '%');
```

**My Notes:**  
Combine `LIKE` and `CONCAT` to check if the country name appears anywhere in the capital name.

---

## Problem 14
Find the capital and the name where the capital is an extension of name of the country.  
You should include Mexico City as it is longer than Mexico. You should not include Luxembourg as the capital is the same as the country.  

**My Solution:**

```sql
SELECT capital, name
FROM world
WHERE capital != name
AND capital LIKE CONCAT('%', name, '%');
```

**My Notes:**  
Filter out exact matches using `!=`.

---

## Problem 15
The capital of Monaco is Monaco-Ville: this is the name Monaco and the extension is -Ville.  
Show the name and the extension where the capital is a proper (non-empty) extension of name of the country.  
You can use the SQL function `REPLACE`.  

**My Solution:**

```sql
SELECT 
  name, 
  REPLACE(capital, name, '') AS extension
FROM world
WHERE capital != name
AND capital LIKE CONCAT('%', name, '%');
```

**My Notes:**  
The `REPLACE` function extracts the extension part of the capital name by removing the country name.  
Example: `REPLACE('vessel', 'e', 'a')` → 'vassal'

---
