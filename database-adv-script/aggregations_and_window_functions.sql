-- Task 2: Apply Aggregations and Window Functions

-- Aggregation: Find the total number of bookings made by each user
SELECT u.id AS user_id, u.name AS first_name, COUNT(b.id) AS total_bookings
FROM User u
LEFT JOIN Booking b ON u.id = b.user_id
GROUP BY u.id, u.name;

-- Window Function: Rank properties based on the total number of bookings they have received
SELECT p.id AS property_id, p.title AS name, COUNT(b.id) AS total_bookings,
       RANK() OVER (ORDER BY COUNT(b.id) DESC) AS booking_rank
FROM Property p
LEFT JOIN Booking b ON p.id = b.property_id
GROUP BY p.id, p.title;

-- Window Function: Assign row numbers to properties based on booking count (no ties)
SELECT p.id AS property_id, p.title AS name, COUNT(b.id) AS total_bookings,
       ROW_NUMBER() OVER (ORDER BY COUNT(b.id) DESC, p.id) AS row_num
FROM Property p
LEFT JOIN Booking b ON p.id = b.property_id
GROUP BY p.id, p.title;
