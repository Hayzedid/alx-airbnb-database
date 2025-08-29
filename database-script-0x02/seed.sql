-- Airbnb Database Sample Data (DML)

-- Users
INSERT INTO User (name, email, password, phone) VALUES
('Alice Smith', 'alice@example.com', 'hashedpassword1', '123-456-7890'),
('Bob Johnson', 'bob@example.com', 'hashedpassword2', '234-567-8901'),
('Carol Lee', 'carol@example.com', 'hashedpassword3', '345-678-9012');

-- Properties
INSERT INTO Property (owner_id, title, description, address, city, country, price_per_night) VALUES
(1, 'Cozy Apartment', 'A nice and cozy apartment in the city center.', '123 Main St', 'New York', 'USA', 120.00),
(2, 'Beach House', 'A beautiful house by the beach.', '456 Ocean Ave', 'Miami', 'USA', 250.00),
(3, 'Mountain Cabin', 'A peaceful cabin in the mountains.', '789 Hill Rd', 'Denver', 'USA', 180.00);

-- Bookings
INSERT INTO Booking (user_id, property_id, start_date, end_date, total_price, status) VALUES
(2, 1, '2025-09-10', '2025-09-15', 600.00, 'confirmed'),
(3, 2, '2025-10-01', '2025-10-05', 1000.00, 'pending'),
(1, 3, '2025-11-20', '2025-11-22', 360.00, 'cancelled');

-- Payments
INSERT INTO Payment (booking_id, amount, payment_method, status) VALUES
(1, 600.00, 'credit_card', 'completed'),
(2, 1000.00, 'paypal', 'pending'),
(3, 360.00, 'credit_card', 'refunded');

-- Reviews
INSERT INTO Review (user_id, property_id, rating, comment) VALUES
(2, 1, 5, 'Great place, very clean!'),
(3, 2, 4, 'Nice location, but a bit noisy.'),
(1, 3, 5, 'Loved the mountain view!');
