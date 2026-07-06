# Jade Dragon Restaurant

A Chinese restaurant website with online food ordering and an admin management panel. Customers can browse the menu, register an account, place orders, and check their order history. Admins can manage menu items, categories, and track incoming orders.

---

## Live Demo

| URL | Description |
|-----|-------------|
| `http://localhost:8080/JadeDragon/` | Homepage |
| `http://localhost:8080/JadeDragon/MenuServlet` | Menu |
| `http://localhost:8080/JadeDragon/login.jsp` | Login |
| `http://localhost:8080/JadeDragon/AdminServlet` | Admin Dashboard |

### Test Accounts

| Username | Password | Role |
|----------|----------|------|
| `admin` | `admin123` | Administrator |
| `customer1` | `admin123` | Customer |

---

## Features

### Customer
- **Homepage** — Featured dishes, popular items, browse by category
- **Menu** — Food cards with images, ratings, prices; search and filter by category
- **Food Detail** — Ingredients, nutritional info, add to cart with quantity and add-ons
- **Shopping Cart** — Add/remove items, adjust quantity, order notes, delivery fee
- **Order Confirmation** — Order summary with items, total, and estimated ready time
- **My Orders** — View past orders and their current status
- **Register / Login** — Account creation with validation and session-based authentication
- **About / Contact / FAQ** — Restaurant info, contact form, and common questions

### Admin
- **Dashboard** — Stats overview: total orders, revenue, menu count, customer count
- **Menu Management** — Add, edit, delete, or toggle availability of food items
- **Category Management** — Add, edit, or delete food categories
- **Order Management** — View all orders, filter by status, view details, update status

---

## Tech Stack

| Layer | Technology |
|-------|------------|
| Backend | Jakarta Servlet 6.0, JSP, JSTL 3.0, Hibernate 6.4 |
| Frontend | HTML5, CSS3, Bootstrap 5, Bootstrap Icons |
| Database | MySQL 8.0 (JDBC + Hibernate) |
| Server | Apache Tomcat 10.1 (via Cargo Maven Plugin) |
| Build | Maven (wrapper included) |
| Language | Java 21 |

---

## Project Structure

```
JadeDragon/
├── sql/
│   └── schema.sql                            # Database schema and seed data
├── src/main/
│   ├── resources/
│   │   ├── database.properties.example       # Database config template
│   │   └── hibernate.cfg.xml                 # Hibernate ORM config
│   ├── java/com/jadedragon/
│   │   ├── model/                            # User, FoodItem, Category, Order, OrderItem, CartItem
│   │   ├── dao/                              # JDBC DAOs and Hibernate DAOs
│   │   ├── controller/                       # Customer-facing servlets
│   │   │   └── admin/                        # Admin servlets (Dashboard, Menu, Category, Order)
│   │   ├── filter/                           # AuthFilter
│   │   └── util/                             # DBConnection, PasswordUtil
│   └── webapp/
│       ├── WEB-INF/web.xml
│       ├── header.jsp / footer.jsp
│       ├── css/style.css
│       ├── js/main.js / validation.js
│       ├── img/                              # Food and category images
│       ├── home.jsp / menu.jsp / food-detail.jsp
│       ├── login.jsp / register.jsp
│       ├── cart.jsp / order-confirm.jsp / my-orders.jsp
│       ├── about.jsp / contact.jsp / faq.jsp
│       ├── admin/                            # Dashboard, menu-items, categories, orders
│       └── error/                            # 404, 500
└── pom.xml
```

---

## Database

5 tables: `users`, `categories`, `food_items`, `orders`, `order_items`

| Table | What it stores |
|-------|----------------|
| `users` | Username, email, password, phone, role (customer/admin) |
| `categories` | Category name, description, image |
| `food_items` | Name, ingredients, nutrition info, price, image, rating |
| `orders` | Customer order: total, status, date, notes |
| `order_items` | Each item in an order: food, quantity, add-ons, price |

Comes with seed data: 5 categories, 26 food items, and 2 user accounts. Images are stored locally under `src/main/webapp/img/`.

---

## Quick Start

### What you need
- JDK 21+
- MySQL 8.0 running on `localhost:3306`

### Steps

```bash
# 1. Clone
git clone https://github.com/Zptt124/FoodOrderingSystem.git
cd FoodOrderingSystem

# 2. Set up your database connection
cp src/main/resources/database.properties.example src/main/resources/database.properties
# Open database.properties and fill in your MySQL username and password

# 3. Create the database and populate seed data
mysql -u root -p < sql/schema.sql

# 4. Build and run
./mvnw package -DskipTests
./mvnw cargo:run

# 5. Open
# http://localhost:8080/JadeDragon/
```

> `database.properties` is gitignored so your credentials stay private. Use `database.properties.example` as the template.