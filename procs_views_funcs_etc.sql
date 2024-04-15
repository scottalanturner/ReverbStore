

-- Delete before creating in case we are updating it
DROP PROCEDURE IF EXISTS auth_user;

--SELECT the user by email/pass. Used on the login screen.
--Return nothing if not found

CREATE PROCEDURE auth_user(
    IN inputEmail VARCHAR(255))
BEGIN

    SELECT id as 'user_id', password as 'user_password'
    FROM custom_user_user
    WHERE email = inputEmail;
END //

DROP PROCEDURE IF EXISTS select_seller_profile;
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
END

--Insert a new Seller
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
END


# Stored procedures, views, functions, and triggers for the Reverb database

#delete a user from the system. This is a HARD delete, not a soft delete
DROP PROCEDURE IF EXISTS DeleteUserAccount;
CREATE PROCEDURE DeleteUserAccount(IN user_id INT)
BEGIN
    DELETE FROM custom_user_user
    WHERE id = user_id;
END

# Update the user's profile information
DROP PROCEDURE IF EXISTS UpdateUserProfile;
CREATE PROCEDURE UpdateUserProfile(IN user_id INT, IN new_first_name VARCHAR(255), IN new_last_name VARCHAR(255))
BEGIN
    UPDATE custom_user_user
    SET first_name = new_first_name, last_name = new_last_name
    WHERE id = user_id;
END

# Get the user's profile information
DROP PROCEDURE IF EXISTS GetUserProfile;
CREATE PROCEDURE GetUserProfile(IN user_id INT)
BEGIN
    SELECT first_name, last_name
    FROM custom_user_user
    WHERE id = user_id;
END

-- Create a stored procedure to insert a new user
DROP PROCEDURE IF EXISTS RegisterUser;

--Registers a new user and creates a basic record
CREATE PROCEDURE RegisterUser(
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_firstName VARCHAR(50),
    IN p_lastName VARCHAR(100)
)
BEGIN
    -- Insert a new user
    INSERT INTO custom_user_user (
        email, password, date_joined,
        first_name, last_name,
        is_superuser, is_staff, is_active 
    )
    VALUES (
        p_email, p_password, NOW(),
        p_firstName, p_lastName, 0, 0, 1
    );
END;

-- Delete before creating in case we are updating it
DROP PROCEDURE IF EXISTS GetUserByCredentials;

--SELECT the user by email/pass. Used on the login screen.
--Return nothing if not found

CREATE PROCEDURE GetUserByCredentials(
    IN inputEmail VARCHAR(255))
BEGIN

    SELECT id as 'user_id', password as 'user_password'
    FROM custom_user_user
    WHERE email = inputEmail;
END //



-- Create a stored procedure to insert a new user
DROP PROCEDURE IF EXISTS InsertUser;

CREATE PROCEDURE InsertUser(
    IN p_userID INT,
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_registrationDate DATE,
    IN p_firstName VARCHAR(50),
    IN p_lastName VARCHAR(100),
    IN p_billingAddressStreet1 VARCHAR(255),
    IN p_billingAddressStreet2 VARCHAR(255),
    IN p_billingAddressCity VARCHAR(100),
    IN p_billingAddressStateProvince VARCHAR(50),
    IN p_billingAddressCountry CHAR(3)
)
BEGIN
    -- Insert a new user
    INSERT INTO AppUser (
        userID, email, password, registrationDate,
        firstName, lastName, billingAddressStreet1,
        billingAddressStreet2, billingAddressCity,
        billingAddressStateProvince, billingAddressCountry
    )
    VALUES (
        p_userID, p_email, p_password, p_registrationDate,
        p_firstName, p_lastName, p_billingAddressStreet1,
        p_billingAddressStreet2, p_billingAddressCity,
        p_billingAddressStateProvince, p_billingAddressCountry
    );
END;



DROP FUNCTION IF EXISTS YearToDateSales;

--used by admins (not users) to aggregate sales data
CREATE FUNCTION YearToDateSales()
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE ytd_sales DECIMAL(10, 2);
    
    SELECT SUM(o.orderTotal) INTO ytd_sales
    FROM Orders o
    WHERE YEAR(o.orderDate) = YEAR(CURRENT_DATE());
    
    IF ytd_sales IS NULL THEN
        SET ytd_sales = 0.00;
    END IF;
    
    RETURN ytd_sales;
END;



--***** VIEWS *****--

--Used on the home page to show the featured instruments. Ordering is by name.**/
DROP VIEW IF EXISTS GetFeaturedInstruments;

CREATE VIEW GetFeaturedInstruments AS
SELECT
    i.instrumentID,
    i.name AS instrumentName,
    i.brand,
    i.model,
    i.description,
    i.price,
    i.status,
    i.imageURL,
    s.storeName AS sellerName
FROM Instrument i
JOIN Seller s ON i.sellerID = s.sellerID
WHERE i.status = 'Available'
AND i.featured = 1
ORDER BY i.name
;

DROP VIEW IF EXISTS GetTopSellers;

--Return the Top 5 instruments that have sold the most, and are available for sale

CREATE VIEW GetTopSellers AS
SELECT i.instrumentID,
           i.name AS instrumentName,
           i.brand,
           i.model,
           i.description,
           i.price,
           i.status,
           i.imageURL,
           s.storeName AS sellerName
    FROM (
        SELECT i.instrumentID
        FROM Orders o 
        JOIN OrderDetails od ON o.orderID = od.orderID
        JOIN Instrument i ON od.instrumentID = i.instrumentID
        WHERE i.status = 'S' -- sold
        GROUP BY i.brand, i.model
        ORDER BY COUNT(*) DESC
        
    ) AS top_instruments
    JOIN Instrument i ON top_instruments.instrumentID = i.instrumentID
    JOIN Seller s ON i.sellerID = s.sellerID
    WHERE i.status = 'A' --available, we don't show sold top sellers since they aren't available to buy
    LIMIT 5; --just the top 5



-- Create a stored procedure to search for instruments with sorting
--can't use a function because of the dynamic sql (sortDirection)
DROP PROCEDURE IF EXISTS SearchInstruments;

CREATE PROCEDURE SearchInstruments(
    IN p_Keyword NVARCHAR(100),
    IN p_MinPrice DECIMAL(10, 2),
    IN p_MaxPrice DECIMAL(10, 2),
    IN p_Brand NVARCHAR(50),
    IN p_Condition INT,
    IN p_Category NVARCHAR(50),
    IN p_Model NVARCHAR(100),
    IN p_SortColumn NVARCHAR(50),
    IN p_SortDirection NVARCHAR(4)
)
BEGIN
    SET @sql = CONCAT('
        SELECT
            i.InstrumentID,
            i.Name AS InstrumentName,
            i.Brand,
            i.Model,
            i.Price,
            i.ImageURL,
            c.CategoryName
        FROM Instrument i
        JOIN Seller s ON i.SellerID = s.SellerID
        LEFT JOIN Category c ON i.CategoryID = c.CategoryID
        WHERE
            (p_Keyword IS NULL OR i.Name LIKE CONCAT("%", p_Keyword, "%"))
            AND (p_MinPrice IS NULL OR i.Price >= p_MinPrice)
            AND (p_MaxPrice IS NULL OR i.Price <= p_MaxPrice)
            AND (p_Brand IS NULL OR i.Brand = p_Brand)
            AND (p_Condition IS NULL OR i.Condition = p_Condition)
            AND (p_Category IS NULL OR c.CategoryName = p_Category)
            AND (p_Model IS NULL OR i.Model = p_Model)
        ORDER BY ', QUOTE(p_SortColumn), ' ', p_SortDirection, ';
    ');

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END;


--Transaction to Create a new purchase
-- Takes data from the one page checkout
-- Adds an order record
-- Updates the instrument as sold
--- Creates a new OrderDetail entry to link the Instrument to the Order
-- Updates the Seller sales data

DROP PROCEDURE IF EXISTS PurchaseInstrument;

CREATE PROCEDURE PurchaseInstrument(
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
    IN p_BillingAddressCountry CHAR(3),
    IN p_Tax DECIMAL(10, 2),
    IN p_ShippingCost DECIMAL(10, 2),
    IN p_OrderTotal DECIMAL(10, 2),
    IN p_TrackingNumber VARCHAR(30),
    IN p_ShippingAddressStreet1 VARCHAR(255),
    IN p_ShippingAddressStreet2 VARCHAR(255),
    IN p_ShippingAddressCity VARCHAR(100),
    IN p_ShippingAddressStateProvince VARCHAR(50),
    IN p_ShippingAddressCountry CHAR(3),
    IN p_OrderEmail VARCHAR(128)
)
BEGIN
    DECLARE v_OrderID INT;
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'An error occurred during purchase. Transaction rolled back.';
    END;

    START TRANSACTION;

    -- Insert a new order
    INSERT INTO Orders (buyerUserID, orderDate, paymentInfoCC, paymentInfoCV2,
                        paymentInfoExpMonth, paymentInfoExpYear,
                        billingAddressStreet1, billingAddressStreet2,
                        billingAddressCity, billingAddressStateProvince,
                        billingAddressCountry, tax, shippingCost, orderTotal,
                        orderStatus, trackingNumber, shippingAddressStreet1,
                        shippingAddressStreet2, shippingAddressCity,
                        shippingAddressStateProvince, shippingAddressCountry,
                        orderEmail)
    VALUES (p_UserID, NOW(), p_PaymentInfoCC, p_PaymentInfoCV2,
            p_PaymentInfoExpMonth, p_PaymentInfoExpYear,
            p_BillingAddressStreet1, p_BillingAddressStreet2,
            p_BillingAddressCity, p_BillingAddressStateProvince,
            p_BillingAddressCountry, p_Tax, p_ShippingCost, p_OrderTotal,
            'P', p_TrackingNumber, p_ShippingAddressStreet1,
            p_ShippingAddressStreet2, p_ShippingAddressCity,
            p_ShippingAddressStateProvince, p_ShippingAddressCountry,
            p_OrderEmail);

    -- Get the newly inserted OrderID
    SET v_OrderID = LAST_INSERT_ID();

    -- Insert order details
    INSERT INTO OrderDetails (OrderID, InstrumentID)
    VALUES (v_OrderID, p_InstrumentID);

    COMMIT;
END;







----******TRIGGERS*****------

--when an Instrument is created an Order and OrderDetails record is created. Update the Instrument as being sold
DROP TRIGGER IF EXISTS UpdateInstrumentStatus;

CREATE TRIGGER UpdateInstrumentStatus AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Instrument
    SET `Status` = 2
    WHERE InstrumentID = NEW.instrumentID;
END;



--Update the seller's sale total.
--Yes, we could have this in the same trigger as above, but it would be less modular
DROP TRIGGER IF EXISTS UpdateSellerTotalSales;

CREATE TRIGGER UpdateSellerTotalSales
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    
    -- Update totalSales in Seller table
    UPDATE Seller
    SET totalSales = totalSales + NEW.orderTotal
    WHERE sellerID = NEW.sellerUserID;
END;


--total sales for a seller. Yes, this column is part of the Seller table. However we
--need a use case that uses a temporary table.
DROP PROCEDURE IF EXISTS CalculateTotalSales;

CREATE PROCEDURE CalculateTotalSales(IN sellerID INT)
BEGIN
    -- Create a local temporary table to store order data
    CREATE TEMPORARY TABLE OrderData (
        orderID INT,
        instrumentID INT,
        quantity INT,
        price DECIMAL(10, 2)
    );

    -- Populate the temp table with order data for the specified seller
    INSERT INTO OrderData (orderID, instrumentID, quantity, price)
    SELECT o.orderID, oi.instrumentID, oi.quantity, i.price
    FROM Orders o
    JOIN OrderItems oi ON o.orderID = oi.orderID
    JOIN Instrument i ON oi.instrumentID = i.instrumentID
    WHERE o.sellerID = sellerID;

    -- Calculate total sales for the seller
    SELECT SUM(quantity * price) AS TotalSales
    FROM OrderData;

    -- Clean up: Drop the temp table
    DROP TEMPORARY TABLE IF EXISTS OrderData;
END;
