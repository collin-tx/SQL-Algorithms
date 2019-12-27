-- SQL functions

-- Get average 'Price' from column 'OrderDetails' in DB
SELECT AVG(Price) FROM OrderDetails;

-- Get number of records from 'Orders' column in DB
SELECT COUNT(OrderId) FROM Orders;

-- Get sum of prices from 'OrderDetails' in DB
SELECT SUM(Price) FROM OrderDetails;

-- Get number of orders with a price over $1,000
SELECT COUNT(OrderId) FROM  OrderDetails WHERE Price > 1000;

-- Get all customers whose first name starts with a Q
SELECT * FROM Customers WHERE FirstName LIKE 'q%';

-- Get all employees who live in Poughkeepsie and make less than $100,000
SELECT * FROM Employees WHERE City = Poughkeepsie AND Salary < 100000;


-- SQL Like

-- Get all records from Customers in which their last name starts with "B" and ends with "N"
SELECT * FROM Customers WHERE lastName LIKE 'b%n';

-- Get all records from Employees where City does not start with 'C' but ends in D
SELECT * FROM Employees WHERE City NOT LIKE 'c%' and City LIKE '%d';

