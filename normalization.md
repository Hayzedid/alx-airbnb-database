# Database Normalization for Airbnb Database

## Normalization Steps

### 1. First Normal Form (1NF)
- All tables have atomic (indivisible) values.
- Each field contains only one value (e.g., no comma-separated lists).

### 2. Second Normal Form (2NF)
- All non-key attributes are fully functionally dependent on the primary key.
- No partial dependencies (applies to tables with composite keys).

### 3. Third Normal Form (3NF)
- No transitive dependencies (non-key attributes do not depend on other non-key attributes).
- All attributes depend only on the primary key.

## Application to Airbnb Database
- Each entity (User, Property, Booking, Payment, Review) has a unique primary key.
- All attributes are atomic and directly related to their entity's primary key.
- Foreign keys are used to establish relationships, not to store redundant data.
- No derived or calculated fields are stored (e.g., total_price is calculated at booking time, not stored elsewhere).

**Result:**
The database design is in 3NF, ensuring minimal redundancy and optimal data integrity.
