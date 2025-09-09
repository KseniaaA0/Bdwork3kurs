SELECT position, COUNT(*) as employee_count
FROM employees
GROUP BY position
ORDER BY employee_count DESC;
