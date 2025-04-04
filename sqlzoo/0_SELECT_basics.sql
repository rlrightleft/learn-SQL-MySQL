/*
0_SELECT_basics.sql
MySQL syntax
Solutions for SQLZoo "SELECT basics" section 
*/

-- Problem 1: The example uses a WHERE clause to show the population of 'France'. Note that strings should be in 'single quotes'; Modify it to show the population of Germany
SELECT population 
FROM world
WHERE name = 'Germany';

/* Reflection:
Strings should be in 'single quotes' to distinguish them from SQL keywords or column names.
*/

-- Problem 2: Checking a list. The word IN allows us to check if an item is in a list. The example shows the name and population for the countries 'Brazil', 'Russia', 'India' and 'China'. Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population 
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

/* Reflection:
Use **IN** for a list - great for matching multiple values in a WHERE clause. 
Separate items using a comma (,).
*/

-- Problem 3: Which countries are not too small and not too big? BETWEEN allows range checking (range specified is inclusive of boundary values). The example below shows countries with an area of 250,000-300,000 sq. km. Modify it to show the country and the area for countries with an area between 200,000 and 250,000.
SELECT name, area 
FROM world
WHERE area BETWEEN 200000 AND 250000;

/* Reflection:
Use **BETWEEN...AND** for an inclusive range - includes both boundary values.
*/


