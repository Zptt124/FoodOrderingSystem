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
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Jade Dragon</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+SC:wght@400;500;700;900&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark" style="background: #1A1A2E; border-bottom: 2px solid #D4A843;">
    <div class="container-fluid">
        <a class="navbar-brand" href="../home.jsp"><span style="font-family: 'Noto Serif SC'; color: #D4A843; font-weight: 700;">🐉 玉龙 Admin</span></a>
        <div class="d-flex">
            <a href="dashboard.jsp" class="btn btn-sm btn-outline-light" style="margin-right: 5px;">Dashboard</a>
            <a href="menu-items.jsp" class="btn btn-sm btn-outline-light" style="margin-right: 5px;">Menu</a>
            <a href="categories.jsp" class="btn btn-sm btn-outline-light" style="margin-right: 5px;">Categories</a>
            <a href="orders.jsp" class="btn btn-sm" style="background: #D4A843; color: #1A1A2E; margin-right: 5px;">Orders</a>
            <a href="../LogoutServlet" class="btn btn-sm btn-outline-light">Logout</a>
        </div>
    </div>
</nav>

<div class="container-fluid" style="background: #FFF8E7; min-height: 90vh; padding: 30px;">
    <h3 style="color: #1A1A2E; margin-bottom: 20px;">Orders <span style="font-family: 'Noto Serif SC'; color: #C41E3A;">订单管理</span></h3>

    <!-- Status Filter -->
    <div class="mb-3">
        <a href="AdminOrderServlet" class="btn btn-sm ${empty statusFilter ? 'btn-gold' : 'btn-outline-gold'}">All</a>
        <a href="AdminOrderServlet?status=pending" class="btn btn-sm ${statusFilter eq 'pending' ? 'btn-gold' : 'btn-outline-gold'}">Pending</a>
        <a href="AdminOrderServlet?status=confirmed" class="btn btn-sm ${statusFilter eq 'confirmed' ? 'btn-gold' : 'btn-outline-gold'}">Confirmed</a>
        <a href="AdminOrderServlet?status=preparing" class="btn btn-sm ${statusFilter eq 'preparing' ? 'btn-gold' : 'btn-outline-gold'}">Preparing</a>
        <a href="AdminOrderServlet?status=completed" class="btn btn-sm ${statusFilter eq 'completed' ? 'btn-gold' : 'btn-outline-gold'}">Completed</a>
        <a href="AdminOrderServlet?status=cancelled" class="btn btn-sm ${statusFilter eq 'cancelled' ? 'btn-gold' : 'btn-outline-gold'}">Cancelled</a>
    </div>

    <!-- Order Detail -->
    <c:if test="${not empty order}">
        <div class="card mb-3" style="border: 2px solid #D4A843;">
            <div class="card-header d-flex justify-content-between" style="background: #1A1A2E; color: #FFF8E7;">
                <strong>Order #${order.orderId} - ${order.username}</strong>
                <span class="badge" style="background: #D4A843; color: #1A1A2E;">${order.statusCn}</span>
            </div>
            <div class="card-body">
                <table class="table table-sm">
                    <thead><tr><th>Item</th><th>Add-ons</th><th>Qty</th><th>Price</th></tr></thead>
                    <tbody>
                        <c:forEach var="oi" items="${order.items}">
                            <tr>
                                <td>${oi.foodName}<br><small style="color:#C41E3A;">${oi.foodNameCn}</small></td>
                                <td><small>${empty oi.addOns ? '-' : oi.addOns}</small></td>
                                <td>${oi.quantity}</td>
                                <td>RM <fmt:formatNumber value="${oi.subtotal}" pattern="#0.00"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <p><strong>Notes:</strong> ${empty order.notes ? 'None' : order.notes}</p>
                <p><small>Ordered: <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></small></p>

                <!-- Update Status -->
                <form method="post" action="AdminOrderServlet" class="mt-2">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <div class="input-group" style="max-width: 300px;">
                        <select name="newStatus" class="form-select form-select-sm">
                            <option value="pending" ${order.status eq 'pending' ? 'selected' : ''}>Pending 待处理</option>
                            <option value="confirmed" ${order.status eq 'confirmed' ? 'selected' : ''}>Confirmed 已确认</option>
                            <option value="preparing" ${order.status eq 'preparing' ? 'selected' : ''}>Preparing 准备中</option>
                            <option value="ready" ${order.status eq 'ready' ? 'selected' : ''}>Ready 待取餐</option>
                            <option value="completed" ${order.status eq 'completed' ? 'selected' : ''}>Completed 已完成</option>
                            <option value="cancelled" ${order.status eq 'cancelled' ? 'selected' : ''}>Cancelled 已取消</option>
                        </select>
                        <button type="submit" class="btn btn-sm" style="background: #D4A843; color: #1A1A2E;">Update 更新</button>
                    </div>
                </form>
            </div>
        </div>
    </c:if>

    <!-- Orders Table -->
    <div class="card">
        <div class="card-body" style="overflow-x: auto;">
            <table class="table table-hover">
                <thead>
                    <tr><th>ID</th><th>Customer</th><th>Total</th><th>Status</th><th>Date</th><th>Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td>#${o.orderId}</td>
                            <td>${o.username}</td>
                            <td>RM <fmt:formatNumber value="${o.totalPrice}" pattern="#0.00"/></td>
                            <td><span class="badge" style="background: #D4A843; color: #1A1A2E;">${o.statusCn}</span></td>
                            <td><small><fmt:formatDate value="${o.orderDate}" pattern="MM/dd HH:mm"/></small></td>
                            <td>
                                <a href="AdminOrderServlet?action=detail&id=${o.orderId}"
                                   class="btn btn-sm btn-outline-warning"><i class="bi bi-eye"></i> View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
