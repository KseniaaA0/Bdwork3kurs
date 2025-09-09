SELECT name, contact_person
FROM suppliers
WHERE supplier_id IN (
    SELECT DISTINCT ps.supplier_id
    FROM product_suppliers ps
    JOIN products p ON ps.product_id = p.product_id
    WHERE p.category_id = (
        SELECT category_id FROM categories WHERE name = 'Ноутбуки'
    )
);
