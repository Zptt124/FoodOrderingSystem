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
    <title>Jade Dragon Chinese Restaurant 玉龙中餐馆</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+SC:wght@400;500;700;900&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background: linear-gradient(135deg, #1A1A2E 0%, #2D1B2E 100%); border-bottom: 2px solid #D4A843;">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="home.jsp">
            <span style="font-family: 'Noto Serif SC', serif; font-size: 1.6rem; color: #D4A843; font-weight: 700;">
                🐉 玉龙
            </span>
            <span style="font-family: 'Poppins', sans-serif; font-size: 0.9rem; color: #FFF8E7; margin-left: 8px; font-weight: 300;">
                Jade Dragon
            </span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item"><a class="nav-link" href="home.jsp">Home 首页</a></li>
                <li class="nav-item"><a class="nav-link" href="MenuServlet">Menu 菜单</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp">About 关于我们</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact 联系我们</a></li>
                <li class="nav-item"><a class="nav-link" href="faq.jsp">FAQ</a></li>
                <% if (isLoggedIn) { %>
                    <% if (isAdmin) { %>
                        <li class="nav-item"><a class="nav-link" href="AdminServlet" style="color: #D4A843 !important;">
                            <i class="bi bi-speedometer2"></i> Admin 后台
                        </a></li>
                    <% } %>
                    <li class="nav-item">
                        <a class="nav-link position-relative" href="cart.jsp">
                            <i class="bi bi-cart3" style="font-size: 1.2rem;"></i>
                            <% if (cartCount > 0) { %>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.65rem;">
                                    <%= cartCount %>
                                </span>
                            <% } %>
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i> <%= currentUser.getUsername() %>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="my-orders.jsp">My Orders 我的订单</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="LogoutServlet">Logout 退出</a></li>
                        </ul>
                    </li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Login 登录</a></li>
                    <li class="nav-item"><a class="nav-link btn btn-outline-gold btn-sm ms-2" href="register.jsp">Register 注册</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
<div style="padding-top: 76px;"></div> <!-- Offset for fixed navbar -->
