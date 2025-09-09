CREATE OR REPLACE PROCEDURE update_order_status(
    p_order_id INT,
    p_status_name VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status_id INT;
    v_current_status VARCHAR(50);
BEGIN
    
    SELECT status_id INTO v_status_id 
    FROM order_statuses 
    WHERE name = p_status_name;
    
    IF v_status_id IS NULL THEN
        RAISE EXCEPTION 'Статус % не найден', p_status_name;
    END IF;
    
   
    SELECT os.name INTO v_current_status
    FROM orders o
    JOIN order_statuses os ON o.status_id = os.status_id
    WHERE o.order_id = p_order_id;
    
    
    IF p_status_name = 'Отправлен' THEN
        UPDATE orders 
        SET status_id = v_status_id, shipped_date = CURRENT_TIMESTAMP
        WHERE order_id = p_order_id;
    ELSE
        UPDATE orders 
        SET status_id = v_status_id
        WHERE order_id = p_order_id;
    END IF;
    
    RAISE NOTICE 'Статус заказа №% изменен с "%" на "%"', p_order_id, v_current_status, p_status_name;
END;
$$;
