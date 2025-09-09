SELECT name
FROM categories
WHERE category_id IN (
    SELECT DISTINCT category_id
    FROM products
    WHERE brand_id = (
        SELECT brand_id FROM brands WHERE name = 'ASUS'
    )
);
