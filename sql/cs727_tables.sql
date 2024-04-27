/**create database cs727;
use database cs727;
*/

DROP TABLE IF EXISTS reverb_order_details;
DROP TABLE IF EXISTS reverb_order;
DROP TABLE IF EXISTS reverb_instrument_attributes;
DROP TABLE IF EXISTS reverb_instrument_category;
DROP TABLE IF EXISTS reverb_instrument;
DROP TABLE IF EXISTS reverb_instrument;
DROP TABLE IF EXISTS reverb_seller;
drop tablE IF EXISTS reverb_user;

CREATE TABLE reverb_user (
    user_id bigint PRIMARY KEY NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    is_superuser tinyint NOT NULL DEFAULT 0,
    password VARCHAR(255) NOT NULL,
    joined TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    first_name VARCHAR(50) NULL,
    last_name VARCHAR(100) NULL, 
    billing_address_street1 VARCHAR(255) NULL,
    billing_address_street2 VARCHAR(255) NULL,
    billing_address_city VARCHAR(100) NULL,
    billing_address_stateprovince VARCHAR(50) NULL,
    billing_address_postal_code VARCHAR(20) NULL,
    billing_address_country CHAR(3) NULL
);

#ALTER TABLE reverb_user modify joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Create Seller table
CREATE TABLE reverb_seller (
    seller_id bigint PRIMARY KEY NOT NULL AUTO_INCREMENT ,
    user_id bigint,
    store_name VARCHAR(100) NOT NULL,
    joined TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_sales INT DEFAULT 0,
    shipping_from_street1 VARCHAR(255),
    shipping_from_street2 VARCHAR(255) NULL,
    shipping_from_city VARCHAR(100),
    shipping_from_stateprovince VARCHAR(50),
    shipping_from_postal_code VARCHAR(20),
    shipping_from_country CHAR(3),
    return_policy INT,
    FOREIGN KEY (user_id) REFERENCES reverb_user(user_id)
);

#ALTER TABLE reverb_seller modify joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
-- Create InstrumentCategory table
CREATE TABLE reverb_instrument_category (
    category_id bigint PRIMARY KEY  NOT NULL AUTO_INCREMENT,
    category TEXT NOT NULL
);

DROP TABLE IF EXISTS reverb_instrument;
-- Create Instrument table
CREATE TABLE reverb_instrument (
    instrument_id bigint PRIMARY KEY  NOT NULL AUTO_INCREMENT,
    seller_id bigint NOT NULL,
    category_id bigint NOT NULL,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(50),
    model VARCHAR(50),
    description TEXT NOT NULL,
    item_condition SMALLINT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    status SMALLINT NOT NULL,
    shipping_type SMALLINT NOT NULL,
    image_url TEXT NOT NULL,
    featured TINYINT(1) DEFAULT 0,
    FOREIGN KEY (seller_id) REFERENCES reverb_seller(seller_id)
);



-- Create InstrumentAttributes table
CREATE TABLE reverb_instrument_attributes (
    attribute_id bigint PRIMARY KEY  NOT NULL AUTO_INCREMENT,
    instrument_id bigint NOT NULL,
    attribute_key VARCHAR(50) NOT NULL,
    attribute_value VARCHAR(255) NOT NULL,
    display_order INT NOT NULL,
    FOREIGN KEY (instrument_id) REFERENCES reverb_instrument(instrument_id)
);

-- Create Orders table
CREATE TABLE reverb_order (
    order_id bigint PRIMARY KEY  NOT NULL AUTO_INCREMENT,
    buyer_user_id bigint NOT NULL,
    seller_id bigint NOT NULL,
    order_date DATE NOT NULL,
    payment_info_cc VARCHAR(20) NOT NULL,
    payment_info_cv2 VARCHAR(4) NOT NULL,
    payment_info_exp_month SMALLINT NOT NULL,
    payment_info_exp_year SMALLINT NOT NULL,
    billing_address_street1 VARCHAR(255) NULL,
    billing_address_street2 VARCHAR(255) NULL,
    billing_address_city VARCHAR(100) NULL,
    billing_address_stateprovince VARCHAR(50) NULL,
    billing_address_postal_code VARCHAR(20) NULL,
    billing_address_country CHAR(3) NULL,
    tax DECIMAL(10, 2) DEFAULT 0,
    shipping_cost DECIMAL(10, 2) DEFAULT 0,
    order_total DECIMAL(10, 2) NOT NULL,
    order_status CHAR(1) NOT NULL,
    tracking_number VARCHAR(30) NOT NULL,
    shipping_from_street1 VARCHAR(255),
    shipping_from_street2 VARCHAR(255) NULL,
    shipping_from_city VARCHAR(100),
    shipping_from_stateprovince VARCHAR(50),
    shipping_from_postal_code VARCHAR(20),
    shipping_from_country CHAR(3),
     order_email VARCHAR(128)
);

-- Create OrderDetails table
CREATE TABLE reverb_order_details (
    order_id bigint,
    instrument_id bigint,
    PRIMARY KEY (order_id, instrument_id),
    FOREIGN KEY (order_id) REFERENCES reverb_order(order_id),
    FOREIGN KEY (instrument_id) REFERENCES reverb_instrument(instrument_id)
);

--search for all orders for a specific user
CREATE INDEX idx_buyerUserID ON reverb_order (buyer_user_id);

--allows UI searching by a specific brand of instrument (Yahmaha, Paste, Ibanez)
CREATE INDEX idx_brand ON reverb_instrument (brand);

--allows UI searching to filter based on price ranges. It may seem costly because of redundant prices, but the DBA can
--put this in cache for speed.
CREATE INDEX idx_price ON reverb_instrument (price);

