/*
9_SELF_JOIN.sql
MySQL syntax
Solutions for SQLZoo "Self JOIN" section
*/

-- Problem 1: How many stops are in the database.
SELECT COUNT(id)
FROM stops;

-- Problem 2: Find the id value for the stop 'Craiglockhart'
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

-- Problem 3: Give the id and the name for the stops on the '4' 'LRT' service.
SELECT stops.id, stops.name
FROM stops
  JOIN route ON (stops.id = stop)
WHERE route.num = '4'
AND route.company = 'LRT';

-- Problem 4: The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.
SELECT company, num, COUNT(*)
FROM route 
WHERE (stop = 149 OR stop = 53)
GROUP BY company, num
HAVING COUNT(*) = 2;

-- Problem 5: Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop
FROM route a 
  JOIN route b ON (a.company = b.company AND a.num = b.num)
WHERE a.stop = 53
AND b.stop = 149;

-- Problem 6: The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a 
  JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart'
AND stopb.name = 'London Road';

-- Problem 7: Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT a.company, a.num
FROM route a
  JOIN route b ON (a.num = b.num AND a.company = b.company)
WHERE a.stop = 115
AND b.stop = 137;

-- Problem 8: Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT a.company, a.num
FROM route a
  JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart'
AND stopb.name = 'Tollcross';

-- Problem 9: Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.
SELECT stopb.name, a.company, a.num
FROM route a
  JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart'
AND (b.pos >= a.pos OR a.pos >= b.pos)

-- Problem 10: Find the routes involving two buses that can go from Craiglockhart to Lochend. Show the bus no. and company for the first bus, the name of the stop for the transfer, and the bus no. and company for the second bus.
-- Hint: Self-join twice to find buses that visit Craiglockhart and Lochend, then join those on matching stops.
SELECT 
  bus1.num,           -- First bus number
  bus1.company,      
  stops.name,         -- Transfer stop name
  bus2.num,           -- Second bus number 
  bus2.company       
FROM (
  -- Subquery bus1: Get all (bus number, company) pairs that go from Craiglockhart
  -- to some other stop (the transfer stop)
  SELECT start1.num, start1.company, stop1.stop
  FROM route AS start1
    JOIN route AS stop1
      ON start1.num = stop1.num
      AND start1.company = stop1.company
      AND start1.stop != stop1.stop
  WHERE start1.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart')
) AS bus1
JOIN (
  -- Subquery bus2: Get all (bus number, company) pairs that go from a stop
  -- (the same transfer stop) to Lochend
  SELECT start2.num, start2.company, start2.stop
  FROM route AS start2
    JOIN route AS stop2
      ON start2.num = stop2.num
      AND start2.company = stop2.company
      AND start2.stop != stop2.stop
  WHERE stop2.stop = (SELECT id FROM stops WHERE name = 'Lochend')
) AS bus2
  ON bus1.stop = bus2.stop -- Transfer must happen at the same stop
JOIN stops 
  ON bus1.stop = stops.id -- Get the transfer stop name
ORDER BY 
  bus1.num, bus1.company, stops.name, bus2.num, bus2.company;

