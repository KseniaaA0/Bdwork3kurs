CREATE VIEW stock_summary AS
SELECT 
    p.product_id,
    p.name as product_name,
    w.name as warehouse_name,
    s.quantity,
    s.last_restocked
FROM stock s
JOIN products p ON s.product_id = p.product_id
JOIN warehouses w ON s.warehouse_id = w.warehouse_id;
