CREATE OR REPLACE FUNCTION check_product_price()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.price <= 0 THEN
        RAISE EXCEPTION 'Цена товара должна быть положительной';
    END IF;
    
    IF NEW.sku IS NULL OR NEW.sku = '' THEN
        RAISE EXCEPTION 'SKU товара не может быть пустым';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_product_price_before_insert
BEFORE INSERT ON products
FOR EACH ROW EXECUTE FUNCTION check_product_price();
