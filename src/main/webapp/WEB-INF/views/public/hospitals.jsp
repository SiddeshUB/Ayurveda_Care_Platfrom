<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Ayurvedic Centers - Ayurveda Wellness</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-dark: #1a2e1a;
            --primary-green: #2d4a2d;
            --accent-gold: #c9a227;
            --accent-gold-light: #e6b55c;
            --text-light: #f5f0e8;
            --text-cream: #e8dcc8;
            --bg-cream: #fdfaf4;
            --bg-dark: #0a0f0a;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        html {
            scroll-behavior: smooth;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--bg-cream);
            color: #333;
            line-height: 1.7;
            overflow-x: hidden;
        }
        
        h1, h2, h3, h4, h5 {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 600;
        }
        
        /* ========== NAVBAR ========== */
        .navbar {
            background: rgba(26, 46, 26, 0.98);
            padding: 15px 0;
            transition: all 0.4s ease;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            backdrop-filter: blur(10px);
        }
        
        .navbar.scrolled {
            padding: 10px 0;
            box-shadow: 0 5px 30px rgba(0,0,0,0.3);
        }
        
        .navbar-brand {
            font-family: 'Cormorant Garamond', serif;
            font-size: 28px;
            font-weight: 700;
            color: var(--accent-gold) !important;
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
            margin: 0 2px;
            transition: all 0.3s ease;
            position: relative;
            white-space: nowrap;
        }
        
        .navbar-nav .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background: var(--accent-gold);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }
        
        .navbar-nav .nav-link:hover::after,
        .navbar-nav .nav-link.active::after {
            width: 70%;
        }
        
        .navbar-nav .nav-link:hover,
        .navbar-nav .nav-link.active {
            color: var(--accent-gold) !important;
        }
        
        .btn-nav {
            background: linear-gradient(135deg, var(--accent-gold) 0%, var(--accent-gold-light) 100%);
            color: var(--primary-dark) !important;
            padding: 10px 25px !important;
            border-radius: 30px;
            font-weight: 600;
            margin-left: 10px;
            transition: all 0.4s ease;
            border: none;
        }
        
        .btn-nav:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(201, 162, 39, 0.4);
            color: var(--primary-dark) !important;
        }
        
        .btn-nav::after {
            display: none;
        }
        
        .navbar-toggler {
            border: none;
            padding: 0;
        }
        
        .navbar-toggler:focus {
            box-shadow: none;
        }
        
        .navbar-toggler-icon {
            background-image: url("${pageContext.request.contextPath}/images/page.jpg") center/cover no-repeat;
        }
        
        /* User Dropdown */
        .user-dropdown .dropdown-toggle {
            background: rgba(201, 162, 39, 0.15);
            border-radius: 30px;
            padding: 8px 20px !important;
        }
        
        .user-dropdown .dropdown-toggle::after {
            display: none;
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
            background: rgba(201, 162, 39, 0.1);
            color: var(--accent-gold);
        }
        
        .user-dropdown .dropdown-item i {
            width: 20px;
            margin-right: 10px;
            color: var(--accent-gold);
        }
        
        /* ========== PAGE HERO ========== */
        .page-hero {
            background: linear-gradient(135deg, rgba(10, 15, 10, 0.9) 0%, rgba(26, 46, 26, 0.85) 100%),
                         url("${pageContext.request.contextPath}/images/ayu1.jpg") center/cover no-repeat;
            padding: 180px 0 100px;
            text-align: center;
            position: relative;
        }
        
       .page-hero::before {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 120px;
    background: linear-gradient(to top, rgba(10,15,10,1), transparent);
}



        
        .page-hero-badge {
            display: inline-block;
            background: rgba(201, 162, 39, 0.2);
            border: 1px solid rgba(201, 162, 39, 0.4);
            padding: 8px 25px;
            border-radius: 30px;
            color: var(--accent-gold);
            font-size: 14px;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 20px;
        }
        
        .page-hero h1 {
            font-size: 56px;
            color: #fff;
            margin-bottom: 20px;
        }
        
        .page-hero p {
            color: rgba(255,255,255,0.8);
            font-size: 18px;
            max-width: 600px;
            margin: 0 auto 40px;
        }
        
        /* Search Box */
        .search-box {
            max-width: 700px;
            margin: 0 auto;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(201, 162, 39, 0.3);
            border-radius: 60px;
            padding: 8px;
            display: flex;
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        }
        
        .search-box input {
            flex: 1;
            border: none;
            background: transparent;
            padding: 15px 25px;
            font-size: 16px;
            color: #fff;
            outline: none;
        }
        
        .search-box input::placeholder {
            color: rgba(255,255,255,0.6);
        }
        
        .search-box button {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            border: none;
            padding: 15px 35px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.4s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .search-box button:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 30px rgba(201, 162, 39, 0.4);
        }
        
        /* ========== FILTERS SECTION ========== */
        .filters-section {
            background: #fff;
            padding: 25px 0;
            border-bottom: 1px solid rgba(201, 162, 39, 0.1);
            position: sticky;
            top: 70px;
            z-index: 100;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        
        .filter-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
        }
        
        .filter-tag {
            padding: 10px 20px;
            border-radius: 30px;
            border: 2px solid rgba(201, 162, 39, 0.3);
            background: transparent;
            color: var(--primary-dark);
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .filter-tag:hover,
        .filter-tag.active {
            background: var(--accent-gold);
            border-color: var(--accent-gold);
            color: var(--primary-dark);
        }
        
        .results-info {
            color: #666;
            font-size: 15px;
        }
        
        .results-info strong {
            color: var(--accent-gold);
        }
        
        /* ========== HOSPITALS GRID ========== */
        .hospitals-section {
            padding: 60px 0 100px;
        }
        
        .hospital-card {
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(201, 162, 39, 0.1);
            height: 100%;
        }
        
        .hospital-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 30px 60px rgba(0,0,0,0.15);
            border-color: rgba(201, 162, 39, 0.3);
        }
        
        .hospital-image {
            position: relative;
            height: 220px;
            overflow: hidden;
        }
        
        .hospital-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s ease;
        }
        
        .hospital-card:hover .hospital-image img {
            transform: scale(1.1);
        }
        
        .hospital-image::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(to bottom, transparent 50%, rgba(0,0,0,0.7));
            z-index: 1;
            opacity: 0;
            transition: opacity 0.4s ease;
        }
        
        .hospital-card:hover .hospital-image::before {
            opacity: 1;
        }
        
        .hospital-badges {
            position: absolute;
            top: 15px;
            left: 15px;
            display: flex;
            gap: 8px;
            z-index: 2;
        }
        
        .badge-cert {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .badge-ayush {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
        }
        
        .badge-nabh {
            background: linear-gradient(135deg, var(--primary-green), #3d6a3d);
            color: #fff;
        }
        
        .hospital-rating {
            position: absolute;
            bottom: 15px;
            right: 15px;
            background: #fff;
            padding: 8px 15px;
            border-radius: 30px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
            z-index: 2;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .hospital-rating i {
            color: var(--accent-gold);
        }
        
        .hospital-save {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255,255,255,0.9);
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            z-index: 2;
        }
        
        .hospital-save:hover {
            background: var(--accent-gold);
            color: #fff;
            transform: scale(1.1);
        }
        
        .hospital-save i {
            color: var(--accent-gold);
            transition: all 0.3s ease;
        }
        
        .hospital-save:hover i {
            color: #fff;
        }
        
        .hospital-body {
            padding: 25px;
        }
        
        .hospital-name {
            font-size: 22px;
            color: var(--primary-dark);
            margin-bottom: 8px;
            transition: color 0.3s ease;
        }
        
        .hospital-card:hover .hospital-name {
            color: var(--accent-gold);
        }
        
        .hospital-location {
            color: #888;
            font-size: 14px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .hospital-location i {
            color: var(--accent-gold);
        }
        
        .hospital-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 20px;
        }
        
        .hospital-tag {
            padding: 6px 14px;
            border-radius: 20px;
            background: rgba(201, 162, 39, 0.1);
            color: var(--primary-dark);
            font-size: 12px;
            font-weight: 500;
        }
        
        .hospital-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 20px;
            border-top: 1px solid rgba(201, 162, 39, 0.1);
        }
        
        .hospital-price {
            font-size: 14px;
            color: #888;
        }
        
        .hospital-price span {
            display: block;
            font-size: 22px;
            font-weight: 700;
            color: var(--primary-green);
            font-family: 'Cormorant Garamond', serif;
        }
        
        .btn-view {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.4s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-view:hover {
            transform: translateX(5px);
            box-shadow: 0 10px 25px rgba(201, 162, 39, 0.3);
            color: var(--primary-dark);
        }
        
        /* ========== PAGINATION ========== */
        .pagination-wrapper {
            margin-top: 60px;
        }
        
        .pagination {
            justify-content: center;
            gap: 8px;
        }
        
        .pagination .page-link {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid rgba(201, 162, 39, 0.2);
            color: var(--primary-dark);
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .pagination .page-link:hover {
            background: rgba(201, 162, 39, 0.1);
            border-color: var(--accent-gold);
            color: var(--accent-gold);
        }
        
        .pagination .page-item.active .page-link {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            border-color: var(--accent-gold);
            color: var(--primary-dark);
        }
        
        /* ========== EMPTY STATE ========== */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
        }
        
        .empty-state-icon {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: rgba(201, 162, 39, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
        }
        
        .empty-state-icon i {
            font-size: 50px;
            color: var(--accent-gold);
        }
        
        .empty-state h3 {
            font-size: 28px;
            color: var(--primary-dark);
            margin-bottom: 15px;
        }
        
        .empty-state p {
            color: #888;
            margin-bottom: 30px;
        }
        
        /* ========== FOOTER ========== */
        .footer {
            background: linear-gradient(180deg, var(--primary-dark) 0%, #0d170d 100%);
            padding: 80px 0 30px;
            color: var(--text-cream);
        }
        
        .footer-brand {
            font-family: 'Cormorant Garamond', serif;
            font-size: 32px;
            color: var(--accent-gold);
            margin-bottom: 20px;
        }
        
        .footer-desc {
            color: rgba(255,255,255,0.7);
            line-height: 1.8;
            margin-bottom: 25px;
        }
        
        .footer h5 {
            color: var(--accent-gold);
            font-size: 20px;
            margin-bottom: 25px;
            font-family: 'Cormorant Garamond', serif;
        }
        
        .footer-links {
            list-style: none;
            padding: 0;
        }
        
        .footer-links li {
            margin-bottom: 12px;
        }
        
        .footer-links a {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .footer-links a:hover {
            color: var(--accent-gold);
            padding-left: 10px;
        }
        
        .social-icons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }
        
        .social-icons a {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: rgba(201, 162, 39, 0.1);
            border: 1px solid rgba(201, 162, 39, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-gold);
            transition: all 0.4s ease;
        }
        
        .social-icons a:hover {
            background: var(--accent-gold);
            color: var(--primary-dark);
            transform: translateY(-5px);
        }
        
        .footer-bottom {
            border-top: 1px solid rgba(201, 162, 39, 0.1);
            padding-top: 30px;
            margin-top: 50px;
            text-align: center;
            color: rgba(255,255,255,0.5);
        }
        
        /* ========== BACK TO TOP ========== */
        .back-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            border: none;
            border-radius: 50%;
            cursor: pointer;
            opacity: 0;
            visibility: hidden;
            transform: translateY(20px);
            transition: all 0.4s ease;
            z-index: 999;
            box-shadow: 0 5px 25px rgba(201, 162, 39, 0.4);
        }
        
        .back-to-top.visible {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }
        
        .back-to-top:hover {
            transform: translateY(-5px);
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
        
        /* ========== RESPONSIVE ========== */
        @media (max-width: 991px) {
            .page-hero h1 {
                font-size: 40px;
            }
            
            .navbar-collapse {
                background: rgba(26, 46, 26, 0.98);
                padding: 20px;
                border-radius: 15px;
                margin-top: 15px;
            }
            
            .filters-section {
                position: relative;
                top: 0;
            }
        }
        
        @media (max-width: 767px) {
            .page-hero {
                padding: 140px 0 80px;
            }
            
            .page-hero h1 {
                font-size: 32px;
            }
            
            .search-box {
                flex-direction: column;
                border-radius: 20px;
                padding: 15px;
            }
            
            .search-box input {
                text-align: center;
                margin-bottom: 10px;
            }
            
            .search-box button {
                width: 100%;
                justify-content: center;
            }
            
            .filter-tags {
                justify-content: center;
            }
            
            .hospital-footer {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .btn-view {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-leaf me-2"></i>Ayurveda Wellness
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-lg-center">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/hospitals">Find Centers</a>
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
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/saved-centers"><i class="fas fa-heart"></i>Saved Centers</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout"><i class="fas fa-sign-out-alt"></i>Sign Out</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/login">Login</a>
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

    <!-- Page Hero -->
    <section class="page-hero">
        <div class="container">
            <span class="page-hero-badge" data-aos="fade-down">Trusted Healthcare Network</span>
            <h1 data-aos="fade-up" data-aos-delay="100">Find Ayurvedic Centers</h1>
            <p data-aos="fade-up" data-aos-delay="200">Discover authentic Ayurvedic hospitals, ashrams, and wellness retreats across India</p>
            
            <form class="search-box" action="${pageContext.request.contextPath}/hospitals" method="get" data-aos="fade-up" data-aos-delay="300">
                <input type="text" name="search" placeholder="Search by location, therapy, or center name..." value="${search}">
                <button type="submit">
                    <i class="fas fa-search"></i>
                    <span>Search</span>
                </button>
            </form>
        </div>
    </section>

    <!-- Filters Section -->
    <section class="filters-section">
        <div class="container">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div class="filter-tags">
                    <button class="filter-tag active">All Centers</button>
                    <button class="filter-tag">Hospitals</button>
                    <button class="filter-tag">Wellness Resorts</button>
                    <button class="filter-tag">Ashrams</button>
                    <button class="filter-tag">AYUSH Certified</button>
                </div>
                <div class="results-info">
                    <c:choose>
                        <c:when test="${not empty hospitals}">
                            Showing <strong>${hospitals.size()}</strong> centers
                            <c:if test="${not empty search}"> for "<strong>${search}</strong>"</c:if>
                        </c:when>
                        <c:otherwise>
                            No results found
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>

    <!-- Hospitals Grid -->
    <section class="hospitals-section">
        <div class="container">
            <c:choose>
                <c:when test="${not empty hospitals}">
                    <div class="row g-4">
                        <c:forEach var="hospital" items="${hospitals}" varStatus="status">
                            <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="${status.index % 3 * 100}">
                                <div class="hospital-card">
                                    <div class="hospital-image">
                                        <c:choose>
                                            <c:when test="${not empty hospital.coverPhotoUrl}">
                                                <img src="${pageContext.request.contextPath}${hospital.coverPhotoUrl}" alt="${hospital.centerName}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://images.unsplash.com/photo-1545205597-3d9d02c29597?w=600" alt="${hospital.centerName}">
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <div class="hospital-badges">
                                            <c:if test="${hospital.ayushCertified}">
                                                <span class="badge-cert badge-ayush">AYUSH</span>
                                            </c:if>
                                            <c:if test="${hospital.nabhCertified}">
                                                <span class="badge-cert badge-nabh">NABH</span>
                                            </c:if>
                                        </div>
                                        
                                        <button class="hospital-save" title="Save Center">
                                            <i class="far fa-heart"></i>
                                        </button>
                                        
                                        <div class="hospital-rating">
                                            <i class="fas fa-star"></i>
                                            <span>${hospital.averageRating != null ? String.format("%.1f", hospital.averageRating) : '4.5'}</span>
                                        </div>
                                    </div>
                                    
                                    <div class="hospital-body">
                                        <h3 class="hospital-name">${hospital.centerName}</h3>
                                        <div class="hospital-location">
                                            <i class="fas fa-map-marker-alt"></i>
                                            ${hospital.city}, ${hospital.state}
                                        </div>
                                        
                                        <div class="hospital-tags">
                                            <span class="hospital-tag">${hospital.centerType}</span>
                                            <c:if test="${hospital.bedsCapacity != null}">
                                                <span class="hospital-tag">${hospital.bedsCapacity} Beds</span>
                                            </c:if>
                                            <span class="hospital-tag">Panchakarma</span>
                                        </div>
                                        
                                        <div class="hospital-footer">
                                            <div class="hospital-price">
                                                Starting from
                                                <span>₹15,000</span>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}" class="btn-view">
                                                View Details <i class="fas fa-arrow-right"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination-wrapper" data-aos="fade-up">
                            <nav>
                                <ul class="pagination">
                                    <c:if test="${currentPage > 0}">
                                        <li class="page-item">
                                            <a class="page-link" href="${pageContext.request.contextPath}/hospitals?page=${currentPage - 1}${not empty search ? '&search='.concat(search) : ''}">
                                                <i class="fas fa-chevron-left"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                    
                                    <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="${pageContext.request.contextPath}/hospitals?page=${i}${not empty search ? '&search='.concat(search) : ''}">${i + 1}</a>
                                        </li>
                                    </c:forEach>
                                    
                                    <c:if test="${currentPage < totalPages - 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="${pageContext.request.contextPath}/hospitals?page=${currentPage + 1}${not empty search ? '&search='.concat(search) : ''}">
                                                <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" data-aos="fade-up">
                        <div class="empty-state-icon">
                            <i class="fas fa-search"></i>
                        </div>
                        <h3>No Centers Found</h3>
                        <p>Try adjusting your search criteria or browse all available centers</p>
                        <a href="${pageContext.request.contextPath}/hospitals" class="btn-view">
                            <i class="fas fa-th-large me-2"></i>View All Centers
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-5">
                <div class="col-lg-4" data-aos="fade-up">
                    <div class="footer-brand"><i class="fas fa-leaf me-2"></i>Ayurveda Wellness</div>
                    <p class="footer-desc">Providing authentic Ayurvedic treatments and consultations for over 25 years. Our mission is to help you achieve optimal health through natural, time-tested methods.</p>
                    <div class="social-icons">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="col-6 col-lg-2" data-aos="fade-up" data-aos-delay="100">
                    <h5>Quick Links</h5>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/hospitals">Find Centers</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                    </ul>
                </div>
                <div class="col-6 col-lg-2" data-aos="fade-up" data-aos-delay="200">
                    <h5>Services</h5>
                    <ul class="footer-links">
                        <li><a href="#">Panchakarma</a></li>
                        <li><a href="#">Herbal Medicine</a></li>
                        <li><a href="#">Yoga & Meditation</a></li>
                        <li><a href="#">Diet & Nutrition</a></li>
                        <li><a href="#">Detox Programs</a></li>
                    </ul>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="300">
                    <h5>Contact Us</h5>
                    <ul class="footer-links">
                        <li><i class="fas fa-map-marker-alt me-2 text-warning"></i>123 Wellness Street, Mumbai</li>
                        <li><i class="fas fa-phone me-2 text-warning"></i>+91 98765 43210</li>
                        <li><i class="fas fa-envelope me-2 text-warning"></i>info@ayurvedawellness.com</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 Ayurveda Wellness Center. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Back to Top -->
    <button class="back-to-top" id="backToTop">
        <i class="fas fa-chevron-up"></i>
    </button>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- AOS JS -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script>
        // Initialize AOS
        AOS.init({
            duration: 800,
            easing: 'ease-out-cubic',
            once: true,
            offset: 50
        });
        
        // Navbar Scroll Effect
        window.addEventListener('scroll', () => {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 100) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
        
        // Back to Top
        const backToTop = document.getElementById('backToTop');
        
        window.addEventListener('scroll', () => {
            if (window.scrollY > 500) {
                backToTop.classList.add('visible');
            } else {
                backToTop.classList.remove('visible');
            }
        });
        
        backToTop.addEventListener('click', () => {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
        
        // Filter Tags
        document.querySelectorAll('.filter-tag').forEach(tag => {
            tag.addEventListener('click', function() {
                document.querySelectorAll('.filter-tag').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
            });
        });
        
        // Save Button Toggle
        document.querySelectorAll('.hospital-save').forEach(btn => {
            btn.addEventListener('click', function() {
                const icon = this.querySelector('i');
                if (icon.classList.contains('far')) {
                    icon.classList.remove('far');
                    icon.classList.add('fas');
                    this.style.background = 'var(--accent-gold)';
                    icon.style.color = '#fff';
                } else {
                    icon.classList.remove('fas');
                    icon.classList.add('far');
                    this.style.background = 'rgba(255,255,255,0.9)';
                    icon.style.color = 'var(--accent-gold)';
                }
            });
        });
    </script>
</body>
</html>
