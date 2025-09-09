SELECT 
    p.name as product_name,
    p.price,
    b.name as brand_name,
    AVG(pr.rating) as avg_rating,
    COUNT(pr.review_id) as review_count
FROM products p
JOIN brands b ON p.brand_id = b.brand_id
LEFT JOIN product_reviews pr ON p.product_id = pr.product_id
GROUP BY p.product_id, p.name, p.price, b.name
HAVING COUNT(pr.review_id) > 0;
