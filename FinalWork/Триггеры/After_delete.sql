CREATE OR REPLACE FUNCTION restore_stock_after_delete()
RETURNS TRIGGER AS $$
BEGIN
    
    UPDATE stock 
    SET quantity = quantity + OLD.quantity
    WHERE product_id = OLD.product_id AND warehouse_id = 1;
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_restore_stock_after_delete
AFTER DELETE ON order_items
FOR EACH ROW EXECUTE FUNCTION restore_stock_after_delete();
