/*
10_TUTORIAL_QUIZZES.sql
MySQL syntax
Solutions for SQLZoo "Tutorial Quizzes" section
*/

-- Quiz 1: SELECT Quiz

-- Question 1.1: Select the code which produces this table
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
  
-- Question 1.2: Pick the result you would obtain from this code:
    SELECT name, population
    FROM world
    WHERE name LIKE "Al%";    

-- Albania   | 3200000
-- Algeria   | 32900000

/* Reflection:
The **LIKE** operator with 'Al%' selects names starting with 'Al'. The % wildcard matches any sequence of characters.
*/

-- Question 1.3: Select the code which shows the countries that end in A or L
SELECT name 
FROM world
WHERE name LIKE '%a' 
  OR name LIKE '%l';

/* Reflection:
'%a' matches names ending with 'a', and '%l' matches names ending with 'l'. 
The **OR** operator combines both conditions.
*/
  
-- Question 1.4: Pick the result from the query
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
  
-- Question 1.5: Here are the first few rows of the world table:
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
  
-- Question 1.6: Select the code that would show the countries with an area larger than 50000 and a population smaller than 10000000
SELECT name, area, population
FROM world
WHERE area > 50000 
  AND population < 10000000;

/* Reflection:
The AND operator ensures that both conditions are met — countries with a large area but a smaller population.
*/
  
-- Question 1.7: Select the code that shows the population density of China, Australia, Nigeria and France
SELECT name, population/area
  FROM world
 WHERE name IN ('China', 'Nigeria', 'France', 'Australia');

/* Reflection:
Dividing population by area calculates population density. 
*/


-- Quiz 2: BBC Quiz

-- Question 2.1: Select the code which gives the name of countries beginning with U
SELECT name
FROM world
WHERE name LIKE 'U%';

-- Question 2.2: Select the code which shows just the population of United Kingdom?
SELECT population
FROM world
WHERE name = 'United Kingdom';

-- Question 2.3: Select the answer which shows the problem with this SQL code - the intended result should be the continent of France:
SELECT continent 
   FROM world 
  WHERE 'name' = 'France';
-- Answer 2.3: 'name' should be name

-- Question 2.4: Select the result that would be obtained from the following code:
SELECT name, population / 10 
  FROM world 
 WHERE population < 10000;
-- Answer 2.4: 
  -- Nauru	990

-- Question 2.5: Select the code which would reveal the name and population of countries in Europe and Asia
SELECT name, population
FROM world
WHERE continent IN ('Europe', 'Asia');

-- Question 2.6: Select the code which would give two rows
SELECT name 
FROM world
WHERE name IN ('Cuba', 'Togo');

-- Question 2.7: Select the result that would be obtained from this code:
SELECT name FROM world
 WHERE continent = 'South America'
   AND population > 40000000;
-- Answer 2.7: 
  -- Brazil
  -- Colombia


-- Quiz 3: Nobel Quiz

-- Question 3.1: Pick the code which shows the name of winner's names beginning with C and ending in n
SELECT winner 
FROM nobel
WHERE winner LIKE 'C%' 
AND winner LIKE '%n';

-- Question 3.2: Select the code that shows how many Chemistry awards were given between 1950 and 1960
SELECT COUNT(subject) 
FROM nobel
WHERE subject = 'Chemistry'
AND yr BETWEEN 1950 and 1960;

-- Question 3.3: Pick the code that shows the amount of years where no Medicine awards were given
SELECT COUNT(DISTINCT yr) 
FROM nobel
WHERE yr NOT IN 
  (SELECT DISTINCT yr 
  FROM nobel 
  WHERE subject = 'Medicine');

-- Question 3.4: Select the result that would be obtained from the following code:
SELECT subject, winner FROM nobel WHERE winner LIKE 'Sir%' AND yr LIKE '196%';
-- Answer 3.4: 
  -- Medicine	| Sir John Eccles
  -- Medicine	| Sir Frank Macfarlane Burnet

-- Question 3.5: Select the code which would show the year when neither a Physics or Chemistry award was given
SELECT yr 
FROM nobel
WHERE yr NOT IN
  (SELECT yr 
  FROM nobel
  WHERE subject IN ('Chemistry','Physics'));

-- Question 3.6: Select the code which shows the years when a Medicine award was given but no Peace or Literature award was
SELECT DISTINCT yr
FROM nobel
WHERE subject='Medicine' 
AND yr NOT IN
  (SELECT yr 
  FROM nobel 
  WHERE subject='Literature')
AND yr NOT IN 
  (SELECT yr 
  FROM nobel
  WHERE subject='Peace');

-- Question 3.7: Pick the result that would be obtained from the following code:
SELECT subject, COUNT(subject) 
   FROM nobel 
  WHERE yr ='1960' 
  GROUP BY subject;
-- Answer 3.7: 
  -- Chemistry  |	1
  -- Literature	| 1
  -- Medicine	  | 2
  -- Peace	    | 1
  -- Physics	  | 1

-- Quiz 4: Nested SELECT Quiz

-- Question 4.1:
