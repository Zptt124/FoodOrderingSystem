<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>
<%
    if (request.getAttribute("order") == null) {
        response.sendRedirect("home.jsp");
        return;
    }
%>

<!-- Page Header -->
<section class="page-header">
    <div class="container">
        <h1><i class="bi bi-check-circle me-2"></i>Order Confirmation</h1>
        <p>Your order has been received and is being prepared</p>
    </div>
</section>

<section style="background: var(--cream); min-height: 60vh; padding: 60px 0;">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <!-- Success Confirmation Card -->
            <div class="confirmation-card">
                <div class="check-icon">
                    <i class="bi bi-check-lg"></i>
                </div>
                <h2 style="font-family:var(--font-heading); color: var(--dark);">Order Placed Successfully!</h2>
                <p class="text-muted mb-4">Thank you for ordering from Jade Dragon. We'll have your food ready shortly.</p>

                <!-- Order Details -->
                <div class="card border-0 shadow-sm mb-4" style="background:var(--gray-100);border-radius:var(--radius-md);text-align:left;">
                    <div class="card-body p-4">
                        <div class="row g-3">
                            <div class="col-sm-6">
                                <small class="text-muted d-block">Order Number</small>
                                <strong style="font-size:1.2rem;color:var(--red);">#${order.orderId}</strong>
                            </div>
                            <div class="col-sm-6">
                                <small class="text-muted d-block">Status</small>
                                <span class="status-badge status-${order.status}">${order.statusLabel}</span>
                            </div>
                            <div class="col-sm-6">
                                <small class="text-muted d-block">Order Date</small>
                                <strong>${order.orderDate}</strong>
                            </div>
                            <div class="col-sm-6">
                                <small class="text-muted d-block">Estimated Ready Time</small>
                                <strong><i class="bi bi-clock"></i> 25-35 minutes</strong>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Items -->
                <div class="table-responsive" style="text-align:left;">
                    <table class="table table-borderless align-middle">
                        <thead style="border-bottom:2px solid var(--gray-300);">
                            <tr>
                                <th style="font-size:0.85rem;text-transform:uppercase;letter-spacing:0.04em;color:var(--gray-500);">Item</th>
                                <th class="text-center" style="font-size:0.85rem;text-transform:uppercase;letter-spacing:0.04em;color:var(--gray-500);">Qty</th>
                                <th class="text-end" style="font-size:0.85rem;text-transform:uppercase;letter-spacing:0.04em;color:var(--gray-500);">Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="oi" items="${order.items}">
                                <tr>
                                    <td>
                                        <strong>${oi.foodName}</strong>
                                        <c:if test="${not empty oi.addOns}">
                                            <br><small class="text-muted">
                                                <i class="bi bi-plus-circle"></i> ${oi.addOns}
                                            </small>
                                        </c:if>
                                    </td>
                                    <td class="text-center">${oi.quantity}</td>
                                    <td class="text-end">RM <fmt:formatNumber value="${oi.subtotal}" pattern="#0.00"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr style="border-top:2px solid var(--red);">
                                <td colspan="2" class="text-end"><strong style="font-size:1.1rem;">Total</strong></td>
                                <td class="text-end">
                                    <strong style="font-size:1.2rem;color:var(--red);">RM <fmt:formatNumber value="${order.totalPrice}" pattern="#0.00"/></strong>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>

                <c:if test="${not empty order.notes}">
                    <div class="alert alert-light border mt-3 mb-3" style="text-align:left;">
                        <i class="bi bi-pencil me-2"></i>
                        <strong>Notes:</strong> ${order.notes}
                    </div>
                </c:if>

                <!-- Action Buttons -->
                <div class="d-flex justify-content-center gap-3 flex-wrap mt-4">
                    <a href="MenuServlet" class="btn btn-outline-primary btn-lg">
                        <i class="bi bi-arrow-left"></i> Back to Menu
                    </a>
                    <a href="my-orders.jsp" class="btn btn-primary btn-lg">
                        <i class="bi bi-receipt"></i> View My Orders
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</section>

<%@ include file="footer.jsp" %>