# Jade Dragon Restaurant 🐉

A full-stack Java EE web application for a Chinese restaurant — food ordering, user management, and admin dashboard. Built as the coursework project for **SWE306 Programming Elective II (1)** at **Xiamen University Malaysia**.

一个基于 Java EE 的中华料理餐厅全栈 Web 应用，包含菜品浏览、用户管理和管理后台。本项目为厦门大学马来西亚分校 **SWE306 程序设计选修 II（1）** 课程作业。

---

## Live Demo 在线预览

| URL | Description |
|-----|-------------|
| `http://localhost:8080/JadeDragon/` | Homepage 首页 |
| `http://localhost:8080/JadeDragon/MenuServlet` | Menu 菜单 |
| `http://localhost:8080/JadeDragon/login.jsp` | Login 登录 |
| `http://localhost:8080/JadeDragon/AdminServlet` | Admin Dashboard 管理后台 |

### Test Accounts 测试账号

| Username | Password | Role |
|----------|----------|------|
| `admin` | `admin123` | Administrator |
| `customer1` | `admin123` | Customer |

---

## Features 功能

### Customer 顾客端
- **Homepage** — Featured dishes, popular items, browse by category
- **Menu** — Categorized food cards with images, ratings, prices; search and filter
- **Food Detail** — Ingredients, nutritional info, ratings display, add to cart
- **Shopping Cart** — Add/remove items, quantity adjustment, order notes, delivery fee
- **Order Confirmation** — Summary with order ID, items, total, estimated ready time
- **My Orders** — Order history list
- **Register / Login** — Account creation with validation, session management, access control
- **About Us** — Restaurant story and chef profiles
- **Contact** — Address, phone, email, business hours (static page)
- **FAQ** — Frequently asked questions (accordion)

### Admin 管理后台
- **Dashboard** — Statistics: total orders, revenue, menu items, customer count; recent orders
- **Menu Management** — Add / edit / delete / toggle availability for food items
- **Category Management** — Add / edit / delete categories
- **Order Management** — View all orders, filter by status, view order details

---

## Tech Stack 技术栈

| Layer | Technology |
|-------|------------|
| Backend | Jakarta Servlet 6.0, JSP, JSTL 3.0, Hibernate 6.4 (JPA) |
| Frontend | HTML5, CSS3, Bootstrap 5, Bootstrap Icons |
| Database | MySQL 8.0 (JDBC + Hibernate dual-layer DAO) |
| Server | Apache Tomcat 10.1 (embedded via Cargo Maven Plugin) |
| Build | Maven 3.8+ (wrapper included) |
| Language | Java 21 |

Technologies used: Servlet, JSP, JSTL, JDBC, JavaBeans, Hibernate/JPA — at least three Java EE technologies as required.

---

## Project Structure 项目结构

```
JadeDragon/
├── sql/
│   └── schema.sql                            # Database schema + seed data
├── src/main/
│   ├── resources/
│   │   ├── database.properties.example       # Database config template
│   │   └── hibernate.cfg.xml                 # Hibernate ORM configuration
│   ├── java/com/jadedragon/
│   │   ├── model/                            # POJOs (User, FoodItem, Category, Order, OrderItem, CartItem)
│   │   ├── dao/                              # Data access (JDBC DAOs + Hibernate DAOs)
│   │   ├── controller/                       # Servlets (Home, Menu, FoodDetail, Login, Register, Logout, Cart, Order, Contact)
│   │   │   └── admin/                        # Admin servlets (Dashboard, Menu, Category, Order)
│   │   ├── filter/                           # AuthFilter — authentication & authorization
│   │   └── util/                             # DBConnection, PasswordUtil (SHA-256 + salt)
│   └── webapp/
│       ├── WEB-INF/web.xml                   # Deployment descriptor
│       ├── header.jsp / footer.jsp            # Shared layout fragments
│       ├── css/style.css                     # Custom design system
│       ├── js/main.js / validation.js        # Client-side scripts
│       ├── home.jsp                          # Homepage with hero, featured, popular, categories
│       ├── menu.jsp                          # Menu with search, filter, food cards
│       ├── food-detail.jsp                   # Detailed view with ingredients & nutrition
│       ├── login.jsp / register.jsp          # Authentication pages
│       ├── cart.jsp / order-confirm.jsp      # Order flow
│       ├── my-orders.jsp                     # Customer order history
│       ├── about.jsp / contact.jsp / faq.jsp # Info pages
│       ├── admin/                            # Dashboard, menu-items, categories, orders
│       └── error/                            # 404, 500 error pages
└── pom.xml                                   # Maven configuration
```

---

## Database Schema 数据库设计

5 tables: `users`, `categories`, `food_items`, `orders`, `order_items`

| Table | Description |
|-------|-------------|
| `users` | User accounts (username, email, password, phone, role) |
| `categories` | Food categories (name, description, image) |
| `food_items` | Menu items with name, ingredients, nutritional info, price, image, rating |
| `orders` | Customer orders with total, status, timestamp, notes |
| `order_items` | Line items within an order (food, quantity, add-ons, price) |

Seed data: 5 categories, 26 food items, 2 user accounts. All food items have real photos from Pexels and Unsplash.

---

## Quick Start 快速启动

### Prerequisites 环境要求
- **JDK 21** or higher
- **MySQL 8.0** running on `localhost:3306`

### Setup Steps 配置步骤

```bash
# 1. Clone the repository
git clone https://github.com/Zptt124/FoodOrderingSystem.git
cd FoodOrderingSystem

# 2. Configure database connection
# Copy the template and edit with your own MySQL credentials
cp src/main/resources/database.properties.example src/main/resources/database.properties
# Edit database.properties — set your MySQL username and password:
#   db.url=jdbc:mysql://localhost:3306/jade_dragon?useSSL=false&...
#   db.username=root
#   db.password=your_mysql_password

# 3. Initialize the database
# Run sql/schema.sql in your MySQL client (creates jade_dragon database + seed data)
mysql -u root -p < sql/schema.sql

# 4. Build and run (embedded Tomcat, port 8080)
./mvnw package -DskipTests
./mvnw cargo:run

# 5. Open in browser
# http://localhost:8080/JadeDragon/
```

> **Note:** `database.properties` is gitignored — each developer keeps their own credentials. The `database.properties.example` file is committed as a template for new contributors.

> **注意：** `database.properties` 已被 gitignore 忽略，每位开发者使用自己的数据库密码。`database.properties.example` 作为模板提交。

---

## SWE306 Assignment Requirements 课程要求对照

| Requirement | Status |
|-------------|--------|
| Homepage with featured items | ✅ |
| Menu page: categorized, images, ratings, pricing, quantity, add-ons | ✅ |
| User registration with validation | ✅ |
| Login with session management | ✅ |
| Access restriction for ordering | ✅ |
| Logout mechanism | ✅ |
| Admin: add/edit/delete food items | ✅ |
| Admin: manage categories | ✅ |
| Admin: view customer orders | ✅ |
| Dynamic order processing (DB data, cart, submit, store, confirm) | ✅ |
| JavaScript input validation | ✅ |
| Responsive styling (Bootstrap 5 + CSS) | ✅ |
| At least 3 Java EE technologies (Servlet, JSP, JSTL, JDBC, JavaBeans, Hibernate/JPA) | ✅ |
| MySQL database | ✅ |

---

## Screenshots 截图

| Homepage | Menu | Food Detail |
|----------|------|-------------|
| Hero + Featured + Categories | Search + Filter + Cards | Ingredients + Nutrition |

| Cart | Login | Admin Dashboard |
|------|-------|-----------------|
| Items + Summary + Checkout | Login Form | Stats + Recent Orders |

---

© 2026 Jade Dragon Restaurant | SWE306 Coursework | Xiamen University Malaysia