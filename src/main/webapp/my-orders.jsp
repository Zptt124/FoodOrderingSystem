<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>
<%
    if (session.getAttribute("user") == null) { response.sendRedirect("login.jsp"); return; }
    if (request.getAttribute("orders") == null) { response.sendRedirect("OrderServlet"); return; }
%>

<!-- Page Header -->
<section class="page-header">
    <div class="container">
        <h1>My Orders</h1>
        <p>View and track your order history</p>
    </div>
</section>

<!-- Orders Section -->
<section style="background: var(--cream); min-height: 60vh; padding: 40px 0;">
    <div class="container">
        <c:choose>
            <c:when test="${not empty orders}">
                <c:forEach var="order" items="${orders}">
                    <div class="order-card mb-4">
                        <div class="order-card-header">
                            <div>
                                <strong>Order #${order.orderId}</strong>
                                <small class="text-muted ms-2">
                                    <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/>
                                </small>
                            </div>
                            <span class="status-badge status-${order.status}">${order.statusLabel}</span>
                        </div>
                        <div class="order-card-body">
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
                                        <c:forEach var="item" items="${order.items}">
                                            <tr>
                                                <td>${item.foodName}</td>
                                                <td>
                                                    <small class="text-muted">${empty item.addOns ? '-' : item.addOns}</small>
                                                </td>
                                                <td class="text-center">${item.quantity}</td>
                                                <td class="text-end">RM <fmt:formatNumber value="${item.unitPrice}" pattern="#0.00"/></td>
                                                <td class="text-end">RM <fmt:formatNumber value="${item.subtotal}" pattern="#0.00"/></td>
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
                            <c:if test="${not empty order.notes}">
                                <p class="mt-3 mb-0"><small><strong>Notes:</strong> ${order.notes}</small></p>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">
                        <i class="bi bi-receipt"></i>
                    </div>
                    <h4>No Orders Yet</h4>
                    <p>You have not placed any orders. Start your culinary journey with Jade Dragon!</p>
                    <a href="MenuServlet" class="btn btn-primary">
                        <i class="bi bi-grid"></i> Browse Menu
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<%@ include file="footer.jsp" %>