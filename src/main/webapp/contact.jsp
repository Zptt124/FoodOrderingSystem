<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<!-- Page Header -->
<section class="page-header">
    <div class="container">
        <h1>Get in Touch</h1>
        <p>We would love to hear from you</p>
    </div>
</section>

<section class="section">
    <div class="container">
        <!-- Success / Error Alerts -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="row">
            <!-- Contact Form -->
            <div class="col-lg-7 mb-4 mb-lg-0">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-4 p-lg-5">
                        <h4 class="mb-4" style="font-family: var(--font-heading);">Send Us a Message</h4>
                        <form action="ContactServlet" method="post" novalidate>
                            <div class="mb-3">
                                <label for="contactName" class="form-label">Name <span style="color: var(--red);">*</span></label>
                                <input type="text" name="name" id="contactName" class="form-control"
                                       value="${name}" required placeholder="Your full name">
                            </div>
                            <div class="mb-3">
                                <label for="contactEmail" class="form-label">Email <span style="color: var(--red);">*</span></label>
                                <input type="email" name="email" id="contactEmail" class="form-control"
                                       value="${email}" required placeholder="your.email@example.com">
                            </div>
                            <div class="mb-3">
                                <label for="contactSubject" class="form-label">Subject</label>
                                <input type="text" name="subject" id="contactSubject" class="form-control"
                                       value="${subject}" placeholder="General Inquiry / Reservation / Feedback">
                            </div>
                            <div class="mb-4">
                                <label for="contactMessage" class="form-label">Message <span style="color: var(--red);">*</span></label>
                                <textarea name="message" id="contactMessage" class="form-control" rows="5"
                                          required placeholder="Tell us how we can help you...">${message}</textarea>
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="bi bi-send-fill"></i> Send Message
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Info Cards -->
            <div class="col-lg-5">
                <div class="contact-info-card mb-3">
                    <div class="info-icon">
                        <i class="bi bi-geo-alt-fill"></i>
                    </div>
                    <div>
                        <h6 class="mb-1" style="font-weight: 700;">Address</h6>
                        <p class="mb-0" style="color: var(--gray-500); font-size: 0.92rem;">
                            88 Jalan Bukit Bintang<br>55100 Kuala Lumpur, Malaysia
                        </p>
                    </div>
                </div>

                <div class="contact-info-card mb-3">
                    <div class="info-icon">
                        <i class="bi bi-telephone-fill"></i>
                    </div>
                    <div>
                        <h6 class="mb-1" style="font-weight: 700;">Phone</h6>
                        <p class="mb-0" style="color: var(--gray-500); font-size: 0.92rem;">
                            +60 3-2148 8888
                        </p>
                    </div>
                </div>

                <div class="contact-info-card mb-3">
                    <div class="info-icon">
                        <i class="bi bi-envelope-fill"></i>
                    </div>
                    <div>
                        <h6 class="mb-1" style="font-weight: 700;">Email</h6>
                        <p class="mb-0" style="color: var(--gray-500); font-size: 0.92rem;">
                            info@jadedragon.com
                        </p>
                    </div>
                </div>

                <div class="contact-info-card">
                    <div class="info-icon">
                        <i class="bi bi-clock-fill"></i>
                    </div>
                    <div>
                        <h6 class="mb-1" style="font-weight: 700;">Business Hours</h6>
                        <p class="mb-0" style="color: var(--gray-500); font-size: 0.92rem;">
                            Mon - Sun: 11:00 AM - 10:00 PM
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Validation Script -->
<script src="js/validation.js"></script>

<%@ include file="footer.jsp" %>