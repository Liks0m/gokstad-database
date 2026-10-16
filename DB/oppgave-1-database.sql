CREATE DATABASE IF NOT EXISTS nettbutikk;
USE nettbutikk;

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
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products (product_id)
);