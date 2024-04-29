-- Active: 1712576204293@@127.0.0.1@3306@reverb
-- these are related to admin/super user functionality for reports, etc.

DROP VIEW IF EXISTS cat_ranking;
-- Description: creates a view that shows the total sales for each instrument category
-- Showcases: advanced aggregation
CREATE VIEW cat_ranking AS
SELECT category, order_total as 'sales',
RANK() OVER (ORDER BY order_total ASC) as rank_sales, 
DENSE_RANK() OVER (ORDER BY order_total ASC) as dense_rank_sales, 
PERCENT_RANK() OVER (ORDER BY order_total ASC) as perc_rank_sales, 
CUME_DIST() OVER (ORDER BY order_total ASC) as cum_dist_sales
FROM reverb_order o
JOIN reverb_order_details od ON o.order_id = od.order_id
JOIN reverb_instrument i ON od.instrument_id = i.instrument_id
JOIN reverb_instrument_category ic ON i.category_id = ic.category_id
ORDER BY rank_sales ASC;


DROP VIEW IF EXISTS sales_by_us_state;
-- description: creates a view that shows the total sales by US state, ranked by total sales
-- showcases: advanced aggregation, window functions, rank
CREATE VIEW sales_by_us_state AS
SELECT *,
    RANK() OVER(ORDER BY total_sales DESC) as sales_rank
FROM (
    SELECT billing_address_stateprovince AS state,
        SUM(order_total) AS total_sales
    FROM reverb_order
    WHERE billing_address_country = 'USA'
    GROUP BY billing_address_stateprovince
    
) AS salesByUSState;

DROP VIEW IF EXISTS running_total_sales;
-- Description: Get a running total of the sales by the category of the instruments
-- Showcases: OLAP, window functions
CREATE VIEW running_total_sales AS
SELECT order_total, SUM(order_total)
OVER (PARTITION BY i.category_id ORDER BY order_date ROWS UNBOUNDED PRECEDING)
as 'Running order totals per category'
FROM reverb_order o
JOIN reverb_order_details od ON o.order_id = od.order_id
JOIN reverb_instrument i ON od.instrument_id = i.instrument_id
;


-- Description: creates a view that shows the total sales for each instrument category, for the brands (Fender, Gibson, Ibanez), for the last 90 days
-- Showcases: OLAP, views, advanced aggregation
DROP VIEW IF EXISTS total_instrument_sales;
-- What are the total sales for each instrument category, for the brands (Fender, Gibson, Ibanez), for the last 90 days
CREATE VIEW total_instrument_sales AS
SELECT category, brand, DATE_FORMAT(order_date, '%Y-%m') AS yearMonth, SUM(order_total) as sales
FROM reverb_order o
JOIN reverb_order_details od ON o.order_id = od.order_id
JOIN reverb_instrument i ON od.instrument_id = i.instrument_id
JOIN reverb_instrument_category ic ON ic.category_id = i.category_id
WHERE order_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 90 DAY) AND CURDATE()
AND brand IN ('Gibson', 'Fender', 'Ibanez')
GROUP BY ROLLUP(category, brand, yearMonth)
;


DROP VIEW IF EXISTS ranked_product_by_price;
--Find the most expensive items in each category (available or sold)
--Showcases: uses window function
CREATE VIEW ranked_product_by_price AS
WITH RankedPrices AS (
    SELECT
        name,
        brand,
        model,
        price,
        category,
        RANK() OVER (PARTITION BY i.category_id ORDER BY price DESC) AS rank_price
    FROM reverb_instrument i
    JOIN reverb_instrument_category ic on i.category_id = ic.category_id
)
SELECT
    name,
    brand,
    model,
    price,
    category
FROM RankedPrices
WHERE rank_price = 1;

DROP VIEW IF EXISTS reverb_seller_rank;
-- Description: creates a view that ranks sellers by total sales in descending order
-- Showcases: advanced aggregation using RANK()
CREATE VIEW reverb_seller_rank AS
SELECT 
    seller_id,
    store_name,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM 
    reverb_seller;

DROP PROCEDURE IF EXISTS total_sales_by_seller;
-- Description: creates a temporary table OrderData and populates it with the seller ID, instrument ID, 
-- quantity of each instrument sold, and total sales for each instrument. 
-- It then calculates the total sales, total quantity of instruments sold, 
-- average price per instrument, and count of unique instruments sold for each seller.
-- Showcases: advanced aggregation, temporary tables
CREATE PROCEDURE total_sales_by_seller()
BEGIN
    -- DROP TEMPORARY TABLE IF EXISTS OrderData;
    -- Create a local temporary table to store order data
    CREATE TEMPORARY TABLE IF NOT EXISTS OrderData (
        sellerId INT,
        storeName VARCHAR(100),
        instrumentID INT,
        orderTotal DECIMAL(10, 2)
    );

    -- Populate the temp table with order data
    INSERT INTO OrderData (sellerId, storeName, instrumentID, orderTotal)
    SELECT s.seller_id, s.store_name, oi.instrument_id, o.order_total
    FROM reverb_order o
    JOIN reverb_order_details oi ON o.order_id = oi.order_id
    JOIN reverb_instrument i ON oi.instrument_id = i.instrument_id
    JOIN reverb_seller s ON o.seller_id = s.seller_id;

    -- Calculate total sales, total quantity, average price, and count of unique instruments for each seller
    SELECT storeName,
        SUM(orderTotal) AS totalSales,
        AVG(orderTotal) AS avgOrderTotal,
        COUNT(DISTINCT instrumentID) AS uniqueInstrumentsSold
    FROM OrderData
    GROUP BY sellerId, storeName;

    -- Clean up: Drop the temp table
    DROP TEMPORARY TABLE IF EXISTS OrderData;
END;