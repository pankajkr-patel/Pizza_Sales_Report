CREATE TABLE pizza_orders (
    pizza_id           SERIAL PRIMARY KEY,
    order_id           INT,
    pizza_name_id      VARCHAR(200) NOT NULL,
    quantity           INT,
    order_date         DATE,
    order_time         TIME,
    unit_price         NUMERIC(10, 2),
    total_price        NUMERIC(10, 2),
    pizza_size         VARCHAR(50),
    pizza_category     VARCHAR(100),
    pizza_ingredients  TEXT,
    pizza_name         VARCHAR(200)
);

SELECT * FROM pizza_orders;


-- Total Revenue
SELECT SUM(total_price) AS  Total_Revenue FROM pizza_orders;

-- Avarage Order Value
SELECT DISTINCT avg(order_id) AS average_order FROM pizza_orders;

-- Hourly Trends for total orders
SELECT TO_CHAR(order_time, 'HOUR') AS order_hour,
COUNT(DISTINCT order_id) AS total_order
FROM pizza_orders
GROUP BY TO_CHAR(order_time, 'HOUR')
ORDER BY TO_CHAR(order_time, 'HOUR');

-- Daily Trends for total orders
SELECT TO_CHAR(order_date, 'Day') AS order_day,
COUNT(DISTINCT order_id) AS total_order
FROM pizza_orders
GROUP BY TO_CHAR(order_date, 'Day');

-- Monthly Trends For Total Orders
SELECT TO_CHAR(order_date , 'Mon') AS Months, COUNT(DISTINCT order_id) AS total_orders FROM pizza_orders
group by TO_CHAR(order_date , 'Mon')
ORDER BY total_orders DESC;

-- Percentage of Sales By Pizza Cotagery
SELECT pizza_category, 
SUM(total_price) AS total_sales,
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_orders),2) AS pct
FROM pizza_orders
GROUP BY pizza_category;

-- Percentage of Sales By Pizza Size
SELECT 
    pizza_size, 
    SUM(total_price) AS total_sales,
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_orders),2) AS pct
FROM 
    pizza_orders
GROUP BY 
    pizza_size
	order by pct DESC ;

-- Top 5 pizza by Revenue
SELECT DISTINCT pizza_name , SUM(total_price) AS total_revenue FROM pizza_orders
GROUP BY pizza_name 
ORDER BY  total_revenue DESC
LIMIT 5;

-- Bottom 5 pizza by Revenue
SELECT DISTINCT pizza_name , SUM(total_price) AS total_revenue FROM pizza_orders
GROUP BY pizza_name 
ORDER BY  total_revenue ASC
LIMIT 5;

-- Top 5 pizza by Quantity
SELECT DISTINCT pizza_name , SUM(quantity) AS total_quantity FROM pizza_orders
GROUP BY pizza_name 
ORDER BY  total_quantity DESC
LIMIT 5;

-- Total Pizza Sold by pizza Category
SELECT pizza_category , SUM(quantity) AS total_pizza_sold FROM pizza_orders
GROUP BY pizza_category;
-- ***********************
SELECT * FROM pizza_orders;