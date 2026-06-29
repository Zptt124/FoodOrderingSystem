-- ============================================
-- Food Ordering System - Database Schema
-- Database: food_ordering_system
-- ============================================

CREATE DATABASE IF NOT EXISTS food_ordering_system
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;

USE food_ordering_system;

-- ============================================
-- 1. Users table
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    user_id   INT AUTO_INCREMENT PRIMARY KEY,
    username  VARCHAR(50)  NOT NULL UNIQUE,
    password  VARCHAR(255) NOT NULL,
    role      VARCHAR(20)  NOT NULL DEFAULT 'customer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- 2. Categories table
-- ============================================
CREATE TABLE IF NOT EXISTS categories (
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO categories (category_name) VALUES
('Signature Dishes'),
('Cold Appetizers'),
('Staples & Dim Sum'),
('Soups & Beverages');

-- ============================================
-- 3. Menu Items table
-- ============================================
CREATE TABLE IF NOT EXISTS menu_items (
    item_id     INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100)   NOT NULL,
    price       DECIMAL(10, 2) NOT NULL,
    description TEXT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
        ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO menu_items (name, price, description, category_id) VALUES
('Beijing Roast Duck',       168.00, 'Fruitwood-roasted, crispy skin with tender meat, served with pancakes and sweet bean sauce', 1),
('Mapo Tofu',                 32.00, 'Authentic Sichuan-style, numbing-spicy and aromatic, perfect with rice',            1),
('Smashed Cucumber Salad',    18.00, 'Garlic-infused, crisp and refreshing, a perfect palate cleanser',                2),
('Yangzhou Fried Rice',       28.00, 'Golden grains with shrimp, char siu, and green peas',                            3),
('West Lake Beef Soup',       38.00, 'Traditional Jiangnan delicacy, rich and velvety smooth',                        4);

-- ============================================
-- 4. Orders table
-- ============================================
CREATE TABLE IF NOT EXISTS orders (
    order_id    INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT            NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    order_time  TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- 5. Order Details table
-- ============================================
CREATE TABLE IF NOT EXISTS order_details (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id  INT            NOT NULL,
    item_id   INT            NOT NULL,
    quantity  INT            NOT NULL,
    price     DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE,
    FOREIGN KEY (item_id)  REFERENCES menu_items(item_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- Default admin user
-- IMPORTANT: Register through the app after deployment — passwords are SHA-256 hashed with salt.
-- This seed record uses a pre-computed hash of 'admin123' for demo purposes only.
-- Each deployment should set its own admin password via the application.
-- ============================================
INSERT INTO users (username, password, role)
VALUES ('admin', '6xq6Gi7D1O5LJunqRsMhwQ==:rVE3kzNrtR5Nj9FeaFmp382b24RfHkSXLaceVDrOf4M=', 'admin')
ON DUPLICATE KEY UPDATE username = username;
