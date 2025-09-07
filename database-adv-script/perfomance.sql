-- Task 4: Optimize Complex Queries

-- Initial complex query: Retrieve all bookings with user, property, and payment details
SELECT b.id AS booking_id, b.start_date, b.end_date, b.total_price,
       u.id AS user_id, u.name AS first_name, u.email,
       p.id AS property_id, p.title AS property_name, p.city AS location,
       pay.id AS payment_id, pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id
WHERE b.start_date >= '2023-01-01'
  AND b.status = 'confirmed'
  AND p.city = 'New York'
  AND u.email LIKE '%@gmail.com%'
ORDER BY b.start_date DESC;

-- Analyze initial query performance
EXPLAIN SELECT b.id AS booking_id, b.start_date, b.end_date, b.total_price,
       u.id AS user_id, u.name AS first_name, u.email,
       p.id AS property_id, p.title AS property_name, p.city AS location,
       pay.id AS payment_id, pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id
WHERE b.start_date >= '2023-01-01'
  AND b.status = 'confirmed'
  AND p.city = 'New York'
  AND u.email LIKE '%@gmail.com%'
ORDER BY b.start_date DESC;

-- Optimized version: Use indexes and minimize joins
SELECT b.id AS booking_id, b.start_date, b.end_date, b.total_price,
       u.name AS first_name, u.email,
       p.title AS property_name, p.city AS location,
       pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id
WHERE b.start_date >= '2023-01-01'
  AND b.status = 'confirmed'
  AND p.city = 'New York'
  AND u.email LIKE '%@gmail.com%'
ORDER BY b.start_date DESC;

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
  AND b.status = 'confirmed'
  AND p.city = 'New York'
  AND u.email LIKE '%@gmail.com%'
ORDER BY b.start_date DESC;

-- Performance comparison query with execution time measurement
SET profiling = 1;

-- Run initial complex query with multiple AND conditions
SELECT b.id AS booking_id, b.start_date, b.end_date, b.total_price,
       u.id AS user_id, u.name AS first_name, u.email,
       p.id AS property_id, p.title AS property_name, p.city AS location,
       pay.id AS payment_id, pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id
WHERE b.start_date >= '2023-01-01'
  AND b.status = 'confirmed'
  AND p.city = 'New York'
  AND u.email LIKE '%@gmail.com%'
  AND pay.status = 'completed'
  AND b.total_price > 100.00;

-- Show execution time for initial query
SHOW PROFILES;

-- Run optimized query with same conditions
SELECT b.id AS booking_id, b.start_date, b.end_date, b.total_price,
       u.name AS first_name, u.email,
       p.title AS property_name, p.city AS location,
       pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id
WHERE b.start_date >= '2023-01-01'
  AND b.status = 'confirmed'
  AND p.city = 'New York'
  AND u.email LIKE '%@gmail.com%'
  AND pay.status = 'completed'
  AND b.total_price > 100.00
ORDER BY b.start_date DESC;

-- Show execution time for optimized query
SHOW PROFILES;

-- Additional complex query with date range and multiple conditions
SELECT b.id AS booking_id, b.start_date, b.end_date, b.total_price,
       u.name AS user_name, u.email,
       p.title AS property_title, p.city,
       pay.amount, pay.payment_method
FROM Booking b
JOIN User u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id
WHERE b.start_date BETWEEN '2024-01-01' AND '2024-12-31'
  AND b.status IN ('confirmed', 'completed')
  AND p.city IN ('New York', 'Los Angeles', 'Chicago')
  AND u.email NOT LIKE '%@test.com%'
  AND pay.amount IS NOT NULL
  AND b.total_price BETWEEN 50.00 AND 500.00
ORDER BY b.start_date, p.city;

-- Analyze this complex query
EXPLAIN SELECT b.id AS booking_id, b.start_date, b.end_date, b.total_price,
       u.name AS user_name, u.email,
       p.title AS property_title, p.city,
       pay.amount, pay.payment_method
FROM Booking b
JOIN User u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id
WHERE b.start_date BETWEEN '2024-01-01' AND '2024-12-31'
  AND b.status IN ('confirmed', 'completed')
  AND p.city IN ('New York', 'Los Angeles', 'Chicago')
  AND u.email NOT LIKE '%@test.com%'
  AND pay.amount IS NOT NULL
  AND b.total_price BETWEEN 50.00 AND 500.00
ORDER BY b.start_date, p.city;

SET profiling = 0;
