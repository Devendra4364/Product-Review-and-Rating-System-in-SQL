-- ============================================
-- 6.1 CREATE DATABASE
-- ============================================

CREATE DATABASE IF NOT EXISTS ProductReviewSystem;
USE ProductReviewSystem;

-- ============================================
-- 6.2 CREATE TABLES (3NF FOLLOWED)
-- ============================================

-- USERS TABLE
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CATEGORIES TABLE
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

-- PRODUCTS TABLE
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2),
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) 
        REFERENCES Categories(category_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- REVIEWS TABLE
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) 
        REFERENCES Users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (product_id) 
        REFERENCES Products(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE (user_id, product_id)   -- One review per user per product
);

-- ADMINS TABLE
CREATE TABLE Admins (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    admin_name VARCHAR(50),
    email VARCHAR(100),
    password VARCHAR(100)
);

-- ============================================
-- 6.3 INSERT SAMPLE DATA (DML)
-- ============================================

-- USERS
INSERT INTO Users (username, email, password)
VALUES
('rahul', 'rahul@gmail.com', 'rahul123'),
('neha', 'neha@gmail.com', 'neha123');

-- CATEGORIES
INSERT INTO Categories (category_name)
VALUES
('Electronics'),
('Books'),
('Clothing');

-- PRODUCTS
INSERT INTO Products (product_name, description, price, category_id)
VALUES
('Smartphone', '5G Android Phone', 15000.00, 1),
('DBMS Book', 'Database Concepts Book', 500.00, 2);

-- ADMINS
INSERT INTO Admins (admin_name, email, password)
VALUES
('Admin1', 'admin@gmail.com', 'admin123');

-- ============================================
-- 6.4 TRANSACTION HANDLING
-- ============================================

-- Successful Transaction
START TRANSACTION;

INSERT INTO Reviews (user_id, product_id, rating, review_text)
VALUES (1, 1, 5, 'Excellent phone');

COMMIT;

-- Rollback Scenario (Failure Case)
START TRANSACTION;

-- This will fail because rating > 5
INSERT INTO Reviews (user_id, product_id, rating, review_text)
VALUES (2, 1, 6,'rating review');

ROLLBACK;

-- ============================================
-- 6.5 INSERT VALID REVIEWS
-- ============================================

INSERT INTO Reviews (user_id, product_id, rating, review_text)
VALUES
(2, 1, 4, 'Good but battery is average'),
(1, 2, 5, 'Very helpful book');

-- ============================================
-- 6.6 SELECT QUERIES (DQL)
-- ============================================

-- View Reviews of a Product
SELECT u.username, r.rating, r.review_text
FROM Reviews r
JOIN Users u ON r.user_id = u.user_id
WHERE r.product_id = 1;

-- Average Rating (Dynamic Aggregation)
SELECT p.product_name, AVG(r.rating) AS average_rating
FROM Products p
JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_id;

-- Products with Avg Rating >= 4
SELECT p.product_name, AVG(r.rating) AS avg_rating
FROM Products p
JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_id
HAVING AVG(r.rating) >= 4;

-- Reviews by Specific User
SELECT p.product_name, r.rating, r.review_text
FROM Reviews r
JOIN Products p ON r.product_id = p.product_id
WHERE r.user_id = 1;

-- Top Rated Product
SELECT p.product_name, AVG(r.rating) AS avg_rating
FROM Products p
JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_id
ORDER BY avg_rating DESC
LIMIT 1;

-- Total Reviews per Product
SELECT product_id, COUNT(*) AS total_reviews
FROM Reviews
GROUP BY product_id;

-- ============================================
-- 6.7 UPDATE QUERY
-- ============================================

UPDATE Reviews
SET rating = 5,
    review_text = 'Updated review'
WHERE user_id = 2 AND product_id = 1;

-- ============================================
-- 6.8 DELETE QUERY
-- ============================================

DELETE FROM Reviews
WHERE review_id = 3;