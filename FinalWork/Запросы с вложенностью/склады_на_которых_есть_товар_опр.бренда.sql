SELECT name, address
FROM warehouses
WHERE warehouse_id IN (
    SELECT DISTINCT s.warehouse_id
    FROM stock s
    JOIN products p ON s.product_id = p.product_id
    WHERE p.category_id = (
        SELECT category_id FROM categories WHERE name = 'Мониторы'
    )
);
