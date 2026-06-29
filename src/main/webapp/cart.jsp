<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>
<%@ page import="java.util.List, com.jadedragon.model.CartItem, java.math.BigDecimal" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp?redirect=cart.jsp");
        return;
    }
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
%>

<section style="background: #FFF8E7; min-height: 80vh; padding: 40px 0;">
<div class="container">
    <h2 class="section-title">Shopping Cart <span style="font-family: 'Noto Serif SC';">购物车</span></h2>

    <c:choose>
        <c:when test="${not empty sessionScope.cart}">
            <div class="row">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-body">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Item 菜品</th>
                                        <th>Price 价格</th>
                                        <th>Qty 数量</th>
                                        <th>Add-ons 附加</th>
                                        <th>Subtotal 小计</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="total" value="0"/>
                                    <c:forEach var="item" items="${sessionScope.cart}">
                                        <c:set var="subtotal" value="${item.unitPrice * item.quantity}"/>
                                        <c:set var="total" value="${total + subtotal}"/>
                                        <tr>
                                            <td>
                                                <strong>${item.foodName}</strong>
                                                <br><small style="font-family: 'Noto Serif SC'; color: #C41E3A;">${item.foodNameCn}</small>
                                            </td>
                                            <td>RM <fmt:formatNumber value="${item.unitPrice}" pattern="#0.00"/></td>
                                            <td>
                                                <form action="CartServlet" method="get" style="display:inline;">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="foodId" value="${item.foodId}">
                                                    <input type="number" name="quantity" value="${item.quantity}"
                                                           min="1" max="10" class="form-control form-control-sm"
                                                           style="width: 60px;" onchange="this.form.submit()">
                                                </form>
                                            </td>
                                            <td><small>${empty item.addOns ? '-' : item.addOns}</small></td>
                                            <td><strong>RM <fmt:formatNumber value="${subtotal}" pattern="#0.00"/></strong></td>
                                            <td>
                                                <a href="CartServlet?action=remove&foodId=${item.foodId}"
                                                   class="btn btn-sm" style="color: #C41E3A;">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <a href="CartServlet?action=clear" class="btn btn-outline-danger btn-sm"
                               onclick="return confirm('Clear cart? 确定清空购物车？')">
                                <i class="bi bi-cart-x"></i> Clear Cart 清空购物车
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card" style="border: 2px solid #D4A843;">
                        <div class="card-body">
                            <h5 style="color: #1A1A2E;">Order Summary 订单摘要</h5>
                            <hr>
                            <c:forEach var="item" items="${sessionScope.cart}">
                                <div class="d-flex justify-content-between" style="font-size: 0.9rem;">
                                    <span>${item.foodName} x${item.quantity}</span>
                                    <span>RM <fmt:formatNumber value="${item.unitPrice * item.quantity}" pattern="#0.00"/></span>
                                </div>
                            </c:forEach>
                            <hr>
                            <div class="d-flex justify-content-between" style="font-size: 1.2rem; font-weight: 700;">
                                <span>Total 总计:</span>
                                <span style="color: #C41E3A;">RM <fmt:formatNumber value="${total}" pattern="#0.00"/></span>
                            </div>

                            <form action="OrderServlet" method="post" class="mt-3">
                                <input type="hidden" name="action" value="checkout">
                                <div class="mb-2">
                                    <label class="form-label">Order Notes 订单备注</label>
                                    <textarea name="notes" class="form-control" rows="2"
                                              placeholder="Special requests..."></textarea>
                                </div>
                                <button type="submit" class="btn btn-lg w-100" style="background: #C41E3A; color: white;">
                                    <i class="bi bi-check-circle"></i> Place Order 下单
                                </button>
                            </form>
                            <a href="MenuServlet" class="btn btn-outline-gold w-100 mt-2">Continue Shopping 继续购物</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5">
                <span style="font-size: 4rem;">🛒</span>
                <h3 style="color: #1A1A2E;">Your cart is empty 购物车为空</h3>
                <p>Start adding delicious Chinese dishes to your cart!</p>
                <a href="MenuServlet" class="btn btn-lg" style="background: #C41E3A; color: white;">
                    Browse Menu 浏览菜单
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</section>

<%@ include file="footer.jsp" %>
