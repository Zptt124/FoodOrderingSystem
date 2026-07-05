<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="header.jsp" %>

<%--
    Chapter 9: JSP Bean Tags Demonstration
    <jsp:useBean> — finds or creates a bean in the specified scope.
    Here we look up the "food" attribute that FoodDetailServlet placed in request scope.
    This is equivalent to: FoodItem food = (FoodItem) request.getAttribute("food");

    <jsp:getProperty> — reads a bean property, equivalent to food.getName().
    <jsp:setProperty> — sets a bean property from request parameters or explicit values.

    These three tags are the core of JSP Bean usage taught in Chapter 9.
--%>
<jsp:useBean id="food" class="com.jadedragon.model.FoodItem" scope="request" />

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
                <li class="breadcrumb-item active" aria-current="page">
                    <%-- Chapter 9: getProperty reads the bean's name property --%>
                    <jsp:getProperty name="food" property="name" />
                </li>
            </ol>
        </nav>

        <div class="row">
            <!-- Food Image -->
            <div class="col-lg-6 mb-4">
                <c:choose>
                    <c:when test="${not empty food.imageUrl}">
                        <img src="${food.imageUrl}"
                             alt="<jsp:getProperty name='food' property='name' />"
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
                <%-- Chapter 9: getProperty reads the bean's name property --%>
                <h2 style="font-weight: 700; color: var(--dark);">
                    <jsp:getProperty name="food" property="name" />
                </h2>

                <div class="d-flex flex-wrap align-items-center gap-2 mb-3">
                    <%-- EL expressions are an alternative to getProperty — both work --%>
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
                                <option value="Extra Chili (+RM 1)">Extra Chili (+RM 1)</option>
                                <option value="No MSG">No MSG</option>
                                <option value="Extra Sauce (+RM 1)">Extra Sauce (+RM 1)</option>
                                <option value="Extra Cheese (+RM 1)">Extra Cheese (+RM 1)</option>
                                <option value="Add Rice (+RM 3)">Add Rice (+RM 3)</option>
                                <option value="Double Portion (+RM 5)">Double Portion (+RM 5)</option>
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
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>
