SELECT first_name, last_name, email
FROM customers
WHERE customer_id IN (
    SELECT DISTINCT o.customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE p.category_id = (
        SELECT category_id FROM categories WHERE name = 'Игровые ноутбуки'
    )
);
