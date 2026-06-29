<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<!-- Page Header -->
<section class="page-header">
    <div class="container">
        <h1>About Jade Dragon</h1>
        <p>Our Story</p>
    </div>
</section>

<!-- Our Story -->
<section class="section">
    <div class="container">
        <div class="about-story animate-in">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-4 mb-lg-0">
                    <div class="section-title text-start mb-4">
                        <span class="subtitle">Since 1998</span>
                        <h2>A Legacy of Flavor</h2>
                        <span class="divider"></span>
                    </div>
                    <p class="mb-3" style="font-size: 1.05rem; line-height: 1.8;">
                        Since 1998, Jade Dragon has been serving authentic Chinese cuisine in the heart of
                        Kuala Lumpur. What began as a small family-run kitchen has grown into one of the
                        city's most beloved dining destinations.
                    </p>
                    <p style="font-size: 1.05rem; line-height: 1.8;">
                        Our master chefs bring decades of experience from China's finest kitchens, crafting
                        each dish with time-honored techniques and the freshest ingredients. Every plate that
                        leaves our kitchen carries the soul of its origin and our passion for excellence.
                    </p>
                </div>
                <div class="col-lg-6 text-center">
                    <div style="background: linear-gradient(135deg, var(--red), var(--red-dark));
                                border-radius: var(--radius-md); padding: 80px 40px; color: var(--white);">
                        <span style="font-size: 5rem;">&#x1F409;</span>
                        <h3 class="mt-3 mb-2" style="color: var(--white); font-family: var(--font-heading);">Jade Dragon</h3>
                        <p class="mb-0" style="opacity: 0.85;">Est. 1998 &middot; Kuala Lumpur</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Our Chefs -->
<section style="background: var(--dark); padding: 80px 0;">
    <div class="container">
        <div class="section-title mb-5">
            <span class="subtitle" style="color: var(--gold-light);">Meet The Team</span>
            <h2 style="color: var(--white);">Our Chefs</h2>
            <span class="divider"></span>
        </div>
        <div class="row">
            <div class="col-lg-4 mb-4">
                <div class="chef-card">
                    <img src="https://images.unsplash.com/photo-1577219491135-ce391730fb2c?w=300&h=300&fit=crop"
                         alt="Chef Wei Zhang" class="chef-img">
                    <h4>Chef Wei Zhang</h4>
                    <p class="mb-1" style="color: var(--red); font-weight: 600;">Executive Chef</p>
                    <p class="mb-1" style="color: var(--gray-500); font-size: 0.9rem;">25 years of experience</p>
                    <p style="color: var(--gray-500); font-size: 0.9rem;">Specialty: Cantonese Cuisine</p>
                </div>
            </div>
            <div class="col-lg-4 mb-4">
                <div class="chef-card">
                    <img src="https://images.unsplash.com/photo-1583394293214-28ded15ee548?w=300&h=300&fit=crop"
                         alt="Chef Lin Chen" class="chef-img">
                    <h4>Chef Lin Chen</h4>
                    <p class="mb-1" style="color: var(--red); font-weight: 600;">Dim Sum Master</p>
                    <p class="mb-1" style="color: var(--gray-500); font-size: 0.9rem;">18 years of experience</p>
                    <p style="color: var(--gray-500); font-size: 0.9rem;">Specialty: Dim Sum & Pastry</p>
                </div>
            </div>
            <div class="col-lg-4 mb-4">
                <div class="chef-card">
                    <img src="https://images.pexels.com/photos/3814446/pexels-photo-3814446.jpeg?w=300&h=300&fit=crop"
                         alt="Chef Mei Wong" class="chef-img">
                    <h4>Chef Mei Wong</h4>
                    <p class="mb-1" style="color: var(--red); font-weight: 600;">Sous Chef</p>
                    <p class="mb-1" style="color: var(--gray-500); font-size: 0.9rem;">15 years of experience</p>
                    <p style="color: var(--gray-500); font-size: 0.9rem;">Specialty: Sichuan Cuisine</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Our Values -->
<section class="section">
    <div class="container">
        <div class="section-title mb-5">
            <span class="subtitle">What We Stand For</span>
            <h2>Our Values</h2>
            <span class="divider"></span>
        </div>
        <div class="row">
            <div class="col-md-6 col-lg-3 mb-4">
                <div class="chef-card h-100">
                    <div style="width: 72px; height: 72px; background: linear-gradient(135deg, var(--red), var(--red-light));
                                border-radius: var(--radius-sm); display: flex; align-items: center; justify-content: center;
                                font-size: 1.8rem; color: white; margin: 0 auto 16px;">
                        <i class="bi bi-basket2-fill"></i>
                    </div>
                    <h5>Quality Ingredients</h5>
                    <p style="color: var(--gray-500); font-size: 0.9rem;">
                        We source only the freshest, highest-quality ingredients for every dish we prepare.
                    </p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3 mb-4">
                <div class="chef-card h-100">
                    <div style="width: 72px; height: 72px; background: linear-gradient(135deg, var(--gold), var(--gold-dark));
                                border-radius: var(--radius-sm); display: flex; align-items: center; justify-content: center;
                                font-size: 1.8rem; color: white; margin: 0 auto 16px;">
                        <i class="bi bi-book-half"></i>
                    </div>
                    <h5>Traditional Recipes</h5>
                    <p style="color: var(--gray-500); font-size: 0.9rem;">
                        Time-honored recipes passed down through generations, preserved with care and precision.
                    </p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3 mb-4">
                <div class="chef-card h-100">
                    <div style="width: 72px; height: 72px; background: linear-gradient(135deg, var(--info), #5DB8C8);
                                border-radius: var(--radius-sm); display: flex; align-items: center; justify-content: center;
                                font-size: 1.8rem; color: white; margin: 0 auto 16px;">
                        <i class="bi bi-heart-fill"></i>
                    </div>
                    <h5>Warm Hospitality</h5>
                    <p style="color: var(--gray-500); font-size: 0.9rem;">
                        Every guest is family. We treat each visit with the warmth and care it deserves.
                    </p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3 mb-4">
                <div class="chef-card h-100">
                    <div style="width: 72px; height: 72px; background: linear-gradient(135deg, var(--success), #5DD879);
                                border-radius: var(--radius-sm); display: flex; align-items: center; justify-content: center;
                                font-size: 1.8rem; color: white; margin: 0 auto 16px;">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <h5>Community First</h5>
                    <p style="color: var(--gray-500); font-size: 0.9rem;">
                        We are proud to be part of Kuala Lumpur's vibrant community and give back whenever we can.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>