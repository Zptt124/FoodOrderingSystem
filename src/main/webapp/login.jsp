<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect("home.jsp");
        return;
    }
%>

<div class="auth-page">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6">
                <div class="auth-card">
                    <div class="text-center mb-3">
                        <span class="d-inline-flex mx-auto mb-3" style="width:56px;height:56px;background:linear-gradient(135deg,var(--red),var(--red-light));border-radius:var(--radius-sm);align-items:center;justify-content:center;font-size:1.5rem;">
                            <i class="bi bi-box-arrow-in-right" style="color:white;"></i>
                        </span>
                        <h2 style="font-family:var(--font-heading);">Welcome Back</h2>
                        <p class="subtitle-text">Sign in to your Jade Dragon account</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger d-flex align-items-center" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <div>${error}</div>
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success d-flex align-items-center" role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            <div>${success}</div>
                        </div>
                    </c:if>

                    <form action="LoginServlet" method="post">
                        <c:if test="${not empty param.redirect}">
                            <input type="hidden" name="redirect" value="${param.redirect}">
                        </c:if>

                        <!-- Username -->
                        <div class="mb-3">
                            <label for="loginUsername" class="form-label">
                                <i class="bi bi-person"></i> Username
                            </label>
                            <input type="text" name="username" id="loginUsername" class="form-control"
                                   value="${username}" required placeholder="Enter your username">
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label for="loginPassword" class="form-label">
                                <i class="bi bi-lock"></i> Password
                            </label>
                            <input type="password" name="password" id="loginPassword" class="form-control"
                                   required placeholder="Enter your password">
                        </div>

                        <button type="submit" class="btn btn-primary btn-lg w-100 mt-2">
                            <i class="bi bi-box-arrow-in-right"></i> Sign In
                        </button>
                    </form>

                    <p class="text-center mt-3" style="opacity: 0.7;">
                        Don't have an account?
                        <a href="register.jsp" style="color: var(--red); font-weight: 600;">Register here</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
