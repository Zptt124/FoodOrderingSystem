<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect("home.jsp");
        return;
    }
%>
<section style="background: linear-gradient(rgba(26,26,46,0.92), rgba(45,27,46,0.92)),
                url('https://images.unsplash.com/photo-1552566626-52f8b828add9?w=1920');
                min-height: 85vh; padding: 60px 0; background-size: cover; background-position: center;">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-4 col-md-6">
            <div class="card" style="background: #FFF; border: 2px solid #D4A843; border-radius: 12px;">
                <div class="card-body p-4">
                    <div class="text-center mb-3">
                        <span style="font-size: 3rem;">🐉</span>
                        <h3 style="font-family: 'Noto Serif SC'; color: #C41E3A;">登录 Login</h3>
                        <p style="opacity: 0.7;">Welcome back to Jade Dragon</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>

                    <form action="LoginServlet" method="post">
                        <c:if test="${not empty param.redirect}">
                            <input type="hidden" name="redirect" value="${param.redirect}">
                        </c:if>
                        <div class="mb-3">
                            <label class="form-label">Username 用户名</label>
                            <input type="text" name="username" class="form-control" value="${username}"
                                   required placeholder="Enter username">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password 密码</label>
                            <input type="password" name="password" class="form-control"
                                   required placeholder="Enter password">
                        </div>
                        <button type="submit" class="btn btn-lg w-100" style="background: #C41E3A; color: white;">
                            Login 登录
                        </button>
                    </form>
                    <p class="text-center mt-3" style="opacity: 0.7;">
                        Don't have an account? 没有账号？
                        <a href="register.jsp" style="color: #C41E3A;">Register 注册</a>
                    </p>

                    <!-- Demo credentials -->
                    <div class="mt-3 p-3" style="background: #FFF8E7; border-radius: 8px; font-size: 0.85rem;">
                        <strong>Demo Accounts 演示账号:</strong><br>
                        Admin: <code>admin</code> / <code>admin123</code><br>
                        Customer: <code>customer1</code> / <code>admin123</code>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</section>

<%@ include file="footer.jsp" %>
