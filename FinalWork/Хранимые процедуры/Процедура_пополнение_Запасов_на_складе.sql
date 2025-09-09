CREATE OR REPLACE PROCEDURE restock_product(
    p_product_id INT,
    p_warehouse_id INT,
    p_quantity INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    
    IF EXISTS (SELECT 1 FROM stock WHERE product_id = p_product_id AND warehouse_id = p_warehouse_id) THEN
        
        UPDATE stock 
        SET quantity = quantity + p_quantity, last_restocked = CURRENT_TIMESTAMP
        WHERE product_id = p_product_id AND warehouse_id = p_warehouse_id;
    ELSE
        
        INSERT INTO stock (product_id, warehouse_id, quantity, last_restocked)
        VALUES (p_product_id, p_warehouse_id, p_quantity, CURRENT_TIMESTAMP);
    END IF;
    
    RAISE NOTICE 'Товар ID % пополнен на % единиц на складе ID %', p_product_id, p_quantity, p_warehouse_id;
END;
$$;
