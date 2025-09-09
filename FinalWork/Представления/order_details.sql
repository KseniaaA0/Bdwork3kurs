CREATE VIEW order_details AS
SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    c.first_name || ' ' || c.last_name as customer_name,
    c.email as customer_email,
    e.first_name || ' ' || e.last_name as employee_name,
    os.name as status,
    pm.name as payment_method
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
JOIN order_statuses os ON o.status_id = os.status_id
JOIN payment_methods pm ON o.payment_method_id = pm.payment_method_id;
