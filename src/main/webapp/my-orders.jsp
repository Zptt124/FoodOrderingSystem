<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>
<%@ page import="com.jadedragon.dao.OrderDAO, com.jadedragon.model.Order, com.jadedragon.model.User, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("login.jsp"); return; }
    OrderDAO orderDAO = new OrderDAO();
    List<Order> myOrders = orderDAO.findByUserId(user.getUserId());
    request.setAttribute("myOrders", myOrders);
%>

<section style="background: #FFF8E7; min-height: 80vh; padding: 40px 0;">
<div class="container">
    <h2 class="section-title">My Orders <span style="font-family: 'Noto Serif SC';">我的订单</span></h2>

    <c:choose>
        <c:when test="${not empty myOrders}">
            <c:forEach var="order" items="${myOrders}">
                <div class="card mb-3">
                    <div class="card-header d-flex justify-content-between align-items-center"
                         style="background: #1A1A2E; color: #FFF8E7;">
                        <div>
                            <strong>Order #${order.orderId}</strong>
                            <small style="opacity: 0.7;"> | ${order.orderDate}</small>
                        </div>
                        <span class="badge" style="background: #D4A843; color: #1A1A2E; font-size: 0.9rem;">
                            ${order.statusCn}
                        </span>
                    </div>
                    <div class="card-body">
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
                                <tr>
                                    <td colspan="2" class="text-end"><strong>Total 总计:</strong></td>
                                    <td><strong style="color: #C41E3A;">RM <fmt:formatNumber value="${order.totalPrice}" pattern="#0.00"/></strong></td>
                                </tr>
                            </tfoot>
                        </table>
                        <c:if test="${not empty order.notes}">
                            <p><small><strong>Notes:</strong> ${order.notes}</small></p>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5">
                <span style="font-size: 4rem;">📋</span>
                <h3>No orders yet 暂无订单</h3>
                <p>Start your culinary journey with Jade Dragon!</p>
                <a href="MenuServlet" class="btn btn-lg" style="background: #C41E3A; color: white;">Order Now 立即点餐</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</section>

<%@ include file="footer.jsp" %>
