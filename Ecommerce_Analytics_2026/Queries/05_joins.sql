-- Q18. INNER JOIN — customers and orders
-- Find customers who have placed orders.
SELECT
    c.CustomerName,
    o.OrderID,
    o.OrderDate,
    o.OrderStatus
FROM customers c
INNER JOIN orders o
    ON c.CustomerID = o.CustomerID
ORDER BY o.OrderDate;


-- Q19. LEFT JOIN — include customers with no orders
SELECT
    c.CustomerID,
    c.CustomerName,
    o.OrderID
FROM customers c
LEFT JOIN orders o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


-- Q20. RIGHT JOIN — show every customer, including those without orders
SELECT
    c.CustomerName,
    o.OrderID
FROM orders o
RIGHT JOIN customers c
    ON o.CustomerID = c.CustomerID;

-- A RIGHT JOIN preserves every row from the table on the right. This query is equivalent in purpose to reversing the tables and using a LEFT JOIN.


-- Q21. Join four tables to build an order report
SELECT
    o.OrderID,
    c.CustomerName,
    p.ProductName,
    oi.Quantity,
    oi.UnitPrice,
    oi.Quantity * oi.UnitPrice AS LineTotal,
    o.OrderStatus
FROM orders o
JOIN customers c
    ON o.CustomerID = c.CustomerID
JOIN order_items oi
    ON o.OrderID = oi.OrderID
JOIN products p
    ON oi.ProductID = p.ProductID
ORDER BY o.OrderID;


-- Q22. Find payment details for each order
SELECT
    o.OrderID,
    c.CustomerName,
    p.Amount,
    p.PaymentMethod,
    p.PaymentStatus
FROM orders o
JOIN customers c
    ON o.CustomerID = c.CustomerID
LEFT JOIN payments p
    ON o.OrderID = p.OrderID
ORDER BY o.OrderID;


-- Q23. CROSS JOIN — all possible customer and product combinations
SELECT
    c.CustomerName,
    p.ProductName
FROM customers c
CROSS JOIN products p
LIMIT 20;


-- This generates combinations, not actual purchases.
-- Q24. SELF JOIN — find customers from the same city
SELECT
    c1.CustomerName AS Customer1,
    c2.CustomerName AS Customer2,
    c1.City
FROM customers c1
JOIN customers c2
    ON c1.City = c2.City
   AND c1.CustomerID < c2.CustomerID;


-- A self join joins a table to itself. The ID condition prevents matching a customer with themselves and avoids duplicate pairs.
