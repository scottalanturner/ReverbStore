

----******TRIGGERS*****------

--when an Instrument is created an Order and OrderDetails record is created. 
-- Update the Instrument as being sold
DROP TRIGGER IF EXISTS update_instrument_status;

CREATE TRIGGER update_instrument_status AFTER INSERT ON reverb_order_details
FOR EACH ROW
BEGIN
    UPDATE reverb_instrument
    SET status = 2
    WHERE instrument_id = NEW.instrument_id;
END;



--Update the seller's sale total.
--Yes, we could have this in the same trigger as above, but it would be less modular
DROP TRIGGER IF EXISTS update_seller_total_sales;

CREATE TRIGGER update_seller_total_sales
AFTER INSERT ON reverb_order
FOR EACH ROW
BEGIN
    -- Update totalSales in Seller table
    UPDATE reverb_seller
    SET total_sales = total_sales + NEW.order_total
    WHERE seller_id = NEW.seller_id;
END;

