<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy | Ayurveda Healthcare Platform</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* === AYUSHAKTI INSPIRED STYLES === */
        :root {
            --ayurveda-primary: #1f2a1f;
            --ayurveda-secondary: #e6b55c;
            --ayurveda-light: #fdfaf4;
            --ayurveda-dark: #0f160f;
            --ayurveda-accent: #2a9d8f;
            --ayurveda-text: #333;
            --ayurveda-text-light: #cdd6b6;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--ayurveda-light);
            color: var(--ayurveda-text);
            line-height: 1.8;
            overflow-x: hidden;
            padding-top: 80px; /* For fixed navbar */
        }
        
        /* === NAVBAR - From Reference === */
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
        
        /* === HERO SECTION FOR PRIVACY === */
        .privacy-hero {
            min-height: 60vh;
            background: linear-gradient(rgba(31, 42, 31, 0.85), rgba(31, 42, 31, 0.9)), 
                        url("${pageContext.request.contextPath}/images/about.jpg");
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white;
            display: flex;
            align-items: center;
            text-align: center;
            padding: 100px 0 60px;
            position: relative;
            overflow: hidden;
        }
        
        .privacy-hero::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,100 Q25,50 50,100 Q75,50 100,100 L100,0 L0,0 Z" fill="rgba(42,157,143,0.1)"/></svg>');
            background-size: 100% auto;
            background-repeat: no-repeat;
            background-position: bottom;
            pointer-events: none;
        }
        
        .privacy-hero-content {
            position: relative;
            z-index: 2;
            animation: fadeInUp 1s ease-out;
        }
        
        .privacy-hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 4rem;
            margin-bottom: 20px;
            color: var(--ayurveda-secondary);
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .privacy-hero p {
            font-size: 1.2rem;
            max-width: 700px;
            margin: 0 auto 30px;
            color: #f5e4c3;
        }
        
        /* === MAIN CONTENT SECTION === */
        .privacy-content {
            padding: 100px 0;
            background: linear-gradient(135deg, #f5f9ff 0%, #e8f4f8 100%);
            position: relative;
        }
        
        .privacy-content::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 300px;
            background: linear-gradient(to bottom, var(--ayurveda-accent), transparent);
            opacity: 0.05;
            pointer-events: none;
        }
        
        .privacy-card {
            background: white;
            border-radius: 20px;
            padding: 60px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.08);
            border-top: 5px solid var(--ayurveda-accent);
            position: relative;
            overflow: hidden;
            margin-bottom: 50px;
            animation: slideUp 0.6s ease-out;
        }
        
        .privacy-card::after {
            content: "";
            position: absolute;
            top: 0;
            right: 0;
            width: 150px;
            height: 150px;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M50,0 C77.614,0 100,22.386 100,50 C100,77.614 77.614,100 50,100 C22.386,100 0,77.614 0,50 C0,22.386 22.386,0 50,0 Z" fill="%232a9d8f" opacity="0.1"/></svg>');
            background-size: contain;
            opacity: 0.5;
        }
        
        .policy-header {
            text-align: center;
            margin-bottom: 50px;
            position: relative;
            padding-bottom: 30px;
        }
        
        .policy-header::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: linear-gradient(to right, transparent, var(--ayurveda-accent), transparent);
        }
        
        .policy-title {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            color: var(--ayurveda-primary);
            margin-bottom: 15px;
        }
        
        .last-updated {
            display: inline-block;
            background: var(--ayurveda-light);
            padding: 10px 25px;
            border-radius: 30px;
            font-size: 0.9rem;
            color: var(--ayurveda-primary);
            border: 2px solid var(--ayurveda-accent);
            margin-bottom: 30px;
        }
        
        .last-updated i {
            color: var(--ayurveda-accent);
            margin-right: 10px;
        }
        
        /* === CONTENT SECTIONS === */
        .content-section {
            margin-bottom: 50px;
            padding: 30px;
            border-radius: 15px;
            background: #fefefe;
            border-left: 4px solid var(--ayurveda-accent);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .content-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }
        
        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--ayurveda-primary);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }
        
        .section-title i {
            color: var(--ayurveda-accent);
            margin-right: 15px;
            font-size: 1.5rem;
            background: rgba(42, 157, 143, 0.1);
            padding: 10px;
            border-radius: 50%;
        }
        
        .section-content {
            color: #555;
            font-size: 1.05rem;
        }
        
        .data-box {
            background: linear-gradient(135deg, #f0f8ff 0%, #e8f4f8 100%);
            border: 1px solid #cce7ff;
            padding: 25px;
            margin: 25px 0;
            border-radius: 10px;
        }
        
        .data-category {
            display: inline-block;
            background: rgba(42, 157, 143, 0.1);
            color: var(--ayurveda-accent);
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.8rem;
            margin: 5px;
            border: 1px solid rgba(42, 157, 143, 0.2);
        }
        
        .cookie-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 25px 0;
        }
        
        .cookie-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            border: 2px solid;
            transition: transform 0.3s ease;
        }
        
        .cookie-card:hover {
            transform: translateY(-5px);
        }
        
        .cookie-essential {
            border-color: #4caf50;
            background: #f1f8e9;
        }
        
        .cookie-analytics {
            border-color: #2196f3;
            background: #e3f2fd;
        }
        
        .cookie-functional {
            border-color: #ff9800;
            background: #fff3e0;
        }
        
        /* === LIST STYLES === */
        .ayurveda-list {
            list-style: none;
            margin: 20px 0;
            padding-left: 0;
        }
        
        .ayurveda-list li {
            padding: 12px 0;
            padding-left: 40px;
            position: relative;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }
        
        .ayurveda-list li:last-child {
            border-bottom: none;
        }
        
        .ayurveda-list li::before {
            content: "✓";
            position: absolute;
            left: 15px;
            color: var(--ayurveda-accent);
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        /* === NAVIGATION BUTTONS === */
        .privacy-navigation {
            display: flex;
            justify-content: space-between;
            margin-top: 60px;
            padding-top: 40px;
            border-top: 1px solid rgba(0,0,0,0.1);
        }
        
        .nav-button {
            padding: 15px 40px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            font-size: 1rem;
        }
        
        .nav-button i {
            margin-right: 10px;
            font-size: 1.2rem;
        }
        
        .btn-home {
            background: var(--ayurveda-primary);
            color: white;
        }
        
        .btn-home:hover {
            background: #0f160f;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(31,42,31,0.2);
        }
        
        .btn-terms {
            background: var(--ayurveda-secondary);
            color: var(--ayurveda-primary);
        }
        
        .btn-terms:hover {
            background: #d4a347;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(230,181,92,0.3);
        }
        
        /* === FOOTER === */
        footer {
            background: var(--ayurveda-primary);
            color: var(--ayurveda-text-light);
            padding: 60px 0 30px;
        }
        
        .footer-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px;
            margin-bottom: 40px;
        }
        
        .footer-col h3 {
            color: var(--ayurveda-secondary);
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
            color: var(--ayurveda-text-light);
            text-decoration: none;
            transition: color 0.3s ease;
        }
        
        .footer-links a:hover {
            color: var(--ayurveda-secondary);
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
            color: var(--ayurveda-text-light);
            transition: all 0.3s ease;
        }
        
        .social-links a:hover {
            background: var(--ayurveda-secondary);
            color: var(--ayurveda-primary);
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
        
        /* === ANIMATIONS === */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* === RESPONSIVE DESIGN === */
        @media (max-width: 992px) {
            .privacy-hero h1 {
                font-size: 3rem;
            }
            
            .policy-title {
                font-size: 2.5rem;
            }
            
            .privacy-card {
                padding: 40px;
            }
        }
        
        @media (max-width: 768px) {
            .privacy-hero h1 {
                font-size: 2.5rem;
            }
            
            .policy-title {
                font-size: 2rem;
            }
            
            .privacy-navigation {
                flex-direction: column;
                gap: 20px;
            }
            
            .nav-button {
                width: 100%;
                justify-content: center;
            }
            
            .cookie-grid {
                grid-template-columns: 1fr;
            }
            
            body {
                padding-top: 70px;
            }
        }
        
        @media (max-width: 480px) {
            .privacy-card {
                padding: 25px;
            }
            
            .section-title {
                font-size: 1.5rem;
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
    <!-- Navbar - From Reference -->
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/products"><i class="fas fa-shopping-bag me-1"></i>Products</a>
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
    <section class="privacy-hero">
        <div class="container">
            <div class="privacy-hero-content">
                <h1>Privacy Policy</h1>
                <p>Your privacy is our priority. Learn how we collect, use, and protect your personal information.</p>
                
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <section class="privacy-content">
        <div class="container">
            <div class="privacy-card">
                <!-- Policy Header -->
                <div class="policy-header">
                    <h1 class="policy-title">Data Protection Commitment</h1>
                    <p class="section-content" style="text-align: center; max-width: 800px; margin: 0 auto;">
                        At Ayurveda Healthcare Platform, we are committed to protecting your privacy and ensuring 
                        the security of your personal information. This policy outlines our practices regarding data collection, use, and protection.
                    </p>
                </div>

                <!-- Information We Collect -->
                <div class="content-section" id="collection">
                    <h2 class="section-title"><i class="fas fa-database"></i> 1. Information We Collect</h2>
                    <div class="section-content">
                        <p>We collect information to provide better services to our users:</p>
                        
                        <div class="data-box">
                            <h4><i class="fas fa-user-circle"></i> Personal Information</h4>
                            <p>Information you provide when using our services:</p>
                            <div>
                                <span class="data-category">Name</span>
                                <span class="data-category">Email Address</span>
                                <span class="data-category">Phone Number</span>
                                <span class="data-category">Location</span>
                                <span class="data-category">Health Preferences</span>
                            </div>
                        </div>
                        
                        <div class="data-box">
                            <h4><i class="fas fa-laptop-code"></i> Technical Information</h4>
                            <p>Automatically collected when you visit our platform:</p>
                            <div>
                                <span class="data-category">IP Address</span>
                                <span class="data-category">Device Type</span>
                                <span class="data-category">Browser Info</span>
                                <span class="data-category">Usage Data</span>
                                <span class="data-category">Cookies</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- How We Use Information -->
                <div class="content-section" id="usage">
                    <h2 class="section-title"><i class="fas fa-cogs"></i> 2. How We Use Your Information</h2>
                    <div class="section-content">
                        <p>Your information helps us provide and improve our services:</p>
                        <ul class="ayurveda-list">
                            <li>Personalize your healthcare provider recommendations</li>
                            <li>Respond to your inquiries and appointment requests</li>
                            <li>Improve platform functionality and user experience</li>
                            <li>Send important service updates and notifications</li>
                            <li>Analyze usage patterns for service enhancement</li>
                            <li>Comply with legal obligations and regulations</li>
                        </ul>
                        <div class="data-box">
                            <p><strong>We do not sell your personal information</strong> to third parties. Data sharing only occurs with healthcare providers when you initiate contact.</p>
                        </div>
                    </div>
                </div>

                <!-- Data Security -->
                <div class="content-section" id="security">
                    <h2 class="section-title"><i class="fas fa-shield-alt"></i> 3. Data Security Measures</h2>
                    <div class="section-content">
                        <p>We implement robust security measures to protect your data:</p>
                        <ul class="ayurveda-list">
                            <li>End-to-end encryption for sensitive data</li>
                            <li>Secure server infrastructure with firewalls</li>
                            <li>Regular security audits and vulnerability assessments</li>
                            <li>Access controls and authentication protocols</li>
                            <li>Employee training on data protection</li>
                            <li>Secure data storage and backup systems</li>
                        </ul>
                        <div class="data-box">
                            <p><i class="fas fa-exclamation-triangle"></i> While we implement industry-standard security measures, no system is completely secure. We recommend users maintain strong passwords and practice safe browsing habits.</p>
                        </div>
                    </div>
                </div>

                <!-- Cookies Policy -->
                <div class="content-section" id="cookies">
                    <h2 class="section-title"><i class="fas fa-cookie-bite"></i> 4. Cookies & Tracking Technologies</h2>
                    <div class="section-content">
                        <p>We use cookies to enhance your browsing experience:</p>
                        
                        <div class="cookie-grid">
                            <div class="cookie-card cookie-essential">
                                <h4><i class="fas fa-check-circle"></i> Essential Cookies</h4>
                                <p>Required for basic platform functionality and security</p>
                            </div>
                            <div class="cookie-card cookie-analytics">
                                <h4><i class="fas fa-chart-bar"></i> Analytics Cookies</h4>
                                <p>Help us understand how users interact with our platform</p>
                            </div>
                            <div class="cookie-card cookie-functional">
                                <h4><i class="fas fa-cog"></i> Functional Cookies</h4>
                                <p>Remember your preferences and settings</p>
                            </div>
                        </div>
                        
                        <p>You can control cookie settings through your browser. However, disabling essential cookies may affect platform functionality.</p>
                    </div>
                </div>

                <!-- Your Rights -->
                <div class="content-section" id="rights">
                    <h2 class="section-title"><i class="fas fa-user-check"></i> 5. Your Privacy Rights</h2>
                    <div class="section-content">
                        <p>Depending on your location, you may have the following rights:</p>
                        <ul class="ayurveda-list">
                            <li><strong>Right to Access:</strong> Request a copy of your personal data</li>
                            <li><strong>Right to Rectification:</strong> Correct inaccurate information</li>
                            <li><strong>Right to Erasure:</strong> Request deletion of your data</li>
                            <li><strong>Right to Restrict:</strong> Limit how we use your data</li>
                            <li><strong>Right to Object:</strong> Object to certain processing activities</li>
                            <li><strong>Right to Portability:</strong> Receive your data in a portable format</li>
                        </ul>
                        <div class="data-box">
                            <p>To exercise these rights, contact our Data Protection Officer at <strong>dpo@ayurvedahealthcare.com</strong>. We respond to all requests within 30 days.</p>
                        </div>
                    </div>
                </div>

                <!-- Data Retention -->
                <div class="content-section" id="retention">
                    <h2 class="section-title"><i class="fas fa-history"></i> 6. Data Retention Period</h2>
                    <div class="section-content">
                        <p>We retain personal data only as long as necessary:</p>
                        <ul class="ayurveda-list">
                            <li><strong>Active Users:</strong> Data retained while account is active</li>
                            <li><strong>Inactive Accounts:</strong> Data deleted after 2 years of inactivity</li>
                            <li><strong>Legal Requirements:</strong> Some data retained for compliance</li>
                            <li><strong>Anonymized Data:</strong> Used for analytics after anonymization</li>
                        </ul>
                        <div class="data-box">
                            <p>Data retention periods are regularly reviewed and updated to comply with changing regulations and business needs.</p>
                        </div>
                    </div>
                </div>

                <!-- Contact Information -->
                <div class="content-section" id="contact">
                    <h2 class="section-title"><i class="fas fa-headset"></i> 7. Contact Information</h2>
                    <div class="section-content">
                        <p>For privacy-related inquiries or concerns:</p>
                        <div class="data-box" style="background: linear-gradient(135deg, #e8f5e9 0%, #f1f8e9 100%);">
                            <h4><i class="fas fa-user-shield"></i> Data Protection Officer</h4>
                            <p><strong>Email:</strong> dpo@ayurvedahealthcare.com</p>
                            <p><strong>Phone:</strong> +91-XXX-XXX-XXXX</p>
                            <p><strong>Address:</strong> Data Protection Office, Ayurveda Wellness Center, New Delhi, India</p>
                            <p><strong>Response Time:</strong> Within 30 business days</p>
                        </div>
                    </div>
                </div>

                <!-- Navigation Buttons -->
                <div class="privacy-navigation">
                    <a href="${pageContext.request.contextPath}/" class="nav-button btn-home">
                        <i class="fas fa-home"></i> Back to Home
                    </a>
                    <a href="${pageContext.request.contextPath}/terms-and-conditions" class="nav-button btn-terms">
                        <i class="fas fa-balance-scale"></i> Terms & Conditions
                    </a>
                </div>
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
                        <li><a href="${pageContext.request.contextPath}/privacy-policy" style="color: var(--ayurveda-accent); font-weight: 600;">Privacy Policy</a></li>
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
                        top: targetElement.offsetTop - 100,
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Add animation to content sections on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        // Observe all content sections
        document.querySelectorAll('.content-section').forEach(section => {
            section.style.opacity = '0';
            section.style.transform = 'translateY(30px)';
            section.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(section);
        });

        // Cookie cards interactive effect
        document.querySelectorAll('.cookie-card').forEach(card => {
            card.addEventListener('click', function() {
                this.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 200);
            });
        });

        // Data categories hover effect
        document.querySelectorAll('.data-category').forEach(category => {
            category.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-3px)';
                this.style.boxShadow = '0 5px 15px rgba(0,0,0,0.1)';
            });
            
            category.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
                this.style.boxShadow = 'none';
            });
        });

        // Add parallax effect to hero background
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const hero = document.querySelector('.privacy-hero');
            if (hero) {
                hero.style.backgroundPositionY = scrolled * 0.5 + 'px';
            }
        });

        // Add print functionality
        const printBtn = document.createElement('button');
        printBtn.innerHTML = '<i class="fas fa-print"></i>';
        printBtn.className = 'print-button';
        printBtn.style.position = 'fixed';
        printBtn.style.bottom = '30px';
        printBtn.style.right = '30px';
        printBtn.style.width = '60px';
        printBtn.style.height = '60px';
        printBtn.style.borderRadius = '50%';
        printBtn.style.background = 'var(--ayurveda-accent)';
        printBtn.style.color = 'white';
        printBtn.style.border = 'none';
        printBtn.style.cursor = 'pointer';
        printBtn.style.boxShadow = '0 5px 15px rgba(0,0,0,0.2)';
        printBtn.style.zIndex = '999';
        printBtn.style.display = 'flex';
        printBtn.style.alignItems = 'center';
        printBtn.style.justifyContent = 'center';
        printBtn.style.fontSize = '20px';
        printBtn.style.transition = 'all 0.3s ease';

        printBtn.addEventListener('mouseenter', () => {
            printBtn.style.transform = 'scale(1.1)';
            printBtn.style.boxShadow = '0 8px 25px rgba(42,157,143,0.4)';
        });

        printBtn.addEventListener('mouseleave', () => {
            printBtn.style.transform = 'scale(1)';
            printBtn.style.boxShadow = '0 5px 15px rgba(0,0,0,0.2)';
        });

        printBtn.addEventListener('click', () => {
            window.print();
        });

        document.body.appendChild(printBtn);

        // Newsletter form submission
        const newsletterForm = document.querySelector('.newsletter');
        if (newsletterForm) {
            const input = newsletterForm.querySelector('input[type="email"]');
            const button = newsletterForm.querySelector('button');
            
            button.addEventListener('click', (e) => {
                e.preventDefault();
                if (input.value && input.value.includes('@')) {
                    alert('Thank you for subscribing to our newsletter!');
                    input.value = '';
                } else {
                    alert('Please enter a valid email address.');
                }
            });
            
            input.addEventListener('keypress', (e) => {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    button.click();
                }
            });
        }

        @media print {
            .navbar,
            footer,
            .privacy-navigation,
            .print-button {
                display: none !important;
            }
            
            .privacy-hero {
                min-height: 200px;
                padding-top: 50px;
            }
            
            .privacy-content {
                padding: 20px 0;
            }
            
            .privacy-card {
                box-shadow: none;
                border: 1px solid #ddd;
            }
        }
    </script>
</body>
</html>