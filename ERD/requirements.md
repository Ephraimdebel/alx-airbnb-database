# Airbnb Database – ERD & Requirements
<img width="1182" height="1002" alt="airbnb_ER_Diagram drawio" src="https://github.com/user-attachments/assets/ef3a578e-6f68-4ea0-9d38-e114dfceb4fd" />

## Project overview
A relational database model for an Airbnb-like system: users, properties, bookings, payments, reviews, and messaging.

## Files
- `airbnb-erd.png` — exported diagram image

## Entities & Attributes
### User
- user_id (PK, UUID, indexed)
- first_name (VARCHAR, NOT NULL)
- last_name (VARCHAR, NOT NULL)
- email (VARCHAR, UNIQUE, NOT NULL)
- password_hash (VARCHAR, NOT NULL)
- phone_number (VARCHAR, NULL)
- role (ENUM: guest|host|admin, NOT NULL)
- created_at (TIMESTAMP, DEFAULT now)

**Note:** INDEX: `email` (UNIQUE)

### Property
- property_id (PK, UUID, indexed)
- host_id (FK → User.user_id)
- name (VARCHAR, NOT NULL)
- description (TEXT, NOT NULL)
- location (VARCHAR, NOT NULL)
- price_per_night (DECIMAL, NOT NULL)
- created_at (TIMESTAMP, DEFAULT now)
- updated_at (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

### Booking
- booking_id (PK, UUID, indexed)
- property_id (FK → Property.property_id)
- user_id (FK → User.user_id)
- start_date (DATE, NOT NULL)
- end_date (DATE, NOT NULL)
- total_price (DECIMAL, NOT NULL)
- status (ENUM: pending|confirmed|canceled, NOT NULL)
- created_at (TIMESTAMP, DEFAULT now)

### Payment
- payment_id (PK, UUID, indexed)
- booking_id (FK → Booking.booking_id, UNIQUE)
- amount (DECIMAL, NOT NULL)
- payment_date (TIMESTAMP, DEFAULT now)
- payment_method (ENUM: credit_card|paypal|stripe, NOT NULL)

### Review
- review_id (PK, UUID, indexed)
- property_id (FK → Property.property_id)
- user_id (FK → User.user_id)
- rating (INT, CHECK 1..5, NOT NULL)
- comment (TEXT, NOT NULL)
- created_at (TIMESTAMP, DEFAULT now)

### Message
- message_id (PK, UUID, indexed)
- sender_id (FK → User.user_id)
- recipient_id (FK → User.user_id)
- message_body (TEXT, NOT NULL)
- sent_at (TIMESTAMP, DEFAULT now)

## Relationships & cardinalities (short)
- **User → Property**: One user (host) → *0..N properties* (property requires exactly 1 host).
- **User → Booking**: One user (guest) → *0..N bookings* (booking requires 1 user).
- **Property → Booking**: One property → *0..N bookings* (booking requires 1 property).
- **Booking → Payment**: One booking → *0..1 payment* (we assume single payment per booking). Payment requires 1 booking.
- **User → Review**: One user → *0..N reviews* (review requires 1 user).
- **Property → Review**: One property → *0..N reviews* (review requires 1 property).
- **User ↔ Message** (self-ref): Simplified many-to-many view — note: *Each Message has exactly one sender and one recipient; Users can send and receive many messages.* Label: **sends / receives**.

## Constraints & notes
- `User.email` UNIQUE
- `Payment.booking_id` UNIQUE (one payment per booking)
- `Booking.start_date < Booking.end_date`
- `Review.rating` 1..5
- Optional: UNIQUE (property_id, user_id) in Review to prevent duplicate reviews by same user
