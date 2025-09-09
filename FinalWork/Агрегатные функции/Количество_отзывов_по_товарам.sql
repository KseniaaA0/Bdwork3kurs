SELECT p.name, COUNT(pr.review_id) as review_count
FROM products p
LEFT JOIN product_reviews pr ON p.product_id = pr.product_id
GROUP BY p.product_id, p.name
HAVING COUNT(pr.review_id) > 0
ORDER BY review_count DESC;
