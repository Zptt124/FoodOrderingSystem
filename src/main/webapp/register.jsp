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
        <div class="col-lg-5 col-md-8">
            <div class="card" style="background: #FFF; border: 2px solid #D4A843; border-radius: 12px;">
                <div class="card-body p-4">
                    <div class="text-center mb-3">
                        <span style="font-size: 3rem;">🐉</span>
                        <h3 style="font-family: 'Noto Serif SC'; color: #C41E3A;">注册 Register</h3>
                        <p style="opacity: 0.7;">Create your Jade Dragon account</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="RegisterServlet" method="post" id="registerForm" novalidate>
                        <div class="mb-3">
                            <label class="form-label">Username 用户名 <span style="color: #C41E3A;">*</span></label>
                            <input type="text" name="username" class="form-control" value="${username}"
                                   required minlength="3" placeholder="At least 3 characters">
                            <div class="invalid-feedback">Username must be at least 3 characters.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email 邮箱 <span style="color: #C41E3A;">*</span></label>
                            <input type="email" name="email" class="form-control" value="${email}"
                                   required placeholder="your@email.com">
                            <div class="invalid-feedback">Please enter a valid email.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone 手机号</label>
                            <input type="tel" name="phone" class="form-control" value="${phone}"
                                   placeholder="+60123456789">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password 密码 <span style="color: #C41E3A;">*</span></label>
                            <input type="password" name="password" id="password" class="form-control"
                                   required minlength="6" placeholder="At least 6 characters">
                            <div class="invalid-feedback">Password must be at least 6 characters.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Confirm Password 确认密码 <span style="color: #C41E3A;">*</span></label>
                            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control"
                                   required placeholder="Re-enter password">
                            <div class="invalid-feedback" id="pwMatchError">Passwords do not match.</div>
                        </div>
                        <button type="submit" class="btn btn-lg w-100" style="background: #C41E3A; color: white;">
                            Register 注册
                        </button>
                    </form>
                    <p class="text-center mt-3" style="opacity: 0.7;">
                        Already have an account? 已有账号？
                        <a href="login.jsp" style="color: #C41E3A;">Login 登录</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
</section>

<script src="js/validation.js"></script>
<%@ include file="footer.jsp" %>
