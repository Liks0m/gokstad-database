USE nettbutikk;

# Task 1 Product overview
SELECT product_name, category, price, stock
FROM nettbutikk.products
WHERE price > 750
  AND stock >= 10
ORDER BY price DESC;

# Task 2 Customers in selected cities
SELECT city, last_name
FROM nettbutikk.customers
WHERE city LIKE 'Oslo'
   OR city LIKE 'Bergen'
   OR city LIKE 'Trondheim'
ORDER BY city, last_name;

# Task 3 Orders within a period
SELECT order_id, order_date, quantity, status
FROM nettbutikk.orders
WHERE order_date BETWEEN '2025-07-01' AND '2025-07-31';

# Task 4 Complete order overview
SELECT o.order_id,
       c.first_name,
       c.last_name,
       p.product_name,
       o.quantity,
       p.price,
       o.order_date,
       o.status,
       p.price * o.quantity AS total_quantity_price
FROM nettbutikk.orders AS o
         INNER JOIN customers AS c ON c.customer_id = o.customer_id
         INNER JOIN products AS p ON p.product_id = o.product_id
ORDER BY total_quantity_price DESC;

# Task 5 Calculated value is the lines 32 and 36

# Task 6 High-value orders
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer,
       p.product_name                         AS product,
       o.quantity,
       p.price,
       p.price * o.quantity                   AS total_stock_price
FROM nettbutikk.orders AS o
         INNER JOIN customers AS c ON c.customer_id = o.customer_id
         INNER JOIN products AS p ON p.product_id = o.product_id
WHERE p.price * o.quantity > 2000
ORDER BY total_stock_price DESC;

# Task 7 Orders per status
SELECT status as status, COUNT(status) AS orders_per_status
FROM nettbutikk.orders
WHERE status = 'Delivered'
   OR status = 'Shipped'
   OR status = 'Processing'
GROUP BY status;

# Task 8 Average price per category
SELECT category, ROUND(AVG(price), 2) as average_price_per_category
FROM nettbutikk.products
GROUP BY category
ORDER BY average_price_per_category DESC;

# Task 9 Orders per customer
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer,
       COUNT(o.order_id)                      AS orders_per_customer
FROM nettbutikk.customers AS c
         LEFT JOIN nettbutikk.orders AS o ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY orders_per_customer DESC;

# Task 10 Number of products sold
SELECT p.product_name, COALESCE(SUM(o.quantity), 0) AS amount_of_product_sold
FROM nettbutikk.products AS p
         LEFT JOIN nettbutikk.orders AS o ON o.product_id = p.product_id
group by p.product_name
ORDER BY amount_of_product_sold DESC;

# Task 11 Calculated value per product
SELECT p.product_name,
       COALESCE(SUM(o.quantity), 0)           AS total_units_ordered,
       COALESCE(SUM(p.price * o.quantity), 0) AS total_order_value
FROM nettbutikk.products AS p
         LEFT JOIN nettbutikk.orders AS o ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_order_value DESC;

# Task 12 Customers with multiple orders
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer,
       COUNT(o.order_id)                      AS orders_per_customer
FROM nettbutikk.customers AS c
         LEFT JOIN nettbutikk.orders AS o ON o.customer_id = c.customer_id
WHERE o.order_id > 1
GROUP BY c.customer_id
ORDER BY orders_per_customer DESC;

# Task 13 Customers without orders
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer,
       COUNT(o.order_id)                      AS orders_per_customer
FROM nettbutikk.customers AS c
         LEFT JOIN nettbutikk.orders AS o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL
GROUP BY c.customer_id
ORDER BY orders_per_customer DESC;

#Task 14 Products without orders
SELECT p.product_name,
       COALESCE(SUM(o.quantity), 0)           AS total_units_ordered,
       COALESCE(SUM(p.price * o.quantity), 0) AS total_order_value
FROM nettbutikk.products AS p
         LEFT JOIN nettbutikk.orders AS o ON o.product_id = p.product_id
WHERE o.quantity IS NULL
GROUP BY p.product_id, p.product_name
ORDER BY total_order_value DESC;

#For Task 15 i found the answer at https://stackoverflow.com/questions/22538287/max-function-in-where-clause-mysql and i just added a LIMIT 1 on a pervious query that queries for high value orders over 2000

# Task 15 Exploration task:
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer,
       p.product_name                         AS product,
       o.quantity,
       p.price,
       p.price * o.quantity                   AS total_stock_price
FROM nettbutikk.orders AS o
         INNER JOIN customers AS c ON c.customer_id = o.customer_id
         INNER JOIN products AS p ON p.product_id = o.product_id
ORDER BY total_stock_price DESC
LIMIT 1;

