# Database Performance Monitoring and Refinement

## Objective
Monitor the performance of frequently used queries on the Airbnb database and implement optimizations to improve efficiency.

## Step 1: Monitoring Query Performance
We used the following queries for monitoring performance:

### Query 1: Retrieve all bookings with user and property details
```sql
EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date,
       u.user_id, u.first_name, u.email,
       p.property_id, p.name AS property_name, p.location
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id;
```
### Query 2: Retrieve all properties and their reviews

```EXPLAIN ANALYZE
SELECT p.property_id, p.name, p.location,
       r.review_id, r.rating, r.comment
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
ORDER BY p.property_id;
```
## Step 2: Identifying Bottlenecks

From the EXPLAIN ANALYZE results:

Queries on Booking scanning all rows were slower due to large table size.

Joins on Property and Review tables occasionally required sequential scans.

Ordering large datasets without indexes caused additional overhead.

## Step 3: Refinements

Implemented the following optimizations:

Indexes added
```
CREATE INDEX idx_booking_start_date ON Booking(start_date);
CREATE INDEX idx_review_property_id ON Review(property_id);
```

Partitioning
The Booking table was partitioned by start_date to reduce scan time for date-range queries.

Optimized queries

Used USING for joins where applicable.

Added WHERE clauses to filter data early.

## Step 4: Performance Improvements

After applying indexes and partitioning:

Query execution times dropped significantly for date-range and join queries.

EXPLAIN ANALYZE showed fewer rows scanned and better utilization of indexes.

The system is now more scalable for large datasets.

## Step 5: Conclusion

Regular monitoring using EXPLAIN ANALYZE allowed identification of bottlenecks. Adding indexes, partitioning, and optimizing query structure improved database performance and ensured the backend can handle growing data efficiently.