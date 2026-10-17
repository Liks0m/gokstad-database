SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS nettbutikk
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;
ALTER DATABASE nettbutikk CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci; # in case the database already existed with another charset
USE nettbutikk;

DROP TABLE IF EXISTS
    customers,
    products,
    orders;

CREATE TABLE customers
(
    customer_id     INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    first_name      VARCHAR(50)                    NOT NULL,
    last_name       VARCHAR(50)                    NOT NULL,
    email           VARCHAR(100) UNIQUE            NOT NULL,
    city            VARCHAR(50)                    NOT NULL,
    registered_date DATE                           NOT NULL
); # there is no need to implement innoDB since this database engine is standard in the latest versions of mysql

CREATE TABLE products
(
    product_id   INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    product_name VARCHAR(100)                   NOT NULL,
    category     VARCHAR(50)                    NOT NULL,
    price        DECIMAL(10, 2)                 NOT NULL,
    stock        INT                            NOT NULL
);

CREATE TABLE orders
(
    order_id    INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    customer_id INT                            NOT NULL,
    product_id  INT                            NOT NULl,
    quantity    INT                            NOT NULL,
    order_date  DATE                           NOT NULL,
    status      VARCHAR(20)                    NOT NULL,
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
);

INSERT INTO products (product_name, category, price, stock)
VALUES ('Laptop Pro 15', 'Computers', 12999.00, 8),
       ('Wireless mouse', 'Accessories', 399.00, 45),
       ('Mechanical Keyboard', 'Accessories', 899.00, 22),
       ('27-inch monitor', 'Monitors', 3299.00, 14),
       ('USB-C hub', 'Accessories', 699.00, 30),
       ('HD webcam', 'Accessories', 799.00, 18),
       ('Gaming headset', 'Audio', 1199.00, 16),
       ('Bluetooth speaker', 'Audio', 1499.00, 12),
       ('External SSD 1 TB', 'Storage', 1099.00, 25),
       ('Laptop stand', 'Accessories', 549.00, 35);

INSERT INTO customers (first_name, last_name, email, city, registered_date)
VALUES ('Ola', 'Nordmann', 'ola.nordmann@example.com', 'Oslo', '2025-01-15'),
       ('Kari', 'Hansen', 'kari.hansen@example.com', 'Bergen', '2025-02-03'),
       ('Per', 'Johansen', 'per.johansen@example.com', 'Trondheim', '2025-02-18'),
       ('Anne', 'Larsen', 'anne.larsen@example.com', 'Oslo', '2025-03-01'),
       ('Thomas', 'Andersen', 'thomas.andersen@example.com', 'Stavanger', '2025-03-12'),
       ('Maria', 'Nilsen', 'maria.nilsen@example.com', 'Kristiansand', '2025-04-05'),
       ('Erik', 'Olsen', 'erik.olsen@example.com', 'Bergen', '2025-04-21'),
       ('Ingrid', 'Berg', 'ingrid.berg@example.com', 'Tromsø', '2025-05-10');

INSERT INTO orders (customer_id, product_id, quantity, order_date, status)
VALUES (1, 1, 1, '2025-06-01', 'Delivered'),
       (1, 2, 2, '2025-06-01', 'Delivered'),
       (2, 4, 1, '2025-06-03', 'Delivered'),
       (3, 3, 1, '2025-06-05', 'Delivered'),
       (4, 5, 2, '2025-06-08', 'Delivered'),
       (5, 7, 1, '2025-06-10', 'Delivered'),
       (6, 8, 1, '2025-06-12', 'Delivered'),
       (7, 9, 2, '2025-06-15', 'Delivered'),
       (2, 2, 1, '2025-07-01', 'Delivered'),
       (3, 5, 1, '2025-07-04', 'Delivered'),
       (4, 4, 2, '2025-07-06', 'Delivered'),
       (5, 9, 1, '2025-07-09', 'Delivered'),
       (1, 9, 1, '2025-08-02', 'Shipped'),
       (3, 2, 3, '2025-08-05', 'Shipped'),
       (5, 4, 1, '2025-08-08', 'Processing'),
       (7, 5, 2, '2025-08-10', 'Processing'),
       (6, 3, 1, '2025-08-12', 'Shipped'),
       (2, 6, 2, '2025-08-15', 'Processing');
