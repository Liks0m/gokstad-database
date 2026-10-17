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
