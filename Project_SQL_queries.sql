use portfolio_db

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;

#Data Cleaning

 -- Remove null sales
DELETE FROM orders
WHERE sales IS NULL;

-- Convert dates
UPDATE orders
SET order_date = CAST(order_date AS DATE),
    ship_date = CAST(ship_date AS DATE);

#Total Sales & Profit

SELECT 
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders;

#Top 10 Products by Sales

SELECT TOP 10
    p.product_name,
    SUM(o.sales) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC

#Sales by Region

SELECT 
    region,
    SUM(sales) AS total_sales
FROM orders
GROUP BY region;

#Customer Segment Analysis

SELECT 
    c.segment,
    SUM(o.sales) AS total_sales,
    SUM(o.profit) AS total_profit
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.segment;

#Monthly Sales Trend

SELECT
    FORMAT(order_date, 'yyyy-MM') AS [month],
    SUM(sales) AS monthly_sales
FROM orders
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY [month];




