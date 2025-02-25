/*
10_TUTORIAL_QUIZZES.sql
MySQL syntax
Solutions for SQLZoo "Tutorial Quizzes" section
*/

-- Quiz: 1. SELECT Quiz

-- Question 1: Select the code which produces this table
-- name          | population
-- --------------|-----------
-- Bahrain       | 1234571
-- Swaziland     | 1220000
-- Timor-Leste   | 1066409

SELECT name, population
FROM world
WHERE population BETWEEN 1000000 AND 1250000;

/* Reflection:
BETWEEN is inclusive, so it captures countries with populations between 1,000,000 and 1,250,000.
*/
  
-- Question 2: Pick the result you would obtain from this code:
      SELECT name, population
      FROM world
      WHERE name LIKE "Al%";    

-- Albania   | 3200000
-- Algeria   | 32900000

/* Reflection:
The **LIKE** operator with 'Al%' selects names starting with 'Al'. The % wildcard matches any sequence of characters.
*/

-- Question 3: Select the code which shows the countries that end in A or L
SELECT name 
FROM world
WHERE name LIKE '%a' 
  OR name LIKE '%l';

/* Reflection:
'%a' matches names ending with 'a', and '%l' matches names ending with 'l'. 
The **OR** operator combines both conditions.
*/
  
-- Question 4: Pick the result from the query
    SELECT name,length(name)
    FROM world
    WHERE length(name)=5 and region='Europe';

-- name    | length(name)
-- --------|--------------
-- Italy   | 5
-- Malta   | 5
-- Spain   | 5

/* Reflection:
LENGTH(name) counts the number of characters in the country name. 
Using AND ensures the region filter is applied alongside the name length condition.
*/
  
-- Question 5: Here are the first few rows of the world table:
-- name        | region      | area  | population | gdp
-- ----------- | ----------- | ----- | ---------- | ------------
-- Afghanistan | South Asia  | 652225 | 26000000   | 
-- Albania     | Europe      | 28728  | 3200000    | 6656000000
-- Algeria     | Middle East | 2400000| 32900000   | 75012000000
-- Andorra     | Europe      | 468    | 64000      | 
-- Pick the result you would obtain from this code:
    SELECT name, area*2 FROM world WHERE population = 64000;

-- Andorra | 936

/* Reflection:
**Simple arithmetic operations** such as multiplication (*) and division (/) can be used in SELECT statements.
*/
  
-- Question 6: Select the code that would show the countries with an area larger than 50000 and a population smaller than 10000000
SELECT name, area, population
FROM world
WHERE area > 50000 
  AND population < 10000000;

/* Reflection:
The AND operator ensures that both conditions are met — countries with a large area but a smaller population.
*/
  
-- Question 7: Select the code that shows the population density of China, Australia, Nigeria and France
SELECT name, population/area
  FROM world
 WHERE name IN ('China', 'Nigeria', 'France', 'Australia');

/* Reflection:
Dividing population by area calculates population density. 
*/

