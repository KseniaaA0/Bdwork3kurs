SELECT first_name, last_name, email
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM product_reviews
    WHERE rating = 5
);
