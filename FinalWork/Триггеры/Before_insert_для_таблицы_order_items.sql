CREATE OR REPLACE FUNCTION check_order_item_quantity()
RETURNS TRIGGER AS $$
DECLARE
    v_available_stock INT;
BEGIN
  
    SELECT COALESCE(SUM(quantity), 0) INTO v_available_stock
    FROM stock
    WHERE product_id = NEW.product_id;
    
    IF NEW.quantity > v_available_stock THEN
        RAISE EXCEPTION 'Недостаточно товара на складе. Доступно: %, запрошено: %', 
            v_available_stock, NEW.quantity;
    END IF;
    
    
    SELECT price INTO NEW.unit_price
    FROM products
    WHERE product_id = NEW.product_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_order_item_quantity
BEFORE INSERT ON order_items
FOR EACH ROW EXECUTE FUNCTION check_order_item_quantity();
