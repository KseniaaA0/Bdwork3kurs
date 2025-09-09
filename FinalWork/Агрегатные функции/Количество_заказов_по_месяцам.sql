SELECT EXTRACT(YEAR FROM order_date) as year,
       EXTRACT(MONTH FROM order_date) as month,
       COUNT(*) as order_count
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
ORDER BY year, month;
