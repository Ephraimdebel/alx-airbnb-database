-- seeds.sql
-- Insert users
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, role)
VALUES
  (uuid_generate_v4(), 'Ephraim', 'Debel', 'ephraim@example.com', 'hash1', 'host'),
  (uuid_generate_v4(), 'Sara', 'Guest', 'sara@example.com', 'hash2', 'guest');

-- Insert a property
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
VALUES
  (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email='ephraim@example.com'), 'Cozy Studio', 'A small studio...', 'Addis Ababa, ET', 25.00);

-- Booking
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  (uuid_generate_v4(),
   (SELECT property_id FROM Property WHERE name='Cozy Studio'),
   (SELECT user_id FROM "User" WHERE email='sara@example.com'),
   '2025-09-10', '2025-09-12', 50.00, 'confirmed');

-- Payment
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
  (uuid_generate_v4(), (SELECT booking_id FROM Booking WHERE total_price=50.00), 50.00, 'stripe');

-- Review
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
  (uuid_generate_v4(), (SELECT property_id FROM Property WHERE name='Cozy Studio'), (SELECT user_id FROM "User" WHERE email='sara@example.com'), 5, 'Great stay!');

-- Message
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
  (uuid_generate_v4(), (SELECT user_id FROM "User" WHERE email='sara@example.com'), (SELECT user_id FROM "User" WHERE email='ephraim@example.com'), 'Hi, I booked your place!');
