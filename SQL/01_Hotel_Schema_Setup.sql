-- USERS TABLE
CREATE TABLE users (
    user_id VARCHAR(50),
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

-- BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id VARCHAR(50),
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50)
);

-- ITEMS TABLE
CREATE TABLE items (
    item_id VARCHAR(50),
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

-- BOOKING COMMERCIALS
CREATE TABLE booking_commercials (
    id VARCHAR(50),
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2)
);

-- SAMPLE DATA
INSERT INTO users VALUES
('u1','John Doe','9999999999','john@mail.com','ABC City'),
('u2','Jane Smith','8888888888','jane@mail.com','XYZ City');

INSERT INTO bookings VALUES
('b1','2021-11-10 10:00:00','101','u1'),
('b2','2021-10-15 12:00:00','102','u2');

INSERT INTO items VALUES
('i1','Paratha',20),
('i2','Veg Curry',80);

INSERT INTO booking_commercials VALUES
('c1','b1','bill1','2021-11-10','i1',2),
('c2','b1','bill1','2021-11-10','i2',1),
('c3','b2','bill2','2021-10-15','i2',15);