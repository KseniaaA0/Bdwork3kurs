SELECT EXTRACT(MONTH FROM order_date) as month,
       COUNT(*) as order_count
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date)
HAVING COUNT(*) = (
    SELECT MAX(order_count)
    FROM (
        SELECT COUNT(*) as order_count
        FROM orders
        GROUP BY EXTRACT(MONTH FROM order_date)
    ) as monthly_orders
);
