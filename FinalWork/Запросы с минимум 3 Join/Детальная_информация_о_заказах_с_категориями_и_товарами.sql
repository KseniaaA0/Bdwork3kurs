SELECT 
    o.order_id,
    o.order_date,
    c.first_name || ' ' || c.last_name as customer_name,
    p.name as product_name,
    cat.name as category_name,
    oi.quantity,
    oi.unit_price,
    oi.subtotal
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id
ORDER BY o.order_date DESC;
