-- ====================================================================
-- PROJECT: SQL Data Analysis on SampleSuperstore & Customer Datasets
-- AUTHOR: Sai Santhosh
-- DESCRIPTION: 25 comprehensive business intelligence and data analysis queries
-- ====================================================================

-- --------------------------------------------------------------------
-- SECTION 1: BASIC DATA EXPLORATION & FILTERS
-- --------------------------------------------------------------------

-- 1. List distinct product categories
SELECT DISTINCT category 
FROM samplesuperstore;

-- 2. Display all sales with a discount greater than 0.2
SELECT * FROM samplesuperstore
WHERE discount > 0.2;

-- 3. Calculate total sales
SELECT SUM(sales) AS total_sales
FROM samplesuperstore;

-- 4. Show all records where discount is between 0.1 and 0.3
SELECT * FROM samplesuperstore
WHERE discount BETWEEN 0.1 AND 0.3;

-- 5. List all records from cities starting with ‘S’
SELECT * FROM samplesuperstore
WHERE city LIKE 'S%';

-- 6. Find records where profit is NULL
SELECT * FROM samplesuperstore
WHERE profit IS NULL;

-- 7. Display Ship mode, country with sales between 500 and 1500
SELECT Ship_Mode, Country, sales
FROM samplesuperstore
WHERE sales BETWEEN 500 AND 1500;


-- --------------------------------------------------------------------
-- SECTION 2: AGGREGATIONS & GEOGRAPHIC METRICS
-- --------------------------------------------------------------------

-- 8. Find total profit per region
SELECT region, SUM(profit) AS total_profit
FROM samplesuperstore
GROUP BY region;

-- 9. Calculate average discount by region
SELECT region, AVG(discount) AS avg_discount
FROM samplesuperstore
GROUP BY region;

-- 10. Find maximum discount given per region
SELECT region, MAX(discount) AS max_discount
FROM samplesuperstore
GROUP BY region;

-- 11. Find total profit percentage per category
SELECT category, (SUM(profit) / SUM(sales)) * 100 AS profit_percentage
FROM samplesuperstore
GROUP BY category;

-- 12. Show average sales per order by region and segment
SELECT region, segment, AVG(sales) AS avg_sales
FROM samplesuperstore
GROUP BY region, segment;


-- --------------------------------------------------------------------
-- SECTION 3: TOP & BOTTOM PERFORMANCE RANKINGS (RANKINGS)
-- --------------------------------------------------------------------

-- 13. Find top 5 states by total sales
SELECT state, SUM(sales) AS total_sales
FROM samplesuperstore
GROUP BY state
ORDER BY total_sales DESC
LIMIT 5;

-- 14. Find top 3 categories by total profit
SELECT category, SUM(profit) AS total_profit
FROM samplesuperstore
GROUP BY category
ORDER BY total_profit DESC
LIMIT 3;

-- 15. Show bottom 5 states by profit
SELECT state, SUM(profit) AS total_profit
FROM samplesuperstore
GROUP BY state
ORDER BY total_profit ASC
LIMIT 5;

-- 16. Find which sub-category has the highest average discount
SELECT sub_category, AVG(discount) AS avg_discount
FROM samplesuperstore
GROUP BY sub_category
ORDER BY avg_discount DESC
LIMIT 1;

-- 17. Identify the top 5 cities generating the most sales
SELECT city, SUM(sales) AS total_sales
FROM samplesuperstore 
GROUP BY city
ORDER BY total_sales DESC
LIMIT 5;


-- --------------------------------------------------------------------
-- SECTION 4: ADVANCED DATA JOINS
-- --------------------------------------------------------------------

-- 18. Inner Join to combine customer and sales data
SELECT c.customer_name, s.category, s.sales, s.profit
FROM customers c
JOIN samplesuperstore s ON c.city = s.city;

-- 19. Display total profit by customer segment
SELECT c.segment, SUM(s.profit) AS total_profit
FROM customers c
JOIN samplesuperstore s ON c.city = s.city AND c.state = s.state
GROUP BY c.segment; 

-- 20. Show all customers even if they made no purchase (Left Join)
SELECT c.customer_name, c.city, s.sales
FROM customers c
LEFT JOIN samplesuperstore s ON c.city = s.city;

-- 21. Display all sales even if customer info is missing (Right Join)
SELECT c.customer_name, s.city, s.sales, s.profit
FROM customers c
RIGHT JOIN samplesuperstore s ON c.city = s.city;

-- 22. Find top 5 states with the most unique postal codes
SELECT c.state, COUNT(DISTINCT c.postal_code) AS postal_count
FROM customers c
JOIN samplesuperstore s ON c.state = s.state
GROUP BY c.state
ORDER BY postal_count DESC
LIMIT 5;

-- 23. Display each segment and the cities they serve
SELECT DISTINCT c.segment, c.city
FROM customers c
JOIN samplesuperstore s ON c.city = s.city
ORDER BY c.segment;

-- 24. Compare number of postal codes per country
SELECT c.country, COUNT(DISTINCT c.postal_code) AS unique_postal_codes
FROM customers c
JOIN samplesuperstore s ON c.country = s.country
GROUP BY c.country;


-- --------------------------------------------------------------------
-- SECTION 5: COMPLEX SUBQUERIES & FILTERING
-- --------------------------------------------------------------------

--
