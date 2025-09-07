-- Task 4: Optimize Complex Queries

-- Initial complex query: Retrieve all bookings with user, property, and payment details
SELECT b.booking_id, b.start_date, b.end_date, b.total_price,
       u.user_id, u.first_name, u.last_name, u.email,
       p.property_id, p.name AS property_name, p.location,
       pay.payment_id, pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;

-- Optimized version: Use indexes and minimize joins
SELECT b.booking_id, b.start_date, b.end_date, b.total_price,
       u.first_name, u.last_name, u.email,
       p.name AS property_name, p.location,
       pay.amount, pay.payment_date, pay.status
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= '2023-01-01'  -- Add date filter to leverage index
ORDER BY b.start_date;
