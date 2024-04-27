










# STORED PROCEDURES
################################






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
