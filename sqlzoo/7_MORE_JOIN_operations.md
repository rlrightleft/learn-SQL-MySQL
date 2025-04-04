# SQLZoo Solutions: More JOIN operations

This document contains my solutions to the SQLZoo ['More JOIN operations' section](https://sqlzoo.net/wiki/More_JOIN_operations) using MySQL syntax, along with my personal learning notes and explanations.

---

## Problem 1
List the films where the year is 1962 (show id, title).

**My Solution:**

```sql
SELECT id, title
FROM movie 
WHERE yr = 1962;
```

---

## Problem 2
Give the year of 'Citizen Kane'.

**My Solution:**

```sql
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';
```

---

## Problem 3
List all of the Star Trek movies, including id, title, and year. Order results by year.

**My Solution:**

```sql
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;
```

---

## Problem 4
What id number does the actor 'Glenn Close' have?

**My Solution:**

```sql
SELECT id
FROM actor
WHERE name = 'Glenn Close';
```

---

## Problem 5
What is the id of the film 'Casablanca'?

**My Solution:**

```sql
SELECT id
FROM movie
WHERE title = 'Casablanca';
```

---

## Problem 6
Obtain the cast list for 'Casablanca'.

**My Solution:**

```sql
SELECT actor.name
FROM actor JOIN casting ON (actor.id = casting.actorid)
WHERE casting.movieid = 11768;
```

**My Notes:**  
`JOIN` retrieves all actors associated with the movie ID 11768 (Casablanca).

---

## Problem 7
Obtain the cast list for the film 'Alien'.

**My Solution:**

```sql
SELECT actor.name
FROM actor JOIN casting ON (actor.id = actorid)
WHERE movieid =
  (
  SELECT id
  FROM movie
  WHERE title = 'Alien'
  );
```

**My Notes:**  
Use a subquery to find the movie ID dynamically.

---

## Problem 8
List the films in which 'Harrison Ford' has appeared.

**My Solution:**

```sql
SELECT title
FROM movie JOIN casting ON (movie.id = movieid)
WHERE actorid =
(
SELECT id
FROM actor
WHERE name = 'Harrison Ford'
);
```

---

## Problem 9
List the films where 'Harrison Ford' has appeared but not in the starring role.

**My Solution:**

```sql
SELECT title
FROM movie JOIN casting ON (movie.id = movieid)
WHERE ord > 1 
AND actorid =
  (
  SELECT id
  FROM actor
  WHERE name = 'Harrison Ford'
  );
```

**My Notes:**  
Use `ord > 1` to exclude lead roles while still listing supporting roles.

---

## Problem 10
List the films together with the leading star for all 1962 films.

**My Solution:**

```sql
SELECT movie.title, actor.name
FROM casting
  JOIN movie ON (movieid = movie.id)
  JOIN actor ON (actorid = actor.id)
WHERE yr = 1962
AND ord = 1;
```

**My Notes:**  
You can `JOIN` more than 2 tables.

---

## Problem 11
Which were the busiest years for 'Rock Hudson'?

**My Solution:**

```sql
SELECT yr, COUNT(title) 
FROM movie 
  JOIN casting ON movie.id = movieid
  JOIN actor ON actorid = actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;
```

**My Notes:**  
Use `HAVING` to filter years where Rock Hudson acted in more than 2 films.

---

## Problem 12
List the film title and the leading actor for all of the films 'Julie Andrews' played in.

**My Solution:**

```sql
SELECT DISTINCT movie.title, actor.name
FROM casting
JOIN movie ON (movieid = movie.id)
JOIN actor ON (actorid = actor.id)
WHERE ord = 1
AND movie.id IN
  (SELECT movieid 
  FROM casting
  WHERE actorid = 
     (
    SELECT id
    FROM actor
    WHERE name = 'Julie Andrews'
     )
  );
```

---

## Problem 13
List actors who've had at least 15 starring roles, in alphabetical order.

**My Solution:**

```sql
SELECT DISTINCT actor.name
FROM actor 
  JOIN casting ON (actor.id = actorid)
WHERE ord = 1
GROUP BY actorid
HAVING COUNT(actorid) >= 15
ORDER BY actor.name;
```

**My Notes:**  
`GROUP BY` groups actors, and `HAVING COUNT()` filters those with 15 or more starring roles.

---

## Problem 14
List films released in 1978 ordered by the number of actors in the cast, then by title.

**My Solution:**

```sql
SELECT movie.title, COUNT(actorid)
FROM movie 
  JOIN casting ON (movie.id = movieid) 
WHERE yr = 1978
GROUP BY movieid
ORDER BY 
  COUNT(actorid) DESC, 
  movie.title;
```

**My Notes:**  
Use `COUNT(actorid)` to measure cast size and sort by `title` in case of ties.

---

## Problem 15
List all the people who have worked with 'Art Garfunkel'.

**My Solution:**

```sql
SELECT actor.name
FROM actor 
  JOIN casting ON (actor.id = actorid)
WHERE actor.name <> 'Art Garfunkel'
AND movieid IN
  (
  SELECT movieid
  FROM casting
  WHERE actorid = 
    (
    SELECT actor.id
    FROM actor
    WHERE actor.name = 'Art Garfunkel'
    )
  );
```

**My Notes:**  
Use subqueries to find all movie IDs featuring Art Garfunkel, then list all other actors in those movies.  
Exclude Art Garfunkel using `actor.name <> 'Art Garfunkel'`.

---
