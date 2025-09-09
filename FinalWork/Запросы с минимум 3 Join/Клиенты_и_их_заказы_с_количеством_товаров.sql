SELECT 
    c.first_name || ' ' || c.last_name as customer_name,
    c.email,
    o.order_id,
    o.order_date,
    o.total_amount,
    COUNT(oi.order_item_id) as item_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, o.order_id, o.order_date, o.total_amount
ORDER BY o.order_date DESC;
