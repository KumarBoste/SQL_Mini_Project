-- Q32. ROW_NUMBER — rank orders by value
WITH OrderValues AS (
    SELECT
        o.OrderID,
        o.OrderStatus,
        SUM(oi.Quantity * oi.UnitPrice) AS OrderValue
    FROM orders o
    JOIN order_items oi
        ON o.OrderID = oi.OrderID
    GROUP BY o.OrderID, o.OrderStatus
)
SELECT
    OrderID,
    OrderStatus,
    OrderValue,
    ROW_NUMBER() OVER (
        ORDER BY OrderValue DESC, OrderID
    ) AS RowNum
FROM OrderValues;


-- ROW_NUMBER() assigns a unique sequential number to each row, even when two orders have the same value.
-- Q33. RANK and DENSE_RANK — rank products by price
SELECT
    ProductName,
    Category,
    Price,
    RANK() OVER (
        ORDER BY Price DESC
    ) AS PriceRank,
    DENSE_RANK() OVER (
        ORDER BY Price DESC
    ) AS DensePriceRank
FROM products;


- RANK() leaves gaps after ties.
- DENSE_RANK() does not leave gaps after ties.
Q34. PARTITION BY — rank products within each category
SELECT
    ProductName,
    Category,
    Price,
    RANK() OVER (
        PARTITION BY Category
        ORDER BY Price DESC
    ) AS CategoryRank
FROM products;


-- PARTITION BY Category restarts the ranking for every category.
-- Q35. LAG — compare monthly sales with the previous month
WITH MonthlySales AS (
    SELECT
        DATE_FORMAT(o.OrderDate, '%Y-%m') AS SalesMonth,
        SUM(oi.Quantity * oi.UnitPrice) AS Sales
    FROM orders o
    JOIN order_items oi
        ON o.OrderID = oi.OrderID
    WHERE o.OrderStatus NOT IN ('Cancelled', 'Returned')
    GROUP BY DATE_FORMAT(o.OrderDate, '%Y-%m')
)
SELECT
    SalesMonth,
    Sales,
    LAG(Sales) OVER (
        ORDER BY SalesMonth
    ) AS PreviousMonthSales,
    Sales - LAG(Sales) OVER (
        ORDER BY SalesMonth
    ) AS SalesDifference
FROM MonthlySales
ORDER BY SalesMonth;


-- LAG() retrieves a value from a previous row in the window. Here, it compares each month's sales with the preceding month in the result.
-- Important: Months without orders aren't automatically included in this result. A calendar table or date-generating CTE is needed for a continuous month-by-month time series.
-- Q36. LEAD — compare with the next month's sales
Use the same MonthlySales CTE from Q35, then run:
SELECT
    SalesMonth,
    Sales,
    LEAD(Sales) OVER (
        ORDER BY SalesMonth
    ) AS NextMonthSales
FROM MonthlySales
ORDER BY SalesMonth;


-- Run this as a separate statement with the MonthlySales CTE definition included above it, since a CTE exists only for the immediately following statement.
-- Q37. Running total of sales
WITH MonthlySales AS (
    SELECT
        DATE_FORMAT(o.OrderDate, '%Y-%m') AS SalesMonth,
        SUM(oi.Quantity * oi.UnitPrice) AS Sales
    FROM orders o
    JOIN order_items oi
        ON o.OrderID = oi.OrderID
    WHERE o.OrderStatus NOT IN ('Cancelled', 'Returned')
    GROUP BY DATE_FORMAT(o.OrderDate, '%Y-%m')
)
SELECT
    SalesMonth,
    Sales,
    SUM(Sales) OVER (
        ORDER BY SalesMonth
        ROWS BETWEEN UNBOUNDED PRECEDING
                 AND CURRENT ROW
    ) AS RunningTotal
FROM MonthlySales
ORDER BY SalesMonth;


-- Q38. Moving average of the last three available months
WITH MonthlySales AS (
    SELECT
        DATE_FORMAT(o.OrderDate, '%Y-%m') AS SalesMonth,
        SUM(oi.Quantity * oi.UnitPrice) AS Sales
    FROM orders o
    JOIN order_items oi
        ON o.OrderID = oi.OrderID
    WHERE o.OrderStatus NOT IN ('Cancelled', 'Returned')
    GROUP BY DATE_FORMAT(o.OrderDate, '%Y-%m')
)
SELECT
    SalesMonth,
    Sales,
    ROUND(
        AVG(Sales) OVER (
            ORDER BY SalesMonth
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS MovingAverage
FROM MonthlySales
ORDER BY SalesMonth;


-- This averages up to three rows in the monthly result. To make it a strict three-calendar-month average, first generate a complete monthly calendar and fill months without sales with zero.
-- Q39. NTILE — divide customers into four spending groups
WITH CustomerSpending AS (
    SELECT
        c.CustomerID,
        c.CustomerName,
        COALESCE(SUM(
            CASE
                WHEN o.OrderStatus NOT IN ('Cancelled', 'Returned')
                THEN oi.Quantity * oi.UnitPrice
                ELSE 0
            END
        ), 0) AS TotalSpending
    FROM customers c
    LEFT JOIN orders o
        ON c.CustomerID = o.CustomerID
    LEFT JOIN order_items oi
        ON o.OrderID = oi.OrderID
    GROUP BY c.CustomerID, c.CustomerName
)
SELECT
    CustomerName,
    TotalSpending,
    NTILE(4) OVER (
        ORDER BY TotalSpending DESC
    ) AS SpendingGroup
FROM CustomerSpending
ORDER BY SpendingGroup, TotalSpending DESC;


-- NTILE(4) distributes the customers into four approximately equal-sized groups. Group 1 contains the highest spenders because we sort by spending descending.
