

--***** VIEWS *****--


--Used on the home page to show the featured instruments. Ordering is by name.**/
DROP VIEW IF EXISTS get_featured_instruments;
-- Description: Get all featured instruments. Basic select/join based on the featured flag
-- Showcases: JOIN, WHERE, ORDER BY
CREATE VIEW get_featured_instruments AS
SELECT
    ri.instrument_id,
    ri.name AS instrument_name,
    ri.brand,
    ri.model,
    ri.description,
    ri.price,
    ri.status,
    ri.image_url,
    rs.store_name
FROM reverb_instrument ri
JOIN reverb_seller rs ON ri.seller_id = rs.seller_id
WHERE ri.status = 1 -- available
AND ri.featured = 1 -- featured
ORDER BY ri.name;





-- Hot Deals (trying to sell the oldest inventory)
DROP VIEW IF EXISTS get_sales_by_category;

-- Description: Get the top 3 oldest instruments for each category. We assume these would
-- be sale items for the purpose of showing set functionality
-- Returns: 12 records. 3 for each category
-- Columns: instrument_id, instrument_name, brand, model, description, price, image_url, store_name
-- Showcases: Set operation, JOIN, ORDER BY, LIMIT, UNION
CREATE VIEW get_sales_by_category AS
(
SELECT ri.instrument_id, ri.name AS instrument_name, ri.brand, ri.model, ri.description,
    ri.price, ri.image_url, rs.store_name
FROM reverb_instrument ri
JOIN reverb_seller rs ON ri.seller_id = rs.seller_id
WHERE ri.status = 1 -- available
    AND category_id = 4 -- Keyboards
ORDER BY date_listed ASC
LIMIT 3
)
UNION 
(
SELECT ri.instrument_id, ri.name AS instrument_name, ri.brand, ri.model, ri.description,
    ri.price, ri.image_url, rs.store_name
FROM reverb_instrument ri
JOIN reverb_seller rs ON ri.seller_id = rs.seller_id
WHERE ri.status = 1 -- available
    AND category_id = 1 -- Guitar
ORDER BY date_listed ASC
LIMIT 3
)
UNION
(
SELECT ri.instrument_id, ri.name AS instrument_name, ri.brand, ri.model, ri.description,
    ri.price, ri.image_url, rs.store_name
FROM reverb_instrument ri
JOIN reverb_seller rs ON ri.seller_id = rs.seller_id
WHERE ri.status = 1 -- available
    AND category_id = 2 -- Bass
ORDER BY date_listed ASC
LIMIT 3
)
UNION
(
SELECT ri.instrument_id, ri.name AS instrument_name, ri.brand, ri.model, ri.description,
    ri.price, ri.image_url, rs.store_name
FROM reverb_instrument ri
JOIN reverb_seller rs ON ri.seller_id = rs.seller_id
WHERE ri.status = 1 -- available
    AND category_id = 3 -- Drums
ORDER BY date_listed ASC
LIMIT 3
);





DROP VIEW IF EXISTS get_by_frets;
-- Description: Get all guitars with 22 frets
-- Columns: instrument_id, instrument_name, brand, model, description, price, image_url, store_name
-- Showcases: set membership (IN)
CREATE VIEW get_by_frets AS
SELECT ri.instrument_id, ri.name AS instrument_name, ri.brand, ri.model, ri.description,
    ri.price, ri.image_url, rs.store_name
FROM reverb_instrument ri
JOIN reverb_seller rs ON ri.seller_id = rs.seller_id
WHERE ri.instrument_id IN (
    SELECT ia.instrument_id
    FROM reverb_instrument_attributes ia
    WHERE ia.attribute_key = 'Number of Frets'
    AND ia.attribute_value = '22'
)
AND ri.status = 1 -- available;





DROP VIEW IF EXISTS get_nonwhite_guitars;
-- Description: Get all guitars that aren't white. Because white guitars are lame
-- Columns: instrument_id, instrument_name, brand, model, description, price, image_url, store_name
-- Showcases: set membership (NOT IN)
CREATE VIEW get_nonwhite_guitars AS
SELECT ri.instrument_id, ri.name AS instrument_name, ri.brand, ri.model, ri.description,
    ri.price, ri.image_url, rs.store_name
FROM reverb_instrument ri
JOIN reverb_seller rs ON ri.seller_id = rs.seller_id
WHERE ri.category_id = 2 -- Guitar
AND ri.status = 1 -- available
AND ri.instrument_id NOT IN (
    SELECT ia.instrument_id
    FROM reverb_instrument_attributes ia
    WHERE ia.attribute_key IN ('Finish', 'Body Color')
    AND ia.attribute_value = 'White'
);






DROP VIEW IF EXISTS get_notdrum_instruments;

-- Description: Get all instruments that aren't drums
-- Columns: instrument_id, instrument_name, brand, model, description, price, image_url, store_name
-- Showcases: set membership (NOT IN)
CREATE VIEW get_notdrum_instruments AS
SELECT ri.instrument_id, ri.name AS instrument_name, ri.brand, ri.model, ri.description,
    ri.price, ri.image_url, rs.store_name
FROM reverb_instrument ri
JOIN reverb_seller rs ON ri.seller_id = rs.seller_id
WHERE ri.instrument_id NOT IN (
    SELECT ri.instrument_id
    FROM reverb_instrument ri
    WHERE ri.category_id = 1 -- Drums
    AND ri.status = 1 -- available
);






DROP VIEW IF EXISTS get_cool_guitars;

-- Description: Get guitars that look cool. This is an important selling point, especially for people who can't play
-- We do this by the color of the guitar, in this case Seafoam Green and Blue Floral Pattern
-- Showcases: Common Table Expressions (CTE) - subquery using WITH, set comparison (ANY), set membership (IN)
CREATE VIEW get_cool_guitars AS
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
WHERE ri.instrument_id = ANY (SELECT instrument_id FROM cool_color_guitars)
AND ri.category_id = 2 -- Guitar
AND ri.status = 1 -- available
;






DROP VIEW IF EXISTS get_expensive_guitars;
-- Description: Get guitars that are expensive. This is a relative term, but in this case, we're looking at guitars between $1000 and $3000 
-- showcases: Common Table Expressions (CTE) - subquery using WITH, set comparison (BETWEEN)
CREATE VIEW get_expensive_guitars AS
WITH Guitars AS (
    SELECT ri.*
    FROM reverb_instrument ri
    WHERE ri.category_id = 2
    AND ri.price BETWEEN 1000 AND 3000
    AND ri.status = 1 -- available
)
SELECT g.instrument_id, g.name AS instrument_name, g.brand, g.model, g.description,
    g.price, g.image_url, rs.store_name
FROM Guitars g
JOIN reverb_seller rs ON g.seller_id = rs.seller_id;


