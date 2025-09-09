SELECT name, price
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM product_suppliers
    WHERE supplier_id = (
        SELECT supplier_id FROM suppliers WHERE name = 'ООО ТехноПоставка'
    )
);
