# SQLZoo Solutions: Window Functions

This document contains my solutions to the SQLZoo ['Window Functions' section](https://sqlzoo.net/wiki/Window_functions) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
Show the last name, party, and votes for the constituency 'S14000024' in 2017.

**My Solution:**

```sql
SELECT lastName, party, votes
FROM ge
WHERE constituency = 'S14000024'
  AND yr = 2017
ORDER BY votes DESC;
```

---

## Problem 2
Show the party and RANK for constituency 'S14000024' in 2017.

**My Solution:**

```sql
SELECT party, votes,
       RANK() OVER (ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000024' 
  AND yr = 2017
ORDER BY party;
```

**My Notes:**  
`RANK()` assigns a rank based on descending votes.

---

## Problem 3
Show the ranking of each party in 'S14000021' for each year.

**My Solution:**

```sql
SELECT yr, party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000021'
ORDER BY party, yr;
```

**My Notes:**  
`PARTITION BY` groups by year to rank votes within each year.

---

## Problem 4
Show the ranking of each party in Edinburgh constituencies (S14000021 to S14000026) in 2017.

**My Solution:**

```sql
SELECT 
  constituency, 
  party, 
  votes,
  RANK() OVER (PARTITION BY constituency ORDER BY votes DESC)
FROM ge
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
  AND yr = 2017
ORDER BY 
  RANK() OVER (PARTITION BY constituency ORDER BY votes DESC), 
  constituency;
```

---

## Problem 5
Show the parties that won for each Edinburgh constituency in 2017.

**My Solution:**

```sql
SELECT constituency, party
FROM (
  SELECT 
    constituency, 
    party, 
    RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS posn
  FROM ge
  WHERE yr = 2017
    AND constituency BETWEEN 'S14000021' AND 'S14000026'
) ranked
WHERE posn = 1;
```

**My Notes:**  
Use a subquery to rank, then filter for the top-ranked (winning) party.

---

## Problem 6
Show how many seats each party won in Scotland in 2017.

**My Solution:**

```sql
SELECT 
  party, 
  COUNT(*) AS seats_won
FROM ge x
WHERE constituency LIKE 'S%'
  AND yr = 2017
  AND votes = (
    SELECT MAX(votes) 
    FROM ge y 
    WHERE y.constituency = x.constituency 
      AND y.yr = 2017
  )
GROUP BY party;
```

**My Notes:**  
Use `COUNT()` and `GROUP BY` to tally seats.  
The subquery ensures only winners per constituency are counted.

---

