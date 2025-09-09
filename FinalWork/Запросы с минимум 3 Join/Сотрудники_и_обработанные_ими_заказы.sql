SELECT 
    e.first_name || ' ' || e.last_name as employee_name,
    e.position,
    COUNT(o.order_id) as processed_orders,
    SUM(o.total_amount) as total_sales
FROM employees e
LEFT JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.position
ORDER BY total_sales DESC;
