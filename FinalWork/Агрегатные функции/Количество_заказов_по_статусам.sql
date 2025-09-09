SELECT os.name, COUNT(o.order_id) as order_count
FROM order_statuses os
LEFT JOIN orders o ON os.status_id = o.status_id
GROUP BY os.status_id, os.name
ORDER BY order_count DESC;
