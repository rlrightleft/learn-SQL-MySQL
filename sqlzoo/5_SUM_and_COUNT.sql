/*
5_SUM_and_COUNT.sql
MySQL syntax
Solutions for SQLZoo "SUM and COUNT" section 
*/

-- Problem 1: Show the total population of the world.
-- world(name, continent, area, population, gdp)
SELECT SUM(population)
FROM world;

/* Reflection:
**SUM()** is an aggregate function that calculates the total population across all rows.
*/

-- Problem 2: List all the continents - just once each.
SELECT DISTINCT continent
FROM world;

/* Reflection:
**DISTINCT** removes duplicate values, ensuring each continent appears only once.
*/

-- Problem 3: Give the total GDP of Africa
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';

/* Reflection:
Using **SUM()** with **WHERE** filters the sum to only African countries.
*/

-- Problem 4: How many countries have an area of at least 1000000
SELECT COUNT(name)
FROM world
WHERE area >= 1000000;

/* Reflection:
**COUNT()** counts the number of rows matching the condition.
*/

-- Problem 5: What is the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

-- Problem 6: For each continent show the continent and number of countries.
SELECT continent, COUNT(name)
FROM world
GROUP BY continent;

/* Reflection:
**GROUP BY** groups rows by continent, and **COUNT()** counts how many countries exist per continent.
By including a **GROUP BY** clause functions, such as SUM and COUNT are applied to groups of items sharing values. 
When you specify GROUP BY continent, the result is that you get only one row for each different value of continent.
*/

-- Problem 7: For each continent show the continent and number of countries with populations of at least 10 million.
SELECT continent, COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent;

/* Reflection:
Applying **WHERE** before **GROUP BY** ensures only countries meeting the condition are counted.
The **WHERE** clause filters rows before the aggregation, the HAVING clause filters after the aggregation.
*/

-- Problem 8: List the continents that have a total population of at least 100 million.
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;

/* Reflection:
The **HAVING** clause allows us to filter the GROUP BY groups which are displayed. 
The WHERE clause filters rows before the aggregation, the **HAVING** clause filters after the aggregation.
*/


-- Additional problems related to the nobel table:
-- The nobel table can be used to practice more SUM and COUNT functions.
-- Nobel Prizes: Aggregate functions
-- This tutorial concerns aggregate functions such as COUNT, SUM and AVG.

-- Nobel Problem 1: Show the total number of prizes awarded.
SELECT COUNT(winner) 
FROM nobel;

-- Nobel Problem 2: List each subject - just once
SELECT DISTINCT subject
FROM nobel;

-- Nobel Problem 3: Show the total number of prizes awarded for Physics.
SELECT COUNT(winner)
FROM nobel
WHERE subject = 'Physics';

-- Nobel Problem 4: For each subject show the subject and the number of prizes.
SELECT subject, COUNT(winner)
FROM nobel
GROUP BY subject;

-- Nobel Problem 5: For each subject show the first year that the prize was awarded.
SELECT subject, yr
FROM nobel x
WHERE yr <= 
  ALL(
    SELECT yr
    FROM nobel y
    WHERE y.subject = x.subject
  )
GROUP BY subject;

-- Nobel Problem 6: For each subject show the number of prizes awarded in the year 2000.
SELECT subject, COUNT(winner)
FROM nobel
WHERE yr = 2000
GROUP BY subject;

-- Nobel Problem 7: Show the number of different winners for each subject. Be aware that Frederick Sanger has won the chemistry prize twice - he should only be counted once.
SELECT subject, COUNT(DISTINCT winner)
FROM nobel
GROUP BY subject;

-- Nobel Problem 8: For each subject show how many years have had prizes awarded.
SELECT subject, COUNT(DISTINCT yr)
FROM nobel
GROUP BY subject;

-- Nobel Problem 9: Show the years in which three prizes were given for Physics.
SELECT yr
FROM nobel
WHERE subject = 'Physics'
GROUP BY yr
HAVING COUNT(winner) = 3;

-- Nobel Problem 10: Show winners who have won more than once.
SELECT winner
FROM nobel
GROUP BY winner
HAVING count(winner) > 1;

-- Nobel Problem 11: Show winners who have won more than one subject.
SELECT winner
FROM nobel
GROUP BY winner
HAVING COUNT(DISTINCT subject) > 1;

-- Nobel Problem 12: Show the year and subject where 3 prizes were given. Show only years 2000 onwards.
SELECT yr, subject
FROM nobel
WHERE yr >= 2000
GROUP BY yr, subject
HAVING COUNT(winner) = 3;
