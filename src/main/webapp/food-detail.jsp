<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>

<%
    if (request.getAttribute("food") == null) {
        response.sendRedirect("menu.jsp");
        return;
    }
%>

<section style="background: #FFF8E7; min-height: 80vh; padding: 40px 0;">
<div class="container">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
            <li class="breadcrumb-item"><a href="MenuServlet">Menu</a></li>
            <li class="breadcrumb-item active">${food.name}</li>
        </ol>
    </nav>

    <div class="row">
        <!-- Food Image -->
        <div class="col-lg-6 mb-4">
            <div style="background: linear-gradient(135deg, #C41E3A, #8B1A2B); border-radius: 16px;
                        height: 350px; display: flex; align-items: center; justify-content: center;
                        color: white; font-size: 6rem;">
                🍲
            </div>
        </div>

        <!-- Food Info -->
        <div class="col-lg-6">
            <h1 style="font-weight: 700; color: #1A1A2E;">${food.name}</h1>
            <h3 style="font-family: 'Noto Serif SC'; color: #C41E3A;">${food.nameCn}</h3>

            <span class="badge" style="background: #D4A843; color: #1A1A2E; font-size: 0.9rem; padding: 6px 12px;">
                ${food.categoryNameCn != null ? food.categoryNameCn : food.categoryName}
            </span>

            <div class="my-3">
                <span class="food-rating" style="font-size: 1.3rem;">★ ${food.rating}</span>
                <span style="opacity: 0.7;">(${food.reviewCount} reviews)</span>
            </div>

            <p style="font-size: 1.05rem; line-height: 1.7; margin: 15px 0;">${food.description}</p>

            <div class="row mb-3">
                <div class="col-6">
                    <strong style="color: #1A1A2E;">Ingredients 原料：</strong>
                    <p style="font-size: 0.9rem;">${food.ingredients}</p>
                </div>
                <div class="col-6">
                    <strong style="color: #1A1A2E;">Nutrition 营养：</strong>
                    <p style="font-size: 0.9rem;">${food.nutritionalInfo}</p>
                </div>
            </div>

            <div class="food-price" style="font-size: 2rem; color: #C41E3A; margin: 15px 0;">
                RM <fmt:formatNumber value="${food.price}" pattern="#0.00"/>
            </div>

            <!-- Add to Cart -->
            <form action="CartServlet" method="post" class="add-to-cart-form">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="foodId" value="${food.foodId}">
                <div class="row g-2 align-items-end">
                    <div class="col-auto">
                        <label class="form-label">Quantity 数量</label>
                        <input type="number" name="quantity" value="1" min="1" max="10"
                               class="form-control" style="width: 80px;">
                    </div>
                    <div class="col">
                        <label class="form-label">Add-ons 附加</label>
                        <select name="addOns" class="form-select">
                            <option value="">None</option>
                            <option value="Extra Chili 加辣">Extra Chili 加辣</option>
                            <option value="No MSG 不要味精">No MSG 不要味精</option>
                            <option value="Extra Sauce 加酱">Extra Sauce 加酱</option>
                            <option value="Add Rice 加米饭 (+RM3)">Add Rice 加米饭</option>
                            <option value="Extra Cheese 加芝士">Extra Cheese 加芝士</option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-lg" style="background: #C41E3A; color: white;">
                            <i class="bi bi-cart-plus"></i> Add to Cart 加入购物车
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Reviews Section -->
    <div class="mt-5">
        <h3 style="color: #1A1A2E; border-bottom: 2px solid #D4A843; padding-bottom: 10px;">
            Reviews 评价 <span style="font-family: 'Noto Serif SC'; font-size: 1rem;">(${food.reviewCount})</span>
        </h3>

        <!-- Add Review -->
        <c:if test="${not empty sessionScope.user}">
            <div class="card mb-4" style="background: #FFF; border: 1px solid rgba(0,0,0,0.1);">
                <div class="card-body">
                    <h6>Write a Review 写评价</h6>
                    <form action="OrderServlet" method="post">
                        <input type="hidden" name="action" value="review">
                        <input type="hidden" name="foodId" value="${food.foodId}">
                        <div class="mb-2">
                            <label class="form-label">Rating 评分</label>
                            <select name="rating" class="form-select form-select-sm" style="width: 120px;" required>
                                <option value="5">★★★★★ (5)</option>
                                <option value="4">★★★★☆ (4)</option>
                                <option value="3">★★★☆☆ (3)</option>
                                <option value="2">★★☆☆☆ (2)</option>
                                <option value="1">★☆☆☆☆ (1)</option>
                            </select>
                        </div>
                        <div class="mb-2">
                            <textarea name="comment" class="form-control" rows="2" placeholder="Your comment..."></textarea>
                        </div>
                        <button type="submit" class="btn btn-sm" style="background: #D4A843; color: #1A1A2E;">Submit</button>
                    </form>
                </div>
            </div>
        </c:if>

        <!-- Reviews List -->
        <c:choose>
            <c:when test="${not empty reviews}">
                <c:forEach var="review" items="${reviews}">
                    <div class="card mb-2" style="background: #FFF; border: 1px solid rgba(0,0,0,0.05);">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <strong>${review.username}</strong>
                                <small style="opacity: 0.6;">${review.createdAt}</small>
                            </div>
                            <div style="color: #D4A843;">
                                <c:forEach begin="1" end="5" var="star">
                                    ${star <= review.rating ? '★' : '☆'}
                                </c:forEach>
                            </div>
                            <p style="margin-top: 5px;">${review.comment}</p>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p style="opacity: 0.6;">No reviews yet. Be the first! 暂无评价，来当第一个！</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</section>

<%@ include file="footer.jsp" %>
