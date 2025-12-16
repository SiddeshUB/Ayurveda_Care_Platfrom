<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ayurveda Wellness | Ancient Healing for Modern Life</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
    /* === ANIMATION IMAGES SECTION === */
    .animation-section {
        padding: 100px 0;
        background: linear-gradient(135deg, #fdfaf4 0%, #f8f3e9 100%);
        position: relative;
        overflow: hidden;
    }

    .animation-container {
            display: flex;
        justify-content: space-between;
            align-items: center;
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    .animation-left {
        flex: 0 0 40%;
        animation: floatLeft 6s ease-in-out infinite;
    }

    .animation-right {
        flex: 0 0 40%;
        animation: floatRight 6s ease-in-out infinite;
    }

    .animation-center {
        flex: 0 0 20%;
            text-align: center;
        padding: 0 40px;
    }

    .animation-image {
            width: 100%;
        height: auto;
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        transition: transform 0.3s ease;
    }

    .animation-image:hover {
        transform: scale(1.05);
    }

    .animation-center h3 {
        font-family: 'Playfair Display', serif;
        font-size: 32px;
        color: #1f2a1f;
        margin-bottom: 20px;
    }

    .animation-center p {
        color: #666;
        font-size: 16px;
        line-height: 1.6;
        margin-bottom: 25px;
    }

    @keyframes floatLeft {
        0%, 100% {
            transform: translateY(0) rotate(-2deg);
        }
        50% {
            transform: translateY(-20px) rotate(0deg);
        }
    }

    @keyframes floatRight {
        0%, 100% {
            transform: translateY(0) rotate(2deg);
        }
        50% {
            transform: translateY(-20px) rotate(0deg);
        }
    }

    /* Responsive for animation section */
    @media (max-width: 992px) {
        .animation-container {
            flex-direction: column;
            gap: 50px;
        }

        .animation-left,
        .animation-right,
        .animation-center {
            flex: 0 0 100%;
            max-width: 500px;
            margin: 0 auto;
        }

        .animation-center {
            order: 1;
            padding: 0;
        }

        .animation-left {
            order: 2;
        }

        .animation-right {
            order: 3;
        }

        @keyframes floatLeft {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-15px);
            }
        }

        @keyframes floatRight {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-15px);
            }
        }
    }

    /* === ORIGINAL STYLES === */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Poppins', sans-serif;
        background: #fdfaf4;
        color: #333;
        line-height: 1.6;
    }

        /* NAVBAR - Bootstrap compatible */
        .navbar {
            background: rgba(31, 42, 31, 0.98);
            padding: 20px 0;
            transition: all 0.4s ease;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 5px 30px rgba(0,0,0,0.3);
            backdrop-filter: blur(10px);
        }
        
        .navbar.scrolled {
            background: rgba(31, 42, 31, 0.98);
            padding: 12px 0;
            box-shadow: 0 5px 30px rgba(0,0,0,0.3);
            backdrop-filter: blur(10px);
        }
        
        .navbar-brand {
        font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 700;
        color: #e6b55c !important;
            letter-spacing: 1px;
        }
        
        .navbar-nav {
            display: flex;
            flex-direction: row;
            align-items: center;
            flex-wrap: nowrap;
        }
        
        .navbar-nav .nav-item {
            display: flex;
            align-items: center;
            white-space: nowrap;
        }
        
        .navbar-nav .nav-link {
            color: #fff !important;
            font-weight: 500;
            padding: 8px 18px !important;
            transition: all 0.3s ease;
            white-space: nowrap;
        }
        
        .navbar-nav .nav-link:hover {
            color: #e6b55c !important;
        }
        
        .btn-nav {
        background: linear-gradient(135deg, #e6b55c 0%, #d4a347 100%);
        color: #1f2a1f !important;
            padding: 10px 25px !important;
            border-radius: 30px;
            font-weight: 600;
            margin-left: 8px;
            transition: all 0.4s ease;
        }
        
        .btn-nav:hover {
            transform: translateY(-3px);
        box-shadow: 0 10px 30px rgba(230, 181, 92, 0.4);
        color: #1f2a1f !important;
    }

        .user-dropdown .dropdown-toggle {
        background: rgba(230, 181, 92, 0.15);
            border-radius: 30px;
            padding: 8px 20px !important;
        }
        
        .user-dropdown .dropdown-menu {
            background: #fff;
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            padding: 10px 0;
            margin-top: 10px;
        }
        
        .user-dropdown .dropdown-item {
            padding: 12px 20px;
            color: #333;
            transition: all 0.3s ease;
        }
        
        .user-dropdown .dropdown-item:hover {
        background: rgba(230, 181, 92, 0.1);
        color: #e6b55c;
        }
        
        .user-dropdown .dropdown-item i {
            width: 20px;
            margin-right: 10px;
            color: #e6b55c;
        }
        
        /* Login Dropdown Styling */
        .nav-item.dropdown .dropdown-toggle {
            cursor: pointer;
        }
        
        .nav-item.dropdown .dropdown-menu {
            background: #fff;
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            padding: 10px 0;
            margin-top: 10px;
            min-width: 200px;
        }
        
        .nav-item.dropdown .dropdown-item {
            padding: 12px 20px;
            color: #333;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }
        
        .nav-item.dropdown .dropdown-item:hover {
            background: rgba(230, 181, 92, 0.1);
            color: #e6b55c;
        }
        
        .nav-item.dropdown .dropdown-item i {
            width: 20px;
            margin-right: 10px;
            color: #e6b55c;
        }
        
    /* HERO */
        .hero {
            min-height: 100vh;
            position: relative;
        overflow: hidden;
        color: #fff;
            display: flex;
            align-items: center;
        text-align: center;
        padding-top: 80px;
        }
        
        .hero-slide {
            position: absolute;
            inset: 0;
            background-size: cover;
            background-position: center;
        background-repeat: no-repeat;
            opacity: 0;
        transition: opacity 1.2s ease-in-out;
        }
        
        .hero-slide.active {
            opacity: 1;
        }
        
        .hero-overlay {
            position: absolute;
            inset: 0;
        background: linear-gradient(rgba(0,0,0,.55), rgba(0,0,0,.75));
            z-index: 1;
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
    }

    .hero-content h1 {
        font-family: 'Playfair Display', serif;
        font-size: 56px;
            font-weight: 700;
        margin-bottom: 20px;
        color: #fff;
    }

    .hero-content p {
        font-size: 18px;
        margin-bottom: 30px;
            max-width: 700px;
        margin-left: auto;
        margin-right: auto;
        }
        
        .hero-buttons {
        margin-top: 30px;
    }

    /* Pagination dots */
        .hero-dots {
            position: absolute;
        bottom: 40px;
        width: 100%;
            display: flex;
        justify-content: center;
        gap: 12px;
        z-index: 3;
        }
        
        .hero-dots span {
            width: 12px;
            height: 12px;
        background: rgba(230,181,92,0.4);
            border-radius: 50%;
            cursor: pointer;
        transition: background 0.3s ease, transform 0.3s ease;
        }
        
        .hero-dots span.active {
        background: #e6b55c;
        transform: scale(1.2);
    }

    /* BUTTON */
    .btn-gold {
        background: #e6b55c;
        color: #1f2a1f;
        border: none;
        border-radius: 50px;
        padding: 12px 32px;
        font-weight: 500;
        font-size: 16px;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
    }

    .btn-gold:hover {
        background: #d4a347;
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        color: #1f2a1f;
    }

    .btn-outline {
        background: transparent;
        border: 2px solid #e6b55c;
        color: #e6b55c;
    }

    .btn-outline:hover {
        background: #e6b55c;
        color: #1f2a1f;
    }

    /* STATS */
    .stats {
        background: #0f160f;
        color: #c5d2a4;
        padding: 60px 0;
    }

    .stats-container {
            display: flex;
        justify-content: space-around;
        text-align: center;
        flex-wrap: wrap;
        }
        
        .stat-item {
        padding: 20px;
        flex: 1;
        min-width: 200px;
        }
        
        .stat-number {
        font-size: 48px;
            font-weight: 700;
        color: #e6b55c;
            margin-bottom: 10px;
        }
        
    .stat-text {
        font-size: 18px;
    }

    /* SECTION TITLES */
    .section-title {
        font-family: 'Playfair Display';
        font-size: 42px;
            text-align: center;
        margin-bottom: 50px;
        color: #1f2a1f;
        }
        
        .section-title.light {
            color: #fff;
        }
        
    /* SECTIONS */
    section {
        padding: 80px 0;
    }

    .section-header {
        text-align: center;
        margin-bottom: 50px;
    }

    .section-subtitle {
        color: #e6b55c;
            font-size: 18px;
        text-transform: uppercase;
        letter-spacing: 2px;
        margin-bottom: 10px;
    }

    /* DARK SECTION */
    .dark {
        background: #0f0f0f;
        color: #fff;
    }

    /* SERVICES */
    .services-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 30px;
        }
        
        .service-card {
        background: #fff;
        border-radius: 10px;
            overflow: hidden;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        transition: transform 0.3s ease;
        }
        
        .service-card:hover {
        transform: translateY(-10px);
        }
        
        .service-img {
        height: 200px;
            background-size: cover;
            background-position: center;
        }
        
        .service-content {
        padding: 25px;
        }
        
        .service-title {
        font-size: 22px;
            margin-bottom: 15px;
        color: #1f2a1f;
        }
        
        .service-desc {
        color: #666;
            margin-bottom: 20px;
    }

    /* TESTIMONIAL */
    .testimonials-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 30px;
    }

    .testimonial {
        background: #142218;
        color: #fff;
            border-radius: 20px;
        padding: 30px;
            position: relative;
    }

    .testimonial:before {
        content: """;
        font-family: serif;
        font-size: 100px;
        color: #e6b55c;
            position: absolute;
        top: -20px;
        left: 10px;
        opacity: 0.3;
        }
        
        .testimonial-text {
        margin-bottom: 20px;
            font-style: italic;
        }
        
        .testimonial-author {
            display: flex;
            align-items: center;
        }
        
        .author-img {
        width: 50px;
        height: 50px;
            border-radius: 50%;
        background-color: #e6b55c;
        margin-right: 15px;
            overflow: hidden;
    }

    .author-info h4 {
        margin-bottom: 5px;
    }

    .author-info p {
        color: #c5d2a4;
            font-size: 14px;
        }
        
    /* APPOINTMENT */
    .appointment {
        background: linear-gradient(rgba(31,42,31,0.9), rgba(31,42,31,0.9)),
                    url("${pageContext.request.contextPath}/images/treatment3.jpg") center/cover;
        color: #fff;
        text-align: center;
        }
        
        .appointment-form {
        max-width: 600px;
            margin: 0 auto;
        background: rgba(255,255,255,0.1);
        padding: 40px;
        border-radius: 15px;
        backdrop-filter: blur(10px);
    }

    .form-group {
            margin-bottom: 20px;
        text-align: left;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
    }

    .form-control {
        width: 100%;
        padding: 12px 15px;
        border-radius: 5px;
        border: 1px solid #444;
        background: rgba(255,255,255,0.1);
            color: #fff;
        }
        
    .form-control:focus {
        outline: none;
        border-color: #e6b55c;
    }

    /* FOOTER */
    footer {
        background: #1f2a1f;
        color: #cdd6b6;
        padding: 60px 0 30px;
    }

    .footer-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 40px;
        margin-bottom: 40px;
    }

    .footer-col h3 {
        color: #e6b55c;
            margin-bottom: 25px;
            font-size: 20px;
        }
        
        .footer-links {
            list-style: none;
        }
        
        .footer-links li {
            margin-bottom: 12px;
        }
        
        .footer-links a {
        color: #cdd6b6;
            text-decoration: none;
        transition: color 0.3s ease;
        }
        
        .footer-links a:hover {
        color: #e6b55c;
        }
        
    .social-links {
            display: flex;
        gap: 15px;
        margin-top: 20px;
    }

    .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: rgba(255,255,255,0.1);
        color: #cdd6b6;
        transition: all 0.3s ease;
    }

    .social-links a:hover {
        background: #e6b55c;
        color: #1f2a1f;
    }

    .newsletter input {
            border-radius: 30px;
            border: none;
        padding: 12px 15px;
        width: 100%;
        margin-bottom: 15px;
    }

    .copyright {
            text-align: center;
        padding-top: 30px;
        border-top: 1px solid rgba(255,255,255,0.1);
        font-size: 14px;
    }

    /* RESPONSIVE */
    @media (max-width: 992px) {
        .hero-content h1 {
            font-size: 46px;
            }
            
            .section-title {
                font-size: 36px;
            }
    }

    @media (max-width: 768px) {
        .hero-content h1 {
                font-size: 36px;
            }
            
            .section-title {
            font-size: 32px;
            }
        }
        
        /* Ensure navbar items stay in single row on desktop */
        @media (min-width: 992px) {
            .navbar-nav {
                flex-wrap: nowrap !important;
            }
            
            .navbar-nav .nav-item {
                flex-shrink: 0;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar - KEEPING CURRENT NAVBAR -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-leaf me-2"></i>Ayurveda Wellness
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/hospitals">Find Centers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/doctors">Find Doctors</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products"></i>Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/about">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/services">Services</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                    </li>
                    <c:choose>
                        <c:when test="${not empty currentUser}">
                            <li class="nav-item dropdown user-dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle me-2"></i>${currentUser.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/dashboard"><i class="fas fa-th-large"></i>Dashboard</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile"><i class="fas fa-user"></i>Profile</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/enquiries"><i class="fas fa-envelope"></i>Enquiries</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout"><i class="fas fa-sign-out-alt"></i>Sign Out</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" id="loginDropdown">
                                    <i class="fas fa-sign-in-alt me-2"></i>Login
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/login">
                                        <i class="fas fa-user me-2"></i>User Login
                                    </a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/hospital/login">
                                        <i class="fas fa-hospital me-2"></i>Hospital Login
                                    </a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/doctor/login">
                                        <i class="fas fa-user-md me-2"></i>Doctor Login
                                    </a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/vendor/login">
                                        <i class="fas fa-store me-2"></i>Vendor Login
                                    </a></li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link btn-nav" href="${pageContext.request.contextPath}/user/register">Sign Up</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link btn-nav" href="${pageContext.request.contextPath}/hospital/register">For Centers</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <!-- Slides -->
        <div class="hero-slide active" style="background-image:url('${pageContext.request.contextPath}/images/hero7.jpg')"></div>
        <div class="hero-slide" style="background-image:url('${pageContext.request.contextPath}/images/hero5.jpg')"></div>
        <div class="hero-slide" style="background-image:url('${pageContext.request.contextPath}/images/hero2.jpg')"></div>
        <div class="hero-slide" style="background-image:url('${pageContext.request.contextPath}/images/hero9.jpg')"></div>

        <!-- Dark overlay -->
        <div class="hero-overlay"></div>
        
        <!-- Content -->
        <div class="container hero-content">
            <h1 id="heroTitle"></h1>
            <p id="heroDesc"></p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/user/register" class="btn-gold" id="heroBtn1"></a>
                <a href="${pageContext.request.contextPath}/services" class="btn-gold btn-outline" id="heroBtn2" style="margin-left: 15px;"></a>
            </div>
        </div>
        
        <!-- Pagination -->
        <div class="hero-dots">
            <span class="active"></span>
            <span></span>
            <span></span>
            <span></span>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats">
        <div class="container stats-container">
                    <div class="stat-item">
                <div class="stat-number">25+</div>
                <div class="stat-text">Years of Experience</div>
                    </div>
                    <div class="stat-item">
                <div class="stat-number">10,000+</div>
                <div class="stat-text">Patients Treated</div>
                    </div>
                    <div class="stat-item">
                <div class="stat-number">98%</div>
                <div class="stat-text">Satisfaction Rate</div>
                    </div>
                    <div class="stat-item">
                <div class="stat-number">50+</div>
                <div class="stat-text">Ayurvedic Experts</div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about">
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">Our Philosophy</p>
                <h2 class="section-title">The Ayurvedic Approach</h2>
            </div>
            <div class="about-content">
                <p style="text-align: center; max-width: 800px; margin: 0 auto 30px; font-size: 18px;">
                    Ayurveda, the ancient Indian system of medicine, views health as a perfect balance between body, mind, and consciousness. 
                    Our center specializes in personalized treatments that address the root cause of imbalance rather than just symptoms.
                </p>
                <div style="text-align: center;">
                    <a href="${pageContext.request.contextPath}/services" class="btn-gold">Discover Our Methods</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Animation Images Section -->
   <section class="balance-section">
    <div class="balance-container">
        <div class="balance-left">
            <img src="https://images.unsplash.com/photo-1599901860904-17e6ed7083a0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" 
                 alt="Yoga Meditation" class="balance-image">
        </div>
        
        <div class="balance-center">
            <h3>Holistic Balance</h3>
            <p>Ayurveda teaches us that true wellness comes from harmony between body, mind, and spirit. Our ancient practices bring modern healing.</p>
            <a href="${pageContext.request.contextPath}/services" class="btn-gold">Explore Balance</a>
        </div>
        
        <div class="balance-right">
            <img src="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" 
                 alt="Ayurvedic Treatment" class="balance-image">
        </div>
    </div>
</section>

<style>
    .balance-section {
        padding: 80px 20px;
        background-color: #f9f7f2;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    .balance-container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        justify-content: center;
        gap: 40px;
    }
    
    .balance-left, .balance-right {
        flex: 1;
        min-width: 300px;
        max-width: 400px;
    }
    
    .balance-center {
        flex: 1.2;
        min-width: 300px;
        max-width: 500px;
        padding: 0 20px;
        text-align: center;
    }
    
    .balance-image {
        width: 100%;
        height: 400px;
        object-fit: cover;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease;
    }
    
    .balance-left .balance-image {
        border-top-right-radius: 40px;
        border-bottom-left-radius: 40px;
    }
    
    .balance-right .balance-image {
        border-top-left-radius: 40px;
        border-bottom-right-radius: 40px;
    }
    
    .balance-image:hover {
        transform: scale(1.02);
    }
    
    .balance-center h3 {
        color: #8a6d3b;
        font-size: 2.2rem;
        margin-bottom: 20px;
        position: relative;
        display: inline-block;
    }
    
    .balance-center h3:after {
        content: '';
        position: absolute;
        width: 60%;
        height: 3px;
        background: linear-gradient(90deg, transparent, #8a6d3b, transparent);
        bottom: -10px;
        left: 20%;
    }
    
    .balance-center p {
        color: #555;
        font-size: 1.1rem;
        line-height: 1.7;
        margin-bottom: 30px;
        padding: 0 10px;
    }
    
    .btn-gold {
        display: inline-block;
        background: linear-gradient(to right, #c9a959, #8a6d3b);
        color: white;
        padding: 14px 32px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 600;
        font-size: 1rem;
        letter-spacing: 1px;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        box-shadow: 0 5px 15px rgba(138, 109, 59, 0.2);
    }
    
    .btn-gold:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(138, 109, 59, 0.3);
        background: linear-gradient(to right, #8a6d3b, #c9a959);
    }
    
    /* Responsive Design */
    @media (max-width: 992px) {
        .balance-container {
            flex-direction: column;
        }
        
        .balance-left, .balance-center, .balance-right {
            max-width: 100%;
        }
        
        .balance-center {
            order: 1;
        }
        
        .balance-left {
            order: 2;
        }
        
        .balance-right {
            order: 3;
        }
    }
    
    @media (max-width: 768px) {
        .balance-section {
            padding: 60px 15px;
        }
        
        .balance-image {
            height: 300px;
        }
        
        .balance-center h3 {
            font-size: 1.8rem;
        }
        
        .balance-center p {
            font-size: 1rem;
        }
    }
</style>


    <!-- Services Section -->
    <section id="services" class="dark">
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">What We Offer</p>
                <h2 class="section-title light">Our Ayurvedic Services</h2>
            </div>
            <div class="services-container">
                    <div class="service-card">
                    <div class="service-img" style="background-image: url('${pageContext.request.contextPath}/images/treatment1.jpg');"></div>
                        <div class="service-content">
                            <h3 class="service-title">Panchakarma Therapy</h3>
                            <p class="service-desc">A comprehensive detoxification and rejuvenation program that eliminates toxins and restores constitutional balance.</p>
                        <a href="${pageContext.request.contextPath}/services" class="btn-gold">Learn More</a>
                        </div>
                    </div>
                    <div class="service-card">
                    <div class="service-img" style="background-image: url('${pageContext.request.contextPath}/images/treatment2.jpg');"></div>
                        <div class="service-content">
                            <h3 class="service-title">Herbal Consultations</h3>
                            <p class="service-desc">Personalized herbal formulations based on your unique constitution and health concerns.</p>
                        <a href="${pageContext.request.contextPath}/services" class="btn-gold">Learn More</a>
                        </div>
                    </div>
                    <div class="service-card">
                    <div class="service-img" style="background-image: url('${pageContext.request.contextPath}/images/treatment3.jpg');"></div>
                        <div class="service-content">
                        <h3 class="service-title">Diet & Lifestyle Guidance</h3>
                            <p class="service-desc">Customized nutritional plans and daily routines aligned with your dosha for optimal wellbeing.</p>
                        <a href="${pageContext.request.contextPath}/services" class="btn-gold">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
            <!-- Services Animation Section with Beautiful Ayurvedic Images -->
    <section class="services-animation-section">
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">Our Premium Services</p>
                <h2 class="section-title">Holistic Ayurvedic Healing</h2>
                <p class="services-subtitle">Experience authentic Ayurveda through our three core services</p>
            </div>

            <div class="services-carousel">
                <!-- Slide 1: Doctor Services -->
                <div class="service-slide active">
                    <div class="slide-content">
                        <div class="slide-image">
                            <img src="https://images.unsplash.com/photo-1551601651-2a8555f1a136?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" 
                                 alt="Ayurvedic Doctor Consultation" class="beautiful-image">
                            <div class="image-overlay"></div>
                        </div>
                        <div class="slide-info">
                            <div class="service-icon">
                                <i class="fas fa-user-md"></i>
                            </div>
                            <div class="slide-number">01</div>
                            <h3>Doctor Consultations</h3>
                            <p>Connect with certified Ayurvedic doctors for personalized diagnosis based on your unique dosha constitution. Get custom treatment plans for holistic healing.</p>
                            <div class="features">
                                <div class="feature-item">
                                    <i class="fas fa-check"></i>
                                    <span>Personalized Diagnosis</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-check"></i>
                                    <span>Dosha Analysis</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-check"></i>
                                    <span>Treatment Plans</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-check"></i>
                                    <span>Follow-up Care</span>
                                </div>
                            </div>
                            <a href="${pageContext.request.contextPath}/doctors" class="btn-gold">
                                <span>Find Ayurvedic Doctors</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Slide 2: Hospital Services -->
                <div class="service-slide">
                    <div class="slide-content">
                        <div class="slide-image">
                            <img src="https://images.unsplash.com/photo-1542744095-fcf48d80b0fd?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" 
                                 alt="Ayurvedic Hospital Treatment" class="beautiful-image">
                            <div class="image-overlay"></div>
                        </div>
                        <div class="slide-info">
                            <div class="service-icon">
                                <i class="fas fa-hospital"></i>
                            </div>
                            <div class="slide-number">02</div>
                            <h3>Hospital & Center Services</h3>
                            <p>Experience authentic Panchakarma therapies and inpatient care in serene Ayurvedic wellness centers with modern facilities and experienced therapists.</p>
                            <div class="features">
                                <div class="feature-item">
                                    <i class="fas fa-check"></i>
                                    <span>Panchakarma Therapy</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-check"></i>
                                    <span>Inpatient Care</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-check"></i>
                                    <span>Wellness Programs</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-check"></i>
                                    <span>Rejuvenation Therapy</span>
                                </div>
                            </div>
                            <a href="${pageContext.request.contextPath}/hospitals" class="btn-gold">
                                <span>Explore Ayurvedic Centers</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Slide 3: Product Services -->
                <div class="service-slide">
                    <div class="slide-content">
                        <div class="slide-image">
                            <img src="https://images.unsplash.com/photo-1582719508461-905c673771fd?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" 
                                 alt="Ayurvedic Herbal Products" class="beautiful-image">
                            <div class="image-overlay"></div>
                        </div>
                        <div class="slide-info">
                            <div class="service-icon">
                                <i class="fas fa-capsules"></i>
                            </div>
                            <div class="slide-number">03</div>
                            <h3>Ayurvedic Products</h3>
                            <p>Discover pure herbal medicines, natural supplements, and wellness products crafted according to ancient Ayurvedic formulations from trusted manufacturers.</p>
                            <div class="features">
                                <div class="feature-item">
                                    <i class="fas fa-check"></i>
                                    <span>Herbal Medicines</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-check"></i>
                                    <span>Natural Supplements</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-check"></i>
                                    <span>Skincare Range</span>
                                </div>
                                <div class="feature-item">
                                    <i class="fas fa-check"></i>
                                    <span>Wellness Products</span>
                                </div>
                            </div>
                            <a href="${pageContext.request.contextPath}/products" class="btn-gold">
                                <span>Browse Ayurvedic Products</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Navigation Controls -->
                <div class="carousel-controls">
                    <div class="dots-container">
                        <button class="dot active" data-slide="0">
                            <span>Doctors</span>
                        </button>
                        <button class="dot" data-slide="1">
                            <span>Centers</span>
                        </button>
                        <button class="dot" data-slide="2">
                            <span>Products</span>
                        </button>
                    </div>
                    
                    <div class="arrows-container">
                        <button class="arrow-btn prev-btn">
                            <i class="fas fa-chevron-left"></i>
                        </button>
                        <div class="slide-counter">
                            <span class="current-slide">01</span>
                            <span class="slash">/</span>
                            <span class="total-slides">03</span>
                        </div>
                        <button class="arrow-btn next-btn">
                            <i class="fas fa-chevron-right"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <style>
        /* Services Animation Section */
        .services-animation-section {
            padding: 100px 0;
            background: linear-gradient(135deg, #fdfaf4 0%, #f8f3e9 100%);
            position: relative;
            overflow: hidden;
        }

        .services-animation-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 1px;
            background: linear-gradient(90deg, transparent, #e6b55c, transparent);
        }

        .services-subtitle {
            text-align: center;
            color: #666;
            font-size: 18px;
            margin-top: -15px;
            margin-bottom: 60px;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
        }

        .services-carousel {
            max-width: 1100px;
            margin: 0 auto;
            position: relative;
        }

        .service-slide {
            display: none;
            animation: slideFadeIn 0.8s ease-out;
        }

        .service-slide.active {
            display: block;
        }

        @keyframes slideFadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .slide-content {
            display: flex;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(31, 42, 31, 0.1);
            min-height: 500px;
            position: relative;
        }

        .slide-image {
            flex: 0 0 50%;
            position: relative;
            overflow: hidden;
        }

        .beautiful-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 1.2s ease;
        }

        .service-slide.active .beautiful-image {
            animation: imageZoom 20s ease-in-out infinite;
        }

        @keyframes imageZoom {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        .image-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(31, 42, 31, 0.1) 0%, rgba(230, 181, 92, 0.05) 100%);
            pointer-events: none;
        }

        .slide-info {
            flex: 0 0 50%;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
        }

        .service-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #e6b55c 0%, #d4a347 100%);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 28px;
            margin-bottom: 25px;
            box-shadow: 0 10px 20px rgba(230, 181, 92, 0.3);
            animation: iconFloat 4s ease-in-out infinite;
        }

        @keyframes iconFloat {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        .slide-number {
            font-size: 14px;
            color: #e6b55c;
            font-weight: 600;
            letter-spacing: 2px;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .slide-info h3 {
            font-family: 'Playfair Display', serif;
            font-size: 32px;
            color: #1f2a1f;
            margin-bottom: 20px;
            line-height: 1.3;
            position: relative;
        }

        .slide-info h3::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 50px;
            height: 3px;
            background: #e6b55c;
        }

        .slide-info p {
            color: #666;
            line-height: 1.7;
            margin: 25px 0 30px;
            font-size: 16px;
        }

        .features {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 35px;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #555;
            font-size: 14px;
            font-weight: 500;
        }

        .feature-item i {
            color: #e6b55c;
            font-size: 12px;
        }

        .btn-gold {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            background: linear-gradient(135deg, #e6b55c 0%, #d4a347 100%);
            color: white;
            padding: 16px 35px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            font-size: 16px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            width: fit-content;
        }

        .btn-gold:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(230, 181, 92, 0.4);
        }

        .btn-gold i {
            transition: transform 0.3s ease;
        }

        .btn-gold:hover i {
            transform: translateX(5px);
        }

        /* Carousel Controls */
        .carousel-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 50px;
            flex-wrap: wrap;
            gap: 20px;
        }

        .dots-container {
            display: flex;
            gap: 20px;
        }

        .dot {
            background: none;
            border: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            padding: 10px;
            transition: all 0.3s ease;
        }

        .dot::before {
            content: '';
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #ddd;
            transition: all 0.3s ease;
        }

        .dot.active::before {
            background: #e6b55c;
            transform: scale(1.3);
            box-shadow: 0 0 15px rgba(230, 181, 92, 0.5);
        }

        .dot span {
            color: #666;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .dot.active span {
            color: #1f2a1f;
            font-weight: 600;
        }

        .arrows-container {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .arrow-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: white;
            border: 2px solid #e6b55c;
            color: #e6b55c;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 18px;
        }

        .arrow-btn:hover {
            background: #e6b55c;
            color: white;
            transform: scale(1.1);
        }

        .slide-counter {
            font-family: 'Playfair Display', serif;
            font-size: 18px;
            color: #1f2a1f;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .slash {
            color: #e6b55c;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .slide-content {
                flex-direction: column;
                min-height: auto;
            }
            
            .slide-image {
                height: 300px;
                flex: 0 0 auto;
            }
            
            .slide-info {
                padding: 40px 30px;
            }
            
            .service-slide.active .beautiful-image {
                animation: imageZoom 15s ease-in-out infinite;
            }
        }

        @media (max-width: 768px) {
            .services-animation-section {
                padding: 80px 0;
            }
            
            .slide-info h3 {
                font-size: 28px;
            }
            
            .features {
                grid-template-columns: 1fr;
            }
            
            .carousel-controls {
                flex-direction: column;
                align-items: center;
                gap: 30px;
            }
            
            .arrows-container {
                order: -1;
            }
        }

        @media (max-width: 576px) {
            .slide-info {
                padding: 30px 20px;
            }
            
            .service-icon {
                width: 60px;
                height: 60px;
                font-size: 24px;
            }
            
            .slide-info h3 {
                font-size: 24px;
            }
            
            .services-subtitle {
                font-size: 16px;
                padding: 0 20px;
            }
        }
    </style>

    <script>
        // Carousel Functionality with 5-second auto-rotation
        document.addEventListener('DOMContentLoaded', function() {
            const slides = document.querySelectorAll('.service-slide');
            const dots = document.querySelectorAll('.dot');
            const prevBtn = document.querySelector('.prev-btn');
            const nextBtn = document.querySelector('.next-btn');
            const currentSlideEl = document.querySelector('.current-slide');
            let currentSlide = 0;
            let autoSlideInterval;
            const totalSlides = slides.length;
            const ROTATION_INTERVAL = 5000; // 5 seconds

            // Function to show specific slide
            function showSlide(index) {
                // Hide all slides
                slides.forEach(slide => {
                    slide.classList.remove('active');
                });
                
                dots.forEach(dot => dot.classList.remove('active'));
                
                // Show the selected slide
                slides[index].classList.add('active');
                dots[index].classList.add('active');
                
                // Update slide counter
                currentSlideEl.textContent = String(index + 1).padStart(2, '0');
                
                // Update current slide index
                currentSlide = index;
            }

            // Function for next slide
            function nextSlide() {
                const nextIndex = (currentSlide + 1) % totalSlides;
                showSlide(nextIndex);
            }

            // Function for previous slide
            function prevSlide() {
                const prevIndex = (currentSlide - 1 + totalSlides) % totalSlides;
                showSlide(prevIndex);
            }

            // Start auto sliding with 5-second intervals
            function startAutoSlide() {
                // Clear any existing interval
                if (autoSlideInterval) {
                    clearInterval(autoSlideInterval);
                }
                
                // Start new interval with 5 seconds
                autoSlideInterval = setInterval(nextSlide, ROTATION_INTERVAL);
            }

            // Stop auto sliding
            function stopAutoSlide() {
                if (autoSlideInterval) {
                    clearInterval(autoSlideInterval);
                    autoSlideInterval = null;
                }
            }

            // Event Listeners
            prevBtn.addEventListener('click', function() {
                stopAutoSlide();
                prevSlide();
                startAutoSlide();
            });

            nextBtn.addEventListener('click', function() {
                stopAutoSlide();
                nextSlide();
                startAutoSlide();
            });

            // Dot click events
            dots.forEach(dot => {
                dot.addEventListener('click', function() {
                    const slideIndex = parseInt(this.dataset.slide);
                    if (slideIndex !== currentSlide) {
                        stopAutoSlide();
                        showSlide(slideIndex);
                        startAutoSlide();
                    }
                });
            });

            // Keyboard navigation
            document.addEventListener('keydown', function(e) {
                if (e.key === 'ArrowLeft') {
                    stopAutoSlide();
                    prevSlide();
                    startAutoSlide();
                } else if (e.key === 'ArrowRight') {
                    stopAutoSlide();
                    nextSlide();
                    startAutoSlide();
                }
            });

            // Pause on hover
            const carousel = document.querySelector('.services-carousel');
            carousel.addEventListener('mouseenter', stopAutoSlide);
            carousel.addEventListener('mouseleave', startAutoSlide);

            // Touch swipe for mobile
            let touchStartX = 0;
            let touchEndX = 0;

            carousel.addEventListener('touchstart', function(e) {
                touchStartX = e.changedTouches[0].screenX;
            });

            carousel.addEventListener('touchend', function(e) {
                touchEndX = e.changedTouches[0].screenX;
                handleSwipe();
            });

            function handleSwipe() {
                const swipeThreshold = 50;
                const diff = touchStartX - touchEndX;

                if (Math.abs(diff) > swipeThreshold) {
                    stopAutoSlide();
                    if (diff > 0) {
                        nextSlide(); // Swipe left
                    } else {
                        prevSlide(); // Swipe right
                    }
                    startAutoSlide();
                }
            }

            // Initialize carousel
            showSlide(0);
            startAutoSlide();
        });
    </script>
    </section>

    <!-- Testimonials Section -->
    <section id="testimonials" class="dark">
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">Patient Stories</p>
                <h2 class="section-title light">What Our Patients Say</h2>
            </div>
            
            <div class="testimonials-container">
                <div class="testimonial">
                    <p class="testimonial-text">After years of struggling with digestive issues, Ayurveda Wellness provided a comprehensive treatment plan that transformed my health. I've never felt better!</p>
                        <div class="testimonial-author">
                            <div class="author-img">
                            <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" 
                                 alt="Sarah Johnson" 
                                 style="width:100%; height:100%; object-fit:cover; border-radius:50%;">
                            </div>
                        <div class="author-info">
                            <h4>Sarah Johnson</h4>
                            <p>Chronic Digestive Issues</p>
                            </div>
                        </div>
                    </div>
                <div class="testimonial">
                    <p class="testimonial-text">The Panchakarma therapy was life-changing. Not only did it alleviate my joint pain, but it also brought a sense of mental clarity I haven't experienced in years.</p>
                        <div class="testimonial-author">
                            <div class="author-img">
                            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80" 
                                 alt="Michael Chen" 
                                 style="width:100%; height:100%; object-fit:cover; border-radius:50%;">
                            </div>
                        <div class="author-info">
                            <h4>Michael Chen</h4>
                            <p>Arthritis & Stress</p>
                            </div>
                        </div>
                    </div>
                <div class="testimonial">
                    <p class="testimonial-text">The personalized diet and lifestyle recommendations have helped me manage my stress levels and improve my sleep quality significantly. Thank you!</p>
                        <div class="testimonial-author">
                            <div class="author-img">
                            <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80" 
                                 alt="Priya Sharma" 
                                 style="width:100%; height:100%; object-fit:cover; border-radius:50%;">
                            </div>
                        <div class="author-info">
                            <h4>Priya Sharma</h4>
                            <p>Insomnia & Anxiety</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Appointment Section -->
    <section class="appointment">
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">Begin Your Journey</p>
                <h2 class="section-title light">Book a Consultation</h2>
            </div>
            <div class="appointment-form">
                <form>
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" class="form-control" placeholder="Enter your name">
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" class="form-control" placeholder="Enter your email">
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" class="form-control" placeholder="Enter your phone">
                    </div>
                    <div class="form-group">
                        <label for="service">Service Interested In</label>
                        <select id="service" class="form-control">
                            <option value="">Select a service</option>
                            <option value="consultation">Initial Consultation</option>
                            <option value="panchakarma">Panchakarma Therapy</option>
                            <option value="herbal">Herbal Consultation</option>
                            <option value="diet">Diet & Lifestyle Guidance</option>
                    </select>
                    </div>
                    <button type="submit" class="btn-gold" style="width: 100%;">Request Appointment</button>
                </form>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer id="contact">
        <div class="container">
            <div class="footer-container">
                <div class="footer-col">
                    <h3>Ayurveda Wellness</h3>
                    <p>Providing authentic Ayurvedic treatments and consultations for over 25 years. Our mission is to help you achieve optimal health through natural, time-tested methods.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="footer-col">
                    <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/terms-and-conditions">Terms & Conditions</a></li>
                        <li><a href="${pageContext.request.contextPath}/privacy-policy">Privacy Policy</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h3>Our Services</h3>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/services">Panchakarma Therapy</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Herbal Medicine</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Yoga & Meditation</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Diet & Nutrition</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Detox Programs</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h3>Newsletter</h3>
                    <p>Subscribe to our newsletter for health tips and special offers.</p>
                    <div class="newsletter">
                        <input type="email" placeholder="Your email address">
                        <button class="btn-gold" style="width: 100%;">Subscribe</button>
                    </div>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2025 Ayurveda Wellness Center. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Navbar scroll effect
        window.addEventListener('scroll', () => {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
        
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                
                const targetId = this.getAttribute('href');
                if (targetId === '#') return;
                
                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop - 80,
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Hero slider functionality
        const slides = document.querySelectorAll('.hero-slide');
        const dots = document.querySelectorAll('.hero-dots span');
        
        const slideContent = [
            {
                title: "Ancient Healing for Modern Life",
                desc: "Discover the transformative power of Ayurveda with personalized treatments, herbal remedies, and lifestyle guidance.",
                btn1: "Begin Your Journey",
                btn2: "Learn More"
            },
            {
                title: "Personalized Panchakarma Therapy",
                desc: "Deep detox and rejuvenation programs designed according to your body constitution and health goals.",
                btn1: "Explore Panchakarma",
                btn2: "Our Programs"
            },
            {
                title: "Herbal Medicine & Natural Healing",
                desc: "Custom herbal formulations prepared by experienced Ayurvedic doctors for long-lasting wellness.",
                btn1: "Consult Now",
                btn2: "Herbal Care"
            },
            {
                title: "Yoga & Meditation for Inner Balance",
                desc: "Mind-body wellness practices combining yoga, meditation, and pranayama for holistic healing.",
                btn1: "Start Practice",
                btn2: "View Schedule"
            }
        ];

        let current = 0;

        const heroTitle = document.getElementById("heroTitle");
        const heroDesc  = document.getElementById("heroDesc");
        const heroBtn1  = document.getElementById("heroBtn1");
        const heroBtn2  = document.getElementById("heroBtn2");
        
        function showSlide(index) {
            slides.forEach((slide, i) => {
                slide.classList.toggle('active', i === index);
                if (dots[i]) dots[i].classList.toggle('active', i === index);
            });

            heroTitle.textContent = slideContent[index].title;
            heroDesc.textContent  = slideContent[index].desc;
            heroBtn1.textContent  = slideContent[index].btn1;
            heroBtn2.textContent  = slideContent[index].btn2;

            current = index;
        }

        showSlide(0);

        setInterval(() => {
            showSlide((current + 1) % slides.length);
        }, 5000);

        dots.forEach((dot, i) => {
            dot.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                showSlide(i);
            });
        });
    </script>
</body>
</html>