SELECT w.name, SUM(s.quantity) as total_quantity
FROM warehouses w
LEFT JOIN stock s ON w.warehouse_id = s.warehouse_id
GROUP BY w.warehouse_id, w.name
ORDER BY total_quantity DESC;
