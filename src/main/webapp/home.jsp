<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>

<!-- Hero Section -->
<section style="background: linear-gradient(rgba(26,26,46,0.85), rgba(45,27,46,0.85)),
                url('https://images.unsplash.com/photo-1552566626-52f8b828add9?w=1920');
                background-size: cover; background-position: center; padding: 100px 0 80px;
                text-align: center; color: #FFF8E7;">
    <div class="container">
        <span style="font-family: 'Noto Serif SC', serif; font-size: 4rem; font-weight: 900; color: #D4A843; display: block;">
            玉龙
        </span>
        <h1 style="font-weight: 700; margin: 10px 0; font-size: 2.5rem;">Jade Dragon</h1>
        <p style="font-family: 'Noto Serif SC', serif; font-size: 1.4rem; margin: 15px 0 25px; opacity: 0.9;">
            传承经典，品味中华
        </p>
        <p style="font-size: 1.1rem; max-width: 600px; margin: 0 auto 30px; opacity: 0.8;">
            Experience the finest authentic Chinese cuisine — from traditional recipes passed down
            through generations to modern culinary artistry.
        </p>
        <a href="MenuServlet" class="btn btn-lg" style="background: #C41E3A; color: #FFF8E7; margin: 0 8px; padding: 12px 32px;">
            View Menu 浏览菜单
        </a>
        <a href="register.jsp" class="btn btn-lg" style="background: transparent; color: #D4A843; border: 2px solid #D4A843; margin: 0 8px; padding: 12px 32px;">
            Order Now 立即订餐
        </a>
    </div>
</section>

<!-- Featured Dishes -->
<section style="background: #FFF8E7; padding: 60px 0;">
    <div class="container">
        <h2 class="section-title">Featured Dishes <span style="font-family: 'Noto Serif SC';">主厨推荐</span></h2>
        <c:choose>
            <c:when test="${not empty featuredItems}">
                <div class="row">
                    <c:forEach var="item" items="${featuredItems}">
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="food-card">
                                <div class="food-card-img" style="background: linear-gradient(135deg, #C41E3A, #8B1A2B);
                                     height: 200px; display: flex; align-items: center; justify-content: center;
                                     color: white; font-size: 3rem;">🍜</div>
                                <div class="food-card-body">
                                    <span class="badge" style="background: #D4A843; color: #1A1A2E; margin-bottom: 8px;">
                                        ${item.categoryNameCn != null ? item.categoryNameCn : item.categoryName}
                                    </span>
                                    <h5>${item.name}</h5>
                                    <p style="color: #8B1A2B; font-family: 'Noto Serif SC';">${item.nameCn}</p>
                                    <p style="font-size: 0.85rem; opacity: 0.8;">${item.description}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="food-price">RM <fmt:formatNumber value="${item.price}" pattern="#0.00"/></span>
                                        <span class="food-rating">★ ${item.rating} (${item.reviewCount})</span>
                                    </div>
                                    <a href="FoodDetailServlet?id=${item.foodId}" class="btn btn-sm w-100 mt-2" style="background: #C41E3A; color: white;">View Details</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <p>Connect your database to see featured dishes!</p>
                    <p style="font-family: 'Noto Serif SC';">连接数据库查看推荐菜品！</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- Popular Dishes -->
<section style="background: #1A1A2E; padding: 60px 0;">
    <div class="container">
        <h2 class="section-title" style="color: #FFF8E7!important;">Popular Dishes <span style="font-family: 'Noto Serif SC';">热门菜品</span></h2>
        <c:choose>
            <c:when test="${not empty popularItems}">
                <div class="row">
                    <c:forEach var="item" items="${popularItems}" begin="0" end="3">
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="food-card" style="background: #2D1B2E; border-color: #D4A843;">
                                <div class="food-card-img" style="background: linear-gradient(135deg, #D4A843, #8B7318);
                                     height: 160px; display: flex; align-items: center; justify-content: center;
                                     color: white; font-size: 2.5rem;">🥘</div>
                                <div class="food-card-body" style="color: #FFF8E7;">
                                    <h5 style="color: #FFF8E7;">${item.name}</h5>
                                    <p style="color: #D4A843; font-family: 'Noto Serif SC';">${item.nameCn}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="food-price" style="color: #D4A843;">RM <fmt:formatNumber value="${item.price}" pattern="#0.00"/></span>
                                        <span style="color: #D4A843;">★ ${item.rating}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5" style="color: #FFF8E7;">
                    <p>Popular dishes loading...</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- Categories Quick Nav -->
<section style="background: #FFF8E7; padding: 50px 0;">
    <div class="container">
        <h2 class="section-title">Browse by Category <span style="font-family: 'Noto Serif SC';">按分类浏览</span></h2>
        <div class="row text-center">
            <c:forEach var="cat" items="${categories}">
                <div class="col-6 col-md mb-3">
                    <a href="MenuServlet?category=${cat.categoryId}" class="category-link">
                        <div class="category-icon-circle">🍽️</div>
                        <strong>${cat.name}</strong>
                        <br><span style="font-family: 'Noto Serif SC'; font-size: 0.9rem; color: #C41E3A;">${cat.nameCn}</span>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- Promo Banner -->
<section style="background: linear-gradient(135deg, #C41E3A, #8B1A2B); padding: 40px 0; text-align: center; color: white;">
    <div class="container">
        <h3 style="font-family: 'Noto Serif SC';">🎉 新顾客首单立减RM10！</h3>
        <p style="font-size: 1.1rem;">First order? Get RM10 off with code: <strong style="background: #D4A843; color: #1A1A2E; padding: 4px 12px; border-radius: 4px;">JADENEW10</strong></p>
    </div>
</section>

<%@ include file="footer.jsp" %>
