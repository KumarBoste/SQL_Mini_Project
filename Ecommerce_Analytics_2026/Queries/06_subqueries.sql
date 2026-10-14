-- Q25. Find products priced above the average price
SELECT ProductName, Price
FROM products
WHERE Price > (
    SELECT AVG(Price)
    FROM products
);


-- Q26. Find customers who placed at least one order
SELECT CustomerName
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.CustomerID = c.CustomerID
);


-- Q27. Find products that have never been ordered
SELECT ProductName
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.ProductID = p.ProductID
);


-- Q28. Find customers whose total order value exceeds ₹50,000
This query uses a correlated subquery and excludes cancelled and returned orders.
SELECT
    c.CustomerID,
    c.CustomerName
FROM customers c
WHERE (
    SELECT COALESCE(SUM(oi.Quantity * oi.UnitPrice), 0)
    FROM orders o
    JOIN order_items oi
        ON o.OrderID = oi.OrderID
    WHERE o.CustomerID = c.CustomerID
      AND o.OrderStatus NOT IN ('Cancelled', 'Returned')
) > 50000;
