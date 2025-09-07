# Query Optimization Report

## Initial Query
- Joined Booking, User, Property, and Payment tables.  
- Observed large sequential scans in Booking and Payment tables.  
- Execution time: ~250ms for dataset of 10000 bookings.

## Optimized Query
- Added filtering on start_date to reduce row scans.  
- Used USING() for simpler joins.  
- Ensured indexes exist on key columns (user_id, property_id, booking_id, start_date).  
- Execution time: ~15ms for the same dataset.

## Conclusion
- Filtering early and using indexed columns significantly reduced query execution time.  
- Using LEFT JOIN only where necessary prevents unnecessary row processing.  
- Simplifying joins improves readability without affecting results.
