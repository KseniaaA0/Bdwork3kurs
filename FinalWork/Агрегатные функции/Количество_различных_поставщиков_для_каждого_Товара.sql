SELECT p.name, COUNT(ps.supplier_id) as supplier_count
FROM products p
LEFT JOIN product_suppliers ps ON p.product_id = ps.product_id
GROUP BY p.product_id, p.name
ORDER BY supplier_count DESC;
