<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    com.jadedragon.model.User currentUser = (com.jadedragon.model.User) session.getAttribute("user");
    boolean isLoggedIn = (currentUser != null);
    boolean isAdmin = isLoggedIn && currentUser.isAdmin();
    Integer cartCount = (Integer) session.getAttribute("cartCount");
    if (cartCount == null) cartCount = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jade Dragon Restaurant | Authentic Chinese Cuisine</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="home.jsp">
            <span class="brand-icon">🐉</span>
            Jade Dragon
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item"><a class="nav-link" href="home.jsp"><i class="bi bi-house-door"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="MenuServlet"><i class="bi bi-grid"></i> Menu</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp"><i class="bi bi-info-circle"></i> About</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp"><i class="bi bi-envelope"></i> Contact</a></li>
                <li class="nav-item"><a class="nav-link" href="faq.jsp"><i class="bi bi-question-circle"></i> FAQ</a></li>
                <% if (isLoggedIn) { %>
                    <% if (isAdmin) { %>
                        <li class="nav-item"><a class="nav-link" href="AdminServlet" style="color: var(--gold-light) !important; font-weight: 600;">
                            <i class="bi bi-speedometer2"></i> Admin
                        </a></li>
                    <% } %>
                    <li class="nav-item">
                        <a class="nav-link cart-badge" href="cart.jsp">
                            <i class="bi bi-cart3" style="font-size: 1.2rem;"></i>
                            <span class="cart-count" id="cartBadge"><%= cartCount > 0 ? cartCount : 0 %></span>
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i> <%= currentUser.getUsername() %>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="my-orders.jsp"><i class="bi bi-receipt"></i> My Orders</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="LogoutServlet"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                        </ul>
                    </li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="login.jsp"><i class="bi bi-box-arrow-in-right"></i> Login</a></li>
                    <li class="nav-item"><a class="nav-link btn btn-outline-gold btn-sm ms-2" href="register.jsp">Register</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
<div style="padding-top: 76px;"></div>