SELECT p.name, COUNT(pp.promotion_id) as promotion_count
FROM products p
LEFT JOIN product_promotions pp ON p.product_id = pp.product_id
GROUP BY p.product_id, p.name
ORDER BY promotion_count DESC;
