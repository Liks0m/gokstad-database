# LLM usage log

## Session 2026-10-17 — Claude Code (Claude Opus 5.5)

### 1. Insert customer data
**Prompt:** On line 52 in `oppgave-1-database.sql`, add the values for the 8 customers (Ola Nordmann … Ingrid Berg). Ignore the ID field since it is auto-incremented.

**What Claude did:** Filled in the empty `INSERT INTO customers (first_name, last_name, email, city, registered_date) VALUES ()` with the 8 rows. `customer_id` was left out so that `AUTO_INCREMENT` assigns IDs 1–8 in order.

### 2. Use utf8mb4
**Prompt:** Set up so it uses utf8mb4.

**What Claude did:** Added at the top of the script:
- `SET NAMES utf8mb4;` so the client connection uses UTF-8 (needed for characters like "ø" in "Tromsø").
- `CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci` on `CREATE DATABASE`.
- An `ALTER DATABASE` with the same charset, in case the database already existed with a different one (`CREATE ... IF NOT EXISTS` doesn't change an existing database).

The tables inherit the charset from the database since they are dropped and recreated. Note: `utf8mb4_0900_ai_ci` requires MySQL 8+; use `utf8mb4_unicode_ci` on MySQL 5.7 or MariaDB.

### 3. Log the session
**Prompt:** Log this Claude session with LLM.md.

**What Claude did:** Created this file.

### 4. Insert order data
**Prompt:** Add the 18 orders at the `VALUES` line (line 68) of the orders insert.

**What Claude did:** Filled in `INSERT INTO orders (customer_id, product_id, quantity, order_date, status)` with the 18 rows, leaving out `order_id` (auto-increment). The pasted status "Processin" was cut off, so it was written as `'Processing'`.

## Session 2026-10-23 — Claude Code (Claude Opus 5.5)

### 5. Include customers with zero orders (oppgave 3, task 9)
**Prompt:** In the task 9 section of `oppgave-3-sporringer.sql`, how do I make it print out customers with zero orders (customer_id 8, Ingrid)? Do not edit the file, only explain.

**What Claude did:** Explained without editing the file:
- `INNER JOIN` only keeps rows that match in both tables, so Ingrid (no rows in `orders`) is removed before `GROUP BY` runs.
- Fix 1: start from `customers` and use `LEFT JOIN nettbutikk.orders AS o ON o.customer_id = c.customer_id`. A `LEFT JOIN` keeps every row from the left table and fills the `o.*` columns with `NULL` when there is no match.
- Fix 2: use `COUNT(o.order_id)` instead of `COUNT(*)`. `COUNT(*)` counts rows, so Ingrid's NULL row would give 1. `COUNT(column)` skips NULLs, so she gets 0.
- Also pointed out a bug in task 4: the products join uses `p.product_id = o.customer_id` and should be `o.product_id` (task 6 has it right).

### 6. Log the session
**Prompt:** Document this in LLM.md.

**What Claude did:** Added this session to the file.

### 7. Check task 11 (calculated value per product)
**Prompt:** Pasted the task 11 description (total units ordered and total calculated value per product, products with no orders shown as 0, sorted highest to lowest value). Do not edit, just check if the query in `oppgave-3-sporringer.sql` is correct.

**What Claude did:** Reviewed the query without editing the file:
- Correct: `LEFT JOIN` from `products` keeps products with no orders, `SUM(p.price * o.quantity)` computes the value, and `ORDER BY ... DESC` sorts correctly.
- Bug: `GROUP BY p.product_name, o.quantity` splits a product into one row per distinct quantity, and the query selects `o.quantity` instead of the total units. It should select `SUM(o.quantity)` and group only by product columns.
- Bug: products with no orders get `NULL`, not 0. Wrap both sums in `COALESCE(..., 0)`.
- Suggestion: group by `p.product_id, p.product_name`, since `product_name` is not `UNIQUE`.
- Note: if order statuses (e.g. cancelled) should be filtered out, put the filter in the `ON` clause, not `WHERE`, or the products with no orders are dropped.

### 8. Log the session
**Prompt:** Log to LLM.md.

**What Claude did:** Added items 7 and 8 to this file.
