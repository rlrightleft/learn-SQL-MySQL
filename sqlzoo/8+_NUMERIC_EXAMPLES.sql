/*
8+_NUMERIC_EXAMPLES.sql
MySQL syntax
Solutions for SQLZoo "NSS Tutorial" section 
*/

-- Problem 1: The example shows the number who responded for: question 1 at 'Edinburgh Napier University' studying '(8) Computer Science'
-- Show the the percentage who STRONGLY AGREE
SELECT A_STRONGLY_AGREE 
FROM nss
WHERE question = 'Q01'
AND institution = 'Edinburgh Napier University'
AND subject = '(8) Computer Science';

-- Problem 2: Show the institution and subject where the score is at least 100 for question 15.
SELECT institution, subject
FROM nss
WHERE question = 'Q15'
AND score >= 100;

-- Problem 3: Show the institution and score where the score for '(8) Computer Science' is less than 50 for question 'Q15'
SELECT institution, score
FROM nss
WHERE question = 'Q15'
AND subject = '(8) Computer Science'
AND score < 50;

-- Problem 4: Show the subject and total number of students who responded to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.
-- HINT: You will need to use SUM over the response column and GROUP BY subject
SELECT subject, SUM(response)
FROM nss
WHERE question = 'Q22'
GROUP BY subject
HAVING subject IN ('(8) Computer Science', '(H) Creative Arts and Design');

-- Problem 5: Show the subject and total number of students who A_STRONGLY_AGREE to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.
-- HINT: The A_STRONGLY_AGREE column is a percentage. To work out the total number of students who strongly agree you must multiply this percentage by the number who responded (response) and divide by 100 - take the SUM of that.
SELECT subject, SUM(A_STRONGLY_AGREE * response / 100)
FROM nss
WHERE question = 'Q22'
GROUP BY subject
HAVING subject IN ('(8) Computer Science', '(H) Creative Arts and Design');

-- Problem 6: Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject '(8) Computer Science' show the same figure for the subject '(H) Creative Arts and Design'.
-- Use the ROUND function to show the percentage without decimal places.
SELECT subject, ROUND(SUM(response*A_STRONGLY_AGREE)/SUM(response),0)
FROM nss
WHERE question = 'Q22'
GROUP BY subject
HAVING subject IN ('(8) Computer Science', '(H) Creative Arts and Design');

-- Problem 7: Show the average scores for question 'Q22' for each institution that include 'Manchester' in the name.
-- The column score is a percentage - you must use the method outlined above to multiply the percentage by the response and divide by the total response. Give your answer rounded to the nearest whole number.
SELECT institution, ROUND(
SUM(score * response) / SUM(response),
0)
FROM nss
WHERE institution LIKE '%Manchester%'
AND question = 'Q22'
GROUP BY institution;

-- Problem 8: Show the institution, the total sample size and the number of computing students for institutions in Manchester for 'Q01'.
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
