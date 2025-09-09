SELECT 
    c.name as category_name,
    COUNT(p.product_id) as product_count,
    AVG(p.price) as avg_price,
    MIN(p.price) as min_price,
    MAX(p.price) as max_price
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.name
ORDER BY product_count DESC;
