-- SQL functions

-- Get average 'Price' from column 'OrderDetails' in DB
SELECT AVG(Price) FROM OrderDetails;

-- Get number of records from 'Orders' column in DB
SELECT COUNT(OrderId) FROM Orders;

-- Get sum of prices from 'OrderDetails' in DB
SELECT SUM(Price) FROM OrderDetails;

-- Get number of orders with a price over $1,000
SELECT COUNT(OrderId) FROM  OrderDetails WHERE Price > 1000;

SELECT movie_lang, MIN(movie_length), MAX(movie_length), AVG(movie_length), COUNT(*) FROM movies
GROUP BY movie_lang;

SELECT COUNT(*) FROM actors 
WHERE date_of_birth > '1970-01-01';


-- Get all employees who live in Poughkeepsie and make less than $100,000
SELECT * FROM Employees WHERE City = Poughkeepsie AND Salary < 100000;


-- SQL Like

-- Get all customers whose first name starts with a Q
SELECT * FROM Customers WHERE FirstName LIKE 'q%';

-- Get all records from Customers in which their last name starts with "B" and ends with "N"
SELECT * FROM Customers WHERE LastName LIKE 'b%n';

-- Get all records from Employees where City does not start with 'C' but ends in D
SELECT * FROM Employees WHERE City NOT LIKE 'c%' and City LIKE '%d';


-- SQL Wildcards

-- Get all records where the firstName of Employee starts with 'z', 'c' or 's'
SELECT * FROM Employees WHERE FirstName LIKE '[zcs]';

-- Get all records from OrderDetails where product does not start with 's', 'f', 'a' or 'd'
SELECT * FROM OrderDetails WHERE Product LIKE '[^sfad]';

-- Get all records in Customers whose last name starts with a letter between M and Z
SELECT * FROM Customers WHERE LastName LIKE '[m-z]';


-- SQL IN

-- Get all records from Employees that live in either Canada or Mexico
SELECT * FROM Employees WHERE Country IN ('Canada', 'Mexico');

-- Get all records where customers are from the same country as suppliers
SELECT * FROM Customers WHERE Country IN (SELECT Country FROM Suppliers);


-- SQL Between

-- Get all records from Products where price is between 1000 and 2000
SELECT * FROM Products WHERE Price BETWEEN 1000 AND 2000;

-- Get all records in Customers where city is between "Albany" and "Detroit" ordered by firstname
SELECT * FROM Customers WHERE City BETWEEN "Albany" AND "Detroit" ORDER BY FirstName;

-- Get all records where product is not between 'coke' and 'pepsi' ordered by price
SELECT * FROM Products WHERE ProductName NOT BETWEEN 'Pepsi' AND 'Coke' ORDER BY Price;




--GROUP BY and HAVING clauses

-- directors per nationality
SELECT nationality, COUNT(nationality) FROM directors
GROUP BY nationality;

--sum total movie length for each age certificate/movie lang combo
SELECT age_certificate, movie_lang, SUM(movie_length) FROM movies
GROUP BY age_certificate, movie_lang;

--movie langs with sum length of > 500
SELECT movie_lang, SUM(movie_length) FROM movies
GROUP BY movie_lang
HAVING SUM(movie_length) > 500;


-- INNER JOINS
--select directors first and last names, the movie names and release dates for all Chinese, Korean and Japanese movies
SELECT d.first_name, d.last_name, m.movie_name, m.release_date
FROM directors d
JOIN movies m ON m.director_id = d.director_id
WHERE m.movie_lang IN ('Chinese', 'Korean', 'Japanese')
ORDER BY m.movie_name;

--SELECT movie names, release dates and international takings of all English language movies
SELECT m.movie_name, m.release_date, mr.international_takings
FROM movies m
JOIN movie_revenues mr ON m.movie_id = mr.movie_id
WHERE m.movie_lang = 'English'
ORDER BY m.movie_name;

-- select movie names, domestic takings and international takings for all movies with either missing domestic takings or missing international takings and order the results by movie name
SELECT m.movie_name, mr.domestic_takings, mr.international_takings
FROM movies m
JOIN movie_revenues mr ON m.movie_id = mr.movie_id
WHERE mr.domestic_takings IS null 
OR mr.international_takings IS NULL
ORDER BY m.movie_name;

-- OTHER JOINS

-- Use a left join to select the first and last names of all british directors and the names and age certificates of the movies they directed.
SELECT d.first_name, d.last_name, m.movie_name, m.age_certificate
FROM directors d
LEFT JOIN movies m ON d.director_id = m.director_id
WHERE d.nationality = 'British'
ORDER BY d.last_name;


-- Count the number of movies that each director has directed.
SELECT CONCAT(d.first_name, ' ',d.last_name) as name, COUNT(m.movie_name)
FROM directors d
FULL JOIN movies m ON d.director_id = m.director_id
GROUP BY d.last_name, d.first_name
ORDER BY d.last_name;

-- Multiple Joins

-- select actors full name and movie names of movies in English
SELECT a.first_name, a.last_name, m.movie_name FROM actors a
JOIN movies_actors ma ON a.actor_id = ma.actor_id
JOIN movies m ON m.movie_id = ma.movie_id
WHERE m.movie_lang = 'English'
ORDER BY m.movie_name;

-- combine all 5 tables
SELECT CONCAT(d.first_name, ' ', d.last_name) as director, m.movie_name, CONCAT(a.first_name, ' ', a.last_name) as actor, mr.domestic_takings, mr.international_takings
FROM directors d
JOIN movies m ON d.director_id = m.director_id
JOIN movies_actors ma ON ma.movie_id = m.movie_id
JOIN actors a ON a.actor_id = ma.actor_id
JOIN movie_revenues mr ON mr.movie_id = m.movie_id;

-- SELECT the first & last names of all actors who have starred in Wes Anderson movies
SELECT DISTINCT CONCAT(a.first_name, ' ', a.last_name) as actor
FROM actors a
JOIN movies_actors ma ON a.actor_id = ma.actor_id
JOIN movies m ON m.movie_id = ma.movie_id
JOIN directors d ON d.director_id = m.director_id
WHERE d.first_name = 'Wes'
AND d.last_name = 'Anderson'
ORDER BY a.last_name;

-- Find which director has the highest total domestic takings 
SELECT CONCAT(d.first_name, ' ', d.last_name) as name, SUM(mr.domestic_takings) AS total_dom_takings
FROM directors d
JOIN movies m ON m.director_id = d.director_id
JOIN movie_revenues mr ON m.movie_id = mr.movie_id
WHERE mr.domestic_takings IS NOT NULL
GROUP BY d.first_name, d.last_name
ORDER BY total_dom_takings DESC
LIMIT 1;


-- UNIONS
-- select first names, last names and DOBs from directors and actors, ordered by DOB
SELECT first_name, last_name, date_of_birth from directors
UNION
SELECT first_name, last_name, date_of_birth from actors
ORDER BY date_of_birth;


-- select first & last names of all directors and actors born in the 1960s, ordered by last name
SELECT first_name, last_name from directors
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
UNION ALL
SELECT first_name, last_name from actors
WHERE date_of_birth BETWEEN '1960-01-01' AND '1969-12-31'
ORDER BY last_name;


-- INTERSECT / EXCEPT
--INTERSECT first, last name and DOB of directors and actors
SELECT first_name, last_name, date_of_birth from directors
INTERSECT
SELECT first_name, last_name, date_of_birth from actors;

-- Retrieve first names of male actors unless they have the same first name as any British directors
SELECT first_name from actors
WHERE gender = 'M'
EXCEPT
SELECT first_name from directors
WHERE nationality = 'British'
ORDER BY first_name;


-- SUBQUERIES
-- uncorrelated SQs
-- Get all movies whose length are greater than the avg movie length
SELECT movie_name, movie_length FROM movies
WHERE movie_length > 
	(SELECT AVG(movie_length) FROM movies);

  -- get all directors younger than James Cameron
SELECT CONCAT(first_name, ' ', last_name) AS director, date_of_birth FROM directors
WHERE date_of_birth >
	(SELECT date_of_birth from directors
	WHERE first_name = 'James'
	AND last_name = 'Cameron')
ORDER BY date_of_birth;

-- Get titles and directors for movies that made more money internationally than domestically
SELECT movie_name, CONCAT(d.first_name, '', d.last_name) as director FROM movies m
JOIN directors d ON m.director_id = d.director_id
WHERE m.movie_id IN
	(SELECT movie_id from movie_revenues
	WHERE international_takings > domestic_takings);

--select all actors older than Marlon Brando
SELECT CONCAT(first_name, ' ', last_name) as actor, date_of_birth from actors
WHERE date_of_birth < 
	(SELECT date_of_birth from actors
	WHERE first_name = 'Marlon'
	AND last_name = 'Brando')
ORDER BY date_of_birth;

-- select titles of all movies that have domestic takings > 300 million
SELECT m.movie_name, mr.domestic_takings FROM movies m
JOIN movie_revenues mr ON mr.movie_id = m.movie_id
WHERE m.movie_id IN
	(SELECT movie_id FROM movie_revenues
	WHERE mr.domestic_takings > 300)
ORDER BY mr.domestic_takings;

-- return shortest and longest movie length for movies with above average domestic takings.
SELECT MIN(m.movie_length), MAX(m.movie_length)
FROM movies m
JOIN movie_revenues mr ON m.movie_id = mr.movie_id
WHERE mr.domestic_takings >
	(SELECT AVG(domestic_takings) FROM movie_revenues);
	
--OR, you can get fancy with a double nested query

SELECT MIN(movie_length), MAX(movie_length) FROM movies
WHERE movie_id IN
	(SELECT movie_id FROM movie_revenues
	WHERE domestic_takings >
		(SELECT AVG(domestic_takings) FROM movie_revenues));

	

--correlated SQs
-- Get all the oldest directors from each nationality
SELECT CONCAT(d1.first_name, ' ', d1.last_name) as director, d1.date_of_birth, d1.nationality
FROM directors d1
WHERE date_of_birth = 
	(SELECT MIN(date_of_birth) FROM directors d2
	WHERE d2.nationality = d1.nationality)
ORDER BY date_of_birth;


