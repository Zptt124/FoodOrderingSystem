<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jade Dragon Restaurant | Authentic Chinese Cuisine</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home.jsp">
            <span class="brand-icon">🐉</span>
            Jade Dragon
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home.jsp"><i class="bi bi-house-door"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/MenuServlet"><i class="bi bi-grid"></i> Menu</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about.jsp"><i class="bi bi-info-circle"></i> About</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp"><i class="bi bi-envelope"></i> Contact</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/faq.jsp"><i class="bi bi-question-circle"></i> FAQ</a></li>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <c:if test="${sessionScope.user.isAdmin()}">
                            <li class="nav-item"><a class="nav-link admin-nav-link" href="${pageContext.request.contextPath}/AdminServlet">
                                <i class="bi bi-speedometer2"></i> Admin
                            </a></li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link cart-badge" href="${pageContext.request.contextPath}/cart.jsp">
                                <i class="bi bi-cart3 cart-icon"></i>
                                <span class="cart-count" id="cartBadge">
                                    ${not empty sessionScope.cartCount ? sessionScope.cartCount : 0}
                                </span>
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" role="button">
                                <i class="bi bi-person-circle"></i> ${sessionScope.user.username}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/OrderServlet"><i class="bi bi-receipt"></i> My Orders</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/LogoutServlet"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login.jsp"><i class="bi bi-box-arrow-in-right"></i> Login</a></li>
                        <li class="nav-item"><a class="nav-link nav-register-btn" href="${pageContext.request.contextPath}/register.jsp">Register</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
