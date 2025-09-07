-- Task 3: Implement Indexes for Optimization

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
