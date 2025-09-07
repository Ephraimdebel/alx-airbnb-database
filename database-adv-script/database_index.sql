-- ================================
-- USER TABLE
-- ================================

-- Before index
EXPLAIN ANALYZE
SELECT * 
FROM User u
WHERE u.email = 'test@example.com';

-- Create index
CREATE INDEX idx_user_email ON User(email);

-- After index
EXPLAIN ANALYZE
SELECT * 
FROM User u
WHERE u.email = 'test@example.com';


-- ================================
-- BOOKING TABLE
-- ================================

-- Before index
EXPLAIN ANALYZE
SELECT * 
FROM Booking b
WHERE b.user_id = 1;

-- Create index
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- After index
EXPLAIN ANALYZE
SELECT * 
FROM Booking b
WHERE b.user_id = 1;


-- ================================
-- PROPERTY TABLE
-- ================================

-- Before index
EXPLAIN ANALYZE
SELECT * 
FROM Property p
WHERE p.location = 'Addis Ababa';

-- Create index
CREATE INDEX idx_property_location ON Property(location);

-- After index
EXPLAIN ANALYZE
SELECT * 
FROM Property p
WHERE p.location = 'Addis Ababa';
