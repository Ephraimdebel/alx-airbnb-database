# Database Schema (DDL)

This folder contains the SQL scripts to create the Airbnb database schema.

## Contents

- `schema.sql`: SQL statements to create tables, define primary keys, foreign keys, and indexes.

## Design Highlights

- User table stores all user information with UNIQUE index on email.
- Property table references User as host_id (foreign key).
- Booking table references both User and Property.
- Payment table enforces one payment per booking (UNIQUE constraint on booking_id).
- Review table links users to properties with ratings (1-5).
- Message table is self-referencing (sender_id and recipient_id pointing to User).

All tables are designed in **3NF**, ensuring no redundancy and optimized relationships.
