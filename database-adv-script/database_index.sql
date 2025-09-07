-- Task 3: Implement Indexes for Optimization

-- Performance measurement queries (run these BEFORE creating indexes)

-- Query 1: User lookup by email (should use idx_user_email)
-- BEFORE INDEX: EXPLAIN ANALYZE
EXPLAIN SELECT * FROM User WHERE email = 'user@example.com';

-- Query 2: Bookings for a specific user (should use idx_booking_user_id)
-- BEFORE INDEX: EXPLAIN ANALYZE
EXPLAIN SELECT * FROM Booking WHERE user_id = 1;

-- Query 3: Properties in a specific city (should use idx_property_city)
-- BEFORE INDEX: EXPLAIN ANALYZE
EXPLAIN SELECT * FROM Property WHERE city = 'New York';

-- Query 4: Date range bookings (should use idx_booking_start_date)
-- BEFORE INDEX: EXPLAIN ANALYZE
EXPLAIN SELECT * FROM Booking WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Query 5: Reviews for a property (should use idx_review_property_id)
-- BEFORE INDEX: EXPLAIN ANALYZE
EXPLAIN SELECT * FROM Review WHERE property_id = 1;

-- Create indexes for high-usage columns

-- Index on User table for email (used in WHERE clauses)
CREATE INDEX idx_user_email ON User(email);

-- Index on Booking table for user_id (used in JOINs)
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on Booking table for property_id (used in JOINs)
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index on Booking table for start_date (used in WHERE and ORDER BY for date ranges)
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- Index on Property table for city (used in WHERE clauses for location-based searches)
CREATE INDEX idx_property_city ON Property(city);

-- Index on Review table for property_id (used in JOINs)
CREATE INDEX idx_review_property_id ON Review(property_id);

-- Performance measurement queries (run these AFTER creating indexes)

-- Query 1: User lookup by email (should now use idx_user_email)
-- AFTER INDEX: EXPLAIN ANALYZE
EXPLAIN SELECT * FROM User WHERE email = 'user@example.com';

-- Query 2: Bookings for a specific user (should now use idx_booking_user_id)
-- AFTER INDEX: EXPLAIN ANALYZE
EXPLAIN SELECT * FROM Booking WHERE user_id = 1;

-- Query 3: Properties in a specific city (should now use idx_property_city)
-- AFTER INDEX: EXPLAIN ANALYZE
EXPLAIN SELECT * FROM Property WHERE city = 'New York';

-- Query 4: Date range bookings (should now use idx_booking_start_date)
-- AFTER INDEX: EXPLAIN ANALYZE
EXPLAIN SELECT * FROM Booking WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Query 5: Reviews for a property (should now use idx_review_property_id)
-- AFTER INDEX: EXPLAIN ANALYZE
EXPLAIN SELECT * FROM Review WHERE property_id = 1;

-- Complex query demonstrating multiple index usage
-- BEFORE INDEX: EXPLAIN ANALYZE
EXPLAIN SELECT u.name, COUNT(b.id) as booking_count, AVG(p.price_per_night) as avg_price
FROM User u
JOIN Booking b ON u.id = b.user_id
JOIN Property p ON b.property_id = p.id
WHERE u.email LIKE '%@gmail.com%'
  AND b.start_date >= '2024-01-01'
  AND p.city = 'New York'
GROUP BY u.id, u.name;

-- AFTER INDEX: EXPLAIN ANALYZE (run after creating all indexes)
EXPLAIN SELECT u.name, COUNT(b.id) as booking_count, AVG(p.price_per_night) as avg_price
FROM User u
JOIN Booking b ON u.id = b.user_id
JOIN Property p ON b.property_id = p.id
WHERE u.email LIKE '%@gmail.com%'
  AND b.start_date >= '2024-01-01'
  AND p.city = 'New York'
GROUP BY u.id, u.name;
