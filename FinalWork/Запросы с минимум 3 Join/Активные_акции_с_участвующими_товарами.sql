SELECT 
    pr.name as promotion_name,
    pr.discount_percent,
    pr.start_date,
    pr.end_date,
    p.name as product_name,
    p.price as original_price,
    ROUND(p.price * (1 - pr.discount_percent / 100), 2) as discounted_price
FROM promotions pr
JOIN product_promotions pp ON pr.promotion_id = pp.promotion_id
JOIN products p ON pp.product_id = p.product_id
WHERE CURRENT_DATE BETWEEN pr.start_date AND pr.end_date
ORDER BY pr.name, p.name;
