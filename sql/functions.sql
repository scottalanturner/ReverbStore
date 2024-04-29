-- Description: This file contains all the functions that are used in the application

DROP FUNCTION IF EXISTS get_instruments_by_category;
-- Description: Get all instruments with a specific category
-- Showcases: Functions, Parameters, Returns
CREATE FUNCTION get_instruments_by_category(category_id INT)
RETURNS TABLE
READS SQL DATA ACCESS READS SQL DATA
BEGIN
    RETURN (
        SELECT g.instrument_id, g.name AS instrument_name, g.brand, g.model, g.description,
        g.price, g.image_url, rs.store_name
        FROM reverb_instrument g
        JOIN reverb_seller rs ON g.seller_id = rs.seller_id
        WHERE g.category_id = category_id
        AND g.status = 1 -- available 
    );