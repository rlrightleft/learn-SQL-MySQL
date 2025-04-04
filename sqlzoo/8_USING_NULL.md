# SQLZoo Solutions: Using NULL

This document contains my solutions to the SQLZoo ['Using NULL' section](https://sqlzoo.net/wiki/Using_Null) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
List the teachers who have NULL for their department.

**My Solution:**

```sql
SELECT name
FROM teacher
WHERE dept IS NULL;
```

**My Notes:**  
Use `IS NULL` to filter null values in SQL.
From Wikipedia: 
  "A null should not be confused with a value of 0. A null indicates a lack of a value, which is not the same as a zero value.
  In SQL, null is a marker, not a value. 
  This usage is quite different from most programming languages, where a null value of a reference means it is not pointing to any object."

---

## Problem 2
Note the INNER JOIN misses the teachers with no department and the departments with no teacher.

**My Solution:**

```sql
SELECT teacher.name, dept.name
FROM teacher 
INNER JOIN dept ON (teacher.dept = dept.id);
```

---

## Problem 3
Use a different JOIN so that all teachers are listed.

**My Solution:**

```sql
SELECT teacher.name, dept.name
FROM teacher
LEFT JOIN dept ON (teacher.dept = dept.id);
```

**My Notes:**  
`LEFT JOIN` includes all teachers, even those without a department.

---

## Problem 4
Use a different JOIN so that all departments are listed.

**My Solution:**

```sql
SELECT teacher.name, dept.name
FROM teacher
RIGHT JOIN dept ON (teacher.dept = dept.id);
```

**My Notes:**  
`RIGHT JOIN` ensures all departments are listed, even if they have no teachers.

---

## Problem 5
Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given.

**My Solution:**

```sql
SELECT 
  teacher.name,
  COALESCE(teacher.mobile, '07986 444 2266') AS 'mobile number'
FROM teacher;
```

**My Notes:**  
`COALESCE()` returns the first non-null value from its arguments.

---

## Problem 6
Use COALESCE and a LEFT JOIN to print the teacher name and department name. Use 'None' where there is no department.

**My Solution:**

```sql
SELECT 
  teacher.name, 
  COALESCE(dept.name, 'None') AS 'department name'
FROM teacher
LEFT JOIN dept ON (teacher.dept = dept.id);
```

---

## Problem 7
Use COUNT to show the number of teachers and the number of mobile phones.

**My Solution:**

```sql
SELECT 
  COUNT(teacher.name),
  COUNT(teacher.mobile)
FROM teacher;
```

---

## Problem 8
Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.

**My Solution:**

```sql
SELECT
  dept.name,
  COUNT(teacher.name)
FROM teacher
RIGHT JOIN dept ON (teacher.dept = dept.id)
GROUP BY dept.name;
```

---

## Problem 9
Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.

**My Solution:**

```sql
SELECT
  teacher.name,
  CASE
    WHEN dept IN (1, 2) THEN 'Sci'
    ELSE 'Art' 
  END AS 'Sci or Art'
FROM teacher;
```

**My Notes:**  
`CASE` allows you to return different values under different conditions.

---

## Problem 10
Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, 'Art' if the dept is 3, and 'None' otherwise.

**My Solution:**

```sql
SELECT
  teacher.name,
  CASE
    WHEN dept IN (1, 2) THEN 'Sci'
    WHEN dept = 3 THEN 'Art'
    ELSE 'None'
  END AS 'Sci, Art, or None'
FROM teacher;
```

---

