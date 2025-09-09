SELECT 
    o.order_id,
    o.order_date,
    c.first_name || ' ' || c.last_name as customer_name,
    pm.name as payment_method,
    os.name as status,
    o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN payment_methods pm ON o.payment_method_id = pm.payment_method_id
JOIN order_statuses os ON o.status_id = os.status_id;
