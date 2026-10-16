SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS practice;
USE practice;

DROP TABLE IF EXISTS activity;
DROP TABLE IF EXISTS category;

CREATE TABLE category
(
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50) NOT NULL
) ENGINE = InnoDB;
CREATE TABLE activity
(
    activity_id       INT AUTO_INCREMENT PRIMARY KEY,
    title             VARCHAR(100) NOT NULL,
    date              DATE,
    estimated_minutes INT,
    status            VARCHAR(20),
    category_id       INT,
    FOREIGN KEY (category_id) REFERENCES category (category_id)
) ENGINE = InnoDB;

INSERT INTO category (name)
VALUES ('Study'),
       ('Work'),
       ('Personal'),
       ('Sport');

INSERT INTO activity (title, date, estimated_minutes, status, category_id)
VALUES ('Read chapter 3', '2026-09-20', 30, 'planned', 1),
       ('Team meeting', '2026-09-21', 60, 'planned', 2),
       ('Grocery shopping', '2026-09-19', 40, 'completed', 3),
       ('Python exercises', '2026-09-22', 90, 'completed', 1),
       ('Football training', '2026-09-23', 75, 'planned', 4), -- last value was missing; I guessed 4
       ('Write report', '2026-09-24', 120, 'planned', 2),
       ('Clean the flat', '2026-09-24', 45, 'planned', 3),
       ('Watch SQL video', '2026-09-25', 28, 'planned', 1),
       ('Evening run', '2026-09-25', 35, 'completed', 4),
       ('Plan the week', '2026-09-27', 15, 'planned', 2);

SELECT *
FROM activity;


