/**create database cs727;
use database cs727;
*/

DROP TABLE OrderDetails;
DROP TABLE Orders;
DROP TABLE InstrumentCategory;
DROP TABLE InstrumentAttributes;
DROP TABLE Instrument;
DROP TABLE Seller;
DROP TABLE AppUser;

CREATE TABLE AppUser (
    userID INT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    registrationDate DATE NOT NULL,
    firstName VARCHAR(50) NULL,
    lastName VARCHAR(100) NULL, 
    billingAddressStreet1 VARCHAR(255) NULL,
    billingAddressStreet2 VARCHAR(255) NULL,
    billingAddressCity VARCHAR(100) NULL,
    billingAddressStateProvince VARCHAR(50) NULL,
    billingAddressCountry CHAR(3) NULL
);

-- Create Seller table
CREATE TABLE reverb_seller (
    seller_id bigint PRIMARY KEY NOT NULL AUTO_INCREMENT ,
    user_id bigint,
    store_name VARCHAR(100) NOT NULL,
    joined DATE NOT NULL,
    total_sales INT DEFAULT 0,
    shipping_from_street1 VARCHAR(255),
    shipping_from_street2 VARCHAR(255) NULL,
    shipping_from_city VARCHAR(100),
    shipping_from_stateprovince VARCHAR(50),
    shipping_from_postal_code VARCHAR(20),
    shipping_from_country CHAR(3),
    return_policy INT,
    FOREIGN KEY (user_id) REFERENCES custom_user_user(id)
);

DROP TABLE IF EXISTS Instrument;
-- Create Instrument table
CREATE TABLE Instrument (
    instrumentID INT PRIMARY KEY,
    sellerID INT NOT NULL,
    categoryID INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(50),
    model VARCHAR(50),
    description TEXT NOT NULL,
    itemCondition SMALLINT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    status SMALLINT NOT NULL,
    shippingType SMALLINT NOT NULL,
    imageURL TEXT NOT NULL,
    featured TINYINT(1) DEFAULT 0,
    FOREIGN KEY (sellerID) REFERENCES Seller(sellerID)
);

-- Create InstrumentCategory table
CREATE TABLE InstrumentCategory (
    categoryID INT PRIMARY KEY,
    category TEXT NOT NULL
);

-- Create InstrumentAttributes table
CREATE TABLE InstrumentAttributes (
    attributeID INT PRIMARY KEY,
    instrumentID INT NOT NULL,
    attKey VARCHAR(50) NOT NULL,
    attValue VARCHAR(255) NOT NULL,
    displayOrder INT NOT NULL,
    FOREIGN KEY (instrumentID) REFERENCES Instrument(instrumentID)
);

-- Create Orders table
CREATE TABLE Orders (
    orderID INT PRIMARY KEY,
    buyerUserID INT NOT NULL,
    sellerUserID INT NOT NULL,
    orderDate DATE NOT NULL,
    paymentInfoCC VARCHAR(20) NOT NULL,
    paymentInfoCV2 VARCHAR(4) NOT NULL,
    paymentInfoExpMonth SMALLINT NOT NULL,
    paymentInfoExpYear SMALLINT NOT NULL,
    billingAddressStreet1 VARCHAR(255) NULL,
    billingAddressStreet2 VARCHAR(255) NULL,
    billingAddressCity VARCHAR(100) NULL,
    billingAddressStateProvince VARCHAR(50) NULL,
    billingAddressCountry CHAR(3) NULL,
    tax DECIMAL(10, 2) DEFAULT 0,
    shippingCost DECIMAL(10, 2) DEFAULT 0,
    orderTotal DECIMAL(10, 2) NOT NULL,
    orderStatus CHAR(1) NOT NULL,
    trackingNumber VARCHAR(30) NOT NULL,
    shippingAddressStreet1 VARCHAR(255),
    shippingAddressStreet2 VARCHAR(255),
    shippingAddressCity VARCHAR(100),
    shippingAddressStateProvince VARCHAR(50),
    shippingAddressCountry CHAR(3),
    orderEmail VARCHAR(128)
);

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    orderID INT,
    instrumentId INT,
    PRIMARY KEY (orderID, instrumentId),
    FOREIGN KEY (orderID) REFERENCES Orders(orderID),
    FOREIGN KEY (instrumentId) REFERENCES Instrument(instrumentId)
);

--search for all orders for a specific user
CREATE INDEX idx_buyerUserID ON Orders (buyerUserID);

--allows UI searching by a specific brand of instrument (Yahmaha, Paste, Ibanez)
CREATE INDEX idx_brand ON Instrument (brand);

--allows UI searching to filter based on price ranges. It may seem costly because of redundant prices, but the DBA can
--put this in cache for speed.
CREATE INDEX idx_price ON Instrument (price);

