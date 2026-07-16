-- COFFEE SALES ANALYSIS

-- DROP SCHEMA IF EXISTS coffee_db; --

CREATE DATABASE coffee_db;
USE coffee_db;

--  Table structure for table `coffee_sales
CREATE TABLE coffee_sales (
    Transaction_ID INT,
    Transaction_Date DATE,
    Transaction_Time TIME,
    Transaction_QTY INT,
    Store_ID INT,
    Store_Location VARCHAR(100),
    Product_ID INT,
    Unit_Price DECIMAL(10,2),
    Total_Sales decimal(10,2),
    Product_Category VARCHAR(100),
    Product_Type VARCHAR(100),
    Product_Details VARCHAR(100)
);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cleaned_Coffee_Sales.csv'
INTO TABLE coffee_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@transaction_id, @transaction_date, @transaction_time, transaction_qty, store_id, store_location, product_id, unit_price, total_sales, product_category, product_type, product_details)
SET 
transaction_id = @transaction_id,
transaction_date = STR_TO_DATE(@transaction_date, '%m/%d/%Y'),
transaction_time = STR_TO_DATE(@transaction_time, '%h:%i:%s %p');

select count(*) from coffee_sales;

SELECT 
    SUM(CASE WHEN Transaction_Date IS NULL THEN 1 END) AS missing_date,
    SUM(CASE WHEN Transaction_Time IS NULL THEN 1 END) AS missing_time,
    SUM(CASE WHEN Transaction_QTY IS NULL THEN 1 END) AS missing_qty,
    SUM(CASE WHEN Unit_price IS NULL THEN 1 END) AS missing_price,
    SUM(CASE WHEN Total_Sales IS NULL THEN 1 END) AS missing_sales,
    SUM(CASE WHEN Product_ID IS NULL THEN 1 END) AS missing_product,
    SUM(CASE WHEN Store_ID IS NULL THEN 1 END) AS missing_store
FROM coffee_sales;

SELECT 
    COUNT(DISTINCT Store_ID) AS store_count,
    COUNT(DISTINCT Product_ID) AS product_count,
    COUNT(DISTINCT Product_Category) AS category_count
FROM coffee_sales;

-- SALES PERFORMANCE ANALYSIS

-- Total Revenue
-- This query calculates the overall revenue generated from all sales
SELECT SUM(total_sales) AS total_revenue
FROM coffee_sales;

-- Monthly Revenue Trend
/* This query aggregates total sales by month to identify seasonal trends
and understand which months generate the highest revenue */
SELECT
    MONTH(transaction_date) AS month,
    SUM(total_sales) AS revenue
FROM coffee_sales
GROUP BY month;

-- Daily Sales Trend
-- This query shows how revenue changes over time (daily performance) 
SELECT 
    transaction_date,
    SUM(total_sales) AS daily_sales
FROM coffee_sales
GROUP BY transaction_date
ORDER BY transaction_date;

-- Peak Sales Hours
-- This query identifies which hours of the day generate the most revenue
SELECT 
    HOUR(transaction_time) AS hour,
    SUM(total_sales) AS sales
FROM coffee_sales
GROUP BY hour
ORDER BY sales DESC;

-- STORE PERFORMANACE

-- Revenue by Store
-- This query compares total revenue across different store locations 
SELECT 
    Store_ID,
    Store_Location,
    SUM(Total_Sales) AS revenue
FROM coffee_sales
GROUP BY Store_ID, Store_Location
ORDER BY revenue DESC;

-- Store Ranking
SELECT 
    Store_ID,
    Store_Location,
    SUM(Total_Sales) AS revenue,
    RANK() OVER (ORDER BY SUM(Total_Sales) DESC) AS store_rank
FROM coffee_sales
GROUP BY Store_ID, Store_Location;

-- PRODUCT & CATEGORY ANALYSIS

-- Top Selling Product
-- This query identifies the most popular products based on quantity sold
SELECT 
    product_type,
    SUM(transaction_qty) AS total_quantity_sold
FROM coffee_sales
GROUP BY product_type
ORDER BY total_quantity_sold DESC
limit 10;

-- Top 10 products by Revenue
/* This query identifies the highest-performing products based on total revenue
  It helps the business understand which products contribute most to income */
SELECT
    product_type,
    SUM(total_sales) AS revenue
FROM coffee_sales
GROUP BY product_type
ORDER BY revenue DESC
LIMIT 10;

-- Revenue by Category
SELECT 
    Product_Category,
    SUM(Total_Sales) AS revenue
FROM coffee_sales
GROUP BY Product_Category
ORDER BY revenue DESC;

-- Category Contribution %
SELECT 
    Product_Category,
    SUM(Total_Sales) AS revenue,
    ROUND(
        SUM(Total_Sales) * 100 /
        (SELECT SUM(Total_Sales) FROM coffee_sales), 2
    ) AS 'contribution %'
FROM coffee_sales
GROUP BY Product_Category
ORDER BY revenue DESC;

-- Store x Heatmap
SELECT 
    Store_Location,
    HOUR(Transaction_Time) AS hour,
    SUM(Total_Sales) AS revenue
FROM coffee_sales
GROUP BY Store_Location, hour
ORDER BY Store_Location, hour;

-- Dynamic Top N products
SELECT *
FROM (
    SELECT 
        Product_Details,
        SUM(Total_Sales) AS revenue,
        RANK() OVER (ORDER BY SUM(Total_Sales) DESC) AS 'rank'
    FROM coffee_sales
    GROUP BY Product_Details
) ranked
WHERE 'rank' <= 5;

-- Rolling 30-day Revenue
WITH daily_sales AS (
    SELECT 
		Transaction_Date AS date,
        SUM(Total_Sales) AS daily_revenue
    FROM coffee_sales
    GROUP BY date
)
SELECT 
    date,
    daily_revenue,
    SUM(daily_revenue) OVER (
        ORDER BY date
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ) AS rolling_30_day_revenue
FROM daily_sales;