# SQLZoo Solutions: SELECT from Nobel

This document contains my solutions to the SQLZoo ['SELECT from Nobel' section](https://sqlzoo.net/wiki/SELECT_from_Nobel_Tutorial) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
Show Nobel prizes for 1950.

**My Solution:**

```sql
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;
```

---

## Problem 2
Show who won the 1962 prize for literature.

**My Solution:**

```sql
SELECT winner
FROM nobel
WHERE yr = 1962
  AND subject = 'literature';
```

---

## Problem 3
Show the year and subject that won Albert Einstein his prize.

**My Solution:**

```sql
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';
```

---

## Problem 4
Give the name of the peace winners since the year 2000, including 2000.

**My Solution:**

```sql
SELECT winner
FROM nobel
WHERE subject = 'peace'
  AND yr >= 2000;
```

**My Notes:**  
Using `>=` ensures inclusion of the boundary year 2000.

---

## Problem 5
Show all details of the literature prize winners for 1980 to 1989 inclusive.

**My Solution:**

```sql
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'literature'
  AND yr BETWEEN 1980 AND 1989;
```

**My Notes:**  
Use `BETWEEN` for an inclusive range filter.

---

## Problem 6
Show all details of the presidential winners: Theodore Roosevelt, Thomas Woodrow Wilson, Jimmy Carter, Barack Obama.

**My Solution:**

```sql
SELECT * 
FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Thomas Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');
```

**My Notes:**  
The `IN` operator allows filtering for multiple values efficiently.

---

## Problem 7
Show the winners with the first name John.

**My Solution:**

```sql
SELECT winner
FROM nobel
WHERE winner LIKE 'John %';
```

---

## Problem 8
Show the year, subject, and name of physics winners for 1980 together with chemistry winners for 1984.

**My Solution:**

```sql
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'physics' AND yr = 1980)
  OR (subject = 'chemistry' AND yr = 1984);
```

**My Notes:**  
Grouping conditions using parentheses ensures proper `OR` logic application.

---

## Problem 9
Show the year, subject, and name of winners for 1980 excluding chemistry and medicine.

**My Solution:**

```sql
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1980
  AND subject NOT IN ('chemistry', 'medicine');
```

**My Notes:**  
The `NOT IN` operator filters out specific subjects.

---

## Problem 10
Show year, subject, and name of people who won a Medicine prize before 1910 and Literature prize after 2004 (including 2004).

**My Solution:**

```sql
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910)
  OR (subject = 'Literature' AND yr >= 2004);
```

---

## Problem 11
Find all details of the prize won by PETER GRÜNBERG.

**My Solution:**

```sql
SELECT *
FROM nobel
WHERE winner = 'PETER GRÜNBERG';
```

**My Notes:**  
Handling names with special characters requires exact matching.

---

## Problem 12
Find all details of the prize won by EUGENE O'NEILL.

**My Solution:**

```sql
SELECT *
FROM nobel
WHERE winner = 'EUGENE O''NEILL';
```

**My Notes:**  
Putting single quotes inside a string requires using double single quotes (`''`).

---

## Problem 13
List the winners, year, and subject where the winner starts with Sir. Show the most recent first, then by name order.

**My Solution:**

```sql
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, 
  winner;
```

**My Notes:**  
Sort first by descending year, then alphabetically by winner.

---

## Problem 14
Show the 1984 winners and subject ordered by subject and winner name; but list chemistry and physics last.

**My Solution:**

```sql
SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN ('physics','chemistry'), 
  subject, 
  winner;
```

**My Notes:**  
Sorting trick: subjects in (`'physics'`, `'chemistry'`) are treated as boolean values (0 or 1).

---
