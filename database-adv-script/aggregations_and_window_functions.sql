-- Task 2: Apply Aggregations and Window Functions

-- Aggregation: Find the total number of bookings made by each user
SELECT u.user_id, u.first_name, u.last_name, COUNT(b.booking_id) AS total_bookings
FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name;

-- Window Function: Rank properties based on the total number of bookings they have received
SELECT p.property_id, p.name, COUNT(b.booking_id) AS total_bookings,
       RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name;

-- Window Function: Assign row numbers to properties based on booking count (no ties)
SELECT p.property_id, p.name, COUNT(b.booking_id) AS total_bookings,
       ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC, p.property_id) AS row_num
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name;
