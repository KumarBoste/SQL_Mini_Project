-- Q29. Calculate customer spending using a CTE
WITH CustomerSpending AS (
    SELECT
        c.CustomerID,
        c.CustomerName,
        COALESCE(
            SUM(oi.Quantity * oi.UnitPrice),
            0
        ) AS TotalSpending
    FROM customers c
    LEFT JOIN orders o
        ON c.CustomerID = o.CustomerID
       AND o.OrderStatus NOT IN ('Cancelled', 'Returned')
    LEFT JOIN order_items oi
        ON o.OrderID = oi.OrderID
    GROUP BY c.CustomerID, c.CustomerName
)
SELECT *
FROM CustomerSpending
ORDER BY TotalSpending DESC;



-- Q30. Use multiple CTEs to calculate category sales
WITH ValidOrders AS (
    SELECT OrderID
    FROM orders
    WHERE OrderStatus NOT IN ('Cancelled', 'Returned')
),
CategorySales AS (
    SELECT
        p.Category,
        SUM(oi.Quantity * oi.UnitPrice) AS Sales
    FROM ValidOrders v
    JOIN order_items oi
        ON v.OrderID = oi.OrderID
    JOIN products p
        ON oi.ProductID = p.ProductID
    GROUP BY p.Category
)
SELECT
    Category,
    Sales,
    ROUND(
        100.0 * Sales / SUM(Sales) OVER (),
        2
    ) AS SalesPercentage
FROM CategorySales
ORDER BY Sales DESC;



-- Q31. Recursive CTE — generate numbers from 1 to 10
WITH RECURSIVE Numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM Numbers
    WHERE n < 10
)
SELECT n
FROM Numbers;


-- Recursive CTEs are useful for generating date sequences, hierarchical reports, and other iterative datasets.
