<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>

<section style="background: #FFF8E7; min-height: 80vh; padding: 40px 0;">
<div class="container">
    <h2 class="section-title">Our Menu <span style="font-family: 'Noto Serif SC';">我们的菜单</span></h2>

    <!-- Search Bar -->
    <div class="row mb-4">
        <div class="col-md-6 mx-auto">
            <form action="MenuServlet" method="get" class="input-group">
                <input type="text" name="search" class="form-control" placeholder="Search dishes... 搜索菜品..."
                       value="${searchKeyword}" style="border: 2px solid #D4A843;">
                <button class="btn" style="background: #C41E3A; color: white;" type="submit">
                    <i class="bi bi-search"></i> Search
                </button>
            </form>
        </div>
    </div>

    <!-- Category Tabs -->
    <div class="d-flex flex-wrap justify-content-center gap-2 mb-4">
        <a href="MenuServlet" class="btn ${empty selectedCategory ? 'btn-gold' : 'btn-outline-gold'}">All 全部</a>
        <c:forEach var="cat" items="${categories}">
            <a href="MenuServlet?category=${cat.categoryId}"
               class="btn ${selectedCategory eq cat.categoryId.toString() ? 'btn-gold' : 'btn-outline-gold'}">
                ${cat.nameCn != null ? cat.nameCn : cat.name}
            </a>
        </c:forEach>
    </div>

    <!-- Add to Cart Success Message -->
    <c:if test="${not empty param.added}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle"></i> Item added to cart! 商品已加入购物车！
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Food Items Grid -->
    <div class="row">
        <c:choose>
            <c:when test="${not empty foodItems}">
                <c:forEach var="item" items="${foodItems}">
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="food-card h-100">
                            <div class="food-card-img" style="background: linear-gradient(135deg, #C41E3A, #8B1A2B);
                                 height: 180px; display: flex; align-items: center; justify-content: center;
                                 color: white; font-size: 3rem; position: relative;">
                                🍲
                                <c:if test="${item.popular}">
                                    <span class="badge" style="position: absolute; top: 10px; right: 10px; background: #D4A843; color: #1A1A2E;">Popular 热门</span>
                                </c:if>
                            </div>
                            <div class="food-card-body">
                                <span class="badge" style="background: #D4A843; color: #1A1A2E; margin-bottom: 8px;">
                                    ${item.categoryNameCn != null ? item.categoryNameCn : item.categoryName}
                                </span>
                                <h5>${item.name}</h5>
                                <p style="color: #8B1A2B; font-family: 'Noto Serif SC'; font-size: 1.1rem;">${item.nameCn}</p>
                                <p style="font-size: 0.85rem; opacity: 0.8; max-height: 60px; overflow: hidden;">${item.description}</p>

                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="food-price">RM <fmt:formatNumber value="${item.price}" pattern="#0.00"/></span>
                                    <span class="food-rating">★ ${item.rating} <small>(${item.reviewCount})</small></span>
                                </div>

                                <form action="CartServlet" method="post" class="add-to-cart-form">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="foodId" value="${item.foodId}">
                                    <div class="d-flex gap-2 align-items-center">
                                        <input type="number" name="quantity" value="1" min="1" max="10"
                                               class="form-control form-control-sm" style="width: 60px;">
                                        <select name="addOns" class="form-select form-select-sm" style="width: 130px;">
                                            <option value="">No add-ons</option>
                                            <option value="Extra Chili 加辣">Extra Chili 加辣</option>
                                            <option value="No MSG 不要味精">No MSG 不要味精</option>
                                            <option value="Extra Sauce 加酱">Extra Sauce 加酱</option>
                                            <option value="Add Rice 加米饭 (+RM3)">Add Rice 加米饭</option>
                                            <option value="Extra Cheese 加芝士">Extra Cheese 加芝士</option>
                                        </select>
                                        <button type="submit" class="btn btn-sm flex-grow-1" style="background: #C41E3A; color: white;">
                                            <i class="bi bi-cart-plus"></i> Add
                                        </button>
                                    </div>
                                </form>
                                <a href="FoodDetailServlet?id=${item.foodId}" class="btn btn-sm btn-outline-gold w-100 mt-2">View Details 详情</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12 text-center py-5">
                    <p style="font-size: 1.2rem;">No dishes found. 未找到菜品。</p>
                    <a href="MenuServlet" class="btn btn-outline-gold">View All 查看全部</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</section>

<%@ include file="footer.jsp" %>
