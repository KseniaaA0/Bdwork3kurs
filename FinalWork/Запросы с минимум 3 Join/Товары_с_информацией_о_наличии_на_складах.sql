SELECT 
    p.name as product_name,
    p.price,
    SUM(s.quantity) as total_stock,
    COUNT(DISTINCT s.warehouse_id) as warehouse_count
FROM products p
LEFT JOIN stock s ON p.product_id = s.product_id
GROUP BY p.product_id, p.name, p.price
ORDER BY total_stock DESC;
