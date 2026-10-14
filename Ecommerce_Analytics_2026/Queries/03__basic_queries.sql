-- Q1. Display all customers
SELECT * FROM customers;


-- Q2. Display selected columns
SELECT CustomerName, City, SignupDate
FROM customers;


-- Q3. Find unique cities
SELECT DISTINCT City
FROM customers;


-- Q4. Find customers from Mumbai
SELECT *
FROM customers
WHERE City = 'Mumbai';


-- Q5. Find products priced between ₹2,000 and ₹15,000
SELECT ProductName, Price
FROM products
WHERE Price BETWEEN 2000 AND 15000
ORDER BY Price;


-- Q6. Find products in specific categories
SELECT *
FROM products
WHERE Category IN ('Electronics', 'Furniture');


-- Q7. Find customers whose names start with A
SELECT *
FROM customers
WHERE CustomerName LIKE 'A%';


-- Q8. Find orders that have not been delivered yet
SELECT *
FROM orders
WHERE DeliveryDate IS NULL;


-- Q9. Find the five most expensive products
SELECT ProductName, Price
FROM products
ORDER BY Price DESC
LIMIT 5;


-- Q10. Classify products using CASE
SELECT
    ProductName,
    Price,
    CASE
        WHEN Price >= 30000 THEN 'Premium'
        WHEN Price >= 5000 THEN 'Mid-Range'
        ELSE 'Budget'
    END AS PriceSegment
FROM products;
