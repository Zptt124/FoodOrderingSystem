# Jade Dragon Restaurant 玉龙中餐馆 🐉

## Authentic Chinese Cuisine | Ordering & Management System

A full-stack Java EE web application for restaurant food ordering and management. Built with Jakarta EE (Servlet 6.0), JSP, MySQL, and Bootstrap 5.

基于 Java EE 的全栈餐饮外卖与管理系统。使用 Jakarta EE (Servlet 6.0)、JSP、MySQL 和 Bootstrap 5 构建。

---

## Features 功能

### Customer 顾客端
- 🏠 **Homepage** — Featured dishes, popular items, category browsing
- 📋 **Menu** — Search, category filtering, food cards with images & ratings
- 🔍 **Food Detail** — Ingredients, nutritional info, reviews, add to cart
- 🛒 **Shopping Cart** — Add/remove items, quantity adjust, order notes
- 📦 **Order Confirmation** — Real-time confirmation with estimated time
- 📜 **My Orders** — View order history with status tracking
- 👤 **Register / Login** — Account creation, password strength indicator, session management
- 📝 **Reviews** — Rate and comment on dishes
- 📄 **About Us** — Restaurant story, chef profiles
- 📧 **Contact** — Contact form with validation
- ❓ **FAQ** — Frequently asked questions accordion

### Admin 管理后台
- 📊 **Dashboard** — Order/revenue/food item/customer statistics
- 🍜 **Menu Management** — Full CRUD for food items (add/edit/delete/toggle availability)
- 📁 **Category Management** — Full CRUD for categories
- 📋 **Order Management** — View all orders, filter by status, update order status

---

## Tech Stack 技术栈

| Layer 层 | Technology 技术 |
|-----------|-----------------|
| **Backend** | Jakarta Servlet 6.0, JSP, JDBC |
| **Frontend** | HTML5, CSS3, Bootstrap 5, Bootstrap Icons |
| **Database** | MySQL 8.0 |
| **Server** | Apache Tomcat 10.1 (embedded via Cargo) |
| **Build** | Maven 3.8+ (wrapper included) |
| **Language** | Java 21 |
| **Version Control** | Git |

---

## Project Structure 项目结构

```
JadeDragon/
├── sql/
│   └── schema.sql                    # Database schema + seed data 数据库建表与初始数据
├── src/main/
│   ├── java/com/jadedragon/
│   │   ├── model/                    # POJOs: User, FoodItem, Category, Order, etc.
│   │   ├── dao/                      # Data Access Objects (plain JDBC)
│   │   ├── controller/               # Servlets (Home, Menu, Cart, Order, Auth...)
│   │   │   └── admin/                # Admin servlets (Dashboard, Menu, Categories, Orders)
│   │   ├── filter/                   # AuthFilter — access control
│   │   └── util/                     # DBConnection, PasswordUtil (SHA-256 + salt)
│   └── webapp/
│       ├── WEB-INF/web.xml           # Jakarta EE configuration
│       ├── header.jsp / footer.jsp   # Shared layout fragments
│       ├── css/style.css             # Custom design system (540+ lines)
│       ├── js/main.js / validation.js # Client-side logic
│       ├── home.jsp / menu.jsp       # Core pages
│       ├── login.jsp / register.jsp  # Authentication
│       ├── cart.jsp / order-confirm.jsp # Order flow
│       ├── food-detail.jsp           # Food detail + reviews
│       ├── about.jsp / contact.jsp / faq.jsp # Info pages
│       ├── my-orders.jsp             # User order history
│       ├── admin/                    # Admin dashboard pages
│       └── error/                    # 404 & 500 error pages
└── pom.xml                           # Maven configuration
```

---

## Quick Start 快速启动

### Prerequisites 环境要求
- **JDK 21** or higher
- **MySQL 8.0** running on `localhost:3306`
- MySQL root password: see `DBConnection.java`

### Setup Steps 启动步骤

```bash
# 1. Clone the repository
git clone https://github.com/Zptt124/FoodOrderingSystem.git
cd FoodOrderingSystem

# 2. Initialize the database
mysql -u root -p < sql/schema.sql

# 3. Build & run (embedded Tomcat on port 8080)
./mvnw package -DskipTests
./mvnw cargo:run

# 4. Open in browser 浏览器打开
# http://localhost:8080/JadeDragon/
```

### Test Accounts 测试账号

| Username | Password | Role |
|----------|----------|------|
| `admin` | `admin123` | Admin 管理员 |
| `customer1` | `admin123` | Customer 顾客 |

---

## Database Schema 数据库设计

7 tables: `users`, `categories`, `food_items`, `orders`, `order_items`, `reviews`, `contact_messages`

Seed data: 5 categories, 26 food items with real food images, 2 user accounts.

---

## Key Design Decisions

- **Plain JDBC** — No ORM for transparency and assignment requirements
- **Session-based Cart** — Cart stored in `HttpSession`, converted to DB record at checkout
- **SHA-256 Password Hashing** — With salt via `PasswordUtil`
- **AuthFilter** — Servlet filter for access control (public/admin/customer-only paths)
- **Responsive Design** — Mobile-first CSS with custom design system (CSS variables)
- **Real Food Images** — Pexels + Unsplash free stock photos for all food items

---

## Screenshots 截图

| Homepage | Menu | Food Detail |
|----------|------|-------------|
| Hero + Featured + Categories | Search + filter + cards | Ingredients + reviews |

| Cart | Order Confirm | Admin Dashboard |
|------|-------------|-----------------|
| Items + summary | Success + details | Stats + orders |

---

## SWE306 Coursework

This project is developed for **SWE306 Programming Elective II (1)** at **Xiamen University Malaysia**, Academic Session 2026/04.

本项目为厦门大学马来西亚分校 **SWE306 程序设计选修 II（1）** 课程项目，2026/04 学期。

### Requirements Fulfilled 满足的要求

- ✅ Java EE technologies: Servlet, JSP, JSTL, JDBC, JavaBeans
- ✅ Frontend: HTML5, CSS3, Bootstrap 5, JavaScript validation
- ✅ User authentication with session management
- ✅ Admin CRUD for menu items & categories
- ✅ Dynamic order processing with database storage
- ✅ Responsive design across devices
- ✅ MySQL database with 7 tables

---

## License

This project is for educational purposes. All food images are from [Pexels](https://pexels.com) and [Unsplash](https://unsplash.com) under their respective free licenses.

---

© 2026 Jade Dragon Restaurant | SWE306 Group Project