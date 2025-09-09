SELECT name, price, category_id
FROM products p1
WHERE price = (
    SELECT MAX(price)
    FROM products p2
    WHERE p2.category_id = p1.category_id
);
