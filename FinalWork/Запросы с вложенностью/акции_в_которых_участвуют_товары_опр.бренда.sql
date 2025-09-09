SELECT name, discount_percent
FROM promotions
WHERE promotion_id IN (
    SELECT DISTINCT pp.promotion_id
    FROM product_promotions pp
    JOIN products p ON pp.product_id = p.product_id
    WHERE p.brand_id = (
        SELECT brand_id FROM brands WHERE name = 'Apple'
    )
);
