CREATE OR REPLACE FUNCTION create_default_stock()
RETURNS TRIGGER AS $$
BEGIN
    
    INSERT INTO stock (product_id, warehouse_id, quantity)
    VALUES (NEW.product_id, 1, 0);
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_create_default_stock
AFTER INSERT ON products
FOR EACH ROW EXECUTE FUNCTION create_default_stock();
