<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%
    com.jadedragon.model.User user = (com.jadedragon.model.User) session.getAttribute("user");
    if (user == null || !user.isAdmin()) { response.sendRedirect("../login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Menu - Jade Dragon</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+SC:wght@400;500;700;900&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark" style="background: #1A1A2E; border-bottom: 2px solid #D4A843;">
    <div class="container-fluid">
        <a class="navbar-brand" href="../home.jsp">
            <span style="font-family: 'Noto Serif SC'; color: #D4A843; font-weight: 700;">🐉 玉龙 Admin</span>
        </a>
        <div class="d-flex">
            <a href="dashboard.jsp" class="btn btn-sm btn-outline-light" style="margin-right: 5px;">Dashboard</a>
            <a href="menu-items.jsp" class="btn btn-sm" style="background: #D4A843; color: #1A1A2E; margin-right: 5px;">Menu</a>
            <a href="categories.jsp" class="btn btn-sm btn-outline-light" style="margin-right: 5px;">Categories</a>
            <a href="orders.jsp" class="btn btn-sm btn-outline-light" style="margin-right: 5px;">Orders</a>
            <a href="../LogoutServlet" class="btn btn-sm btn-outline-light">Logout</a>
        </div>
    </div>
</nav>

<div class="container-fluid" style="background: #FFF8E7; min-height: 90vh; padding: 30px;">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 style="color: #1A1A2E;">Menu Items <span style="font-family: 'Noto Serif SC'; color: #C41E3A;">菜品管理</span></h3>
        <button class="btn" style="background: #C41E3A; color: white;" data-bs-toggle="modal" data-bs-target="#foodModal"
                onclick="clearForm()">
            <i class="bi bi-plus-lg"></i> Add New Item
        </button>
    </div>

    <div class="card">
        <div class="card-body" style="overflow-x: auto;">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th><th>Name</th><th>Chinese</th><th>Category</th>
                        <th>Price</th><th>Rating</th><th>Featured</th><th>Available</th><th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${foodItems}">
                        <tr>
                            <td>${item.foodId}</td>
                            <td>${item.name}</td>
                            <td style="font-family: 'Noto Serif SC';">${item.nameCn}</td>
                            <td>${item.categoryName}</td>
                            <td>RM <fmt:formatNumber value="${item.price}" pattern="#0.00"/></td>
                            <td>★ ${item.rating}</td>
                            <td>${item.featured ? '⭐' : '-'}</td>
                            <td>${item.available ? '✅' : '❌'}</td>
                            <td>
                                <a href="AdminMenuServlet?action=edit&id=${item.foodId}" class="btn btn-sm btn-outline-warning">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <form method="post" action="AdminMenuServlet" style="display:inline;">
                                    <input type="hidden" name="action" value="toggle">
                                    <input type="hidden" name="foodId" value="${item.foodId}">
                                    <button type="submit" class="btn btn-sm btn-outline-info">
                                        <i class="bi bi-${item.available ? 'eye-slash' : 'eye'}"></i>
                                    </button>
                                </form>
                                <form method="post" action="AdminMenuServlet" style="display:inline;"
                                      onsubmit="return confirm('Delete this item? 确定删除？')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="foodId" value="${item.foodId}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add/Edit Modal -->
<div class="modal fade" id="foodModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="background: #1A1A2E; color: #D4A843;">
                <h5 class="modal-title" id="modalTitle">Add New Food Item</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="AdminMenuServlet" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" id="formAction" value="add">
                    <input type="hidden" name="foodId" id="editFoodId" value="">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Name (EN) <span style="color:#C41E3A;">*</span></label>
                            <input type="text" name="name" id="editName" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">中文名 <span style="color:#C41E3A;">*</span></label>
                            <input type="text" name="nameCn" id="editNameCn" class="form-control" required>
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
                            <label class="form-label">Price <span style="color:#C41E3A;">*</span></label>
                            <input type="number" step="0.01" name="price" id="editPrice" class="form-control" required>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label">Category <span style="color:#C41E3A;">*</span></label>
                            <select name="categoryId" id="editCategory" class="form-select" required>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.categoryId}">${cat.name} / ${cat.nameCn}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label">Image URL</label>
                            <input type="text" name="imageUrl" id="editImage" class="form-control">
                        </div>
                        <div class="col-md-3 mb-3 d-flex align-items-end">
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
                    <button type="submit" class="btn" style="background: #C41E3A; color: white;">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
<c:if test="${not empty editItem}">
document.getElementById('formAction').value = 'update';
document.getElementById('modalTitle').textContent = 'Edit Food Item';
document.getElementById('editFoodId').value = '${editItem.foodId}';
document.getElementById('editName').value = '${editItem.name}';
document.getElementById('editNameCn').value = '${editItem.nameCn}';
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
</c:if>
function clearForm() {
    document.getElementById('formAction').value = 'add';
    document.getElementById('modalTitle').textContent = 'Add New Food Item';
    ['editFoodId','editName','editNameCn','editDesc','editIngredients','editNutrition','editPrice','editImage'].forEach(id => document.getElementById(id).value = '');
    document.getElementById('editFeatured').checked = false;
    document.getElementById('editPopular').checked = false;
    document.getElementById('editAvailable').checked = true;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
