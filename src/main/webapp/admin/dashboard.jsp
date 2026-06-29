<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%
    com.jadedragon.model.User sessionUser = (com.jadedragon.model.User) session.getAttribute("user");
    if (sessionUser == null || !sessionUser.isAdmin()) { response.sendRedirect("../login.jsp"); return; }
%>
<%@ include file="../header.jsp" %>

<div class="admin-layout">
    <!-- Admin Sidebar -->
    <div class="admin-sidebar">
        <div class="px-3 mb-4">
            <h5 class="text-white mb-0" style="font-family: var(--font-heading);">
                <i class="bi bi-speedometer2" style="color: var(--gold);"></i> Admin Panel
            </h5>
        </div>
        <nav class="d-flex flex-column">
            <a href="${pageContext.request.contextPath}/AdminServlet" class="nav-link active">
                <i class="bi bi-house-door"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/AdminMenuServlet" class="nav-link">
                <i class="bi bi-egg-fried"></i> Menu Items
            </a>
            <a href="${pageContext.request.contextPath}/AdminCategoryServlet" class="nav-link">
                <i class="bi bi-folder"></i> Categories
            </a>
            <a href="${pageContext.request.contextPath}/AdminOrderServlet" class="nav-link">
                <i class="bi bi-cart-check"></i> Orders
            </a>
        </nav>
    </div>

    <!-- Admin Main Content -->
    <div class="admin-main">
        <h3 class="mb-4" style="font-family: var(--font-heading);">Dashboard</h3>

        <!-- Stat Cards -->
        <div class="row mb-4">
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="stat-card">
                    <div class="stat-icon red">
                        <i class="bi bi-cart-check"></i>
                    </div>
                    <div>
                        <h3>${not empty orderCount ? orderCount : 0}</h3>
                        <p>Total Orders</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="stat-card">
                    <div class="stat-icon gold">
                        <i class="bi bi-currency-dollar"></i>
                    </div>
                    <div>
                        <h3>
                            <c:choose>
                                <c:when test="${not empty revenue}">
                                    RM <fmt:formatNumber value="${revenue}" pattern="#,##0.00"/>
                                </c:when>
                                <c:otherwise>RM 0.00</c:otherwise>
                            </c:choose>
                        </h3>
                        <p>Total Revenue</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <i class="bi bi-egg-fried"></i>
                    </div>
                    <div>
                        <h3>${not empty foodCount ? foodCount : 0}</h3>
                        <p>Total Menu Items</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="stat-card">
                    <div class="stat-icon green">
                        <i class="bi bi-people"></i>
                    </div>
                    <div>
                        <h3>${not empty customerCount ? customerCount : 0}</h3>
                        <p>Total Customers</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Pending Orders -->
        <div class="card" style="border: none; border-radius: var(--radius-md); box-shadow: var(--shadow-sm);">
            <div class="card-header" style="background: var(--dark); color: var(--white); border-radius: var(--radius-md) var(--radius-md) 0 0;">
                <strong><i class="bi bi-clock-history"></i> Recent Pending Orders</strong>
            </div>
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${not empty pendingOrders}">
                        <div class="table-responsive">
                            <table class="admin-table table mb-0">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Total</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="o" items="${pendingOrders}">
                                        <tr>
                                            <td><strong>#${o.orderId}</strong></td>
                                            <td>${o.username}</td>
                                            <td>RM <fmt:formatNumber value="${o.totalPrice}" pattern="#0.00"/></td>
                                            <td><small><fmt:formatDate value="${o.orderDate}" pattern="MM/dd HH:mm"/></small></td>
                                            <td><span class="status-badge status-${o.status}">${o.statusLabel}</span></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/AdminOrderServlet?action=detail&id=${o.orderId}" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-eye"></i> View
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-4">
                            <i class="bi bi-check-circle" style="font-size: 2rem; color: var(--gray-300);"></i>
                            <p class="text-muted mt-2 mb-0">No pending orders</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>