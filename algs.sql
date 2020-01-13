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