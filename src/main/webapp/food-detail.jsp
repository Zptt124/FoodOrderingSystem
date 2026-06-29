<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>

<%
    if (request.getAttribute("food") == null) {
        response.sendRedirect("MenuServlet");
        return;
    }
%>

<section class="section">
    <div class="container">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                <li class="breadcrumb-item"><a href="MenuServlet">Menu</a></li>
                <li class="breadcrumb-item active" aria-current="page">${food.name}</li>
            </ol>
        </nav>

        <div class="row">
            <!-- Food Image -->
            <div class="col-lg-6 mb-4">
                <c:choose>
                    <c:when test="${not empty food.imageUrl}">
                        <img src="${food.imageUrl}" alt="${food.name}"
                             style="width: 100%; border-radius: var(--radius-md); object-fit: cover; max-height: 420px;"
                             onerror="this.onerror=null; this.parentNode.innerHTML='<div class=\'img-fallback\' style=\'min-height: 350px; border-radius: var(--radius-md); font-size: 5rem;\'>&#x1F372;</div>';">
                    </c:when>
                    <c:otherwise>
                        <div class="img-fallback" style="min-height: 350px; border-radius: var(--radius-md); font-size: 5rem;">
                            &#x1F372;
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Food Info -->
            <div class="col-lg-6">
                <h2 style="font-weight: 700; color: var(--dark);">${food.name}</h2>

                <div class="d-flex flex-wrap align-items-center gap-2 mb-3">
                    <span class="badge" style="background: var(--gold); color: var(--dark); font-size: 0.85rem; padding: 6px 14px; border-radius: var(--radius-full);">
                        ${food.categoryName}
                    </span>
                    <c:if test="${food.rating > 0}">
                        <span class="badge" style="background: var(--success); color: white; font-size: 0.85rem; padding: 6px 14px; border-radius: var(--radius-full);">
                            <i class="bi bi-check-circle"></i> Available
                        </span>
                    </c:if>
                </div>

                <!-- Star Rating & Review Count -->
                <div class="d-flex align-items-center gap-2 mb-3">
                    <div class="rating-stars" style="font-size: 1.2rem;">
                        <c:forEach begin="1" end="5" var="star">
                            <c:choose>
                                <c:when test="${star <= food.rating}">
                                    <span class="filled">&#9733;</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="empty">&#9734;</span>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <span class="rating-value">${food.rating}</span>
                    <span class="rating-count">(${food.reviewCount} review<c:if test="${food.reviewCount != 1}">s</c:if>)</span>
                </div>

                <!-- Price -->
                <div class="food-price mb-3" style="font-size: 2.2rem;">
                    RM <fmt:formatNumber value="${food.price}" pattern="#0.00"/>
                </div>

                <!-- Description -->
                <p style="line-height: 1.8; color: var(--gray-700);">${food.description}</p>

                <!-- Ingredients & Nutrition -->
                <c:if test="${not empty food.ingredients}">
                    <div class="card border-0 mb-3" style="background: var(--cream-dark); border-radius: var(--radius-sm);">
                        <div class="card-body">
                            <h6 class="mb-2" style="font-weight: 700; color: var(--dark);">
                                <i class="bi bi-list-check me-2" style="color: var(--red);"></i>Ingredients
                            </h6>
                            <p class="mb-0" style="font-size: 0.92rem; color: var(--gray-700);">${food.ingredients}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty food.nutritionalInfo}">
                    <div class="card border-0 mb-3" style="background: var(--cream-dark); border-radius: var(--radius-sm);">
                        <div class="card-body">
                            <h6 class="mb-2" style="font-weight: 700; color: var(--dark);">
                                <i class="bi bi-clipboard2-heart me-2" style="color: var(--red);"></i>Nutritional Information
                            </h6>
                            <p class="mb-0" style="font-size: 0.92rem; color: var(--gray-700); white-space: pre-line;">${food.nutritionalInfo}</p>
                        </div>
                    </div>
                </c:if>

                <!-- Add to Cart Form -->
                <form action="CartServlet" method="post" class="add-to-cart-form mt-4">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="foodId" value="${food.foodId}">
                    <div class="row g-3 align-items-end">
                        <div class="col-auto">
                            <label for="quantity" class="form-label">Quantity</label>
                            <input type="number" name="quantity" id="quantity" value="1" min="1" max="10"
                                   class="form-control" style="width: 85px;">
                        </div>
                        <div class="col">
                            <label for="addOns" class="form-label">Add-ons</label>
                            <select name="addOns" id="addOns" class="form-select">
                                <option value="">None</option>
                                <option value="Extra Chili">Extra Chili</option>
                                <option value="No MSG">No MSG</option>
                                <option value="Extra Sauce">Extra Sauce</option>
                                <option value="Add Rice (+RM3)">Add Rice (+RM3)</option>
                                <option value="Extra Cheese">Extra Cheese</option>
                            </select>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="bi bi-cart-plus"></i> Add to Cart
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Reviews Section -->
        <div class="mt-5">
            <div class="d-flex align-items-center justify-content-between mb-4" style="border-bottom: 2px solid var(--gold); padding-bottom: 12px;">
                <h3 class="mb-0" style="color: var(--dark);">Reviews</h3>
                <span style="color: var(--gray-500); font-size: 0.9rem;">${food.reviewCount} review<c:if test="${food.reviewCount != 1}">s</c:if></span>
            </div>

            <!-- Write a Review (logged-in users only) -->
            <c:if test="${not empty sessionScope.user}">
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body p-4">
                        <h6 class="mb-3" style="font-weight: 700;">Write a Review</h6>
                        <form action="OrderServlet" method="post">
                            <input type="hidden" name="action" value="review">
                            <input type="hidden" name="foodId" value="${food.foodId}">
                            <div class="mb-3">
                                <label class="form-label">Your Rating</label>
                                <div class="star-rating-input">
                                    <input type="radio" name="rating" value="5" id="star5" required>
                                    <label for="star5" title="5 stars"><i class="bi bi-star-fill"></i></label>
                                    <input type="radio" name="rating" value="4" id="star4">
                                    <label for="star4" title="4 stars"><i class="bi bi-star-fill"></i></label>
                                    <input type="radio" name="rating" value="3" id="star3">
                                    <label for="star3" title="3 stars"><i class="bi bi-star-fill"></i></label>
                                    <input type="radio" name="rating" value="2" id="star2">
                                    <label for="star2" title="2 stars"><i class="bi bi-star-fill"></i></label>
                                    <input type="radio" name="rating" value="1" id="star1">
                                    <label for="star1" title="1 star"><i class="bi bi-star-fill"></i></label>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="reviewComment" class="form-label">Your Comment</label>
                                <textarea name="comment" id="reviewComment" class="form-control" rows="3"
                                          placeholder="Share your experience with this dish..." required></textarea>
                            </div>
                            <button type="submit" class="btn btn-gold">
                                <i class="bi bi-pencil-square"></i> Submit Review
                            </button>
                        </form>
                    </div>
                </div>
            </c:if>

            <c:if test="${empty sessionScope.user}">
                <div class="alert alert-info" role="alert">
                    <i class="bi bi-info-circle-fill me-2"></i>
                    Please <a href="login.jsp" style="font-weight: 600;">log in</a> to leave a review.
                </div>
            </c:if>

            <!-- Reviews List -->
            <c:choose>
                <c:when test="${not empty reviews}">
                    <c:forEach var="review" items="${reviews}">
                        <div class="review-card">
                            <div class="review-header">
                                <span class="review-user">${review.username}</span>
                                <span class="review-date">${review.createdAt}</span>
                            </div>
                            <div class="rating-stars mb-2">
                                <c:forEach begin="1" end="5" var="star">
                                    <c:choose>
                                        <c:when test="${star <= review.rating}">
                                            <span class="filled">&#9733;</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="empty">&#9734;</span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                            <p class="review-text mb-0">${review.comment}</p>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <div style="font-size: 3rem; opacity: 0.2; margin-bottom: 16px;">
                            <i class="bi bi-chat-square-text"></i>
                        </div>
                        <p style="color: var(--gray-500);">No reviews yet. Be the first to share your experience!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>