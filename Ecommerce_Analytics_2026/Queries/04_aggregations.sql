-- Q11. Calculate total, average, minimum and maximum product prices
SELECT
    COUNT(*) AS TotalProducts,
    SUM(Price) AS TotalPrice,
    ROUND(AVG(Price), 2) AS AveragePrice,
    MIN(Price) AS CheapestProduct,
    MAX(Price) AS MostExpensiveProduct
FROM products;


-- Q12. Count orders by status
SELECT
    OrderStatus,
    COUNT(*) AS TotalOrders
FROM orders
GROUP BY OrderStatus
ORDER BY TotalOrders DESC;


-- Q13. Calculate revenue by product category
-- Here, order value is calculated from Quantity × UnitPrice. Cancelled and returned orders are excluded from this illustrative gross sales metric.
SELECT
    p.Category,
    SUM(oi.Quantity * oi.UnitPrice) AS GrossSales
FROM order_items oi
JOIN products p
    ON oi.ProductID = p.ProductID
JOIN orders o
    ON oi.OrderID = o.OrderID
WHERE o.OrderStatus NOT IN ('Cancelled', 'Returned')
GROUP BY p.Category
ORDER BY GrossSales DESC;


-- Q14. Find categories with sales above ₹50,000
SELECT
    p.Category,
    SUM(oi.Quantity * oi.UnitPrice) AS GrossSales
FROM order_items oi
JOIN products p
    ON oi.ProductID = p.ProductID
JOIN orders o
    ON oi.OrderID = o.OrderID
WHERE o.OrderStatus NOT IN ('Cancelled', 'Returned')
GROUP BY p.Category
HAVING SUM(oi.Quantity * oi.UnitPrice) > 50000;


-- Remember: WHERE filters rows before grouping; HAVING filters groups after aggregation.
-- Q15. Calculate order value
SELECT
    OrderID,
    SUM(Quantity * UnitPrice) AS OrderValue
FROM order_items
GROUP BY OrderID
ORDER BY OrderValue DESC;


-- Q16. Calculate monthly gross sales
SELECT
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS SalesMonth,
    SUM(oi.Quantity * oi.UnitPrice) AS GrossSales
FROM orders o
JOIN order_items oi
    ON o.OrderID = oi.OrderID
WHERE o.OrderStatus NOT IN ('Cancelled', 'Returned')
GROUP BY DATE_FORMAT(o.OrderDate, '%Y-%m')
ORDER BY SalesMonth;


-- Q17. Calculate the cancellation rate
SELECT
    COUNT(*) AS TotalOrders,
    SUM(OrderStatus = 'Cancelled') AS CancelledOrders,
    ROUND(
        100.0 * SUM(OrderStatus = 'Cancelled') / COUNT(*),
        2
    ) AS CancellationRate
FROM orders;
