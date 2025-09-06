# Advanced SQL Joins – Airbnb Database

This project implements complex SQL queries using **INNER JOIN**, **LEFT JOIN**, and **FULL OUTER JOIN** on an Airbnb-style database schema.

## Queries Implemented

### 1. INNER JOIN – Bookings with Users

Retrieves all bookings and the respective users who made them.

- Ensures that only bookings linked to existing users appear.

```sql
SELECT b.id, b.property_id, b.start_date, b.end_date, u.username, u.email
FROM bookings b
INNER JOIN users u ON b.user_id = u.id;

```

### 1. LEFT JOIN – Properties with Reviews

Retrieves all properties and their reviews, including properties with no reviews.

- Useful to identify unrated or new properties.

```
SELECT p.id, p.title, r.rating, r.comment
FROM properties p
LEFT JOIN reviews r ON p.id = r.property_id;

```
### 1. FULL OUTER JOIN – Users and Bookings

Retrieves all users and all bookings.
 - Includes users with no bookings and bookings without valid users.

 ```
 SELECT u.id, u.username, b.id, b.property_id, b.start_date, b.end_date
FROM users u
FULL OUTER JOIN bookings b ON u.id = b.user_id;

```

Files

 - joins_queries.sql → contains all SQL join queries.

 - README.md → documentation of queries with explanations.

How to Run

Run the queries in your SQL client after setting up the Airbnb database schema:
```
mysql -u root -p airbnb < joins_queries.sql

```