CREATE OR REPLACE FUNCTION prevent_product_price_decrease()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.price < OLD.price THEN
        RAISE NOTICE 'Цена товара уменьшена с % до %', OLD.price, NEW.price;
        -- Можно добавить логирование в отдельную таблицу
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_product_price_decrease
BEFORE UPDATE ON products
FOR EACH ROW EXECUTE FUNCTION prevent_product_price_decrease();
