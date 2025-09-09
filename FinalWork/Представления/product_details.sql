CREATE VIEW product_details AS
SELECT 
    p.product_id,
    p.name as product_name,
    p.price,
    p.sku,
    b.name as brand_name,
    c.name as category_name,
    p.specifications
FROM products p
JOIN brands b ON p.brand_id = b.brand_id
JOIN categories c ON p.category_id = c.category_id;
