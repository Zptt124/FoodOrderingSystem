<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>

<%-- Hero --%>
<section class="hero">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 hero-content">
                <span class="hero-badge">Since 1998</span>
                <h1>Savor the Taste of<br><span class="gold-text">Tradition</span></h1>
                <p class="lead">Authentic Chinese cuisine crafted with passion since 1998. Experience the finest flavors from across China.</p>
                <div class="hero-buttons">
                    <a href="MenuServlet" class="btn btn-primary btn-lg">View Our Menu <i class="bi bi-arrow-right"></i></a>
                    <a href="menu.jsp" class="btn btn-outline-gold btn-lg">Order Now</a>
                </div>
            </div>
            <div class="col-lg-6 hero-image-wrapper d-none d-lg-block">
                <img src="${pageContext.request.contextPath}/img/food/peking-duck.jpg"
                     alt="Chinese cuisine" class="hero-main-img"
                     >
            </div>
        </div>
    </div>
</section>

<%-- Featured Dishes --%>
<section class="section" style="background: var(--cream);">
    <div class="container">
        <div class="section-title">
            <span class="subtitle">Chef Picks</span>
            <h2>Featured Dishes</h2>
            <span class="divider"></span>
        </div>

        <c:choose>
            <c:when test="${not empty featuredItems}">
                <div class="row g-4">
                    <c:forEach var="item" items="${featuredItems}">
                        <div class="col-lg-4 col-md-6">
                            <div class="food-card">
                                <div class="food-card-img">
                                    <img src="${pageContext.request.contextPath}/${item.imageUrl}" alt="${item.name}"
                                         loading="lazy"
                                         >
                                    <span class="category-badge">${item.categoryName}</span>
                                </div>
                                <div class="food-card-body">
                                    <h5>${item.name}</h5>
                                    <p class="text-muted">${item.description}</p>
                                    <div class="food-card-footer">
                                        <span class="food-price">RM <fmt:formatNumber value="${item.price}" pattern="#0.00"/></span>
                                        <div class="food-rating">
                                            <c:forEach begin="1" end="5" var="star">
                                                <c:choose>
                                                    <c:when test="${star <= item.rating}"><span class="star filled">&#9733;</span></c:when>
                                                    <c:otherwise><span class="star empty">&#9733;</span></c:otherwise>
                                                </c:choose>
                                            </c:forEach>
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
                <div class="image-carousel">
                    <div class="carousel-track">
                        <div class="carousel-slide">
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/spring-rolls.jpg" alt="Spring Rolls"><div class="carousel-label">Spring Rolls</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/dumplings.jpg" alt="Dumplings"><div class="carousel-label">Dumplings</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/kung-pao-chicken.jpg" alt="Kung Pao Chicken"><div class="carousel-label">Kung Pao Chicken</div></div>
                        </div>
                        <div class="carousel-slide">
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/peking-duck.jpg" alt="Peking Duck"><div class="carousel-label">Peking Duck</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/mapo-tofu.jpg" alt="Mapo Tofu"><div class="carousel-label">Mapo Tofu</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/sweet-sour-pork.jpg" alt="Sweet & Sour Pork"><div class="carousel-label">Sweet &amp; Sour Pork</div></div>
                        </div>
                        <div class="carousel-slide">
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/honey-walnut-shrimp.jpg" alt="Honey Walnut Shrimp"><div class="carousel-label">Honey Walnut Shrimp</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/beef-chow-fun.jpg" alt="Beef Chow Fun"><div class="carousel-label">Beef Chow Fun</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/buddha-soup.jpg" alt="Buddha Jumps Over the Wall"><div class="carousel-label">Buddha Soup</div></div>
                        </div>
                    </div>
                </div>
                <div class="carousel-dots"><span class="dot active"></span><span class="dot"></span><span class="dot"></span></div>
                <div style="text-align:center; margin-top: 16px;">
                    <a href="MenuServlet" class="btn btn-primary">Browse Full Menu</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<%-- Popular Dishes --%>
<section class="section popular-section">
    <div class="container">
        <div class="section-title">
            <span class="subtitle" style="color: var(--gold-light);">Fan Favorites</span>
            <h2 style="color: var(--white);">Popular Dishes</h2>
            <span class="divider"></span>
        </div>

        <c:choose>
            <c:when test="${not empty popularItems}">
                <div class="row g-4">
                    <c:forEach var="item" items="${popularItems}" begin="0" end="3">
                        <div class="col-lg-3 col-md-6 col-6">
                            <div class="food-card popular-card">
                                <div class="food-card-img">
                                    <img src="${pageContext.request.contextPath}/${item.imageUrl}" alt="${item.name}"
                                         loading="lazy"
                                         >
                                    <c:if test="${item.popular}">
                                        <span class="badge-overlay">
                                            <span class="badge bg-warning text-dark fw-bold px-2 py-1">
                                                <i class="bi bi-fire"></i> Popular
                                            </span>
                                        </span>
                                    </c:if>
                                </div>
                                <div class="food-card-body">
                                    <h5 style="color: var(--white);">${item.name}</h5>
                                    <p class="text-muted">${item.description}</p>
                                    <div class="food-card-footer">
                                        <span class="food-price" style="color: var(--gold-light);">RM <fmt:formatNumber value="${item.price}" pattern="#0.00"/></span>
                                        <div class="food-rating">
                                            <c:forEach begin="1" end="5" var="star">
                                                <c:choose>
                                                    <c:when test="${star <= item.rating}"><span class="star filled">&#9733;</span></c:when>
                                                    <c:otherwise><span class="star empty dark-star">&#9733;</span></c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <span class="rating-count">(${item.reviewCount})</span>
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
                <div class="image-carousel carousel-dark">
                    <div class="carousel-track">
                        <div class="carousel-slide">
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/peking-duck.jpg" alt="Peking Duck"><div class="carousel-label">Peking Duck</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/kung-pao-chicken.jpg" alt="Kung Pao Chicken"><div class="carousel-label">Kung Pao Chicken</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/mapo-tofu.jpg" alt="Mapo Tofu"><div class="carousel-label">Mapo Tofu</div></div>
                        </div>
                        <div class="carousel-slide">
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/dumplings.jpg" alt="Dumplings"><div class="carousel-label">Dumplings</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/honey-walnut-shrimp.jpg" alt="Honey Walnut Shrimp"><div class="carousel-label">Honey Walnut Shrimp</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/bubble-tea.jpg" alt="Bubble Tea"><div class="carousel-label">Bubble Tea</div></div>
                        </div>
                        <div class="carousel-slide">
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/sesame-balls.jpg" alt="Sesame Balls"><div class="carousel-label">Sesame Balls</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/egg-tarts.jpg" alt="Egg Tarts"><div class="carousel-label">Egg Tarts</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/food/mango-pudding.jpg" alt="Mango Pudding"><div class="carousel-label">Mango Pudding</div></div>
                        </div>
                    </div>
                </div>
                <div class="carousel-dots"><span class="dot active"></span><span class="dot"></span><span class="dot"></span></div>
                <div style="text-align:center; margin-top: 16px;">
                    <a href="MenuServlet" class="btn btn-outline-gold">Browse Full Menu</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<%-- Browse by Category --%>
<section class="section" style="background: var(--cream);">
    <div class="container">
        <div class="section-title">
            <span class="subtitle">Explore Our Menu</span>
            <h2>Browse by Category</h2>
            <span class="divider"></span>
        </div>

        <c:choose>
            <c:when test="${not empty categories}">
                <div class="category-grid">
                    <c:forEach var="cat" items="${categories}">
                        <a href="MenuServlet?category=${cat.categoryId}" class="category-card">
                            <div class="category-icon-circle">
                                <img src="${pageContext.request.contextPath}/${cat.imageUrl}" alt="${cat.name}"
                                     loading="lazy"
                                     >
                            </div>
                            <span>${cat.name}</span>
                        </a>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="image-carousel">
                    <div class="carousel-track">
                        <div class="carousel-slide">
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/category/appetizers.jpg" alt="Appetizers"><div class="carousel-label">Appetizers</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/category/main-course.jpg" alt="Main Course"><div class="carousel-label">Main Course</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/category/desserts.jpg" alt="Desserts"><div class="carousel-label">Desserts</div></div>
                        </div>
                        <div class="carousel-slide">
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/category/beverages.jpg" alt="Beverages"><div class="carousel-label">Beverages</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/category/chefs-special.jpg" alt="Chef's Special"><div class="carousel-label">Chef's Special</div></div>
                            <div class="carousel-card"><img src="${pageContext.request.contextPath}/img/category/appetizers.jpg" alt="Appetizers"><div class="carousel-label">Appetizers</div></div>
                        </div>
                    </div>
                </div>
                <div class="carousel-dots"><span class="dot active"></span><span class="dot"></span></div>
                <div style="text-align:center; margin-top: 16px;">
                    <a href="MenuServlet" class="btn btn-primary">Browse Menu</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<%@ include file="footer.jsp" %>