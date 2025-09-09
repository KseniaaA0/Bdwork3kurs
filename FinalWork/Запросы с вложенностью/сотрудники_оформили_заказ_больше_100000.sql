SELECT first_name, last_name, position
FROM employees
WHERE employee_id IN (
    SELECT employee_id
    FROM orders
    WHERE total_amount > 100000
    AND employee_id IS NOT NULL
);
