<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%
    com.jadedragon.model.User user = (com.jadedragon.model.User) session.getAttribute("user");
    if (user == null || !user.isAdmin()) { response.sendRedirect("../login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Jade Dragon</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+SC:wght@400;500;700;900&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark" style="background: #1A1A2E; border-bottom: 2px solid #D4A843;">
    <div class="container-fluid">
        <a class="navbar-brand" href="../home.jsp">
            <span style="font-family: 'Noto Serif SC'; color: #D4A843; font-weight: 700;">🐉 玉龙 Admin</span>
        </a>
        <div class="d-flex align-items-center">
            <span style="color: #FFF8E7; margin-right: 15px;">Admin: <%= user.getUsername() %></span>
            <a href="dashboard.jsp" class="btn btn-sm" style="background: #D4A843; color: #1A1A2E; margin-right: 5px;">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
            <a href="menu-items.jsp" class="btn btn-sm btn-outline-light" style="margin-right: 5px;">Menu</a>
            <a href="categories.jsp" class="btn btn-sm btn-outline-light" style="margin-right: 5px;">Categories</a>
            <a href="orders.jsp" class="btn btn-sm btn-outline-light" style="margin-right: 5px;">Orders</a>
            <a href="../LogoutServlet" class="btn btn-sm btn-outline-light">Logout</a>
        </div>
    </div>
</nav>

<div class="container-fluid" style="background: #FFF8E7; min-height: 90vh; padding: 30px;">
    <h3 style="color: #1A1A2E; margin-bottom: 25px;">
        Dashboard <span style="font-family: 'Noto Serif SC'; color: #C41E3A;">管理仪表盘</span>
    </h3>

    <!-- Stats Cards -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card text-center" style="border-left: 4px solid #C41E3A;">
                <div class="card-body">
                    <h1 style="color: #C41E3A; font-weight: 700;">${totalOrders}</h1>
                    <p style="opacity: 0.7;">Total Orders 总订单</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-center" style="border-left: 4px solid #D4A843;">
                <div class="card-body">
                    <h1 style="color: #D4A843; font-weight: 700;">RM <fmt:formatNumber value="${totalRevenue}" pattern="#,###"/></h1>
                    <p style="opacity: 0.7;">Total Revenue 总营收</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-center" style="border-left: 4px solid #2ECC71;">
                <div class="card-body">
                    <h1 style="color: #2ECC71; font-weight: 700;">${totalFoodItems}</h1>
                    <p style="opacity: 0.7;">Menu Items 菜品数</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-center" style="border-left: 4px solid #3498DB;">
                <div class="card-body">
                    <h1 style="color: #3498DB; font-weight: 700;">${totalCustomers}</h1>
                    <p style="opacity: 0.7;">Customers 客户数</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Pending Orders -->
    <div class="card">
        <div class="card-header" style="background: #1A1A2E; color: #D4A843;">
            <strong>Recent Pending Orders 待处理订单</strong>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty recentOrders}">
                    <table class="table table-hover">
                        <thead>
                            <tr><th>Order ID</th><th>Customer</th><th>Total</th><th>Date</th><th>Status</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="o" items="${recentOrders}">
                                <tr>
                                    <td>#${o.orderId}</td>
                                    <td>${o.username}</td>
                                    <td>RM <fmt:formatNumber value="${o.totalPrice}" pattern="#0.00"/></td>
                                    <td><small><fmt:formatDate value="${o.orderDate}" pattern="MM/dd HH:mm"/></small></td>
                                    <td><span class="badge" style="background: #D4A843; color: #1A1A2E;">${o.statusCn}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class="text-center py-3" style="opacity: 0.6;">No pending orders. Database connection required.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
