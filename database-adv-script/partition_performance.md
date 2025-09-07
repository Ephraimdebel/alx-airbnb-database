# Partitioning Performance Report

## Objective
The objective of this task was to implement **table partitioning** on the `Booking` table based on the `start_date` column to improve query performance on large datasets.

## Approach
1. Created a new partitioned table `Booking_Partitioned` using **RANGE partitioning** on `start_date`.  
2. Defined yearly partitions (`Booking_2025`, `Booking_2026`) to store bookings for specific years.  
3. Migrated existing data from the original `Booking` table into the partitioned table.  
4. Tested query performance using **EXPLAIN ANALYZE** for date-based queries.

## Observations
- **Before partitioning**: Queries scanning large date ranges had to sequentially scan the entire `Booking` table, resulting in slower execution times.  
- **After partitioning**: Queries targeting a specific year only scanned the corresponding partition, reducing the number of rows scanned.  
- Execution times decreased noticeably, especially for queries that only needed a subset of the data.

## Example Queries
```sql
-- Fetch bookings in January 2025
EXPLAIN ANALYZE
SELECT *
FROM Booking_Partitioned
WHERE start_date BETWEEN '2025-01-01' AND '2025-01-31';

-- Fetch bookings in May 2026
EXPLAIN ANALYZE
SELECT *
FROM Booking_Partitioned
WHERE start_date BETWEEN '2026-05-01' AND '2026-05-31';
