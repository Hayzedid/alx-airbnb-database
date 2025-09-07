# ALX Airbnb Database - Advanced SQL Scripts

This project demonstrates advanced SQL querying techniques, database optimization, and performance monitoring for an Airbnb-like database system.

## Project Structure

```
alx-airbnb-database/
├── database-adv-script/
│   ├── joins_queries.sql          # Complex JOIN operations
│   ├── subqueries.sql             # Advanced subquery implementations
│   ├── aggregations_and_window_functions.sql  # Aggregation and window functions
│   ├── database_index.sql         # Index creation and optimization
│   ├── index_performance.md       # Index performance analysis
│   ├── performance.sql            # Query optimization examples
│   ├── optimization_report.md     # Comprehensive optimization report
│   ├── partitioning.sql           # Database partitioning implementation
│   ├── partition_performance.md   # Partition performance analysis
│   ├── performance_monitoring.md  # Monitoring and maintenance guide
│   └── README.md                  # This file
├── database-script-0x01/
│   └── schema.sql                 # Database schema
├── database-script-0x02/
│   └── seed.sql                   # Sample data
├── ERD/
│   ├── airbnb-erd.png            # Entity Relationship Diagram
│   └── requirements.md           # Database requirements
└── README.md                      # Main project README
```

## Database Schema

The database consists of the following main tables:
- **User**: User account information
- **Property**: Property listings with details
- **Booking**: Booking records linking users and properties
- **Payment**: Payment transactions for bookings

## SQL Scripts Overview

### 1. Joins Queries (`joins_queries.sql`)
- INNER JOINs for related data retrieval
- LEFT/RIGHT JOINs for optional relationships
- Multiple table joins with complex conditions
- Performance-optimized join patterns

### 2. Subqueries (`subqueries.sql`)
- Correlated and non-correlated subqueries
- Subqueries in SELECT, FROM, and WHERE clauses
- EXISTS and IN operators with subqueries
- Nested subquery implementations

### 3. Aggregations and Window Functions (`aggregations_and_window_functions.sql`)
- GROUP BY with aggregate functions (SUM, AVG, COUNT, etc.)
- Window functions (ROW_NUMBER, RANK, LAG, LEAD)
- Running totals and moving averages
- Complex analytical queries

### 4. Database Indexing (`database_index.sql`)
- Strategic index creation for optimal performance
- Composite indexes for multi-column queries
- Index maintenance and monitoring
- Index usage analysis

### 5. Performance Optimization (`performance.sql`)
- Query optimization techniques
- Index utilization strategies
- Execution plan analysis
- Performance benchmarking

### 6. Database Partitioning (`partitioning.sql`)
- Table partitioning by date ranges
- Monthly and quarterly partition schemes
- Partition management queries
- Performance benefits of partitioning

## Performance Improvements

### Indexing Results
- **Query Execution Time**: 88-89% reduction
- **Index Coverage**: All major queries optimized
- **Storage Overhead**: 15-20% increase

### Partitioning Benefits
- **Date Range Queries**: 85% faster execution
- **Data Archiving**: 99.93% faster maintenance
- **Scalability**: Improved handling of large datasets

## Setup Instructions

1. **Database Setup**
   ```sql
   -- Create database
   CREATE DATABASE airbnb_db;
   USE airbnb_db;

   -- Run schema script
   SOURCE database-script-0x01/schema.sql;

   -- Load sample data
   SOURCE database-script-0x02/seed.sql;
   ```

2. **Run Optimization Scripts**
   ```sql
   -- Create indexes
   SOURCE database-adv-script/database_index.sql;

   -- Implement partitioning
   SOURCE database-adv-script/partitioning.sql;
   ```

3. **Performance Monitoring**
   - Enable MySQL performance schema
   - Review `performance_monitoring.md` for monitoring setup
   - Schedule regular maintenance tasks

## Key Features Demonstrated

- ✅ Complex multi-table JOIN operations
- ✅ Advanced subquery patterns
- ✅ Aggregation and window function usage
- ✅ Strategic database indexing
- ✅ Query performance optimization
- ✅ Database partitioning strategies
- ✅ Performance monitoring and maintenance
- ✅ Comprehensive documentation

## Technologies Used

- **Database**: MySQL 8.0+
- **SQL Features**: Advanced joins, subqueries, window functions
- **Optimization**: Indexing, partitioning, query tuning
- **Monitoring**: Performance schema, slow query logs

## Learning Outcomes

This project demonstrates proficiency in:
- Advanced SQL query writing and optimization
- Database performance tuning techniques
- Index design and maintenance strategies
- Partitioning for large-scale databases
- Performance monitoring and alerting
- Database maintenance best practices

## Usage

Each SQL script can be run independently or in sequence. The scripts are designed to work with the provided schema and sample data. Performance monitoring scripts should be implemented in a production environment for ongoing optimization.

## Contributing

This is an educational project for ALX Software Engineering program. For improvements or questions, please refer to the ALX curriculum guidelines.
