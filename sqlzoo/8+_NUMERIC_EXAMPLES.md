# SQLZoo Solutions: Numeric Examples (NSS Tutorial)

This document contains my solutions to the SQLZoo ['Numeric Examples (NSS Tutorial)' section](https://sqlzoo.net/wiki/NSS_Tutorial) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
Show the percentage who STRONGLY AGREE for Q01 at Edinburgh Napier University, Computer Science.

**My Solution:**

```sql
SELECT A_STRONGLY_AGREE 
FROM nss
WHERE question = 'Q01'
AND institution = 'Edinburgh Napier University'
AND subject = '(8) Computer Science';
```

---

## Problem 2
Show the institution and subject where the score is at least 100 for question 15.

**My Solution:**

```sql
SELECT institution, subject
FROM nss
WHERE question = 'Q15'
AND score >= 100;
```

---

## Problem 3
Show the institution and score for Computer Science with score less than 50 for question Q15.

**My Solution:**

```sql
SELECT institution, score
FROM nss
WHERE question = 'Q15'
AND subject = '(8) Computer Science'
AND score < 50;
```

---

## Problem 4
Show the subject and total number of students who responded to question 22 for Computer Science and Creative Arts and Design.

**My Solution:**

```sql
SELECT subject, SUM(response)
FROM nss
WHERE question = 'Q22'
GROUP BY subject
HAVING subject IN ('(8) Computer Science', '(H) Creative Arts and Design');
```

**My Notes:**  
Use `SUM()` over the `response` column and `GROUP BY` subject to get totals.

---

## Problem 5
Show the subject and total number of students who strongly agreed to question 22 for Computer Science and Creative Arts and Design.

**My Solution:**

```sql
SELECT subject, SUM(A_STRONGLY_AGREE * response / 100)
FROM nss
WHERE question = 'Q22'
GROUP BY subject
HAVING subject IN ('(8) Computer Science', '(H) Creative Arts and Design');
```

**My Notes:**  
Multiply percentage by response count, divide by 100, and sum the values.

---

## Problem 6
Show the percentage of students who strongly agreed to question 22 for Computer Science and Creative Arts and Design, rounded to the nearest whole number.

**My Solution:**

```sql
SELECT subject, ROUND(SUM(response*A_STRONGLY_AGREE)/SUM(response),0)
FROM nss
WHERE question = 'Q22'
GROUP BY subject
HAVING subject IN ('(8) Computer Science', '(H) Creative Arts and Design');
```

**My Notes:**  
Calculate weighted average and round to zero decimal places.

---

## Problem 7
Show the average scores for question Q22 for each institution with 'Manchester' in the name, rounded to the nearest whole number.

**My Solution:**

```sql
SELECT institution, ROUND(
SUM(score * response) / SUM(response),
0)
FROM nss
WHERE institution LIKE '%Manchester%'
AND question = 'Q22'
GROUP BY institution;
```

---

## Problem 8
Show the institution, total sample size, and number of computing students for Manchester institutions for Q01.

**My Solution:**

```sql
SELECT 
  institution, 
  SUM(sample),
  SUM(
    CASE WHEN subject = '(8) Computer Science' THEN sample
    ELSE 0 
    END 
  ) AS comp
FROM nss
WHERE question = 'Q01'
AND institution LIKE '%Manchester%'
GROUP BY institution;
```

**My Notes:**  
Use `CASE WHEN` inside `SUM()` to conditionally sum Computer Science sample sizes.

---
