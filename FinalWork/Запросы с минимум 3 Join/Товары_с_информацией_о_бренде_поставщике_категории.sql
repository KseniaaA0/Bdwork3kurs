SELECT 
    p.name as product_name,
    p.price,
    b.name as brand_name,
    c.name as category_name,
    s.name as supplier_name,
    ps.supply_price
FROM products p
JOIN brands b ON p.brand_id = b.brand_id
JOIN categories c ON p.category_id = c.category_id
JOIN product_suppliers ps ON p.product_id = ps.product_id
JOIN suppliers s ON ps.supplier_id = s.supplier_id;
