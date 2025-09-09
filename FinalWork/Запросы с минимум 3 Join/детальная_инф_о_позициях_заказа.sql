SELECT 
    o.order_id,
    o.order_date,
    c.first_name || ' ' || c.last_name as customer_name,
    p.name as product_name,
    oi.quantity,
    oi.unit_price,
    oi.subtotal
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON oi.product_id = p.product_id;
