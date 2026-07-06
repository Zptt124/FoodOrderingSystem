<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>

<section class="page-header">
    <div class="container">
        <h1>Our Menu</h1>
        <p>Explore authentic Chinese dishes made fresh with the finest ingredients.</p>
    </div>
</section>

<section class="section" style="background: var(--cream);">
    <div class="container">

        <!-- Search -->
        <div class="row justify-content-center mb-4">
            <div class="col-lg-6 col-md-8">
                <form action="MenuServlet" method="get" class="search-bar w-100 mx-auto">
                    <span class="search-icon"><i class="bi bi-search"></i></span>
                    <input type="text" name="search" class="form-control" placeholder="Search dishes..."
                           value="${searchKeyword}" style="padding-left: 48px;">
                </form>
            </div>
        </div>

        <!-- Category tabs -->
        <div class="d-flex flex-wrap justify-content-center gap-2 mb-4">
            <a href="MenuServlet" class="btn ${empty selectedCategory || selectedCategory == '' ? 'btn-primary' : 'btn-outline-primary'}">
                <i class="bi bi-grid-3x3-gap-fill me-1"></i> All
            </a>
            <c:forEach var="cat" items="${categories}">
                <a href="MenuServlet?category=${cat.categoryId}"
                   class="btn ${selectedCategory eq cat.categoryId.toString() ? 'btn-primary' : 'btn-outline-primary'}">
                    ${cat.name}
                </a>
            </c:forEach>
        </div>

        <c:if test="${not empty param.added}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                <strong>Added to cart!</strong>
                <a href="cart.jsp" class="alert-link ms-2">View Cart <i class="bi bi-arrow-right-short"></i></a>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty foodItems}">
                    <c:forEach var="item" items="${foodItems}">
                        <div class="col-lg-4 col-md-6">
                            <div class="food-card h-100">
                                <div class="food-card-img">
                                    <img src="${pageContext.request.contextPath}/${item.imageUrl}" alt="${item.name}"
                                         loading="lazy"
                                         >
                                    <span class="category-badge">${item.categoryName}</span>
                                    <c:if test="${item.popular}">
                                        <span class="badge-overlay">
                                            <span class="badge" style="background: var(--gold); color: var(--dark); font-weight: 700; padding: 5px 10px;">
                                                <i class="bi bi-fire"></i> Popular
                                            </span>
                                        </span>
                                    </c:if>
                                </div>
                                <div class="food-card-body">
                                    <h5>
                                        <a href="FoodDetailServlet?id=${item.foodId}" style="color: inherit; text-decoration: none;">
                                            ${item.name}
                                        </a>
                                    </h5>
                                    <p class="text-muted">${item.description}</p>

                                    <!-- Price and Rating -->
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

                                    <!-- Unavailable Badge -->
                                    <c:if test="${not item.available}">
                                        <div class="alert alert-warning text-center py-1 mt-2 mb-2" role="alert" style="font-size: 0.8rem;">
                                            <i class="bi bi-exclamation-triangle-fill"></i> Currently Unavailable
                                        </div>
                                    </c:if>

                                    <!-- Add to Cart Form -->
                                    <c:if test="${item.available}">
                                        <form action="CartServlet" method="post" class="add-to-cart-form mt-3">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="foodId" value="${item.foodId}">
                                            <div class="row g-2 align-items-end">
                                                <div class="col-4">
                                                    <label class="form-label" style="font-size: 0.75rem; margin-bottom: 2px;">Qty</label>
                                                    <input type="number" name="quantity" value="1" min="1" max="10"
                                                           class="form-control form-control-sm text-center" style="padding: 0.4rem 0.25rem;">
                                                </div>
                                                <div class="col-8">
                                                    <label class="form-label" style="font-size: 0.75rem; margin-bottom: 2px;">Add-ons</label>
                                                    <select name="addOns" class="form-select form-select-sm" style="font-size: 0.8rem;">
                                                        <option value="">No add-ons</option>
                                                        <option value="Extra Chili (+RM 1)">Extra Chili (+RM 1)</option>
                                                        <option value="No MSG">No MSG</option>
                                                        <option value="Extra Sauce (+RM 1)">Extra Sauce (+RM 1)</option>
                                                        <option value="Extra Cheese (+RM 1)">Extra Cheese (+RM 1)</option>
                                                        <option value="Add Rice (+RM 3)">Add Rice (+RM 3)</option>
                                                        <option value="Double Portion (+RM 5)">Double Portion (+RM 5)</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="d-flex gap-2 mt-2">
                                                <button type="submit" class="btn btn-primary btn-sm flex-grow-1">
                                                    <i class="bi bi-cart-plus"></i> Add to Cart
                                                </button>
                                                <a href="FoodDetailServlet?id=${item.foodId}" class="btn btn-outline-gold btn-sm">
                                                    <i class="bi bi-info-circle"></i>
                                                </a>
                                            </div>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="empty-state">
                            <div class="empty-icon">
                                <i class="bi bi-emoji-frown"></i>
                            </div>
                            <h4>No Dishes Found</h4>
                            <c:choose>
                                <c:when test="${not empty searchKeyword}">
                                    <p>No results found for "<strong>${searchKeyword}</strong>". Try a different search term.</p>
                                </c:when>
                                <c:otherwise>
                                    <p>No dishes are available in this category right now. Please check back later.</p>
                                </c:otherwise>
                            </c:choose>
                            <a href="MenuServlet" class="btn btn-primary">
                                <i class="bi bi-arrow-repeat me-2"></i> View All Dishes
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</section>

<%@ include file="footer.jsp" %>
