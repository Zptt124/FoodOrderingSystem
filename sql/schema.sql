-- ============================================
-- Jade Dragon Chinese Restaurant
-- Database Schema
-- ============================================

CREATE DATABASE IF NOT EXISTS jade_dragon
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;

USE jade_dragon;

-- ============================================
-- 1. Users Table
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    user_id       INT AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL UNIQUE,
    email         VARCHAR(100) NOT NULL UNIQUE,
    password      VARCHAR(255) NOT NULL,
    phone         VARCHAR(20),
    role          ENUM('customer','admin') NOT NULL DEFAULT 'customer',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 2. Categories Table
-- ============================================
CREATE TABLE IF NOT EXISTS categories (
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(50)  NOT NULL,
    description   TEXT,
    image_url     VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 3. Food Items Table
-- ============================================
CREATE TABLE IF NOT EXISTS food_items (
    food_id        INT AUTO_INCREMENT PRIMARY KEY,
    name           VARCHAR(100) NOT NULL,
    description    TEXT,
    ingredients    TEXT,
    nutritional_info TEXT,
    price          DECIMAL(10,2) NOT NULL,
    image_url      VARCHAR(255),
    category_id    INT,
    rating         DECIMAL(3,2) DEFAULT 0,
    review_count   INT DEFAULT 0,
    is_featured    BOOLEAN DEFAULT FALSE,
    is_popular     BOOLEAN DEFAULT FALSE,
    is_available   BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 4. Orders Table
-- ============================================
CREATE TABLE IF NOT EXISTS orders (
    order_id      INT AUTO_INCREMENT PRIMARY KEY,
    user_id       INT NOT NULL,
    total_price   DECIMAL(10,2) NOT NULL,
    status        ENUM('pending','confirmed','preparing','ready','completed','cancelled') NOT NULL DEFAULT 'pending',
    order_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes         TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- 5. Order Items Table
-- ============================================
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id      INT NOT NULL,
    food_id       INT NOT NULL,
    quantity      INT NOT NULL DEFAULT 1,
    add_ons       VARCHAR(255),
    unit_price    DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (food_id) REFERENCES food_items(food_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Seed Data: Categories
-- ============================================
INSERT INTO categories (category_id, name, description, image_url) VALUES
(1, 'Appetizers',
 'Start your meal with our traditional Chinese appetizers',
 'https://images.unsplash.com/photo-1625220194771-7ebdea0b70b9?w=600&q=80'),

(2, 'Main Course',
 'Hearty and flavorful main dishes from across China',
 'https://images.unsplash.com/photo-1525755662778-989d0524087e?w=600&q=80'),

(3, 'Desserts',
 'Sweet endings inspired by Chinese pastry traditions',
 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=600&q=80'),

(4, 'Beverages',
 'Traditional Chinese teas and refreshing drinks',
 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=600&q=80'),

(5, 'Chef''s Special',
 'Signature dishes crafted by our master chef',
 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=600&q=80');

-- ============================================
-- Seed Data: Admin User
-- Password: admin123 (SHA-256 hashed)
-- ============================================
INSERT INTO users (username, email, password, phone, role) VALUES
('admin', 'admin@jadedragon.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', '+60123456789', 'admin'),
('customer1', 'customer1@email.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', '+60187654321', 'customer');

-- ============================================
-- Seed Data: Food Items
-- ============================================

-- Appetizers (category_id=1)
INSERT INTO food_items (name, description, ingredients, nutritional_info, price, image_url, category_id, is_featured, is_popular, rating, review_count) VALUES
('Spring Rolls',
 'Crispy golden spring rolls filled with shredded vegetables and served with sweet chili dipping sauce.',
 'Cabbage, Carrots, Bean Sprouts, Mushrooms, Rice Paper, Soy Sauce, Sesame Oil',
 'Per serving (2 rolls): 180 kcal, 8g Protein, 22g Carbs, 7g Fat',
 18.00, 'https://images.pexels.com/photos/18545630/pexels-photo-18545630.jpeg?w=600', 1, TRUE, TRUE, 4.5, 128),

('Dumplings (6 pcs)',
 'Hand-folded pork and chive dumplings, steamed or pan-fried to perfection with ginger-soy dipping sauce.',
 'Pork, Chinese Chives, Ginger, Garlic, Soy Sauce, Sesame Oil, Wheat Flour',
 'Per serving (6 pcs): 320 kcal, 18g Protein, 28g Carbs, 14g Fat',
 22.00, 'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?w=600&q=80', 1, TRUE, TRUE, 4.7, 203),

('Wonton Soup',
 'Delicate pork and shrimp wontons swimming in a clear, aromatic broth with spring onions and sesame.',
 'Pork, Shrimp, Wonton Wrappers, Chicken Broth, Spring Onion, Ginger, Sesame Oil',
 'Per bowl: 250 kcal, 15g Protein, 20g Carbs, 10g Fat',
 20.00, 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=600&q=80', 1, FALSE, TRUE, 4.3, 89),

('Scallion Pancakes',
 'Crispy, flaky multi-layered pancakes with fresh scallions, served with soy-vinegar dipping sauce.',
 'Wheat Flour, Scallions, Sesame Oil, Salt, Vegetable Oil',
 'Per serving: 280 kcal, 6g Protein, 32g Carbs, 14g Fat',
 15.00, 'https://images.unsplash.com/photo-1563379926898-05f4575a45d8?w=600&q=80', 1, FALSE, FALSE, 4.1, 67),

('Edamame',
 'Steamed young soybeans tossed with sea salt and a hint of Sichuan pepper.',
 'Soybeans, Sea Salt, Sichuan Pepper, Sesame Oil',
 'Per serving: 180 kcal, 15g Protein, 12g Carbs, 8g Fat',
 14.00, 'https://images.pexels.com/photos/31261434/pexels-photo-31261434.jpeg?w=600', 1, FALSE, FALSE, 4.0, 45);

-- Main Course (category_id=2)
INSERT INTO food_items (name, description, ingredients, nutritional_info, price, image_url, category_id, is_featured, is_popular, rating, review_count) VALUES
('Kung Pao Chicken',
 'Tender diced chicken stir-fried with peanuts, dried chilies, and Sichuan peppercorns in a savory-sweet sauce.',
 'Chicken Thigh, Peanuts, Dried Chilies, Sichuan Peppercorn, Scallions, Garlic, Soy Sauce, Rice Vinegar, Sugar',
 'Per serving: 420 kcal, 32g Protein, 18g Carbs, 22g Fat',
 28.00, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?w=600&q=80', 2, TRUE, TRUE, 4.8, 312),

('Mapo Tofu',
 'Silky tofu cubes in a fiery, numbing Sichuan chili bean paste sauce with minced pork.',
 'Silken Tofu, Minced Pork, Doubanjiang (Chili Bean Paste), Sichuan Peppercorn, Garlic, Ginger, Spring Onion',
 'Per serving: 350 kcal, 22g Protein, 12g Carbs, 24g Fat',
 24.00, 'https://images.pexels.com/photos/5848480/pexels-photo-5848480.jpeg?w=600', 2, TRUE, TRUE, 4.6, 178),

('Sweet & Sour Pork',
 'Crispy battered pork tenderloin tossed in a vibrant sweet and sour sauce with bell peppers and pineapple.',
 'Pork Tenderloin, Bell Peppers, Pineapple, Ketchup, Rice Vinegar, Sugar, Cornstarch',
 'Per serving: 480 kcal, 28g Protein, 36g Carbs, 20g Fat',
 26.00, 'https://images.unsplash.com/photo-1544025162-d76694265947?w=600&q=80', 2, FALSE, TRUE, 4.4, 156),

('Peking Duck (Half)',
 'Roasted duck with crispy skin, served with thin pancakes, hoisin sauce, cucumber, and spring onions.',
 'Duck, Hoisin Sauce, Cucumber, Spring Onion, Pancakes (Wheat Flour), Five-Spice Powder, Maltose',
 'Per serving: 580 kcal, 38g Protein, 30g Carbs, 32g Fat',
 68.00, 'https://images.pexels.com/photos/7363758/pexels-photo-7363758.jpeg?w=600', 2, TRUE, TRUE, 4.9, 421),

('Beef Chow Fun',
 'Wok-fried flat rice noodles with tender sliced beef, bean sprouts, and dark soy sauce — a Cantonese classic.',
 'Flat Rice Noodles, Beef Sirloin, Bean Sprouts, Scallions, Dark Soy Sauce, Light Soy Sauce, Sesame Oil',
 'Per serving: 520 kcal, 30g Protein, 45g Carbs, 18g Fat',
 25.00, 'https://images.unsplash.com/photo-1555126634-323283e090fa?w=600&q=80', 2, FALSE, TRUE, 4.5, 134),

('Yangzhou Fried Rice',
 'Classic Yangzhou-style fried rice with shrimp, char siu pork, eggs, peas, and carrots.',
 'Jasmine Rice, Shrimp, Char Siu Pork, Eggs, Green Peas, Carrots, Scallions, Soy Sauce',
 'Per serving: 450 kcal, 22g Protein, 48g Carbs, 14g Fat',
 22.00, 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=600&q=80', 2, FALSE, FALSE, 4.3, 98),

('Braised Eggplant',
 'Silky braised eggplant in a garlicky soy-based sauce with minced pork and chili — a homestyle favorite.',
 'Eggplant, Minced Pork, Garlic, Ginger, Soy Sauce, Dark Soy Sauce, Chili, Sugar, Cornstarch',
 'Per serving: 300 kcal, 12g Protein, 18g Carbs, 20g Fat',
 20.00, 'https://images.pexels.com/photos/5848478/pexels-photo-5848478.jpeg?w=600', 2, FALSE, FALSE, 4.2, 76),

('Honey Walnut Shrimp',
 'Crispy battered shrimp tossed in a creamy honey-mayo sauce topped with candied walnuts.',
 'Shrimp, Candied Walnuts, Honey, Mayonnaise, Condensed Milk, Lemon Juice, Cornstarch',
 'Per serving: 460 kcal, 24g Protein, 28g Carbs, 26g Fat',
 35.00, 'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=600&q=80', 2, FALSE, TRUE, 4.7, 189);

-- Desserts (category_id=3)
INSERT INTO food_items (name, description, ingredients, nutritional_info, price, image_url, category_id, is_featured, is_popular, rating, review_count) VALUES
('Mango Pudding',
 'Creamy, refreshing mango pudding topped with fresh mango cubes and a drizzle of evaporated milk.',
 'Mango Puree, Gelatin, Evaporated Milk, Sugar, Fresh Mango',
 'Per serving: 220 kcal, 5g Protein, 35g Carbs, 8g Fat',
 16.00, 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=600&q=80', 3, FALSE, TRUE, 4.6, 145),

('Sesame Balls (4 pcs)',
 'Crispy glutinous rice balls coated in sesame seeds, filled with sweet red bean paste.',
 'Glutinous Rice Flour, Red Bean Paste, Sesame Seeds, Sugar, Vegetable Oil',
 'Per serving (4 pcs): 320 kcal, 6g Protein, 48g Carbs, 12g Fat',
 16.00, 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=600&q=80', 3, FALSE, FALSE, 4.3, 92),

('Egg Tarts (3 pcs)',
 'Flaky pastry shells filled with smooth, lightly sweetened egg custard — a dim sum classic.',
 'Wheat Flour, Butter, Eggs, Sugar, Evaporated Milk, Vanilla',
 'Per serving (3 pcs): 340 kcal, 8g Protein, 38g Carbs, 18g Fat',
 18.00, 'https://images.pexels.com/photos/9633532/pexels-photo-9633532.jpeg?w=600', 3, FALSE, TRUE, 4.5, 167),

('Red Bean Soup',
 'Warm, comforting sweet red bean soup with lotus seeds and dried tangerine peel.',
 'Red Beans, Lotus Seeds, Dried Tangerine Peel, Rock Sugar',
 'Per bowl: 200 kcal, 8g Protein, 42g Carbs, 1g Fat',
 14.00, 'https://images.pexels.com/photos/5652183/pexels-photo-5652183.jpeg?w=600', 3, FALSE, FALSE, 4.1, 58),

('Fortune Cookies',
 'Crispy vanilla fortune cookies, each with a special message inside. Comes with 6 pieces.',
 'Wheat Flour, Sugar, Vanilla Extract, Egg Whites, Butter',
 'Per serving (6 pcs): 180 kcal, 4g Protein, 32g Carbs, 3g Fat',
 12.00, 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=600&q=80', 3, FALSE, FALSE, 3.9, 34);

-- Beverages (category_id=4)
INSERT INTO food_items (name, description, ingredients, nutritional_info, price, image_url, category_id, is_featured, is_popular, rating, review_count) VALUES
('Jasmine Tea (Pot)',
 'Fragrant jasmine green tea served in a traditional Chinese teapot. Refreshing and aromatic.',
 'Jasmine Green Tea Leaves, Hot Water',
 'Per pot: 5 kcal, 0g Protein, 1g Carbs, 0g Fat',
 12.00, 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=600&q=80', 4, FALSE, TRUE, 4.4, 112),

('Oolong Tea (Pot)',
 'Semi-oxidized Tie Guan Yin oolong tea with floral notes and a smooth, lingering finish.',
 'Tie Guan Yin Oolong Tea Leaves, Hot Water',
 'Per pot: 5 kcal, 0g Protein, 1g Carbs, 0g Fat',
 14.00, 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=600&q=80', 4, FALSE, FALSE, 4.3, 87),

('Plum Juice',
 'Chilled sweet and sour plum drink — a classic Chinese summer refresher.',
 'Smoked Plums, Hawthorn, Licorice Root, Rock Sugar, Water',
 'Per glass: 120 kcal, 0g Protein, 30g Carbs, 0g Fat',
 10.00, 'https://images.pexels.com/photos/4030788/pexels-photo-4030788.jpeg?w=600', 4, FALSE, FALSE, 4.2, 65),

('Soy Milk',
 'Freshly made warm or cold soybean milk, lightly sweetened.',
 'Soybeans, Water, Sugar',
 'Per glass: 150 kcal, 8g Protein, 16g Carbs, 5g Fat',
 8.00, 'https://images.unsplash.com/photo-1600788907416-456578634209?w=600&q=80', 4, FALSE, FALSE, 4.0, 43),

('Bubble Tea',
 'Classic milk tea with chewy tapioca pearls. Choose black tea or green tea base.',
 'Tapioca Pearls, Black Tea, Milk Powder, Sugar, Water',
 'Per cup: 350 kcal, 4g Protein, 56g Carbs, 10g Fat',
 15.00, 'https://images.unsplash.com/photo-1558857563-b371033873b8?w=600&q=80', 4, FALSE, TRUE, 4.6, 234);

-- Chef's Special (category_id=5)
INSERT INTO food_items (name, description, ingredients, nutritional_info, price, image_url, category_id, is_featured, is_popular, rating, review_count) VALUES
('Buddha Jumps Over the Wall',
 'Our master chef''s legendary soup — a luxurious 24-hour double-boiled broth with abalone, sea cucumber, dried scallops, fish maw, shiitake mushrooms, and Jinhua ham.',
 'Abalone, Sea Cucumber, Dried Scallops, Fish Maw, Shiitake Mushrooms, Jinhua Ham, Chicken, Chinese Herbs',
 'Per serving: 380 kcal, 35g Protein, 15g Carbs, 18g Fat',
 188.00, 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=600&q=80', 5, TRUE, TRUE, 4.9, 312),

('Lobster Noodles',
 'Whole Boston lobster wok-fried with ginger and scallions atop a bed of crispy pan-fried noodles.',
 'Boston Lobster, Egg Noodles, Ginger, Scallions, Shaoxing Wine, Soy Sauce, Oyster Sauce',
 'Per serving: 620 kcal, 42g Protein, 38g Carbs, 28g Fat',
 128.00, 'https://images.pexels.com/photos/20150651/pexels-photo-20150651.jpeg?w=600', 5, TRUE, FALSE, 4.8, 189),

('Imperial Hot Pot',
 'A grand tableside experience: simmering bone broth with premium sliced wagyu beef, fresh seafood, seasonal vegetables, and house-made dipping sauces. For 2-4 persons.',
 'Wagyu Beef Slices, Prawns, Fish Fillet, Tofu, Seasonal Vegetables, Bone Broth, Dipping Sauces',
 'Per pot (for 2-4): 1800 kcal, 120g Protein, 80g Carbs, 90g Fat',
 268.00, 'https://images.pexels.com/photos/30915727/pexels-photo-30915727.jpeg?w=600', 5, FALSE, TRUE, 4.9, 147);