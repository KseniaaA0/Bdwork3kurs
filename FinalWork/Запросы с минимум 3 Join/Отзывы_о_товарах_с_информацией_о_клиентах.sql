SELECT 
    p.name as product_name,
    c.first_name || ' ' || c.last_name as customer_name,
    pr.rating,
    pr.comment,
    pr.created_at
FROM product_reviews pr
JOIN products p ON pr.product_id = p.product_id
JOIN customers c ON pr.customer_id = c.customer_id
ORDER BY pr.created_at DESC;
