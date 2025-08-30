-- schema.sql (PostgreSQL)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users
CREATE TABLE IF NOT EXISTS "User" (
  user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  phone_number VARCHAR(50),
  role VARCHAR(10) NOT NULL CHECK (role IN ('guest','host','admin')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Properties
CREATE TABLE IF NOT EXISTS Property (
  property_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  host_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR(255) NOT NULL,
  price_per_night DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bookings
CREATE TABLE IF NOT EXISTS Booking (
  booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  property_id UUID NOT NULL REFERENCES Property(property_id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  status VARCHAR(10) NOT NULL CHECK (status IN ('pending','confirmed','canceled')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CHECK (start_date < end_date)
);

-- Payments (one payment per booking)
CREATE TABLE IF NOT EXISTS Payment (
  payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  booking_id UUID NOT NULL UNIQUE REFERENCES Booking(booking_id) ON DELETE CASCADE,
  amount DECIMAL(10,2) NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card','paypal','stripe'))
);

-- Reviews
CREATE TABLE IF NOT EXISTS Review (
  review_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  property_id UUID NOT NULL REFERENCES Property(property_id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
  rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (property_id, user_id) -- optional: one review per user per property
);

-- Messages (self-referencing)
CREATE TABLE IF NOT EXISTS Message (
  message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  sender_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
  recipient_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_property_id ON Property(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_property ON Booking(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_user ON Booking(user_id);
