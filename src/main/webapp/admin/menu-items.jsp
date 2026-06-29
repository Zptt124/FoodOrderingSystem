<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%
    com.jadedragon.model.User sessionUser = (com.jadedragon.model.User) session.getAttribute("user");
    if (sessionUser == null || !sessionUser.isAdmin()) { response.sendRedirect("../login.jsp"); return; }
%>
<%@ include file="../header.jsp" %>

<div class="admin-layout">
    <!-- Admin Sidebar -->
    <div class="admin-sidebar">
        <div class="px-3 mb-4">
            <h5 class="text-white mb-0" style="font-family: var(--font-heading);">
                <i class="bi bi-speedometer2" style="color: var(--gold);"></i> Admin Panel
            </h5>
        </div>
        <nav class="d-flex flex-column">
            <a href="${pageContext.request.contextPath}/AdminServlet" class="nav-link">
                <i class="bi bi-house-door"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/AdminMenuServlet" class="nav-link active">
                <i class="bi bi-egg-fried"></i> Menu Items
            </a>
            <a href="${pageContext.request.contextPath}/AdminCategoryServlet" class="nav-link">
                <i class="bi bi-folder"></i> Categories
            </a>
            <a href="${pageContext.request.contextPath}/AdminOrderServlet" class="nav-link">
                <i class="bi bi-cart-check"></i> Orders
            </a>
        </nav>
    </div>

    <!-- Admin Main Content -->
    <div class="admin-main">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3 style="font-family: var(--font-heading);">Menu Items</h3>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#foodModal" onclick="clearForm()">
                <i class="bi bi-plus-lg"></i> Add New Item
            </button>
        </div>

        <div class="card" style="border: none; border-radius: var(--radius-md); box-shadow: var(--shadow-sm);">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="admin-table table mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Image</th>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Rating</th>
                                <th>Featured</th>
                                <th>Available</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${foodItems}">
                                <tr>
                                    <td>${item.foodId}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty item.imageUrl}">
                                                <img src="${item.imageUrl}" alt="${item.name}" style="width: 50px; height: 50px; object-fit: cover; border-radius: var(--radius-xs);">
                                            </c:when>
                                            <c:otherwise>
                                                <div style="width: 50px; height: 50px; background: var(--cream-dark); border-radius: var(--radius-xs); display: flex; align-items: center; justify-content: center; color: var(--gray-500);">
                                                    <i class="bi bi-image"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><strong>${item.name}</strong></td>
                                    <td>${item.categoryName}</td>
                                    <td>RM <fmt:formatNumber value="${item.price}" pattern="#0.00"/></td>
                                    <td>
                                        <i class="bi bi-star-fill" style="color: var(--gold); font-size: 0.8rem;"></i>
                                        ${item.rating}
                                        <small class="text-muted">(${item.reviewCount})</small>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.featured}">
                                                <span class="badge-featured">Featured</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">-</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.available}">
                                                <span class="badge" style="background: #D4EDDA; color: #155724;">Yes</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge" style="background: #F8D7DA; color: #721C24;">No</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <button class="btn btn-sm btn-outline-warning" onclick="editItem('${item.foodId}', '${item.name}', '${item.description}', '${item.ingredients}', '${item.nutritionalInfo}', '${item.price}', '${item.categoryId}', '${item.imageUrl}', ${item.featured}, ${item.popular}, ${item.available})" data-bs-toggle="modal" data-bs-target="#foodModal">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <form method="post" action="${pageContext.request.contextPath}/AdminMenuServlet" style="display:inline;">
                                                <input type="hidden" name="action" value="toggle">
                                                <input type="hidden" name="foodId" value="${item.foodId}">
                                                <button type="submit" class="btn btn-sm btn-outline-info">
                                                    <i class="bi bi-${item.available ? 'eye-slash' : 'eye'}"></i>
                                                </button>
                                            </form>
                                            <form method="post" action="${pageContext.request.contextPath}/AdminMenuServlet" style="display:inline;"
                                                  onsubmit="return confirm('Are you sure you want to delete this item?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="foodId" value="${item.foodId}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty foodItems}">
                                <tr>
                                    <td colspan="9" class="text-center py-4 text-muted">No menu items found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add / Edit Food Item Modal -->
<div class="modal fade" id="foodModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Add New Food Item</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/AdminMenuServlet" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" id="formAction" value="add">
                    <input type="hidden" name="foodId" id="editFoodId" value="">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Name <span style="color: var(--red);">*</span></label>
                            <input type="text" name="name" id="editName" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Image URL</label>
                            <input type="text" name="imageUrl" id="editImage" class="form-control" placeholder="https://...">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea name="description" id="editDesc" class="form-control" rows="2"></textarea>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Ingredients</label>
                            <textarea name="ingredients" id="editIngredients" class="form-control" rows="2"></textarea>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Nutritional Info</label>
                            <textarea name="nutritionalInfo" id="editNutrition" class="form-control" rows="2"></textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="form-label">Price (RM) <span style="color: var(--red);">*</span></label>
                            <input type="number" step="0.01" name="price" id="editPrice" class="form-control" required>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label">Category <span style="color: var(--red);">*</span></label>
                            <select name="categoryId" id="editCategory" class="form-select" required>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.categoryId}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3 d-flex align-items-end">
                            <div class="form-check form-check-inline">
                                <input type="checkbox" name="isFeatured" id="editFeatured" class="form-check-input" value="on">
                                <label class="form-check-label">Featured</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input type="checkbox" name="isPopular" id="editPopular" class="form-check-input" value="on">
                                <label class="form-check-label">Popular</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input type="checkbox" name="isAvailable" id="editAvailable" class="form-check-input" value="on" checked>
                                <label class="form-check-label">Available</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
<c:if test="${not empty editItem}">
(function() {
    document.getElementById('formAction').value = 'update';
    document.getElementById('modalTitle').textContent = 'Edit Food Item';
    document.getElementById('editFoodId').value = '${editItem.foodId}';
    document.getElementById('editName').value = '${editItem.name}';
    document.getElementById('editDesc').value = '${editItem.description}';
    document.getElementById('editIngredients').value = '${editItem.ingredients}';
    document.getElementById('editNutrition').value = '${editItem.nutritionalInfo}';
    document.getElementById('editPrice').value = '${editItem.price}';
    document.getElementById('editCategory').value = '${editItem.categoryId}';
    document.getElementById('editImage').value = '${editItem.imageUrl != null ? editItem.imageUrl : ""}';
    document.getElementById('editFeatured').checked = ${editItem.featured};
    document.getElementById('editPopular').checked = ${editItem.popular};
    document.getElementById('editAvailable').checked = ${editItem.available};
    new bootstrap.Modal(document.getElementById('foodModal')).show();
})();
</c:if>

function editItem(id, name, desc, ingredients, nutrition, price, catId, imageUrl, featured, popular, available) {
    document.getElementById('formAction').value = 'update';
    document.getElementById('modalTitle').textContent = 'Edit Food Item';
    document.getElementById('editFoodId').value = id;
    document.getElementById('editName').value = name;
    document.getElementById('editDesc').value = desc;
    document.getElementById('editIngredients').value = ingredients;
    document.getElementById('editNutrition').value = nutrition;
    document.getElementById('editPrice').value = price;
    document.getElementById('editCategory').value = catId;
    document.getElementById('editImage').value = imageUrl;
    document.getElementById('editFeatured').checked = featured;
    document.getElementById('editPopular').checked = popular;
    document.getElementById('editAvailable').checked = available;
}

function clearForm() {
    document.getElementById('formAction').value = 'add';
    document.getElementById('modalTitle').textContent = 'Add New Food Item';
    document.getElementById('editFoodId').value = '';
    document.getElementById('editName').value = '';
    document.getElementById('editDesc').value = '';
    document.getElementById('editIngredients').value = '';
    document.getElementById('editNutrition').value = '';
    document.getElementById('editPrice').value = '';
    document.getElementById('editImage').value = '';
    document.getElementById('editFeatured').checked = false;
    document.getElementById('editPopular').checked = false;
    document.getElementById('editAvailable').checked = true;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>