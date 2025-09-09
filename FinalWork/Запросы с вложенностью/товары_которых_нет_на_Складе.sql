SELECT name, price
FROM products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id 
    FROM stock 
    WHERE quantity > 0
);
