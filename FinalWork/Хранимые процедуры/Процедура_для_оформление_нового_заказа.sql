CREATE OR REPLACE PROCEDURE create_order(
    p_customer_id INT,
    p_employee_id INT,
    p_payment_method_id INT,
    p_shipping_address TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_order_id INT;
    v_status_id INT;
BEGIN


    SELECT status_id INTO v_status_id 
    FROM order_statuses 
    WHERE name = 'Оформлен';
    

    INSERT INTO orders (customer_id, employee_id, status_id, payment_method_id, total_amount, shipping_address)
    VALUES (p_customer_id, p_employee_id, v_status_id, p_payment_method_id, 0, p_shipping_address)
    RETURNING order_id INTO v_order_id;
    
    RAISE NOTICE 'Заказ №% успешно создан', v_order_id;
END;
$$;
