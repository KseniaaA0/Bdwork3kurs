CREATE OR REPLACE PROCEDURE apply_category_discount(
    p_category_id INT,
    p_discount_percent DECIMAL(5,2),
    p_start_date DATE,
    p_end_date DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_promotion_id INT;
    v_product_record RECORD;
BEGIN
  
    INSERT INTO promotions (name, description, discount_percent, start_date, end_date)
    VALUES (
        'Скидка на категорию',
        'Автоматически созданная скидка на категорию товаров',
        p_discount_percent,
        p_start_date,
        p_end_date
    )
    RETURNING promotion_id INTO v_promotion_id;
    
    
    FOR v_product_record IN 
        SELECT product_id FROM products WHERE category_id = p_category_id
    LOOP
        INSERT INTO product_promotions (product_id, promotion_id)
        VALUES (v_product_record.product_id, v_promotion_id);
    END LOOP;
    
    RAISE NOTICE 'Скидка %%% применена к % товарам категории ID %', 
        p_discount_percent, 
        (SELECT COUNT(*) FROM products WHERE category_id = p_category_id),
        p_category_id;
END;
$$;
