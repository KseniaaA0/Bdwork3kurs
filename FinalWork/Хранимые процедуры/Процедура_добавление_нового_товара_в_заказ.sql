CREATE OR REPLACE PROCEDURE add_product_to_order(
    p_order_id INT,
    p_product_id INT,
    p_quantity INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_unit_price DECIMAL(10,2);
    v_subtotal DECIMAL(10,2);
    v_current_total DECIMAL(10,2);
BEGIN
    
    SELECT price INTO v_unit_price 
    FROM products 
    WHERE product_id = p_product_id;
    
    
    INSERT INTO order_items (order_id, product_id, quantity, unit_price)
    VALUES (p_order_id, p_product_id, p_quantity, v_unit_price);
    
    
    SELECT SUM(subtotal) INTO v_current_total
    FROM order_items
    WHERE order_id = p_order_id;
    
    UPDATE orders 
    SET total_amount = v_current_total
    WHERE order_id = p_order_id;
    
    RAISE NOTICE 'Товар добавлен в заказ №%', p_order_id;
END;
$$;
