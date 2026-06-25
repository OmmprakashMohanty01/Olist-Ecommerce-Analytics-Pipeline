-- 1. What is the total volume of orders and our date range?
SELECT 
    COUNT(order_id) AS total_orders,
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
FROM orders;

-- 2. Are there missing values (Nulls) in our delivery data?
-- This is crucial for supply chain analysis!
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_approved_at IS NULL THEN 1 ELSE 0 END) AS missing_approval_dates,
    SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) AS missing_delivery_dates
FROM orders;

-- 3. What is the distribution of order statuses?
SELECT 
    order_status,
    COUNT(order_id) AS status_count
FROM orders
GROUP BY order_status
ORDER BY status_count DESC;