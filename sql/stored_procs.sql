

-- Transaction to Create a new purchase
-- Takes data from the one page checkout
-- Adds an order record
-- Updates the instrument as sold
-- Creates a new OrderDetail entry to link the Instrument to the Order
-- Updates the Seller sales data
DROP PROCEDURE IF EXISTS purchase_instrument;

CREATE PROCEDURE purchase_instrument(
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
)
BEGIN
    -- Declare a variable to hold the error message
    DECLARE v_error_message VARCHAR(255);
    DECLARE v_full_message VARCHAR(2000);

    DECLARE v_OrderID INT;

    DECLARE exit handler for sqlexception
    BEGIN

        -- Get the error message
        GET DIAGNOSTICS CONDITION 1
        v_error_message = MESSAGE_TEXT;
        
        ROLLBACK;
        
     -- Check if v_error_message is NULL
        IF v_error_message IS NOT NULL THEN
            -- Concatenate the error message
            SET v_full_message = CONCAT('ERROR. Transaction rolled back. Error: ', v_error_message);
        ELSE
            -- Set a default error message
            SET v_full_message = 'ERROR. Transaction rolled back.';
        END IF;

        -- Truncate v_full_message to 128 characters
        SET v_full_message = SUBSTRING(v_full_message, 1, 128);

        -- Signal an error with the full error message
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = v_full_message;
    END;
    -- begin transaction
    START TRANSACTION;

    -- load the shipping address from the seller. This is a denormalized field, but it's easier to do it this way    
    -- store in variables to insert into the order
    SELECT seller_id, shipping_from_street1, shipping_from_street2, shipping_from_city, shipping_from_stateprovince, shipping_from_postal_code, shipping_from_country 
        INTO @sellerID, @shippingFromStreet1, @shippingFromStreet2, @shippingFromCity, @shippingFromStateProvince, @shippingFromPostalCode, @shippingFromCountry    
    FROM reverb_seller
    WHERE seller_id = (SELECT seller_id FROM reverb_instrument WHERE instrument_id = p_InstrumentID);

    -- Insert a new order
    -- The order status is set to 'P' (Pending) initially. The seller then has to 
    -- mark it as shipped ('S') when the tracking has been created and the product
    -- dropped off at the shipper. (NOT IMPLEMENTED, but would be in a real system)
    INSERT INTO reverb_order (buyer_user_id, seller_id,
                        order_date, payment_info_cc, payment_info_cv2,
                        payment_info_exp_month, payment_info_exp_year,
                        billing_address_street1, billing_address_street2,
                        billing_address_city, billing_address_stateprovince,
                        billing_address_postal_code,
                        billing_address_country, tax, shipping_cost, order_total,
                        order_status, shipping_from_street1,
                        shipping_from_street2, shipping_from_city,
                        shipping_from_stateprovince, shipping_from_postal_code, shipping_from_country,
                        order_email)
    VALUES (p_UserID, @sellerID, CURDATE(), p_PaymentInfoCC, p_PaymentInfoCV2,
            p_PaymentInfoExpMonth, p_PaymentInfoExpYear,
            p_BillingAddressStreet1, p_BillingAddressStreet2,
            p_BillingAddressCity, p_BillingAddressStateProvince,
            p_BillingAddressPostalCode,
            p_BillingAddressCountry, p_Tax, p_ShippingCost, p_OrderTotal,
            'P', @shippingFromStreet1, @shippingFromStreet2, @shippingFromCity,
            @shippingFromStateProvince, @shippingFromPostalCode, @shippingFromCountry,
            p_OrderEmail);

    -- Get the newly inserted OrderID
    SET v_OrderID = LAST_INSERT_ID();

    -- Insert order details
    INSERT INTO reverb_order_details (order_id, instrument_id)
    VALUES (v_OrderID, p_InstrumentID);

    -- trigger update_instrument_status will update the instrument status to sold

    -- trigger update_seller_total_sales will update the seller's total sales

    -- commit the transaction
    COMMIT;

    -- Returns the order id that was created. This will be used on the confirmation page
    SELECT v_OrderID as 'order_id';
END;

DROP PROCEDURE IF EXISTS get_instrument_by_id;

# Get an instrument by its ID, including its attributes
# Used to display the details of an instrument
# The procedure returns two result sets: the instrument details and its attributes
CREATE PROCEDURE get_instrument_by_id(IN instrument_id INT)
BEGIN
    -- First result set: instrument details
    SELECT
        ri.instrument_id,
        ri.name AS instrument_name,
        ri.brand,
        ri.model,
        ri.description,
        ri.price,
        ri.status,
        ri.image_url,
        ri.shipping_type,
        rs.store_name
    FROM reverb_instrument ri
    JOIN reverb_seller rs ON ri.seller_id = rs.seller_id
    WHERE ri.instrument_id = instrument_id;

    -- Second result set: instrument attributes
    SELECT
        ria.attribute_key,
        ria.attribute_value
    FROM reverb_instrument_attributes ria
    WHERE ria.instrument_id = instrument_id;
END;







-- Create a stored procedure to insert a new user
DROP PROCEDURE IF EXISTS register_user;

CREATE PROCEDURE register_user(
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_firstName VARCHAR(50),
    IN p_lastName VARCHAR(100),
    IN p_billingAddressStreet1 VARCHAR(255),
    IN p_billingAddressStreet2 VARCHAR(255),
    IN p_billingAddressCity VARCHAR(100),
    IN p_billingAddressStateProvince VARCHAR(50),
    IN p_billingAddressPostalCode VARCHAR(50),
    IN p_billingAddressCountry CHAR(3)
)
BEGIN
    -- Insert a new user
    INSERT INTO reverb_user (
        email, password, joined,
        first_name, last_name, billing_address_street1,
        billing_address_street2, billing_address_city,
        billing_address_stateprovince, billing_address_postal_code, billing_address_country
    )
    VALUES (
        p_email, p_password, NOW(),
        p_firstName, p_lastName, p_billingAddressStreet1,
        p_billingAddressStreet2, p_billingAddressCity,
        p_billingAddressStateProvince, p_billingAddressPostalCode, p_billingAddressCountry
    );
END;

# Get the user's profile information
DROP PROCEDURE IF EXISTS select_user_profile;
CREATE PROCEDURE select_user_profile(IN p_userID INT)
BEGIN
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
    WHERE user_id = p_userID;
END;

-- Delete before creating in case we are updating it
DROP PROCEDURE IF EXISTS auth_user;

-- SELECT the user by email/pass. Used on the login screen.
-- Return nothing if not found
CREATE PROCEDURE auth_user(
    IN inputEmail VARCHAR(255))
BEGIN

    SELECT user_id, password as 'user_password', is_superuser
    FROM reverb_user
    WHERE email = inputEmail;
END;



DROP PROCEDURE IF EXISTS select_seller_profile;
-- Get the seller's profile information
-- Used to display the seller's profile page
CREATE PROCEDURE select_seller_profile(IN seller_id INT)
BEGIN
    SELECT store_name,
              total_sales,
              shipping_from_street1,
              shipping_from_street2,
              shipping_from_city,
              shipping_from_stateprovince,
              shipping_from_postal_code,
              shipping_from_country,
              return_policy,
              user_id
    FROM reverb_seller
    WHERE seller_id = seller_id;
END;

-- Insert a new Seller
DROP PROCEDURE IF EXISTS create_seller;

CREATE PROCEDURE create_seller(
    IN p_userID INT,
    IN p_storeName VARCHAR(100),
    IN p_shippingFromStreet1 VARCHAR(255),
    IN p_shippingFromStreet2 VARCHAR(255),
    IN p_shippingFromCity VARCHAR(100),
    IN p_shippingFromStateProvince VARCHAR(50),
    IN p_shippingFromPostalCode VARCHAR(50),
    IN p_shippingFromCountry CHAR(3),
    IN p_returnPolicy INT
)
BEGIN
    -- Insert a new seller
    INSERT INTO reverb_seller (
        user_id, 
        store_name,
        total_sales, 
        shipping_from_street1,
        shipping_from_street2, 
        shipping_from_city,
        shipping_from_stateprovince, 
        shipping_from_postal_code, 
        shipping_from_country,
        joined,
        return_policy
    )
    VALUES (
        p_userID, 
        p_storeName,
        0, 
        p_shippingFromStreet1,
        p_shippingFromStreet2, 
        p_shippingFromCity,
        p_shippingFromStateProvince, 
        p_shippingFromPostalCode,
        p_shippingFromCountry,
        NOW(),
        p_returnPolicy
    );
END; 


#select if the user is a seller. Used to determine if the user can see the seller dashboard
DROP PROCEDURE IF EXISTS is_seller;
CREATE PROCEDURE is_seller(IN user_id INT)
BEGIN
    SELECT seller_id
    FROM reverb_seller
    WHERE user_id = user_id;
END;



-- drop the procedure if it exists
DROP PROCEDURE IF EXISTS get_instruments_by_category;
-- Create a stored procedure to get all instruments by category
-- The procedure takes a category_id as input and returns a result set with instrument details
-- The procedure uses a temporary table to store the result set before returning it
-- Showcases: temporary table
CREATE PROCEDURE get_instruments_by_category(IN category_id INT)
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS ResultTable (
        instrument_id INT,
        instrument_name VARCHAR(255),
        brand VARCHAR(255),
        model VARCHAR(255),
        description TEXT,
        price DECIMAL(10,2),
        image_url VARCHAR(255),
        store_name VARCHAR(255)
    );
    INSERT INTO ResultTable
    SELECT g.instrument_id, g.name AS instrument_name, g.brand, g.model, g.description,
    g.price, g.image_url, rs.store_name
    FROM reverb_instrument g
    JOIN reverb_seller rs ON g.seller_id = rs.seller_id
    WHERE g.category_id = category_id
    AND g.status = 1; -- status = 1 means the instrument is available

    SELECT * FROM ResultTable;
END;
