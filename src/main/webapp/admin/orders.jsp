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
            <a href="${pageContext.request.contextPath}/AdminServlet" class="nav-link">
                <i class="bi bi-house-door"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/AdminMenuServlet" class="nav-link">
                <i class="bi bi-egg-fried"></i> Menu Items
            </a>
            <a href="${pageContext.request.contextPath}/AdminCategoryServlet" class="nav-link">
                <i class="bi bi-folder"></i> Categories
            </a>
            <a href="${pageContext.request.contextPath}/AdminOrderServlet" class="nav-link active">
                <i class="bi bi-cart-check"></i> Orders
            </a>
        </nav>
    </div>

    <!-- Admin Main Content -->
    <div class="admin-main">
        <h3 style="font-family: var(--font-heading); margin-bottom: 20px;">
            <i class="bi bi-receipt me-2"></i>Orders
        </h3>

        <!-- Status Filter Tabs -->
        <div class="mb-4">
            <div class="custom-tabs">
                <a href="${pageContext.request.contextPath}/AdminOrderServlet" class="custom-tab ${empty currentFilter ? 'active' : ''}">All</a>
                <a href="${pageContext.request.contextPath}/AdminOrderServlet?status=pending" class="custom-tab ${currentFilter eq 'pending' ? 'active' : ''}">Pending</a>
                <a href="${pageContext.request.contextPath}/AdminOrderServlet?status=confirmed" class="custom-tab ${currentFilter eq 'confirmed' ? 'active' : ''}">Confirmed</a>
                <a href="${pageContext.request.contextPath}/AdminOrderServlet?status=preparing" class="custom-tab ${currentFilter eq 'preparing' ? 'active' : ''}">Preparing</a>
                <a href="${pageContext.request.contextPath}/AdminOrderServlet?status=ready" class="custom-tab ${currentFilter eq 'ready' ? 'active' : ''}">Ready</a>
                <a href="${pageContext.request.contextPath}/AdminOrderServlet?status=completed" class="custom-tab ${currentFilter eq 'completed' ? 'active' : ''}">Completed</a>
                <a href="${pageContext.request.contextPath}/AdminOrderServlet?status=cancelled" class="custom-tab ${currentFilter eq 'cancelled' ? 'active' : ''}">Cancelled</a>
            </div>
        </div>

        <!-- Order Detail View (when viewing a specific order) -->
        <c:if test="${not empty order}">
            <div class="card mb-4" style="border: 2px solid var(--gold); border-radius: var(--radius-md);">
                <div class="card-header d-flex justify-content-between align-items-center" style="background: var(--dark); color: var(--white); border-radius: var(--radius-md) var(--radius-md) 0 0;">
                    <strong>Order #${order.orderId} - ${order.username}</strong>
                    <span class="status-badge status-${order.status}">${order.statusLabel}</span>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-sm mb-0">
                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Add-Ons</th>
                                    <th class="text-center">Qty</th>
                                    <th class="text-end">Unit Price</th>
                                    <th class="text-end">Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="oi" items="${order.items}">
                                    <tr>
                                        <td>${oi.foodName}</td>
                                        <td><small class="text-muted">${empty oi.addOns ? '-' : oi.addOns}</small></td>
                                        <td class="text-center">${oi.quantity}</td>
                                        <td class="text-end">RM <fmt:formatNumber value="${oi.unitPrice}" pattern="#0.00"/></td>
                                        <td class="text-end">RM <fmt:formatNumber value="${oi.subtotal}" pattern="#0.00"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="text-end"><strong>Total:</strong></td>
                                    <td class="text-end">
                                        <strong style="color: var(--red);">
                                            RM <fmt:formatNumber value="${order.totalPrice}" pattern="#0.00"/>
                                        </strong>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <p class="mt-3 mb-1"><strong>Notes:</strong> ${empty order.notes ? 'None' : order.notes}</p>
                    <p class="mb-3"><small class="text-muted">Ordered: <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></small></p>

                    <!-- Update Status -->
                    <form method="post" action="${pageContext.request.contextPath}/AdminOrderServlet" class="mt-2">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="orderId" value="${order.orderId}">
                        <div class="input-group" style="max-width: 350px;">
                            <select name="newStatus" class="form-select form-select-sm">
                                <option value="pending" ${order.status eq 'pending' ? 'selected' : ''}>Pending</option>
                                <option value="confirmed" ${order.status eq 'confirmed' ? 'selected' : ''}>Confirmed</option>
                                <option value="preparing" ${order.status eq 'preparing' ? 'selected' : ''}>Preparing</option>
                                <option value="ready" ${order.status eq 'ready' ? 'selected' : ''}>Ready</option>
                                <option value="completed" ${order.status eq 'completed' ? 'selected' : ''}>Completed</option>
                                <option value="cancelled" ${order.status eq 'cancelled' ? 'selected' : ''}>Cancelled</option>
                            </select>
                            <button type="submit" class="btn btn-gold btn-sm">Update</button>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>

        <!-- Orders Table -->
        <div class="card" style="border: none; border-radius: var(--radius-md); box-shadow: var(--shadow-sm);">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="admin-table table mb-0">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Items</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="o" items="${orders}">
                                <tr>
                                    <td><strong>#${o.orderId}</strong></td>
                                    <td>${o.username}</td>
                                    <td>${o.items != null ? o.items.size() : 0}</td>
                                    <td>RM <fmt:formatNumber value="${o.totalPrice}" pattern="#0.00"/></td>
                                    <td><span class="status-badge status-${o.status}">${o.statusLabel}</span></td>
                                    <td><small><fmt:formatDate value="${o.orderDate}" pattern="MM/dd HH:mm"/></small></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/AdminOrderServlet?action=detail&id=${o.orderId}" class="btn btn-sm btn-outline-primary">
                                            <i class="bi bi-eye"></i> View
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty orders}">
                                <tr>
                                    <td colspan="7" class="text-center py-4 text-muted">No orders found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
