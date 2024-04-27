#here's your password for all users: asdfasdf: $pbkdf2-sha256$29000$3Pt/D8FYa621trZ2rnVubQ$S3ts7V7jzVZT3m3DS30KHQiXhqGKvkExjVqgv5WAgsw

INSERT INTO reverb_user (
    email, 
    is_superuser, 
    password, 
    first_name, 
    last_name, 
    billing_address_street1, 
    billing_address_street2, 
    billing_address_city, 
    billing_address_stateprovince, 
    billing_address_postal_code, 
    billing_address_country
) VALUES 
('test1@test.com', false, '$pbkdf2-sha256$29000$3Pt/D8FYa621trZ2rnVubQ$S3ts7V7jzVZT3m3DS30KHQiXhqGKvkExjVqgv5WAgsw', 'John', 'Doe', '123 Main St', 'Apt 101', 'New York', 'NY', '10001', 'USA'),
('user2@example.com', false, '$pbkdf2-sha256$29000$3Pt/D8FYa621trZ2rnVubQ$S3ts7V7jzVZT3m3DS30KHQiXhqGKvkExjVqgv5WAgsw', 'Jane', 'Smith', '456 Elm St', '', 'Los Angeles', 'CA', '90001', 'USA'),
('admin@test.com', true, '$pbkdf2-sha256$29000$3Pt/D8FYa621trZ2rnVubQ$S3ts7V7jzVZT3m3DS30KHQiXhqGKvkExjVqgv5WAgsw', 'Admin', 'User', '789 Oak St', 'Suite 200', 'Chicago', 'IL', '60601', 'USA'),
('customer@example.com', false, '$pbkdf2-sha256$29000$3Pt/D8FYa621trZ2rnVubQ$S3ts7V7jzVZT3m3DS30KHQiXhqGKvkExjVqgv5WAgsw', 'Customer', 'Test', '321 Pine St', '', 'Houston', 'TX', '77001', 'USA'),
('user3@example.com', false, '$pbkdf2-sha256$29000$3Pt/D8FYa621trZ2rnVubQ$S3ts7V7jzVZT3m3DS30KHQiXhqGKvkExjVqgv5WAgsw', 'Alice', 'Johnson', '987 Cedar St', '', 'Miami', 'FL', '33101', 'USA'),
('user4@example.com', false, '$pbkdf2-sha256$29000$3Pt/D8FYa621trZ2rnVubQ$S3ts7V7jzVZT3m3DS30KHQiXhqGKvkExjVqgv5WAgsw', 'Bob', 'Brown', '654 Maple St', 'Unit B', 'San Francisco', 'CA', '94101', 'USA'),
('user5@example.com', false, '$pbkdf2-sha256$29000$3Pt/D8FYa621trZ2rnVubQ$S3ts7V7jzVZT3m3DS30KHQiXhqGKvkExjVqgv5WAgsw', 'Emily', 'Davis', '852 Walnut St', '', 'Seattle', 'WA', '98101', 'USA'),
('user6@example.com', false, '$pbkdf2-sha256$29000$3Pt/D8FYa621trZ2rnVubQ$S3ts7V7jzVZT3m3DS30KHQiXhqGKvkExjVqgv5WAgsw', 'David', 'Wilson', '369 Pine St', '', 'Boston', 'MA', '02101', 'USA'),
('user7@example.com', false, '$pbkdf2-sha256$29000$3Pt/D8FYa621trZ2rnVubQ$S3ts7V7jzVZT3m3DS30KHQiXhqGKvkExjVqgv5WAgsw', 'Sarah', 'Martinez', '753 Oak St', 'Apt 303', 'Atlanta', 'GA', '30301', 'USA'),
('user8@example.com', false, '$pbkdf2-sha256$29000$3Pt/D8FYa621trZ2rnVubQ$S3ts7V7jzVZT3m3DS30KHQiXhqGKvkExjVqgv5WAgsw', 'Michael', 'Lopez', '159 Elm St', '', 'Dallas', 'TX', '75201', 'USA'),
('user11@example.com', false, 'password11', 'Alice', 'Johnson', '987 Cedar St', '', 'Miami', 'FL', '33101', 'USA'),
('user12@example.com', false, 'password12', 'Bob', 'Brown', '654 Maple St', 'Unit B', 'San Francisco', 'CA', '94101', 'USA'),
('user13@example.com', false, 'password13', 'Emily', 'Davis', '852 Walnut St', '', 'Seattle', 'WA', '98101', 'USA'),
('user14@example.com', false, 'password14', 'David', 'Wilson', '369 Pine St', '', 'Boston', 'MA', '02101', 'USA'),
('user15@example.com', false, 'password15', 'Sarah', 'Martinez', '753 Oak St', 'Apt 303', 'Atlanta', 'GA', '30301', 'USA'),
('user16@example.com', false, 'password16', 'Michael', 'Lopez', '159 Elm St', '', 'Dallas', 'TX', '75201', 'USA'),
('user17@example.com', false, 'password17', 'Emma', 'Garcia', '369 Cedar St', '', 'Miami', 'FL', '33101', 'USA'),
('user18@example.com', false, 'password18', 'Daniel', 'Martinez', '852 Oak St', '', 'Chicago', 'IL', '60601', 'USA'),
('user19@example.com', false, 'password19', 'Olivia', 'Hernandez', '753 Pine St', '', 'New York', 'NY', '10001', 'USA'),
('user20@example.com', false, 'password20', 'Ethan', 'Lopez', '123 Walnut St', '', 'Los Angeles', 'CA', '90001', 'USA'),
('user21@example.com', false, 'password21', 'Ava', 'Gonzalez', '456 Cedar St', '', 'San Francisco', 'CA', '94101', 'USA'),
('user22@example.com', false, 'password22', 'Sophia', 'Perez', '987 Oak St', 'Floor 2', 'Seattle', 'WA', '98101', 'USA'),
('user23@example.com', false, 'password23', 'Mia', 'Rodriguez', '369 Elm St', '', 'Boston', 'MA', '02101', 'USA'),
('user24@example.com', false, 'password24', 'Logan', 'Gonzalez', '753 Cedar St', '', 'Atlanta', 'GA', '30301', 'USA'),
('user25@example.com', false, 'password25', 'Lucas', 'Hernandez', '159 Pine St', '', 'Houston', 'TX', '77001', 'USA'),
('user26@example.com', false, 'password26', 'Mason', 'Martinez', '852 Elm St', '', 'Dallas', 'TX', '75201', 'USA'),
('user27@example.com', false, 'password27', 'Sophia', 'Smith', '987 Cedar St', '', 'Miami', 'FL', '33101', 'USA'),
('user28@example.com', false, 'password28', 'Ava', 'Johnson', '654 Maple St', 'Unit B', 'San Francisco', 'CA', '94101', 'USA'),
('user29@example.com', false, 'password29', 'Logan', 'Williams', '852 Walnut St', '', 'Seattle', 'WA', '98101', 'USA'),
('user30@example.com', false, 'password30', 'Mason', 'Jones', '369 Pine St', '', 'Boston', 'MA', '02101', 'USA'),
('user31@example.com', false, 'password31', 'Ethan', 'Brown', '753 Oak St', 'Apt 303', 'Atlanta', 'GA', '30301', 'USA'),
('user32@example.com', false, 'password32', 'Sophia', 'Davis', '159 Elm St', '', 'Dallas', 'TX', '75201', 'USA'),
('user33@example.com', false, 'password33', 'Mia', 'Taylor', '369 Cedar St', '', 'Miami', 'FL', '33101', 'USA'),
('user34@example.com', false, 'password34', 'Lucas', 'Martinez', '852 Oak St', '', 'Chicago', 'IL', '60601', 'USA'),
('user35@example.com', false, 'password35', 'Ava', 'Lopez', '753 Pine St', '', 'New York', 'NY', '10001', 'USA'),
('user36@example.com', false, 'password36', 'Logan', 'Garcia', '123 Walnut St', '', 'Los Angeles', 'CA', '90001', 'USA'),
('user37@example.com', false, 'password37', 'Mason', 'Hernandez', '456 Cedar St', '', 'San Francisco', 'CA', '94101', 'USA'),
('user38@example.com', false, 'password38', 'Sophia', 'Gonzalez', '987 Oak St', 'Floor 2', 'Seattle', 'WA', '98101', 'USA'),
('user39@example.com', false, 'password39', 'Mia', 'Rodriguez', '369 Elm St', '', 'Boston', 'MA', '02101', 'USA'),
('user40@example.com', false, 'password40', 'Lucas', 'Perez', '753 Cedar St', '', 'Atlanta', 'GA', '30301', 'USA');


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
    return_policy
) VALUES 
(1, 'Music Paradise', 1000, '123 Main St', 'Floor 1', 'New York', 'NY', '10001', 'USA', 30),
(2, 'Guitar Haven', 1500, '456 Elm St', NULL, 'Los Angeles', 'CA', '90001', 'USA', 14),
(3, 'Drum Universe', 800, '789 Oak St', 'Suite 200', 'Chicago', 'IL', '60601', 'USA', 45),
(4, 'Vintage Sounds', 2000, '321 Pine St', '', 'Houston', 'TX', '77001', 'USA', 30),
(5, 'Keyboards Galore', 1200, '987 Cedar St', NULL, 'Miami', 'FL', '33101', 'USA', 30),
(6, 'Strings & Co.', 1800, '654 Maple St', 'Unit B', 'San Francisco', 'CA', '94101', 'USA', 30),
(7, 'Audio World', 1400, '852 Walnut St', '', 'Seattle', 'WA', '98101', 'USA', 14),
(8, 'Brass Kingdom', 900, '369 Pine St', '', 'Boston', 'MA', '02101', 'USA', 30),
(9, 'Synth City', 1100, '753 Oak St', 'Apt 303', 'Atlanta', 'GA', '30301', 'USA', 30),
(10, 'Bass Haven', 1300, '159 Elm St', '', 'Dallas', 'TX', '75201', 'USA', 30),
(11, 'Piano Universe', 1600, '369 Cedar St', '', 'Miami', 'FL', '33101', 'USA', 14),
(12, 'Sound Essentials', 1700, '852 Oak St', '', 'Chicago', 'IL', '60601', 'USA', 30),
(13, 'Amp Emporium', 2000, '753 Pine St', '', 'New York', 'NY', '10001', 'USA', 45),
(14, 'Vinyl Vault', 1900, '123 Walnut St', '', 'Los Angeles', 'CA', '90001', 'USA', 30),
(15, 'Microphone World', 1000, '456 Cedar St', '', 'San Francisco', 'CA', '94101', 'USA', 14),
(16, 'DJ Paradise', 1200, '987 Oak St', 'Floor 2', 'Seattle', 'WA', '98101', 'USA', 30),
(17, 'Pro Audio Emporium', 800, '369 Elm St', '', 'Boston', 'MA', '02101', 'USA', 30),
(18, 'Guitar Gallery', 1100, '753 Cedar St', '', 'Atlanta', 'GA', '30301', 'USA', 45),
(19, 'Keyboard Kingdom', 1500, '159 Pine St', '', 'Houston', 'TX', '77001', 'USA', 30),
(20, 'Drum Depot', 1300, '852 Elm St', '', 'Dallas', 'TX', '75201', 'USA', 30),
(21, 'Canadian Drums', 1000, '123 Maple Ave', 'Suite 100', 'Toronto', 'ON', 'M5A 1N1', 'CAN', 30),
(22, 'Maple Guitars', 1500, '456 Oak St', '', 'Montreal', 'QC', 'H2Y 1Z2', 'CAN', 14),
(23, 'Poutine Synths', 800, '789 Pine St', '', 'Vancouver', 'BC', 'V6B 1R3', 'CAN', 45),
(24, 'Quebec Audio', 2000, '321 Cedar St', '', 'Quebec City', 'QC', 'G1R 1A1', 'CAN', 30);

INSERT INTO reverb_instrument_category (category)
VALUES 
('Drums'),
('Guitars'),
('Keyboards'),
('Woodwinds');


INSERT INTO reverb_instrument (
    seller_id,
    category_id,
    name,
    brand,
    model,
    description,
    item_condition,
    price,
    status,
    shipping_type,
    image_url,
    featured
) VALUES 
(25, 1, 'Mapex Drum Kit', 'Mapex', 'Maple Series', 'Professional drum kit with maple shells', 1, 1500.00, 1, 1, 'https://cdn.shopify.com/s/files/1/0222/5646/5880/products/mapex-drum-kit-8_1024x1024.jpg?v=1627548710', 0),
(26, 2, 'Fender Stratocaster', 'Fender', 'Stratocaster', 'Classic electric guitar with versatile tones', 1, 1200.00, 1, 1, 'https://cdn.shopify.com/s/files/1/0206/9470/products/Fender-Stratocaster-Electric-Guitar.jpg?v=1609391131', 0),
(27, 3, 'Roland Juno-DS', 'Roland', 'Juno-DS', 'Synthesizer keyboard with high-quality sounds', 1, 1000.00, 1, 1, 'https://cdn.shopify.com/s/files/1/0032/8273/2715/products/ROLAND_JUNO-DS88_2_2000x.jpg?v=1623181661', 0),
(28, 4, 'Yamaha YCL-255 Clarinet', 'Yamaha', 'YCL-255', 'Student clarinet with great tone and durability', 1, 800.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1393/images/3827/Yamaha-YCL255-Clarinet__16625.1624493412.500.750.jpg?c=2', 0),
(29, 1, 'DW Collector\'s Series Drum Kit', 'DW', 'Collector\'s Series', 'High-end drum kit for professional drummers', 1, 3000.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1503/images/4119/DW-Collector_s-Series-Purple-Heart-14-6-Piece-Shell-Kit__25399.1627602029.1280.1280.jpg?c=2', 0),
(25, 2, 'Gibson Les Paul Standard', 'Gibson', 'Les Paul Standard', 'Iconic electric guitar with a rich, warm tone', 1, 2500.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1633/images/4581/Gibson-Les-Paul-Standard-50s-Ebony__65915.1627609911.500.750.jpg?c=2', 0),
(26, 3, 'Korg Kronos', 'Korg', 'Kronos', 'Flagship workstation keyboard with extensive features', 1, 3500.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1613/images/4504/Korg-Kronos-2-73__09758.1627528661.500.750.jpg?c=2', 0),
(27, 4, 'Buffet Crampon R13 Clarinet', 'Buffet Crampon', 'R13', 'Professional clarinet known for its exceptional quality', 1, 2000.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1392/images/3826/Buffet-Crampon-R13-Bb-Clarinet-Wood__31295.1624493347.500.750.jpg?c=2', 0),
(28, 1, 'Pearl Export Drum Kit', 'Pearl', 'Export', 'Popular beginner-to-intermediate drum kit', 1, 800.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1458/images/4005/Pearl-Export-5-Piece-Drum-Set-with-Hardware-Honey-Amber__23079.1627592999.500.750.jpg?c=2', 0),
(29, 2, 'Taylor 314ce Acoustic Guitar', 'Taylor', '314ce', 'High-quality acoustic guitar with a bright, clear tone', 1, 1800.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1612/images/4502/Taylor-314ce-Acoustic-Guitar-Shaded-Edge-Burst__50441.1627526919.500.750.jpg?c=2', 0),
(25, 3, 'Kawai ES110 Digital Piano', 'Kawai', 'ES110', 'Compact and portable digital piano with authentic piano sound', 1, 899.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1369/images/3769/Kawai-ES110-Portable-Digital-Piano__98315.1624491529.500.750.jpg?c=2', 0),
(26, 1, 'Tama Superstar Classic Drum Kit', 'Tama', 'Superstar Classic', 'Versatile drum kit with high-quality hardware and construction', 1, 1199.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1366/images/3766/Tama-Superstar-Classic-Custom-5-Piece-Shell-Pack-Lacquer-Finishes__46053.1624484515.500.750.jpg?c=2', 0),
(27, 2, 'Gretsch G2622T Streamliner Center Block Guitar', 'Gretsch', 'G2622T Streamliner', 'Semi-hollowbody electric guitar with authentic Gretsch sound', 1, 649.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1361/images/3761/Gretsch-G2622T-Streamliner-Center-Block-with-Bigsby-Flagstaff-Sunset__70995.1624476150.500.750.jpg?c=2', 0),
(28, 4, 'Selmer Paris Series III Alto Saxophone', 'Selmer Paris', 'Series III', 'Professional alto saxophone with exceptional tone and response', 1, 4599.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1354/images/3754/Selmer-Paris-Series-III-Model-62-Professional-Alto-Saxophone__09788.1624473942.500.750.jpg?c=2', 0),
(29, 3, 'Yamaha PSR-E373 Portable Keyboard', 'Yamaha', 'PSR-E373', 'Entry-level portable keyboard with a wide range of features', 1, 199.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1363/images/3763/Yamaha-PSR-E373-61-Key-Portable-Keyboard__98733.1624477148.500.750.jpg?c=2', 0),
(25, 1, 'Ludwig Breakbeats by Questlove Drum Kit', 'Ludwig', 'Breakbeats', 'Compact and portable drum kit designed by Questlove', 1, 399.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1359/images/3759/Ludwig-Breakbeats-by-Questlove-4-Piece-Drum-Kit__81295.1624474840.500.750.jpg?c=2', 0),
(26, 2, 'Fender Player Stratocaster Electric Guitar', 'Fender', 'Player Stratocaster', 'Versatile electric guitar with classic Stratocaster design and tone', 1, 749.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1355/images/3755/Fender-Player-Stratocaster-HSS-Pau-Ferro-Fingerboard-Polar-White__05912.1624473955.500.750.jpg?c=2', 0),
(27, 3, 'Roland FP-30X Digital Piano', 'Roland', 'FP-30X', 'Compact and affordable digital piano with authentic piano sound', 1, 699.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1367/images/3767/Roland-FP-30X-Digital-Piano-Black__21118.1624485253.500.750.jpg?c=2', 0),
(28, 4, 'Buffet Crampon ICON Clarinet', 'Buffet Crampon', 'ICON', 'Professional clarinet with innovative design and exceptional tone', 1, 4199.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1364/images/3764/Buffet-Crampon-ICON-Bb-Clarinet__10642.1624476934.500.750.jpg?c', 0),
(25, 1, 'Mapex Armory Series Drum Kit', 'Mapex', 'Armory Series', 'Versatile drum kit with hybrid shells for balanced tone', 1, 999.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1347/images/3747/Mapex-Armory-6-Piece-Studioease-Fast-Tom-Shell-Kit-Bombshell-Black__50676.1624471135.500.750.jpg?c=2', 0),
(26, 2, 'Epiphone Les Paul Studio Electric Guitar', 'Epiphone', 'Les Paul Studio', 'Affordable electric guitar with classic Les Paul design', 1, 449.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1352/images/3752/Epiphone-Les-Paul-Studio-LT-Electric-Guitar-Ebony__03878.1624473636.500.750.jpg?c=2', 0),
(27, 3, 'Korg Minilogue XD Polyphonic Analog Synthesizer', 'Korg', 'Minilogue XD', 'Polyphonic analog synthesizer with digital multi-engine', 1, 649.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1349/images/3749/Korg-Minilogue-XD-Polyphonic-Analog-Synthesizer__18711.1624472611.500.750.jpg?c=2', 0),
(25, 4, 'Yamaha YTS-480 Intermediate Tenor Saxophone', 'Yamaha', 'YTS-480', 'Intermediate tenor saxophone with excellent tone and playability', 1, 2389.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1357/images/3757/Yamaha-YTS-480-Intermediate-Tenor-Saxophone__81954.1624474663.500.750.jpg?c=2', 0),
(26, 1, 'Ludwig Evolution Maple Drum Kit', 'Ludwig', 'Evolution Maple', 'High-quality drum kit with maple shells for warm tone', 1, 1399.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1362/images/3762/Ludwig-Evolution-Maple-5-Piece-Drum-Set-with-Hardware-Heritage-Drum__47261.1624476745.500.750.jpg?c=2', 0),
(27, 2, 'PRS SE Custom 22 Electric Guitar', 'PRS', 'SE Custom 22', 'Versatile electric guitar with smooth playability and tone', 1, 799.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1351/images/3751/PRS-SE-Custom-22-Electric-Guitar-Gray-Black__46395.1624473512.500.750.jpg?c=2', 0),
(25, 3, 'Casio CT-X700 Portable Keyboard', 'Casio', 'CT-X700', 'Affordable portable keyboard with expressive sound and features', 1, 174.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1368/images/3768/Casio-CT-X700-61-Key-Portable-Keyboard__17052.1624480467.500.750.jpg?c=2', 0),
(26, 4, 'Buffet Crampon Tradition Clarinet', 'Buffet Crampon', 'Tradition', 'Professional clarinet with rich tone and enhanced resonance', 1, 4449.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1346/images/3746/Buffet-Crampon-Tradition-Bb-Clarinet__81095.1624470848.500.750.jpg?c=2', 0),
(27, 1, 'Pearl Export EXX Drum Kit', 'Pearl', 'Export EXX', 'Popular drum kit series known for its reliability and quality', 1, 849.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1356/images/3756/Pearl-Export-EXX-5-Piece-Drum-Set-with-Hardware-Pure-White__69928.1624474483.500.750.jpg?c=2', 0),
(25, 2, 'Ibanez RG Series Electric Guitar', 'Ibanez', 'RG Series', 'High-performance electric guitar designed for metal and rock', 1, 599.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1348/images/3748/Ibanez-RG550-Road-Flare-Red-Electric-Guitar__69917.1624471282.500.750.jpg?c=2', 0),
(26, 3, 'Roland JUNO-DS61 Synthesizer', 'Roland', 'JUNO-DS61', '61-key synthesizer with versatile sounds and performance features', 1, 699.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1365/images/3765/Roland-JUNO-DS61-Synthesizer__25671.1624474056.500.750.jpg?c=2', 0),
(27, 4, 'Yamaha YAS-280 Student Alto Saxophone', 'Yamaha', 'YAS-280', 'Student alto saxophone with excellent intonation and playability', 1, 1495.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1360/images/3760/Yamaha-YAS-280-Student-Alto-Saxophone__99413.1624475276.500.750.jpg?c=2', 0),
(25, 1, 'Gretsch Catalina Maple Drum Kit', 'Gretsch', 'Catalina Maple', 'Versatile drum kit with warm maple shells and classic tone', 1, 749.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1345/images/3745/Gretsch-Catalina-Maple-7-Piece-Drum-Set-with-Hardware-Satin-Deep-Maple__01245.1624470846.500.750.jpg?c=2', 0),
(26, 2, 'Fender Telecaster Electric Guitar', 'Fender', 'Telecaster', 'Iconic electric guitar with timeless design and versatile tone', 1, 999.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1343/images/3743/Fender-Player-Telecaster-Electric-Guitar-Maple-Fingerboard-Buttercream__13219.1624471262.500.750.jpg?c=2', 0),
(27, 3, 'Kawai KDP70 Digital Piano', 'Kawai', 'KDP70', 'Affordable digital piano with realistic piano sound and touch', 1, 799.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1358/images/3758/Kawai-KDP70-Digital-Piano-Black__30921.1624473907.500.750.jpg?c=2', 0),
(25, 4, 'Buffet Crampon R13 Prestige Clarinet', 'Buffet Crampon', 'R13 Prestige', 'Professional clarinet with exceptional tone and craftsmanship', 1, 5999.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1344/images/3744/Buffet-Crampon-R13-Prestige-Professional-Bb-Clarinet__89268.1624470842.500.750.jpg?c=2', 0),
(26, 1, 'Tama Silverstar Drum Kit', 'Tama', 'Silverstar', 'High-quality drum kit with birch shells for focused tone', 1, 899.99, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1342/images/3742/Tama-Silverstar-4-Piece-Shell-Pack__28019.1624471260.500.750.jpg?c=2', 0),
(27, 2, 'Gibson SG Standard Electric Guitar', 'Gibson', 'SG Standard', 'Classic electric guitar with iconic design and powerful tone', 1, 1499.00, 1, 1, 'https://cdn11.bigcommerce.com/s-n3f5sr6i/products/1341/images/3741/Gibson-SG-Standard-Electric-Guitar-Heritage-Cherry__68417.1624470835.500.750.jpg?c=2', 0);


-- PUT THESE IN A SHELL AND THEY WILL INSERT. This plugin won't execute the whole thing
INSERT INTO reverb_instrument_attributes (instrument_id, attribute_key, attribute_value, display_order) VALUES
-- Attributes for Mapex Drum Kit (instrument_id 11)
(11, 'Drum Configuration', '5-Piece', 1),
(11, 'Drum Shell Material', 'Maple', 2),
(11, 'Finish', 'Black Sparkle', 3),
(11, 'Hardware Finish', 'Chrome', 4),
(11, 'Tom Sizes', '8", 10", 12", 14", 16"', 5),

-- Attributes for Fender Stratocaster (instrument_id 12)
(12, 'Body Material', 'Alder', 6),
(12, 'Neck Material', 'Maple', 7),
(12, 'Fretboard Material', 'Rosewood', 8),
(12, 'Pickup Configuration', 'SSS', 9),
(12, 'Bridge Type', 'Tremolo', 10),
(12, 'Number of Frets', '22', 11),
(12, 'Scale Length', '25.5"', 12),

-- Attributes for Roland Juno-DS (instrument_id 13)
(13, 'Polyphony', '128', 13),
(13, 'Number of Keys', '61', 14),
(13, 'Sound Engine', 'Digital', 15),
(13, 'Effects', 'Reverb, Chorus, Delay', 16),
(13, 'Sequencer', 'Yes', 17),

-- Attributes for Yamaha YCL-255 Clarinet (instrument_id 14)
(14, 'Key System', 'Boehm (French)', 18),
(14, 'Body Material', 'ABS Resin', 19),
(14, 'Key Material', 'Nickel-plated', 20),
(14, 'Tone Holes', 'Undercut', 21),
(14, 'Thumb Rest', 'Adjustable', 22),

-- Attributes for DW Collector's Series Drum Kit (instrument_id 15)
(15, 'Drum Configuration', '4-Piece', 23),
(15, 'Drum Shell Material', 'Maple', 24),
(15, 'Finish', 'Natural Lacquer', 25),
(15, 'Hardware Finish', 'Gold', 26),
(15, 'Tom Sizes', '10", 12", 14", 16"', 27),

-- Attributes for Gibson Les Paul Standard (instrument_id 16)
(16, 'Body Material', 'Mahogany', 28),
(16, 'Top Material', 'Maple', 29),
(16, 'Neck Material', 'Mahogany', 30),
(16, 'Fretboard Material', 'Rosewood', 31),
(16, 'Pickup Configuration', 'HH', 32),

-- Attributes for Korg Kronos (instrument_id 17)
(17, 'Number of Keys', '88', 33),
(17, 'Sound Engine', 'Synthesis', 34),
(17, 'Polyphony', '120', 35),
(17, 'Effects', 'Numerous', 36),
(17, 'Sequencer', 'Yes', 37),

-- Attributes for Buffet Crampon R13 Clarinet (instrument_id 18)
(18, 'Key System', 'Boehm (French)', 38),
(18, 'Body Material', 'Grenadilla Wood', 39),
(18, 'Key Material', 'Silver-plated', 40),
(18, 'Tone Holes', 'Undercut', 41),
(18, 'Thumb Rest', 'Adjustable', 42),

-- Attributes for Pearl Export Drum Kit (instrument_id 19)
(19, 'Drum Configuration', '5-Piece', 43),
(19, 'Drum Shell Material', 'Poplar', 44),
(19, 'Finish', 'Jet Black', 45),
(19, 'Hardware Finish', 'Chrome', 46),
(19, 'Tom Sizes', '10", 12", 14", 16"', 47),

-- Attributes for Taylor 314ce Acoustic Guitar (instrument_id 20)
(20, 'Body Shape', 'Grand Auditorium', 48),
(20, 'Top Material', 'Sitka Spruce', 49),
(20, 'Body Material', 'Sapele', 50),
(20, 'Neck Material', 'Tropical Mahogany', 51),
(20, 'Fretboard Material', 'Ebony', 52),
(20, 'Number of Frets', '20', 53),
(20, 'Scale Length', '25.5"', 54),

-- Attributes for Kawai ES110 Digital Piano (instrument_id 21)
(21, 'Number of Keys', '88', 55),
(21, 'Action', 'Responsive Hammer Compact', 56),
(21, 'Sound Engine', 'Harmonic Imaging', 57),
(21, 'Polyphony', '192', 58),
(21, 'Built-in Songs', '19', 59),

-- Attributes for Tama Superstar Classic Drum Kit (instrument_id 22)
(22, 'Drum Configuration', '5-Piece', 60),
(22, 'Drum Shell Material', 'Birch', 61),
(22, 'Finish', 'Vintage Blue Sparkle', 62),
(22, 'Hardware Finish', 'Chrome', 63),
(22, 'Tom Sizes', '8", 10", 12", 14", 16"', 64),

-- Attributes for Gretsch G2622T Streamliner Center Block Guitar (instrument_id 23)
(23, 'Body Material', 'Maple', 65),
(23, 'Top Material', 'Maple', 66),
(23, 'Body Shape', 'Double Cutaway', 67),
(23, 'Neck Material', 'Nato', 68),
(23, 'Fretboard Material', 'Laurel', 69),
(23, 'Number of Frets', '22', 70),
(23, 'Scale Length', '24.75"', 71),

-- Attributes for Selmer Paris Series III Alto Saxophone (instrument_id 24)
(24, 'Key Finish', 'Gold Lacquer', 72),
(24, 'Body Material', 'Yellow Brass', 73),
(24, 'Key Material', 'Yellow Brass', 74),
(24, 'Tone Holes', 'Drawn', 75),
(24, 'Thumb Rest', 'Adjustable', 76),

-- Attributes for Yamaha PSR-E373 Portable Keyboard (instrument_id 25)
(25, 'Number of Keys', '61', 77),
(25, 'Polyphony', '48', 78),
(25, 'Voices', '622', 79),
(25, 'Styles', '205', 80),
(25, 'Duo Mode', 'Yes', 81),

-- Attributes for Ludwig Breakbeats by Questlove Drum Kit (instrument_id 26)
(26, 'Drum Configuration', '4-Piece', 82),
(26, 'Drum Shell Material', 'Poplar', 83),
(26, 'Finish', 'Azure Sparkle', 84),
(26, 'Hardware Finish', 'Black', 85),
(26, 'Tom Sizes', '10", 13", 16"', 86),

-- Attributes for Fender Player Stratocaster Electric Guitar (instrument_id 27)
(27, 'Body Material', 'Alder', 87),
(27, 'Neck Material', 'Maple', 88),
(27, 'Fretboard Material', 'Pau Ferro', 89),
(27, 'Pickup Configuration', 'SSS', 90),
(27, 'Bridge Type', 'Tremolo', 91),
(27, 'Number of Frets', '22', 92),
(27, 'Scale Length', '25.5"', 93),

-- Attributes for Roland FP-30X Digital Piano (instrument_id 28)
(28, 'Number of Keys', '88', 94),
(28, 'Action', 'PHA-4 Standard', 95),
(28, 'Sound Engine', 'SuperNATURAL', 96),
(28, 'Polyphony', '256', 97),
(28, 'Built-in Songs', '100', 98),

-- Attributes for Buffet Crampon ICON Clarinet (instrument_id 29)
(29, 'Key System', 'Boehm (French)', 99),
(29, 'Body Material', 'Grenadilla Wood', 100),
(29, 'Key Material', 'Silver-plated', 101),
(29, 'Tone Holes', 'Undercut', 102),
(29, 'Thumb Rest', 'Adjustable', 103),

-- Attributes for Mapex Armory Series Drum Kit (instrument_id 30)
(30, 'Drum Configuration', '6-Piece', 104),
(30, 'Drum Shell Material', 'Birch', 105),
(30, 'Finish', 'Transparent Walnut', 106),
(30, 'Hardware Finish', 'Black', 107),
(30, 'Tom Sizes', '10", 12", 14", 16"', 108),

-- Attributes for Epiphone Les Paul Studio Electric Guitar (instrument_id 31)
(31, 'Body Material', 'Mahogany', 109),
(31, 'Top Material', 'Maple', 110),
(31, 'Neck Material', 'Mahogany', 111),
(31, 'Fretboard Material', 'Pau Ferro', 112),
(31, 'Pickup Configuration', 'HH', 113),

-- Attributes for Korg Minilogue XD Polyphonic Analog Synthesizer (instrument_id 32)
(32, 'Polyphony', '4-Voice', 114),
(32, 'Oscillators', '2', 115),
(32, 'Filter Types', 'Low Pass, High Pass, Band Pass', 116),
(32, 'Sequencer', '16-Step', 117),
(32, 'Effects', 'Modulation, Delay, Reverb', 118),

-- Attributes for Yamaha YTS-480 Intermediate Tenor Saxophone (instrument_id 33)
(33, 'Key Finish', 'Gold Lacquer', 119),
(33, 'Body Material', 'Yellow Brass', 120),
(33, 'Key Material', 'Yellow Brass', 121),
(33, 'Tone Holes', 'Drawn', 122),
(33, 'Thumb Rest', 'Adjustable', 123),

-- Attributes for Ludwig Evolution Maple Drum Kit (instrument_id 34)
(34, 'Drum Configuration', '5-Piece', 124),
(34, 'Drum Shell Material', 'Maple', 125),
(34, 'Finish', 'Black Sparkle', 126),
(34, 'Hardware Finish', 'Chrome', 127),
(34, 'Tom Sizes', '8", 10", 12", 14", 16"', 128),

-- Attributes for PRS SE Custom 22 Electric Guitar (instrument_id 35)
(35, 'Body Material', 'Mahogany', 129),
(35, 'Top Material', 'Maple', 130),
(35, 'Neck Material', 'Maple', 131),
(35, 'Fretboard Material', 'Rosewood', 132),
(35, 'Pickup Configuration', 'HH', 133),

-- Attributes for Casio CT-X700 Portable Keyboard (instrument_id 36)
(36, 'Number of Keys', '61', 134),
(36, 'Polyphony', '48', 135),
(36, 'Voices', '600', 136),
(36, 'Rhythms', '195', 137),
(36, 'Lesson Function', 'Yes', 138),

-- Attributes for Buffet Crampon Tradition Clarinet (instrument_id 37)
(37, 'Key System', 'Boehm (French)', 139),
(37, 'Body Material', 'Grenadilla Wood', 140),
(37, 'Key Material', 'Silver-plated', 141),
(37, 'Tone Holes', 'Undercut', 142),
(37, 'Thumb Rest', 'Adjustable', 143),

-- Attributes for Pearl Export EXX Drum Kit (instrument_id 38)
(38, 'Drum Configuration', '5-Piece', 144),
(38, 'Drum Shell Material', 'Poplar', 145),
(38, 'Finish', 'Smokey Chrome', 146),
(38, 'Hardware Finish', 'Black', 147),
(38, 'Tom Sizes', '10", 12", 14", 16"', 148),

-- Attributes for Ibanez RG Series Electric Guitar (instrument_id 39)
(39, 'Body Material', 'Mahogany', 149),
(39, 'Top Material', 'Maple', 150),
(39, 'Neck Material', 'Maple', 151),
(39, 'Fretboard Material', 'Rosewood', 152),
(39, 'Pickup Configuration', 'HH', 153),

-- Attributes for Roland JUNO-DS61 Synthesizer (instrument_id 40)
(40, 'Polyphony', '128', 154),
(40, 'Number of Keys', '61', 155),
(40, 'Sound Engine', 'Digital', 156),
(40, 'Effects', 'Reverb, Chorus, Delay', 157),
(40, 'Sequencer', 'Yes', 158),

-- Attributes for Yamaha YAS-280 Student Alto Saxophone (instrument_id 41)
(41, 'Key Finish', 'Gold Lacquer', 159),
(41, 'Body Material', 'Yellow Brass', 160),
(41, 'Key Material', 'Yellow Brass', 161),
(41, 'Tone Holes', 'Drawn', 162),
(41, 'Thumb Rest', 'Adjustable', 163),

-- Attributes for Gretsch Catalina Maple Drum Kit (instrument_id 42)
(42, 'Drum Configuration', '6-Piece', 164),
(42, 'Drum Shell Material', 'Maple', 165),
(42, 'Finish', 'Walnut Glaze', 166),
(42, 'Hardware Finish', 'Chrome', 167),
(42, 'Tom Sizes', '8", 10", 12", 14", 16"', 168),

-- Attributes for Fender Telecaster Electric Guitar (instrument_id 43)
(43, 'Body Material', 'Alder', 169),
(43, 'Neck Material', 'Maple', 170),
(43, 'Fretboard Material', 'Maple', 171),
(43, 'Pickup Configuration', 'SS', 172),
(43, 'Bridge Type', 'Fixed', 173),

-- Attributes for Kawai KDP70 Digital Piano (instrument_id 44)
(44, 'Number of Keys', '88', 174),
(44, 'Action', 'Responsive Hammer Compact', 175),
(44, 'Sound Engine', 'Harmonic Imaging', 176),
(44, 'Polyphony', '192', 177),
(44, 'Built-in Songs', '15', 178),

-- Attributes for Buffet Crampon R13 Prestige Clarinet (instrument_id 45)
(45, 'Key System', 'Boehm (French)', 179),
(45, 'Body Material', 'Grenadilla Wood', 180),
(45, 'Key Material', 'Silver-plated', 181),
(45, 'Tone Holes', 'Undercut', 182),
(45, 'Thumb Rest', 'Adjustable', 183),

-- Attributes for Tama Silverstar Drum Kit (instrument_id 46)
(46, 'Drum Configuration', '4-Piece', 184),
(46, 'Drum Shell Material', 'Birch', 185),
(46, 'Finish', 'Vintage Burgundy Sparkle', 186),
(46, 'Hardware Finish', 'Black Nickel', 187),
(46, 'Tom Sizes', '10", 12", 14", 16"', 188),

-- Attributes for Gibson SG Standard Electric Guitar (instrument_id 47)
(47, 'Body Material', 'Mahogany', 189),
(47, 'Neck Material', 'Mahogany', 190),
(47, 'Fretboard Material', 'Rosewood', 191),
(47, 'Pickup Configuration', 'HH', 192),
(47, 'Bridge Type', 'Fixed', 193),
(47, 'Number of Frets', '22', 194),
(47, 'Scale Length', '24.75"', 195);

INSERT INTO reverb_instrument_attributes (instrument_id, attribute_key, attribute_value, display_order) VALUES
(12, 'Body Color', 'Red', 196),
(16, 'Body Color', 'Black', 197),
(20, 'Body Color', 'White', 198),
(23, 'Body Color', 'Blue Floral Pattern', 199),
(27, 'Body Color', 'Seafoam Green', 200),
(31, 'Body Color', 'Red', 201),
(35, 'Body Color', 'Black', 202),
(39, 'Body Color', 'White', 203),
(43, 'Body Color', 'Blue Floral Pattern', 204),
(47, 'Body Color', 'Seafoam Green', 205);