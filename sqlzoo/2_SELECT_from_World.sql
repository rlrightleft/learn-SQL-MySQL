/*
2_SELECT_from_World.sql
MySQL syntax
Solutions for SQLZoo "SELECT from World" section 
*/

-- Problem 1: Read the notes about this table (world). Observe the result of running this SQL command to show the name, continent, and population of all countries.
SELECT name, continent, population 
FROM world;

-- Problem 2: Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
SELECT name 
FROM world
WHERE population >= 200000000;

-- Problem 3: Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT name, gdp/population
FROM world
WHERE population >=200000000;

/* Reflection:
Per capita GDP is the GDP divided by the population - GDP/population.
*/

-- Problem 4: Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
SELECT name, population/1000000
FROM world
WHERE continent = 'South America';

-- Problem 5: Show the name and population for France, Germany, Italy
SELECT name, population
FROM world
WHERE name IN ('France','Germany','Italy');

-- Problem 6: Show the countries which have a name that includes the word 'United'
SELECT name
FROM world
WHERE name LIKE '%United%';

-- Problem 7: Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million. Show the countries that are big by area or big by population. Show name, population and area.
SELECT name, population, area
FROM world
WHERE area > 3000000
  OR population > 250000000;

-- Problem 8: Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.
-- Australia has a big area but a small population, it should be included. Indonesia has a big population but a small area, it should be included. China has a big population and big area, it should be excluded. United Kingdom has a small population and a small area, it should be excluded.
SELECT name, population, area
FROM world
WHERE area > 3000000
  XOR population > 250000000;

-- Problem 9: Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places. For Americas show population in millions and GDP in billions both to 2 decimal places.
-- Millions and billions: Divide by 1000000 (6 zeros) for millions. Divide by 1000000000 (9 zeros) for billions.
-- Missing decimals: For some version of SQL the division of an integer by an integer will be an integer. One way to prevent this is to divide by a floating point number such as 1000000.0.
SELECT 
  name, 
  ROUND(population/1000000,2), 
  ROUND(gdp/1000000000,2)
FROM world
WHERE continent = 'South America';

/* Reflection:
ROUND(f,p) returns f rounded to p decimal places.
The number of decimal places may be negative, this will round to the nearest 10 (when p is -1), or 100 (when p is -2), or 1000 (when p is -3), etc..
ROUND(7253.86, 0)    ->  7254
ROUND(7253.86, 1)    ->  7253.9
ROUND(7253.86,-3)    ->  7000
*/

-- Problem 10: Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000. Show per-capita GDP for the trillion dollar countries to the nearest $1000.
SELECT name, ROUND(gdp/population,-3)
FROM world
WHERE gdp >= 1000000000000;

-- Problem 11: Greece has capital Athens.

Each of the strings 'Greece', and 'Athens' has 6 characters. Show the name and capital where the name and the capital have the same number of characters.
-- You can use the LENGTH function to find the number of characters in a string
-- For Microsoft SQL Server the function LENGTH is LEN
SELECT name, capital
  FROM world
 WHERE LENGTH(name) = LENGTH(capital);

/* Reflection:
LENGTH(s) returns the number of characters in string s.
LENGTH('Hello') -> 5 
*/

-- Problem 12: The capital of Sweden is Stockholm. Both words start with the letter 'S'. Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
-- You can use the function LEFT to isolate the first character.
-- You can use <> as the NOT EQUALS operator.
SELECT name, capital
FROM world
WHERE LEFT(name,1) = LEFT(capital,1)
  AND name <> capital;

/* Reflection:
LEFT(s,n) allows you to extract n characters from the start of the string s.
LEFT('Hello world', 3) -> 'Hel'
*/

-- Problem 13: Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name. Find the country that has all the vowels and no spaces in its name.
-- You can use the phrase name NOT LIKE '%a%' to exclude characters from your results. 
SELECT name
  FROM world
WHERE name LIKE '%a%' 
  AND name LIKE '%e%' 
  AND name LIKE '%i%' 
  AND name LIKE '%o%' 
  AND name LIKE '%u%'
  AND name NOT LIKE '% %';
