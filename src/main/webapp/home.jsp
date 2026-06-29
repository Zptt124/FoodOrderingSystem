<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>

<!-- ============================================
     Hero Section
     ============================================ -->
<section class="hero" style="min-height: 90vh;">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 hero-content">
                <span class="text-uppercase fw-semibold mb-3 d-block" style="color: var(--gold-light); letter-spacing: 0.12em; font-size: 0.9rem;">
                    Established 1998
                </span>
                <h1 class="mb-3" style="max-width: 550px;">
                    Savor the Taste of<br>
                    <span class="gold-text">Tradition</span>
                </h1>
                <p class="lead mb-4" style="font-size: 1.15rem; color: rgba(255,255,255,0.7); max-width: 520px; line-height: 1.8;">
                    Authentic Chinese cuisine crafted with passion since 1998.
                    Experience the finest flavors from across China.
                </p>
                <div class="hero-buttons">
                    <a href="MenuServlet" class="btn btn-primary btn-lg">
                        View Our Menu <i class="bi bi-arrow-right"></i>
                    </a>
                    <a href="menu.jsp" class="btn btn-outline-gold btn-lg">
                        Order Now
                    </a>
                </div>
            </div>
            <div class="col-lg-6 hero-image-wrapper">
                <img src="https://images.pexels.com/photos/7363758/pexels-photo-7363758.jpeg?w=800"
                     alt="Delicious Chinese cuisine"
                     style="width: 100%; max-height: 450px; object-fit: cover; border-radius: var(--radius-lg); box-shadow: var(--shadow-xl);"
                     onerror="this.onerror=null;this.src='data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 width=%22400%22 height=%22300%22><rect fill=%22%23FFF8E7%22 width=%22400%22 height=%22300%22/><text x=%22200%22 y=%22150%22 text-anchor=%22middle%22 font-size=%2260%22>🐉</text></svg>';">
            </div>
        </div>
    </div>
</section>

<!-- ============================================
     Featured Dishes Section
     ============================================ -->
<section class="section" style="background: var(--cream);">
    <div class="container">
        <div class="section-title">
            <span class="subtitle">Chef's Selection</span>
            <h2>Featured Dishes</h2>
            <span class="divider"></span>
        </div>

        <c:choose>
            <c:when test="${not empty featuredItems}">
                <div class="row">
                    <c:forEach var="item" items="${featuredItems}">
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="food-card">
                                <div class="food-card-img">
                                    <c:choose>
                                        <c:when test="${not empty item.imageUrl}">
                                            <img src="${item.imageUrl}" alt="${item.name}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="food-card-placeholder" style="height: 220px; font-size: 3.5rem;">&#127858;</div>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="category-badge">${item.categoryName}</span>
                                </div>
                                <div class="food-card-body">
                                    <h5>${item.name}</h5>
                                    <p class="text-muted">${item.description}</p>
                                    <c:if test="${item.featured}">
                                        <span class="badge-featured mb-2" style="display: inline-block; width: fit-content;">Featured</span>
                                    </c:if>
                                    <div class="food-card-footer">
                                        <span class="food-price">RM <fmt:formatNumber value="${item.price}" pattern="#0.00"/></span>
                                        <div class="food-rating">
                                            <span class="rating-stars">
                                                <c:forEach begin="1" end="5" var="star">
                                                    <c:choose>
                                                        <c:when test="${star <= item.rating}">
                                                            <span class="filled">&#9733;</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="empty">&#9733;</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </span>
                                            <span class="rating-count">(${item.reviewCount})</span>
                                        </div>
                                    </div>
                                    <a href="FoodDetailServlet?id=${item.foodId}" class="btn btn-outline-primary btn-sm w-100 mt-3">
                                        View Details <i class="bi bi-arrow-right-short"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">
                        <i class="bi bi-star"></i>
                    </div>
                    <h4>No Featured Dishes</h4>
                    <p>Check back soon for our chef's special recommendations.</p>
                    <a href="MenuServlet" class="btn btn-primary">Browse Full Menu</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- ============================================
     Popular Dishes Section
     ============================================ -->
<section class="section" style="background: var(--dark);">
    <div class="container">
        <div class="section-title">
            <span class="subtitle" style="color: var(--gold-light);">Customer Favorites</span>
            <h2 style="color: var(--white);">Popular Dishes</h2>
            <span class="divider"></span>
        </div>

        <c:choose>
            <c:when test="${not empty popularItems}">
                <div class="row">
                    <c:forEach var="item" items="${popularItems}" begin="0" end="3">
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="food-card" style="background: #2D1B2E; border-color: rgba(212,168,67,0.25);">
                                <div class="food-card-img">
                                    <c:choose>
                                        <c:when test="${not empty item.imageUrl}">
                                            <img src="${item.imageUrl}" alt="${item.name}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="food-card-placeholder" style="height: 200px; font-size: 3rem;">&#129379;</div>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${item.popular}">
                                        <span class="badge-overlay">
                                            <span class="badge" style="background: var(--gold); color: var(--dark); font-weight: 700; padding: 5px 10px;">
                                                <i class="bi bi-fire"></i> Popular
                                            </span>
                                        </span>
                                    </c:if>
                                </div>
                                <div class="food-card-body">
                                    <h5 style="color: var(--white);">${item.name}</h5>
                                    <p class="text-muted" style="color: rgba(255,255,255,0.55) !important;">${item.description}</p>
                                    <div class="food-card-footer" style="border-top-color: rgba(255,255,255,0.1);">
                                        <span class="food-price" style="color: var(--gold-light);">RM <fmt:formatNumber value="${item.price}" pattern="#0.00"/></span>
                                        <div class="food-rating">
                                            <span class="rating-stars">
                                                <c:forEach begin="1" end="5" var="star">
                                                    <c:choose>
                                                        <c:when test="${star <= item.rating}">
                                                            <span class="filled">&#9733;</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="empty" style="color: rgba(255,255,255,0.2);">&#9733;</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </span>
                                            <span class="rating-count" style="color: rgba(255,255,255,0.5);">(${item.reviewCount})</span>
                                        </div>
                                    </div>
                                    <a href="FoodDetailServlet?id=${item.foodId}" class="btn btn-outline-gold btn-sm w-100 mt-3">
                                        View Details <i class="bi bi-arrow-right-short"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon" style="color: rgba(255,255,255,0.2);">
                        <i class="bi bi-fire"></i>
                    </div>
                    <h4 style="color: var(--white);">No Popular Dishes</h4>
                    <p style="color: rgba(255,255,255,0.5);">Popular dishes are loading. Please check back shortly.</p>
                    <a href="MenuServlet" class="btn btn-outline-gold">Browse Full Menu</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- ============================================
     Browse by Category Section
     ============================================ -->
<section class="section" style="background: var(--cream);">
    <div class="container">
        <div class="section-title">
            <span class="subtitle">Explore</span>
            <h2>Browse by Category</h2>
            <span class="divider"></span>
        </div>

        <c:choose>
            <c:when test="${not empty categories}">
                <div class="row justify-content-center">
                    <c:forEach var="cat" items="${categories}">
                        <div class="col-6 col-md-4 col-lg mb-3">
                            <a href="MenuServlet?category=${cat.categoryId}" class="category-link">
                                <div class="category-icon-circle">
                                    <c:choose>
                                        <c:when test="${not empty cat.imageUrl}">
                                            <img src="${cat.imageUrl}" alt="${cat.name}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-grid"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <span>${cat.name}</span>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">
                        <i class="bi bi-collection"></i>
                    </div>
                    <h4>No Categories Available</h4>
                    <p>Categories are being set up. Please check back soon.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- ============================================
     Promo Banner
     ============================================ -->
<section class="section-sm">
    <div class="container">
        <div class="promo-banner">
            <div class="row align-items-center">
                <div class="col-lg-8 text-lg-start text-center mb-3 mb-lg-0">
                    <h3 style="font-size: 1.6rem;">
                        <i class="bi bi-tag-fill me-2"></i>Today's Special
                    </h3>
                    <p style="font-size: 1.1rem; margin-bottom: 0;">
                        20% off on all Chef's Special dishes! Use code <strong style="background: rgba(255,255,255,0.2); padding: 4px 14px; border-radius: var(--radius-full);">CHEF20</strong> at checkout.
                    </p>
                </div>
                <div class="col-lg-4 text-lg-end text-center">
                    <a href="MenuServlet" class="btn btn-gold btn-lg">
                        Order Now <i class="bi bi-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>