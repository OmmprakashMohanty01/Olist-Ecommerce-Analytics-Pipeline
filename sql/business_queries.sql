-- Create a Master View for Tableau and Business Analysis
CREATE OR REPLACE VIEW vw_ecommerce_sales AS
SELECT 
    o.order_id,
    o.customer_id,
    c.customer_state,
    c.customer_city,
    o.order_purchase_timestamp,
    -- Extracting date parts for easier filtering
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS order_year,
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS order_month,
    o.order_status,
    oi.product_id,
    pt.product_category_name_english AS product_category,
    oi.price AS product_price,
    oi.freight_value,
    (oi.price + oi.freight_value) AS total_order_value,
    
    -- Supply Chain Business Logic: Was the order delayed?
    o.order_estimated_delivery_date,
    o.order_delivered_customer_date,
    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Late'
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 'On Time'
        ELSE 'Unresolved'
    END AS delivery_status,

    -- Calculate exact delay in days
    EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) AS delay_days

FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation pt ON p.product_category_name = pt.product_category_name;