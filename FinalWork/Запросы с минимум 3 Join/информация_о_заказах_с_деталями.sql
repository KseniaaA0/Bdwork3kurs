SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    c.first_name || ' ' || c.last_name as customer_name,
    e.first_name || ' ' || e.last_name as employee_name,
    os.name as status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
JOIN order_statuses os ON o.status_id = os.status_id;
