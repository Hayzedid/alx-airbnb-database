# Performance Monitoring and Maintenance

## Monitoring Setup

### 1. Query Performance Monitoring
```sql
-- Enable slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1;  -- Log queries taking longer than 1 second
SET GLOBAL slow_query_log_file = '/var/log/mysql/slow-queries.log';

-- Monitor query execution statistics
SELECT sql_text, exec_count, avg_timer_wait/1000000000 AS avg_time_sec,
       total_latency/1000000000 AS total_time_sec
FROM performance_schema.events_statements_summary_by_digest
ORDER BY avg_timer_wait DESC
LIMIT 10;
```

### 2. Index Usage Monitoring
```sql
-- Check index usage statistics
SELECT object_schema, object_name, index_name,
       count_read, count_fetch, count_insert, count_update, count_delete
FROM performance_schema.table_io_waits_summary_by_index_usage
WHERE object_schema = 'airbnb_db'
ORDER BY (count_read + count_fetch) DESC;

-- Identify unused indexes
SELECT table_name, index_name
FROM information_schema.statistics
WHERE table_schema = 'airbnb_db'
AND index_name NOT IN (
    SELECT index_name
    FROM performance_schema.table_io_waits_summary_by_index_usage
    WHERE object_schema = 'airbnb_db'
    AND (count_read + count_fetch) > 0
);
```

### 3. Table and Index Statistics
```sql
-- Update table statistics
ANALYZE TABLE User, Property, Booking, Payment;

-- Check table fragmentation
SELECT table_name, data_free / 1024 / 1024 AS free_mb,
       data_length / 1024 / 1024 AS data_mb,
       index_length / 1024 / 1024 AS index_mb
FROM information_schema.tables
WHERE table_schema = 'airbnb_db';
```

## Maintenance Tasks

### 1. Regular Index Maintenance
```sql
-- Rebuild fragmented indexes
ALTER TABLE User ENGINE = InnoDB;
ALTER TABLE Property ENGINE = InnoDB;
ALTER TABLE Booking ENGINE = InnoDB;
ALTER TABLE Payment ENGINE = InnoDB;

-- Update index statistics
ANALYZE TABLE User, Property, Booking, Payment;
```

### 2. Partition Maintenance
```sql
-- Add new partitions for future dates
ALTER TABLE Booking ADD PARTITION (
    PARTITION p2026 VALUES LESS THAN (2027)
);

ALTER TABLE Payment ADD PARTITION (
    PARTITION p2026_q1 VALUES LESS THAN (2026-04-01),
    PARTITION p2026_q2 VALUES LESS THAN (2026-07-01),
    PARTITION p2026_q3 VALUES LESS THAN (2026-10-01),
    PARTITION p2026_q4 VALUES LESS THAN (2027-01-01)
);

-- Archive old partitions
ALTER TABLE Booking DROP PARTITION p2023;
ALTER TABLE Payment DROP PARTITION p2023_q1, p2023_q2, p2023_q3, p2023_q4;
```

### 3. Automated Monitoring Script
```sql
-- Create monitoring procedure
DELIMITER //

CREATE PROCEDURE monitor_database_performance()
BEGIN
    -- Check for slow queries
    SELECT COUNT(*) AS slow_queries_today
    FROM performance_schema.events_statements_history
    WHERE timer_end > 1000000000000;  -- Queries > 1 second

    -- Check index usage
    SELECT COUNT(*) AS unused_indexes
    FROM information_schema.statistics s
    LEFT JOIN performance_schema.table_io_waits_summary_by_index_usage i
    ON s.table_schema = i.object_schema
    AND s.table_name = i.object_name
    AND s.index_name = i.index_name
    WHERE s.table_schema = 'airbnb_db'
    AND i.count_read IS NULL;

    -- Check table sizes
    SELECT table_name,
           (data_length + index_length) / 1024 / 1024 AS size_mb
    FROM information_schema.tables
    WHERE table_schema = 'airbnb_db'
    ORDER BY size_mb DESC;
END //

DELIMITER ;

-- Schedule daily monitoring
CREATE EVENT daily_performance_monitor
ON SCHEDULE EVERY 1 DAY STARTS '2024-01-01 00:00:00'
DO CALL monitor_database_performance();
```

## Alerting and Notifications

### Performance Thresholds
- Query execution time > 5 seconds
- Index usage < 70% for primary queries
- Table fragmentation > 30%
- Disk space usage > 85%

### Automated Alerts
```sql
-- Create alert for long-running queries
CREATE TRIGGER alert_slow_query
AFTER INSERT ON performance_schema.events_statements_history
FOR EACH ROW
BEGIN
    IF NEW.timer_wait > 5000000000000 THEN  -- 5 seconds
        INSERT INTO performance_alerts (alert_type, message, timestamp)
        VALUES ('SLOW_QUERY', CONCAT('Slow query detected: ', NEW.sql_text), NOW());
    END IF;
END;
```

## Performance Tuning Recommendations

1. **Query Optimization**
   - Review and optimize top 10 slowest queries monthly
   - Consider query result caching for frequently accessed data
   - Use prepared statements for repeated queries

2. **Index Management**
   - Remove unused indexes quarterly
   - Add indexes for new query patterns
   - Monitor index fragmentation monthly

3. **Partition Management**
   - Add future partitions quarterly
   - Archive old data annually
   - Rebalance partitions if needed

4. **Hardware and Configuration**
   - Monitor memory usage and adjust innodb_buffer_pool_size
   - Optimize disk I/O for better performance
   - Consider read replicas for heavy read workloads

## Conclusion
Implementing comprehensive performance monitoring and regular maintenance ensures the database remains optimized and responsive to changing workload patterns.
