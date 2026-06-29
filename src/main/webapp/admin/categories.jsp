<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
            <a href="${pageContext.request.contextPath}/AdminMenuServlet" class="nav-link">
                <i class="bi bi-egg-fried"></i> Menu Items
            </a>
            <a href="${pageContext.request.contextPath}/AdminCategoryServlet" class="nav-link active">
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
            <h3 style="font-family: var(--font-heading);">Categories</h3>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#catModal" onclick="clearCatForm()">
                <i class="bi bi-plus-lg"></i> Add Category
            </button>
        </div>

        <div class="card" style="border: none; border-radius: var(--radius-md); box-shadow: var(--shadow-sm);">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="admin-table table mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cat" items="${categories}">
                                <tr>
                                    <td>${cat.categoryId}</td>
                                    <td><strong>${cat.name}</strong></td>
                                    <td>${not empty cat.description ? cat.description : '<span class="text-muted">-</span>'}</td>
                                    <td>
                                        <div class="d-flex gap-1">
                                            <button class="btn btn-sm btn-outline-warning" onclick="editCategory('${cat.categoryId}', '${cat.name}', '${cat.description}', '${cat.imageUrl}')" data-bs-toggle="modal" data-bs-target="#catModal">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <form method="post" action="${pageContext.request.contextPath}/AdminCategoryServlet" style="display:inline;"
                                                  onsubmit="return confirm('Are you sure you want to delete this category?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="categoryId" value="${cat.categoryId}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty categories}">
                                <tr>
                                    <td colspan="4" class="text-center py-4 text-muted">No categories found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add / Edit Category Modal -->
<div class="modal fade" id="catModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="catModalTitle">Add Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/AdminCategoryServlet" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" id="catAction" value="add">
                    <input type="hidden" name="categoryId" id="catEditId" value="">
                    <div class="mb-3">
                        <label class="form-label">Name <span style="color: var(--red);">*</span></label>
                        <input type="text" name="name" id="catEditName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea name="description" id="catEditDesc" class="form-control" rows="2"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Image URL</label>
                        <input type="text" name="imageUrl" id="catEditImage" class="form-control" placeholder="https://...">
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
<c:if test="${not empty editCategory}">
(function() {
    document.getElementById('catAction').value = 'update';
    document.getElementById('catModalTitle').textContent = 'Edit Category';
    document.getElementById('catEditId').value = '${editCategory.categoryId}';
    document.getElementById('catEditName').value = '${editCategory.name}';
    document.getElementById('catEditDesc').value = '${editCategory.description}';
    document.getElementById('catEditImage').value = '${editCategory.imageUrl != null ? editCategory.imageUrl : ""}';
    new bootstrap.Modal(document.getElementById('catModal')).show();
})();
</c:if>

function editCategory(id, name, desc, imageUrl) {
    document.getElementById('catAction').value = 'update';
    document.getElementById('catModalTitle').textContent = 'Edit Category';
    document.getElementById('catEditId').value = id;
    document.getElementById('catEditName').value = name;
    document.getElementById('catEditDesc').value = desc;
    document.getElementById('catEditImage').value = imageUrl;
}

function clearCatForm() {
    document.getElementById('catAction').value = 'add';
    document.getElementById('catModalTitle').textContent = 'Add Category';
    document.getElementById('catEditId').value = '';
    document.getElementById('catEditName').value = '';
    document.getElementById('catEditDesc').value = '';
    document.getElementById('catEditImage').value = '';
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
