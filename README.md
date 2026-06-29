# Food Ordering and Restaurant Management System

A full-stack Java EE web application that enables customer-side food ordering and admin-side restaurant management.

---

## Features

- Browse categorized food menus with detailed item information
- User authentication with session management and access control
- Shopping cart, checkout workflow, and order confirmation
- Admin dashboard with full CRUD for menu items and categories
- Complete order records with customer and transaction details
- Responsive interface across all devices

---

## Setup

### Prerequisites

- JDK 8+
- Apache Tomcat 9.0+
- MySQL 8.0+

### Installation

1. Import `/database/schema.sql` into your MySQL database
2. Update database credentials in the DB utility class
3. Import the project as a **Dynamic Web Project** in your IDE
4. Configure and start the Apache Tomcat server
5. Visit: [http://localhost:8080/SWE306-FoodOrderingSystem/](http://localhost:8080/SWE306-FoodOrderingSystem/)

---

## Tech Stack

| Layer       | Technology                           |
|-------------|--------------------------------------|
| Frontend UI | HTML5, CSS3, Bootstrap 5, JavaScript |
| Backend     | Servlets, JSP, JavaBeans, JDBC       |
| Database    | MySQL 8.0+                           |
| Runtime     | Apache Tomcat 9.0+                   |

---

## Project Structure

```plaintext
FoodOrderingSystem/
├── src/com/swe306/
│   ├── bean/         # Entity classes
│   ├── servlet/      # Controller servlets
│   └── util/         # Utility classes
├── webapp/
│   ├── assets/       # Static resources
│   ├── pages/        # JSP pages
│   └── WEB-INF/
│       └── web.xml
└── database/
    └── schema.sql
```
