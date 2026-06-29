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
            <div class="col-lg-5 col-md-8">
                <div class="auth-card">
                    <div class="text-center mb-3">
                        <span class="brand-icon d-inline-flex mx-auto mb-3" style="width:56px;height:56px;background:linear-gradient(135deg,var(--red),var(--red-light));border-radius:var(--radius-sm);align-items:center;justify-content:center;font-size:1.5rem;">
                            <i class="bi bi-person-plus-fill" style="color:white;"></i>
                        </span>
                        <h2 style="font-family:var(--font-heading);">Create Account</h2>
                        <p class="subtitle-text">Join Jade Dragon for exclusive offers and easy ordering</p>
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

                    <form action="RegisterServlet" method="post" id="registerForm" novalidate>
                        <!-- Username -->
                        <div class="mb-3">
                            <label for="regUsername" class="form-label">
                                <i class="bi bi-person"></i> Username <span style="color:var(--red);">*</span>
                            </label>
                            <input type="text" name="username" id="regUsername" class="form-control"
                                   value="${username}" required minlength="3"
                                   placeholder="At least 3 characters">
                            <div class="invalid-feedback">Username must be at least 3 characters.</div>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label for="regEmail" class="form-label">
                                <i class="bi bi-envelope"></i> Email <span style="color:var(--red);">*</span>
                            </label>
                            <input type="email" name="email" id="regEmail" class="form-control"
                                   value="${email}" required
                                   placeholder="your@email.com">
                            <div class="invalid-feedback">Please enter a valid email address.</div>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label for="regPhone" class="form-label">
                                <i class="bi bi-telephone"></i> Phone <small class="text-muted">(optional)</small>
                            </label>
                            <input type="tel" name="phone" id="regPhone" class="form-control"
                                   value="${phone}" placeholder="+60123456789">
                            <div class="invalid-feedback">Please enter a valid phone number (7-15 digits).</div>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label for="password" class="form-label">
                                <i class="bi bi-lock"></i> Password <span style="color:var(--red);">*</span>
                            </label>
                            <input type="password" name="password" id="password" class="form-control"
                                   required minlength="6" placeholder="At least 6 characters">
                            <div class="invalid-feedback">Password must be at least 6 characters.</div>
                        </div>

                        <!-- Confirm Password -->
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">
                                <i class="bi bi-lock-fill"></i> Confirm Password <span style="color:var(--red);">*</span>
                            </label>
                            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control"
                                   required placeholder="Re-enter your password">
                            <div class="invalid-feedback" id="pwMatchError">Passwords do not match.</div>
                        </div>

                        <button type="submit" class="btn btn-primary btn-lg w-100 mt-2">
                            <i class="bi bi-person-check"></i> Create Account
                        </button>
                    </form>

                    <p class="text-center mt-3" style="opacity: 0.7;">
                        Already have an account?
                        <a href="login.jsp" style="color: var(--red); font-weight: 600;">Sign in here</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="js/validation.js"></script>
<%@ include file="footer.jsp" %>