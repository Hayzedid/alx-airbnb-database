-- Task 1: Practice Subqueries

-- Non-correlated subquery: Find all properties where the average rating is greater than 4.0
SELECT p.id AS property_id, p.title AS name, p.city AS location
FROM Property p
WHERE p.id IN (
    SELECT r.property_id
    FROM Review r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);

-- Correlated subquery: Find users who have made more than 3 bookings
SELECT u.id AS user_id, u.name AS first_name
FROM User u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.id
) > 3;
