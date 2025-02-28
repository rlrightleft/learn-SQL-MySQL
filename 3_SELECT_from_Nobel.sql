/*
3_SELECT_from_Nobel.sql
MySQL syntax
Solutions for SQLZoo "SELECT from Nobel" section
*/

-- Problem 1: Change the query shown so that it displays Nobel prizes for 1950.
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;

-- Problem 2: Show who won the 1962 prize for literature.
SELECT winner
FROM nobel
WHERE yr = 1962
  AND subject = 'literature';

-- Problem 3: Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';
