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
