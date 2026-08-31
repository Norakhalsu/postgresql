-- ============================================
-- PostgreSQL-Specific Features
-- Database: training_store
-- ============================================


-- ============================================
-- 1. RETURNING
-- ============================================

INSERT INTO customers (name, email, city)
VALUES ('Fahad', 'fahad@test.com', 'Riyadh')
RETURNING *;


-- UPDATE + RETURNING
UPDATE customers
SET city = 'Dammam'
WHERE name = 'Fahad'
RETURNING *;


-- DELETE + RETURNING
DELETE FROM customers
WHERE name = 'Fahad'
RETURNING *;


-- ============================================
-- 2. UPSERT - ON CONFLICT
-- ============================================

INSERT INTO customers (name, email, city)
VALUES ('Sara', 'sara@test.com', 'Dammam')
ON CONFLICT (email)
DO UPDATE
SET city = EXCLUDED.city
RETURNING *;


-- ============================================
-- 3. ILIKE
-- Case-insensitive search
-- ============================================

SELECT *
FROM customers
WHERE name ILIKE 's%';


-- ============================================
-- 4. DISTINCT ON
-- One customer from each city
-- ============================================

SELECT DISTINCT ON (city)
    city,
    name,
    email
FROM customers
ORDER BY city, customer_id;


-- ============================================
-- 5. JSONB
-- ============================================

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    details JSONB
);


INSERT INTO products (name, details)
VALUES (
    'MacBook Pro',
    '{
        "brand": "Apple",
        "ram": 16,
        "storage": 512,
        "colors": ["black", "silver"]
    }'
);


-- Show products
SELECT * FROM products;


-- Get one value from inside JSON
SELECT
    name,
    details->>'brand' AS brand
FROM products;


-- Filter using a JSON value
SELECT *
FROM products
WHERE details->>'brand' = 'Apple';


-- Convert JSON ram value to INTEGER
SELECT *
FROM products
WHERE (details->>'ram')::INTEGER >= 16;


-- ============================================
-- 6. PostgreSQL Arrays
-- ============================================

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    skills TEXT[]
);


INSERT INTO employees (name, skills)
VALUES (
    'nourah',
    ARRAY['Python', 'SQL', 'Docker']
);


-- Show employees
SELECT * FROM employees;


-- Find employees who have SQL as a skill
SELECT *
FROM employees
WHERE 'SQL' = ANY(skills);