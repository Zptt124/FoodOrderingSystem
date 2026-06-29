<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    com.jadedragon.model.User user = (com.jadedragon.model.User) session.getAttribute("user");
    if (user == null || !user.isAdmin()) { response.sendRedirect("../login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories - Jade Dragon</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+SC:wght@400;500;700;900&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="../css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark" style="background: #1A1A2E; border-bottom: 2px solid #D4A843;">
    <div class="container-fluid">
        <a class="navbar-brand" href="../home.jsp"><span style="font-family: 'Noto Serif SC'; color: #D4A843; font-weight: 700;">🐉 玉龙 Admin</span></a>
        <div class="d-flex">
            <a href="dashboard.jsp" class="btn btn-sm btn-outline-light" style="margin-right: 5px;">Dashboard</a>
            <a href="menu-items.jsp" class="btn btn-sm btn-outline-light" style="margin-right: 5px;">Menu</a>
            <a href="categories.jsp" class="btn btn-sm" style="background: #D4A843; color: #1A1A2E; margin-right: 5px;">Categories</a>
            <a href="orders.jsp" class="btn btn-sm btn-outline-light" style="margin-right: 5px;">Orders</a>
            <a href="../LogoutServlet" class="btn btn-sm btn-outline-light">Logout</a>
        </div>
    </div>
</nav>

<div class="container-fluid" style="background: #FFF8E7; min-height: 90vh; padding: 30px;">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 style="color: #1A1A2E;">Categories <span style="font-family: 'Noto Serif SC'; color: #C41E3A;">分类管理</span></h3>
        <button class="btn" style="background: #C41E3A; color: white;" data-bs-toggle="modal" data-bs-target="#catModal">
            <i class="bi bi-plus-lg"></i> Add Category
        </button>
    </div>

    <div class="card">
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                    <tr><th>ID</th><th>Name (EN)</th><th>中文名</th><th>Description</th><th>Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="cat" items="${categories}">
                        <tr>
                            <td>${cat.categoryId}</td>
                            <td>${cat.name}</td>
                            <td style="font-family: 'Noto Serif SC';">${cat.nameCn}</td>
                            <td>${cat.description}</td>
                            <td>
                                <a href="AdminCategoryServlet?action=edit&id=${cat.categoryId}"
                                   class="btn btn-sm btn-outline-warning"><i class="bi bi-pencil"></i></a>
                                <form method="post" action="AdminCategoryServlet" style="display:inline;"
                                      onsubmit="return confirm('Delete this category?')">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="categoryId" value="${cat.categoryId}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Category Modal -->
<div class="modal fade" id="catModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background: #1A1A2E; color: #D4A843;">
                <h5 class="modal-title" id="catModalTitle">Add Category</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="AdminCategoryServlet" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" id="catAction" value="add">
                    <input type="hidden" name="categoryId" id="catEditId" value="">
                    <div class="mb-3">
                        <label class="form-label">Name (EN) <span style="color:#C41E3A;">*</span></label>
                        <input type="text" name="name" id="catEditName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">中文名 <span style="color:#C41E3A;">*</span></label>
                        <input type="text" name="nameCn" id="catEditNameCn" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea name="description" id="catEditDesc" class="form-control" rows="2"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Image URL</label>
                        <input type="text" name="imageUrl" id="catEditImage" class="form-control">
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
<c:if test="${not empty editCategory}">
document.getElementById('catAction').value = 'update';
document.getElementById('catModalTitle').textContent = 'Edit Category';
document.getElementById('catEditId').value = '${editCategory.categoryId}';
document.getElementById('catEditName').value = '${editCategory.name}';
document.getElementById('catEditNameCn').value = '${editCategory.nameCn}';
document.getElementById('catEditDesc').value = '${editCategory.description}';
document.getElementById('catEditImage').value = '${editCategory.imageUrl != null ? editCategory.imageUrl : ""}';
new bootstrap.Modal(document.getElementById('catModal')).show();
</c:if>
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
