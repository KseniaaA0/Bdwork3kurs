SELECT c.name as category_name, 
(
    SELECT AVG(pr.rating)
    FROM product_reviews pr
    JOIN products p ON pr.product_id = p.product_id
    WHERE p.category_id = c.category_id
) as avg_rating
FROM categories c
WHERE (
    SELECT AVG(pr.rating)
    FROM product_reviews pr
    JOIN products p ON pr.product_id = p.product_id
    WHERE p.category_id = c.category_id
) IS NOT NULL;
