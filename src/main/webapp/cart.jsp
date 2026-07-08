<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp?redirect=cart.jsp");
        return;
    }
%>

<!-- Page Header -->
<section class="page-header">
    <div class="container">
        <h1><i class="bi bi-cart3 me-2"></i>Your Cart</h1>
        <p>Review your selections before placing your order</p>
    </div>
</section>

<section style="background: var(--cream); min-height: 60vh; padding: 40px 0;">
<div class="container">
    <c:choose>
        <%-- Cart has items --%>
        <c:when test="${not empty sessionScope.cart}">
            <div class="row">
                <!-- Cart Items -->
                <div class="col-lg-8">
                    <div class="cart-table">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Price</th>
                                    <th class="text-center">Quantity</th>
                                    <th>Subtotal</th>
                                    <th class="text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${sessionScope.cart}">
                                    <tr>
                                        <td>
                                            <strong>${item.foodName}</strong>
                                            <c:if test="${not empty item.addOns}">
                                                <br><small class="text-muted">
                                                    <i class="bi bi-plus-circle"></i> ${item.addOns}
                                                </small>
                                            </c:if>
                                        </td>
                                        <td>RM <fmt:formatNumber value="${item.unitPrice}" pattern="#0.00"/></td>
                                        <td class="text-center" style="min-width:140px;">
                                            <form action="CartServlet" method="post" class="d-flex align-items-center justify-content-center gap-1">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="foodId" value="${item.foodId}">
                                                <button type="button" class="btn btn-sm btn-outline-secondary qty-dec" style="border-radius:var(--radius-full);width:32px;height:32px;padding:0;line-height:1;">
                                                    <i class="bi bi-dash"></i>
                                                </button>
                                                <input type="number" name="quantity" value="${item.quantity}"
                                                       min="1" max="20" class="form-control form-control-sm qty-input"
                                                       onchange="this.form.submit()">
                                                <button type="button" class="btn btn-sm btn-outline-secondary qty-inc" style="border-radius:var(--radius-full);width:32px;height:32px;padding:0;line-height:1;">
                                                    <i class="bi bi-plus"></i>
                                                </button>
                                            </form>
                                        </td>
                                        <td><strong>RM <fmt:formatNumber value="${item.subtotal}" pattern="#0.00"/></strong></td>
                                        <td class="text-end">
                                            <form action="CartServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="foodId" value="${item.foodId}">
                                                <button type="submit" class="btn btn-sm"
                                                        style="color:var(--red);background:transparent;border:none;"
                                                        title="Remove item">
                                                    <i class="bi bi-trash3" style="font-size:1.1rem;"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-3">
                        <a href="CartServlet?action=clear"
                           class="btn btn-outline-danger btn-sm"
                           onclick="return confirm('Are you sure you want to clear your entire cart?')">
                            <i class="bi bi-cart-x"></i> Clear Cart
                        </a>
                        <a href="MenuServlet" class="btn btn-outline-primary btn-sm ms-2">
                            <i class="bi bi-arrow-left"></i> Continue Shopping
                        </a>
                    </div>
                </div>

                <!-- Cart Summary Sidebar — uses request attributes from CartServlet -->
                <div class="col-lg-4">
                    <div class="cart-summary">
                        <h4><i class="bi bi-receipt me-2"></i>Order Summary</h4>

                        <c:forEach var="item" items="${sessionScope.cart}">
                            <div class="d-flex justify-content-between align-items-center mb-2" style="font-size:0.9rem;">
                                <span style="max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
                                    ${item.foodName}
                                    <span class="text-muted">x${item.quantity}</span>
                                </span>
                                <span>RM <fmt:formatNumber value="${item.subtotal}" pattern="#0.00"/></span>
                            </div>
                        </c:forEach>

                        <hr>

                        <div class="d-flex justify-content-between mb-2" style="font-size:0.92rem;">
                            <span>Subtotal</span>
                            <span>RM <fmt:formatNumber value="${cartSubtotal}" pattern="#0.00"/></span>
                        </div>

                        <div class="d-flex justify-content-between mb-2" style="font-size:0.92rem;">
                            <span>Delivery Fee</span>
                            <span>
                                <c:choose>
                                    <c:when test="${isFreeDelivery}">
                                        <span class="text-success fw-bold">FREE</span>
                                        <small class="text-muted text-decoration-line-through ms-1">RM 3.00</small>
                                    </c:when>
                                    <c:otherwise>
                                        RM <fmt:formatNumber value="${deliveryFee}" pattern="#0.00"/>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>

                        <c:choose>
                            <c:when test="${isFreeDelivery}">
                                <small class="text-success d-block mb-2">
                                    <i class="bi bi-check-circle-fill"></i> Free delivery unlocked! Orders over RM 50 qualify.
                                </small>
                            </c:when>
                            <c:otherwise>
                                <small class="text-muted d-block mb-2">
                                    <i class="bi bi-info-circle"></i> Add RM <fmt:formatNumber value="${amountToFree}" pattern="#0.00"/> more for free delivery.
                                </small>
                            </c:otherwise>
                        </c:choose>

                        <hr>

                        <div class="d-flex justify-content-between mb-3" style="font-size:1.2rem; font-weight:700;">
                            <span>Total</span>
                            <span style="color:var(--red);">RM <fmt:formatNumber value="${cartTotal}" pattern="#0.00"/></span>
                        </div>

                        <form action="OrderServlet" method="post" id="checkoutForm">
                            <input type="hidden" name="action" value="checkout">
                            <div class="mb-3">
                                <label for="orderNotes" class="form-label">
                                    <i class="bi bi-pencil"></i> Order Notes
                                </label>
                                <textarea name="notes" id="orderNotes" class="form-control" rows="2"
                                          maxlength="200"
                                          placeholder="Special requests, allergies, etc.">${param.notes}</textarea>
                                <small class="text-muted mt-1 d-block" id="notesCharCount">0/200</small>
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg w-100">
                                <i class="bi bi-check-circle"></i> Place Order
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:when>

        <%-- Empty Cart --%>
        <c:otherwise>
            <div class="empty-state">
                <div class="empty-icon">
                    <i class="bi bi-cart3"></i>
                </div>
                <h4>Your cart is empty</h4>
                <p>Looks like you haven't added anything yet. Browse our menu and discover delicious dishes!</p>
                <a href="MenuServlet" class="btn btn-primary btn-lg">
                    <i class="bi bi-grid"></i> Browse Menu
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</section>

<!-- Quantity +/- button handlers (JavaScript for client-side interaction) -->
<script>
(function() {
    document.querySelectorAll('.qty-dec').forEach(function(btn) {
        btn.addEventListener('click', function() {
            var form = this.closest('form');
            var input = form.querySelector('.qty-input');
            var val = parseInt(input.value) || 1;
            if (val > 1) {
                input.value = val - 1;
                form.submit();
            }
        });
    });
    document.querySelectorAll('.qty-inc').forEach(function(btn) {
        btn.addEventListener('click', function() {
            var form = this.closest('form');
            var input = form.querySelector('.qty-input');
            var val = parseInt(input.value) || 1;
            if (val < 20) {
                input.value = val + 1;
                form.submit();
            }
        });
    });
})();
</script>

<%@ include file="footer.jsp" %>
