-- Active: 1712576204293@@127.0.0.1@3306@reverb
-- This is a sratchpad for writing SQL statements to test and develop the application.
-- These are NOT intended to be documented or used by anyone else. They are for my own use to avoid
-- cluttering the main code for queries and updates that I need to test and develop, or fix
-- test data to provide meaninful results.

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


UPDATE reverb_order SET billing_address_stateprovince = 'FL' WHERE order_id = 11;

SELECT *,
    RANK() OVER(ORDER BY total_sales DESC) as sales_rank
FROM (
    SELECT billing_address_stateprovince AS state,
        SUM(order_total) AS total_sales
    FROM reverb_order
    WHERE billing_address_country = 'USA'
    GROUP BY billing_address_stateprovince
    
) AS salesByUSState;



-- Description: get a running total of the sales by the category of the instruments
SELECT category, 
    SUM(order_total) OVER (
        PARTITION BY i.category_id ROWS UNBOUNDED PRECEDING
        ) as 'sales_by_category'
FROM reverb_order o
JOIN reverb_order_details od ON o.order_id = od.order_id
JOIN reverb_instrument i ON od.instrument_id = i.instrument_id
JOIN reverb_instrument_category ic ON i.category_id = ic.category_id
;


SELECT *
FROM reverb_order o
JOIN reverb_order_details od ON o.order_id = od.order_id
JOIN reverb_instrument i ON od.instrument_id = i.instrument_id
JOIN reverb_instrument_category ic ON i.category_id = ic.category_id
;


SELECT category, brand, DATE_FORMAT(order_date, '%Y-%m') AS yearMonth, SUM(order_total) as sales
FROM reverb_order o
JOIN reverb_order_details od ON o.order_id = od.order_id
JOIN reverb_instrument i ON od.instrument_id = i.instrument_id
JOIN reverb_instrument_category ic ON ic.category_id = i.category_id
WHERE order_date BETWEEN '2024-03-01' AND '2024-05-01'
AND brand IN ('Gibson', 'Fender', 'Ibanez')
GROUP BY ROLLUP(category, brand, yearMonth)
;

SELECT view_definition FROM information_schema.views WHERE table_name = 'ranked_product_by_price';



DROP TEMPORARY TABLE IF EXISTS OrderData;
    -- Create a local temporary table to store order data
    CREATE TEMPORARY TABLE OrderData (
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
    #DROP TEMPORARY TABLE IF EXISTS OrderData;


DROP TEMPORARY TABLE IF EXISTS OrderData;
 call total_sales_by_seller();

WITH Guitars AS (
    SELECT ri.*
    FROM reverb_instrument ri
    WHERE ri.category_id = 2
    AND ri.price BETWEEN 1000 AND 3000
)
SELECT g.instrument_id, g.name AS instrument_name, g.brand, g.model, g.description,
    g.price, g.image_url, rs.store_name
FROM Guitars g
JOIN reverb_seller rs ON g.seller_id = rs.seller_id;



SELECT ri.name, attribute_key, attribute_value
FROM reverb_instrument ri
JOIN reverb_instrument_attributes ia on ri.instrument_id = ia.instrument_id
WHERE ri.category_id = 2;

SELECT ri.instrument_id, ri.name AS instrument_name, ri.brand, ri.model, ri.description,
    ri.price, ri.image_url, rs.store_name
FROM reverb_instrument ri
JOIN reverb_seller rs ON ri.seller_id = rs.seller_id
WHERE ri.category_id = 2;

WITH cool_color_guitars AS (
    SELECT ia.instrument_id
    FROM reverb_instrument_attributes ia
    WHERE ia.attribute_key = 'Body Color'
    AND ia.attribute_value IN ('Seafoam Green', 'Blue Floral Pattern')
)
SELECT ri.instrument_id, ri.name AS instrument_name, ri.brand, ri.model, ri.description,
    ri.price, ri.image_url, rs.store_name
FROM reverb_instrument ri
JOIN reverb_seller rs ON ri.seller_id = rs.seller_id
WHERE ri.instrument_id IN (SELECT instrument_id FROM cool_color_guitars)
AND ri.category_id = 2; -- Guitar

SELECT * FROM get_notdrum_instruments;

SELECT category_id, name FROM reverb_instrument where name like '%drum%';

SELECT * FROM get_notwhite_guitars;

SELECT instrument_id, name FROM reverb_instrument;
SELECT * FROM reverb_instrument_attributes where instrument_id = 19;

SELECT ia.attribute_value
FROM reverb_instrument_attributes ia
WHERE ia.attribute_key = 'Finish'
AND ia.attribute_value != 'White';

SELECT * FROM reverb_instrument_attributes where instrument_id = 35;
UPDATE reverb_instrument_attributes set attribute_value = 'White' where attribute_id = 455;

SELECT first_name, 
    last_name,
    is_superuser,
    email,
    billing_address_street1, 
    billing_address_street2, 
    billing_address_city, 
    billing_address_stateprovince, 
    billing_address_postal_code, 
    billing_address_country
FROM reverb_user
WHERE user_id = 5;

call select_user_profile(1);

/**
   IN p_InstrumentID INT,
    IN p_UserID INT,
    IN p_PaymentInfoCC VARCHAR(20),
    IN p_PaymentInfoCV2 VARCHAR(4),
    IN p_PaymentInfoExpMonth SMALLINT,
    IN p_PaymentInfoExpYear SMALLINT,
    IN p_BillingAddressStreet1 VARCHAR(255),
    IN p_BillingAddressStreet2 VARCHAR(255),
    IN p_BillingAddressCity VARCHAR(100),
    IN p_BillingAddressStateProvince VARCHAR(50),
    IN p_BillingAddressPostalCode VARCHAR(50),
    IN p_BillingAddressCountry CHAR(3),
    IN p_Tax DECIMAL(10, 2),
    IN p_ShippingCost DECIMAL(10, 2),
    IN p_OrderTotal DECIMAL(10, 2),
    IN p_OrderEmail VARCHAR(128)
    */

call purchase_instrument(15,
    1,
    '1234567890123456',
    '123',
    12,
    2022,
    '123 Main St',
    'Apt 1',
    'Anytown',
    'NY',
    '12345',
    'USA',
    0.00,
    0.00,
    2500.00,
    'test1@test.com')


SELECT * FROM reverb_order
WHERE order_id = (SELECT MAX(order_id) FROM reverb_order);

-- verify total_sales trigger was fired
SELECT total_sales from reverb_seller where seller_id = 25;

-- verify trigger on order_details was fired to update instrument status to sold
select status from reverb_instrument where instrument_id = 11;

-- delete the record just created in the stored proc to start over
DELETE FROM reverb_order_details;
-- delete the order just created so we can buy the instrument again
DELETE FROM reverb_order;

UPDATE reverb_instrument set status = 1 where status = 2;

call get_instrument_by_id(11);

UPDATE reverb_instrument
SET image_url =  CONCAT(instrument_id, '.jpeg');


update reverb_instrument set featured = 1 where instrument_id in (11, 12, 13, 14, 15, 16);


select * from get_featured_instruments;


select instrument_id, image_url from reverb_instrument;



UPDATE reverb_instrument SET date_listed = '2023-01-01' WHERE instrument_id = 11;
UPDATE reverb_instrument SET date_listed = '2023-02-01' WHERE instrument_id = 12;
UPDATE reverb_instrument SET date_listed = '2023-03-01' WHERE instrument_id = 13;
UPDATE reverb_instrument SET date_listed = '2023-04-01' WHERE instrument_id = 14;
UPDATE reverb_instrument SET date_listed = '2023-05-01' WHERE instrument_id = 15;
UPDATE reverb_instrument SET date_listed = '2023-06-01' WHERE instrument_id = 16;
UPDATE reverb_instrument SET date_listed = '2023-07-01' WHERE instrument_id = 17;
UPDATE reverb_instrument SET date_listed = '2023-08-01' WHERE instrument_id = 18;
UPDATE reverb_instrument SET date_listed = '2023-09-01' WHERE instrument_id = 19;
UPDATE reverb_instrument SET date_listed = '2023-10-01' WHERE instrument_id = 20;
UPDATE reverb_instrument SET date_listed = '2023-11-01' WHERE instrument_id = 21;
UPDATE reverb_instrument SET date_listed = '2023-12-01' WHERE instrument_id = 22;
UPDATE reverb_instrument SET date_listed = '2024-01-01' WHERE instrument_id = 23;
UPDATE reverb_instrument SET date_listed = '2024-02-01' WHERE instrument_id = 24;
UPDATE reverb_instrument SET date_listed = '2024-03-01' WHERE instrument_id = 25;
UPDATE reverb_instrument SET date_listed = '2024-04-01' WHERE instrument_id = 26;
UPDATE reverb_instrument SET date_listed = '2024-05-01' WHERE instrument_id = 27;
UPDATE reverb_instrument SET date_listed = '2024-06-01' WHERE instrument_id = 28;
UPDATE reverb_instrument SET date_listed = '2024-07-01' WHERE instrument_id = 29;
UPDATE reverb_instrument SET date_listed = '2024-08-01' WHERE instrument_id = 30;
UPDATE reverb_instrument SET date_listed = '2024-09-01' WHERE instrument_id = 31;
UPDATE reverb_instrument SET date_listed = '2024-10-01' WHERE instrument_id = 32;
UPDATE reverb_instrument SET date_listed = '2024-11-01' WHERE instrument_id = 33;
UPDATE reverb_instrument SET date_listed = '2024-12-01' WHERE instrument_id = 34;
UPDATE reverb_instrument SET date_listed = '2023-01-01' WHERE instrument_id = 35;
UPDATE reverb_instrument SET date_listed = '2023-02-01' WHERE instrument_id = 36;
UPDATE reverb_instrument SET date_listed = '2023-03-01' WHERE instrument_id = 37;
UPDATE reverb_instrument SET date_listed = '2023-04-01' WHERE instrument_id = 38;
UPDATE reverb_instrument SET date_listed = '2023-05-01' WHERE instrument_id = 39;
UPDATE reverb_instrument SET date_listed = '2023-06-01' WHERE instrument_id = 40;
UPDATE reverb_instrument SET date_listed = '2023-07-01' WHERE instrument_id = 41;
UPDATE reverb_instrument SET date_listed = '2023-08-01' WHERE instrument_id = 42;
UPDATE reverb_instrument SET date_listed = '2023-09-01' WHERE instrument_id = 43;
UPDATE reverb_instrument SET date_listed = '2023-10-01' WHERE instrument_id = 44;
UPDATE reverb_instrument SET date_listed = '2023-11-01' WHERE instrument_id = 45;
UPDATE reverb_instrument SET date_listed = '2023-12-01' WHERE instrument_id = 46;
UPDATE reverb_instrument SET date_listed = '2024-01-01' WHERE instrument_id = 47;