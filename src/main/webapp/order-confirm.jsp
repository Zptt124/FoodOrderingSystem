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

<section style="background: #FFF8E7; min-height: 80vh; padding: 60px 0;">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="text-center mb-4">
                <div style="width: 80px; height: 80px; background: #D4A843; border-radius: 50%;
                            display: inline-flex; align-items: center; justify-content: center; font-size: 2.5rem; color: white;">
                    ✓
                </div>
                <h2 style="color: #1A1A2E; margin-top: 15px;">Order Confirmed! 🎉</h2>
                <p style="font-family: 'Noto Serif SC'; color: #C41E3A;">订单已确认！</p>
            </div>

            <div class="card" style="border: 2px solid #D4A843;">
                <div class="card-body p-4">
                    <div class="text-center mb-3">
                        <h5>Order #${order.orderId}</h5>
                        <span class="badge" style="background: #D4A843; color: #1A1A2E; font-size: 1rem; padding: 8px 20px;">
                            ${order.statusCn}
                        </span>
                    </div>
                    <hr>

                    <h6>Order Details 订单详情:</h6>
                    <table class="table table-sm">
                        <thead>
                            <tr><th>Item</th><th>Qty</th><th>Price</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="oi" items="${order.items}">
                                <tr>
                                    <td>${oi.foodName} <br><small style="color: #C41E3A;">${oi.foodNameCn}</small></td>
                                    <td>${oi.quantity}</td>
                                    <td>RM <fmt:formatNumber value="${oi.subtotal}" pattern="#0.00"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr class="table-active">
                                <td colspan="2"><strong>Total 总计</strong></td>
                                <td><strong style="color: #C41E3A;">RM <fmt:formatNumber value="${order.totalPrice}" pattern="#0.00"/></strong></td>
                            </tr>
                        </tfoot>
                    </table>

                    <p style="font-size: 0.9rem; opacity: 0.7;">
                        <i class="bi bi-clock"></i> Order placed at: ${order.orderDate}<br>
                        Estimated ready time: 25-35 minutes
                    </p>

                    <div class="text-center mt-3">
                        <a href="home.jsp" class="btn btn-outline-gold">Back to Home 返回首页</a>
                        <a href="my-orders.jsp" class="btn" style="background: #C41E3A; color: white;">My Orders 我的订单</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</section>

<%@ include file="footer.jsp" %>
