-- ============================================
-- PostgreSQL Basic Queries
-- Database: training_store
-- ============================================

-- Show all customers
SELECT * FROM customers;

-- Customers from Riyadh
SELECT *
FROM customers
WHERE city = 'Riyadh';

-- Sort customers by name
SELECT *
FROM customers
ORDER BY name;

-- Sort customers by ID
SELECT *
FROM customers
ORDER BY customer_id;

-- Select specific columns
SELECT name, email, city
FROM customers;

-- Count customers
SELECT COUNT(*)
FROM customers;