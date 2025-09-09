SELECT 
    p.name as product_name,
    p.price as original_price,
    pr.name as promotion_name,
    pr.discount_percent,
    ROUND(p.price * (1 - pr.discount_percent / 100), 2) as discounted_price
FROM products p
JOIN product_promotions pp ON p.product_id = pp.product_id
JOIN promotions pr ON pp.promotion_id = pr.promotion_id
WHERE CURRENT_DATE BETWEEN pr.start_date AND pr.end_date;
