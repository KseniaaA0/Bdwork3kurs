SELECT b.name, COUNT(p.product_id) as product_count
FROM brands b
LEFT JOIN products p ON b.brand_id = p.brand_id
GROUP BY b.brand_id, b.name
ORDER BY product_count DESC;
