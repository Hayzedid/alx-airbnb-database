-- Task 0: Write Complex Queries with Joins

-- INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT b.id AS booking_id, b.start_date, b.end_date, u.id AS user_id, u.name AS first_name, u.email
FROM Booking b
INNER JOIN User u ON b.user_id = u.id;

-- LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews
SELECT p.id AS property_id, p.title AS property_name, p.city AS location, r.id AS review_id, r.rating, r.comment
FROM Property p
LEFT JOIN Review r ON p.id = r.property_id;

-- FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
-- MySQL doesn't support FULL OUTER JOIN directly, so we use UNION of LEFT and RIGHT JOINs
SELECT u.id AS user_id, u.name AS first_name, b.id AS booking_id, b.start_date, b.end_date
FROM User u
LEFT JOIN Booking b ON u.id = b.user_id
UNION
SELECT u.id AS user_id, u.name AS first_name, b.id AS booking_id, b.start_date, b.end_date
FROM User u
RIGHT JOIN Booking b ON u.id = b.user_id;
