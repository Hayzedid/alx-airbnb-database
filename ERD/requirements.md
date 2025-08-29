# Airbnb Database ER Diagram Requirements

**Short Description:**
This ER diagram shows the main entities (User, Property, Booking, Payment, Review) and their relationships for an Airbnb-like system.

## Entities and Attributes

- **User**: id, name, email, password, phone, created_at
- **Property**: id, owner_id (User), title, description, address, city, country, price_per_night, created_at
- **Booking**: id, user_id (User), property_id (Property), start_date, end_date, total_price, status, created_at
- **Payment**: id, booking_id (Booking), amount, payment_date, payment_method, status
- **Review**: id, user_id (User), property_id (Property), rating, comment, created_at

## Relationships

- User can own multiple Properties (1-to-many)
- User can make multiple Bookings (1-to-many)
- Property can have multiple Bookings (1-to-many)
- Booking is linked to one Payment (1-to-1)
- User can write multiple Reviews (1-to-many)
- Property can have multiple Reviews (1-to-many)

## ER Diagram

Create an ER diagram using Draw.io or a similar tool based on the above entities and relationships. Save the diagram as `airbnb-erd.png` in this folder.
