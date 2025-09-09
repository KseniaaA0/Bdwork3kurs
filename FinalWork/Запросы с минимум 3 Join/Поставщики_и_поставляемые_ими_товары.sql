SELECT 
    s.name as supplier_name,
    s.contact_person,
    p.name as product_name,
    ps.supply_price,
    ps.delivery_days
FROM suppliers s
JOIN product_suppliers ps ON s.supplier_id = ps.supplier_id
JOIN products p ON ps.product_id = p.product_id
ORDER BY s.name, p.name;
