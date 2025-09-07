-- Task 4: Optimize Complex Queries

-- Initial complex query: Retrieve all bookings with user, property, and payment details
SELECT b.id AS booking_id, b.start_date, b.end_date, b.total_price,
       u.id AS user_id, u.name AS first_name, u.email,
       p.id AS property_id, p.title AS property_name, p.city AS location,
       pay.id AS payment_id, pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id;

-- Analyze initial query performance
EXPLAIN SELECT b.id AS booking_id, b.start_date, b.end_date, b.total_price,
       u.id AS user_id, u.name AS first_name, u.email,
       p.id AS property_id, p.title AS property_name, p.city AS location,
       pay.id AS payment_id, pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id;

-- Optimized version: Use indexes and minimize joins
SELECT b.id AS booking_id, b.start_date, b.end_date, b.total_price,
       u.name AS first_name, u.email,
       p.title AS property_name, p.city AS location,
       pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id
WHERE b.start_date >= '2023-01-01'  -- Add date filter to leverage index
ORDER BY b.start_date;

-- Analyze optimized query performance
EXPLAIN SELECT b.id AS booking_id, b.start_date, b.end_date, b.total_price,
       u.name AS first_name, u.email,
       p.title AS property_name, p.city AS location,
       pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id
WHERE b.start_date >= '2023-01-01'
ORDER BY b.start_date;

-- Performance comparison query with execution time measurement
SET profiling = 1;

-- Run initial query
SELECT b.booking_id, b.start_date, b.end_date, b.total_price,
       u.user_id, u.first_name, u.last_name, u.email,
       p.property_id, p.name AS property_name, p.location,
       pay.payment_id, pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;

-- Show execution time for initial query
SHOW PROFILES;

-- Run optimized query
SELECT b.booking_id, b.start_date, b.end_date, b.total_price,
       u.first_name, u.last_name, u.email,
       p.name AS property_name, p.location,
       pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= '2023-01-01'
ORDER BY b.start_date;

-- Show execution time for optimized query
SHOW PROFILES;

SET profiling = 0;
