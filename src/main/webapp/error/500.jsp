<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ include file="../header.jsp" %>

<section style="background: var(--dark); min-height: 70vh; display: flex; align-items: center; justify-content: center; text-align: center; padding: 60px 0;">
    <div class="container">
        <div class="empty-state">
            <div style="font-family: var(--font-heading); font-size: 8rem; font-weight: 900; color: var(--gold); line-height: 1; margin-bottom: 16px;">
                500
            </div>
            <h2 style="color: var(--white); margin-bottom: 12px;">Internal Server Error</h2>
            <p style="color: rgba(255,255,255,0.6); max-width: 500px; margin: 0 auto 24px;">
                Something went wrong on our end. Please try again later.
            </p>
            <a href="../home.jsp" class="btn btn-primary btn-lg">
                <i class="bi bi-house-door"></i> Go Back Home
            </a>
        </div>
    </div>
</section>

<%@ include file="../footer.jsp" %>