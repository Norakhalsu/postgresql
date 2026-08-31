---

# Commands & SQL Practice

This section documents the commands and SQL queries used during the PostgreSQL practice, in order.

## 1. Create PostgreSQL Container

Create a PostgreSQL 17 container using Docker:

```bash
docker run --name postgres-training \
  -e POSTGRES_USER=nora \
  -e POSTGRES_PASSWORD=********* \
  -e POSTGRES_DB=training_store \
  -p 5432:5432 \
  -d postgres:17
```

## 2. Check Running Containers

```bash
docker ps
```

## 3. Connect to PostgreSQL

Connect to the `training_store` database using `psql`:

```bash
docker exec -it postgres-training psql -U nora -d training_store
```

After connecting, the PostgreSQL prompt appears as:

```text
training_store=#
```

---

## 4. List Databases

```sql
\l
```

## 5. List Tables

```sql
\dt
```

## 6. Create Customers Table

```sql
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    city VARCHAR(100)
);
```

## 7. Check Tables Again

```sql
\dt
```

## 8. Describe Customers Table

```sql
\d customers
```

## 9. Insert Sample Customers

```sql
INSERT INTO customers (name, email, city)
VALUES
('Sara', 'sara@test.com', 'Riyadh'),
('Lama', 'lama@test.com', 'Jeddah'),
('Noura', 'noura@test.com', 'Riyadh');
```

## 10. Select All Customers

```sql
SELECT * FROM customers;
```

Example result:

```text
 customer_id | name  |      email       |  city
-------------+-------+------------------+---------
 1           | Sara  | sara@test.com    | Riyadh
 2           | Lama  | lama@test.com    | Jeddah
 3           | Noura | noura@test.com   | Riyadh
```

---

# PostgreSQL-Specific Features

## 11. Enable Query Timing in psql

```sql
\timing
```

This displays how long each query takes to execute.

## 12. INSERT with RETURNING

PostgreSQL can immediately return the row that was inserted:

```sql
INSERT INTO customers (name, email, city)
VALUES ('Fahad', 'fahad@test.com', 'Riyadh')
RETURNING *;
```

## 13. UPDATE with RETURNING

```sql
UPDATE customers
SET city = 'Dammam'
WHERE name = 'Fahad'
RETURNING *;
```

## 14. DELETE with RETURNING

```sql
DELETE FROM customers
WHERE name = 'Fahad'
RETURNING *;
```

## 15. UPSERT with ON CONFLICT

Insert a customer, or update the existing row when the email already exists:

```sql
INSERT INTO customers (name, email, city)
VALUES ('Sara', 'sara@test.com', 'Dammam')
ON CONFLICT (email)
DO UPDATE
SET city = EXCLUDED.city
RETURNING *;
```

## 16. Case-Insensitive Search with ILIKE

```sql
SELECT *
FROM customers
WHERE name ILIKE 's%';
```

## 17. DISTINCT ON

Return one customer from each city:

```sql
SELECT DISTINCT ON (city)
    city,
    name,
    email
FROM customers
ORDER BY city, customer_id;
```

---

# JSONB Practice

## 18. Create Products Table with JSONB

```sql
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    details JSONB
);
```

## 19. Insert JSON Data

```sql
INSERT INTO products (name, details)
VALUES
(
    'MacBook Pro',
    '{
        "brand": "Apple",
        "ram": 16,
        "storage": 512,
        "colors": ["black", "silver"]
    }'
);
```

## 20. Select Products

```sql
SELECT * FROM products;
```

## 21. Read a Value from JSONB

```sql
SELECT
    name,
    details->>'brand' AS brand
FROM products;
```

## 22. Filter Using JSONB

```sql
SELECT *
FROM products
WHERE details->>'brand' = 'Apple';
```

## 23. Cast JSONB Value to Integer

```sql
SELECT *
FROM products
WHERE (details->>'ram')::INTEGER >= 16;
```

---

# PostgreSQL Arrays

## 24. Create Employees Table with an Array

```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    skills TEXT[]
);
```

## 25. Insert an Array

```sql
INSERT INTO employees (name, skills)
VALUES (
    'Nora',
    ARRAY['Python', 'SQL', 'Docker']
);
```

## 26. Select Employees

```sql
SELECT * FROM employees;
```

## 27. Search Inside an Array

```sql
SELECT *
FROM employees
WHERE 'SQL' = ANY(skills);
```

---

# Useful psql Commands

## 28. List Tables

```sql
\dt
```

## 29. Describe a Table

```sql
\d customers
```

## 30. List Schemas

```sql
\dn
```

## 31. List Databases

```sql
\l
```

## 32. List PostgreSQL Users and Roles

```sql
\du
```

## 33. Enable Query Timing

```sql
\timing
```

## 34. Toggle Expanded Display

```sql
\x
```

Useful when viewing rows containing many columns or JSON data.

## 35. Exit psql

```sql
\q
```

---

# Docker Management

## 36. Stop PostgreSQL Container

```bash
docker stop postgres-training
```

## 37. Start PostgreSQL Container Again

```bash
docker start postgres-training
```

## 38. Reconnect to PostgreSQL

```bash
docker exec -it postgres-training psql -U nora -d training_store
```

---

# Git & GitHub

## 39. Create Project Directory

```bash
mkdir postgresql-learning
cd postgresql-learning
```

## 40. Create Project Structure

```bash
mkdir sql docker

touch README.md
touch docker/commands.md
touch sql/01-create-tables.sql
touch sql/02-insert-data.sql
touch sql/03-basic-queries.sql
touch sql/04-postgresql-features.sql
```

## 41. Open Project in VS Code

```bash
code .
```

## 42. Initialize Git Repository

```bash
git init
```

## 43. Stage Files

```bash
git add .
```

## 44. Check Git Status

```bash
git status
```

## 45. Create First Commit

```bash
git commit -m "Initialize PostgreSQL learning project"
```

## 46. Connect Local Repository to GitHub

```bash
git remote add origin https://github.com/Norakhalsu/postgresql.git
```

## 47. Set Main Branch

```bash
git branch -M main
```

## 48. Push to GitHub

```bash
git push -u origin main
```

---

# Next Topics

Future PostgreSQL practice will include:

- JOIN
- GROUP BY
- Aggregate functions
- Views
- Indexes
- Transactions
- EXPLAIN ANALYZE
- Functions
- Stored procedures
- Triggers
- Schemas
- Roles and permissions
- Extensions
- pgvector