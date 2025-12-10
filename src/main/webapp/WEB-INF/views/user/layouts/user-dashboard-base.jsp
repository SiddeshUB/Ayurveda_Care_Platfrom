<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${not empty param.pageTitle}">${param.pageTitle}</c:when><c:otherwise>Dashboard</c:otherwise></c:choose> - Ayurveda Wellness</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-dark: #1a2e1a;
            --primary-green: #2d4a2d;
            --accent-gold: #c9a227;
            --accent-gold-light: #e6b55c;
            --text-light: #f5f0e8;
            --text-cream: #e8dcc8;
            --bg-cream: #fdfaf4;
            --bg-light: #f8f6f1;
            --sidebar-width: 280px;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--bg-light);
            color: #333;
            line-height: 1.6;
            overflow-x: hidden;
        }
        
        h1, h2, h3, h4, h5 {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 600;
        }
        
        /* ========== SIDEBAR ========== */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            background: linear-gradient(180deg, var(--primary-dark) 0%, #0d1a0d 100%);
            z-index: 1000;
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease;
        }
        
        .sidebar-header {
            padding: 25px 20px;
            border-bottom: 1px solid rgba(201, 162, 39, 0.15);
        }
        
        .sidebar-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: var(--accent-gold);
            font-family: 'Cormorant Garamond', serif;
            font-size: 24px;
            font-weight: 700;
        }
        
        .sidebar-brand i {
            font-size: 28px;
        }
        
        .sidebar-nav {
            flex: 1;
            padding: 20px 0;
            overflow-y: auto;
        }
        
        .nav-section {
            padding: 0 15px;
            margin-bottom: 15px;
        }
        
        .nav-section-title {
            font-size: 11px;
            font-weight: 600;
            color: rgba(255,255,255,0.4);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            padding: 10px 15px;
            margin-bottom: 5px;
        }
        
        .nav-item {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 20px;
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            border-radius: 12px;
            margin: 4px 10px;
            transition: all 0.3s ease;
            font-weight: 500;
            font-size: 14px;
        }
        
        .nav-item:hover {
            background: rgba(201, 162, 39, 0.1);
            color: #fff;
        }
        
        .nav-item.active {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            font-weight: 600;
        }
        
        .nav-item i {
            width: 20px;
            text-align: center;
            font-size: 16px;
        }
        
        .nav-badge {
            margin-left: auto;
            background: #dc3545;
            color: #fff;
            font-size: 11px;
            padding: 3px 8px;
            border-radius: 20px;
            font-weight: 600;
        }
        
        .nav-item.active .nav-badge {
            background: var(--primary-dark);
            color: #fff;
        }
        
        .sidebar-footer {
            padding: 20px;
            border-top: 1px solid rgba(201, 162, 39, 0.15);
        }
        
        .logout-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            padding: 12px;
            background: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.3);
            border-radius: 10px;
            color: #dc3545;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .logout-btn:hover {
            background: #dc3545;
            color: #fff;
        }
        
        /* ========== MAIN CONTENT ========== */
        .main-content {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
        }
        
        /* ========== TOP HEADER ========== */
        .top-header {
            background: #fff;
            padding: 15px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .header-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .sidebar-toggle {
            display: none;
            background: none;
            border: none;
            font-size: 24px;
            color: var(--primary-dark);
            cursor: pointer;
        }
        
        .page-title {
            font-size: 24px;
            color: var(--primary-dark);
            margin: 0;
        }
        
        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .header-search {
            position: relative;
        }
        
        .header-search input {
            padding: 10px 15px 10px 45px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            width: 280px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: var(--bg-light);
        }
        
        .header-search input:focus {
            outline: none;
            border-color: var(--accent-gold);
            background: #fff;
        }
        
        .header-search i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 8px 15px;
            background: var(--bg-light);
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .user-profile:hover {
            background: #e9ecef;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-dark);
            font-weight: 700;
            font-size: 16px;
        }
        
        .user-info {
            text-align: left;
        }
        
        .user-name {
            font-weight: 600;
            font-size: 14px;
            color: var(--primary-dark);
            line-height: 1.2;
        }
        
        .user-status {
            font-size: 12px;
            color: #28a745;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .user-status::before {
            content: '';
            width: 8px;
            height: 8px;
            background: #28a745;
            border-radius: 50%;
        }
        
        /* ========== DASHBOARD CONTENT ========== */
        .dashboard-content {
            padding: 30px;
        }
        
        /* ========== DASHBOARD CARDS ========== */
        .dashboard-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            border: 1px solid rgba(0,0,0,0.03);
            transition: all 0.3s ease;
        }
        
        .dashboard-card:hover {
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        }
        
        .card-header-custom {
            padding: 20px 25px;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .card-title {
            font-size: 18px;
            color: var(--primary-dark);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .card-title i {
            color: var(--accent-gold);
        }
        
        .card-body-custom {
            padding: 25px;
        }
        
        /* ========== STAT CARDS ========== */
        .stat-card {
            background: #fff;
            border-radius: 16px;
            padding: 25px;
            display: flex;
            align-items: center;
            gap: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            border: 1px solid rgba(0,0,0,0.03);
            transition: all 0.3s ease;
            height: 100%;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }
        
        .stat-icon {
            width: 65px;
            height: 65px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
        }
        
        .stat-icon.green {
            background: rgba(45, 74, 45, 0.1);
            color: var(--primary-green);
        }
        
        .stat-icon.gold {
            background: rgba(201, 162, 39, 0.1);
            color: var(--accent-gold);
        }
        
        .stat-icon.blue {
            background: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
        }
        
        .stat-icon.orange {
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }
        
        .stat-icon.red {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }
        
        .stat-icon.teal {
            background: rgba(32, 201, 151, 0.1);
            color: #20c997;
        }
        
        .stat-content h3 {
            font-family: 'Poppins', sans-serif;
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-dark);
            margin: 0 0 5px 0;
            line-height: 1;
        }
        
        .stat-content p {
            font-size: 14px;
            color: #888;
            margin: 0;
        }
        
        /* ========== WELCOME BANNER ========== */
        .welcome-banner {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary-green) 100%);
            border-radius: 20px;
            padding: 35px 40px;
            color: #fff;
            position: relative;
            overflow: hidden;
            margin-bottom: 30px;
        }
        
        .welcome-banner::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(201, 162, 39, 0.2) 0%, transparent 70%);
            border-radius: 50%;
        }
        
        .welcome-banner .content {
            position: relative;
            z-index: 1;
        }
        
        .welcome-banner h2 {
            font-size: 28px;
            margin-bottom: 10px;
            color: #fff;
        }
        
        .welcome-banner p {
            color: rgba(255,255,255,0.85);
            font-size: 15px;
            margin-bottom: 20px;
        }
        
        .btn-gold {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            padding: 12px 28px;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            border: none;
        }
        
        .btn-gold:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(201, 162, 39, 0.4);
            color: var(--primary-dark);
        }
        
        .btn-outline-gold {
            background: transparent;
            border: 2px solid var(--accent-gold);
            color: var(--accent-gold);
            padding: 10px 24px;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            font-size: 14px;
        }
        
        .btn-outline-gold:hover {
            background: var(--accent-gold);
            color: var(--primary-dark);
        }
        
        /* ========== LIST ITEMS ========== */
        .list-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            background: var(--bg-light);
            border-radius: 12px;
            margin-bottom: 12px;
            border-left: 4px solid var(--accent-gold);
            transition: all 0.3s ease;
        }
        
        .list-item:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        
        .list-item:last-child {
            margin-bottom: 0;
        }
        
        .list-item-content {
            flex: 1;
        }
        
        .list-item-content h4 {
            font-size: 15px;
            font-weight: 600;
            color: var(--primary-dark);
            margin: 0 0 4px 0;
            font-family: 'Poppins', sans-serif;
        }
        
        .list-item-content p {
            font-size: 13px;
            color: #888;
            margin: 0;
        }
        
        /* ========== BADGES ========== */
        .badge-status {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .badge-pending {
            background: rgba(255, 193, 7, 0.15);
            color: #d39e00;
        }
        
        .badge-confirmed {
            background: rgba(40, 167, 69, 0.15);
            color: #28a745;
        }
        
        .badge-replied {
            background: rgba(23, 162, 184, 0.15);
            color: #17a2b8;
        }
        
        .badge-cancelled {
            background: rgba(220, 53, 69, 0.15);
            color: #dc3545;
        }
        
        /* ========== EMPTY STATE ========== */
        .empty-state {
            text-align: center;
            padding: 50px 30px;
        }
        
        .empty-state-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: var(--bg-light);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
        }
        
        .empty-state-icon i {
            font-size: 32px;
            color: #ccc;
        }
        
        .empty-state h4 {
            font-size: 18px;
            color: var(--primary-dark);
            margin-bottom: 10px;
        }
        
        .empty-state p {
            color: #888;
            font-size: 14px;
            margin-bottom: 20px;
        }
        
        /* ========== SIDEBAR OVERLAY ========== */
        .sidebar-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.5);
            z-index: 999;
            display: none;
        }
        
        .sidebar-overlay.active {
            display: block;
        }
        
        /* ========== RESPONSIVE ========== */
        @media (max-width: 991px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .sidebar-toggle {
                display: block;
            }
            
            .header-search {
                display: none;
            }
            
            .user-info {
                display: none;
            }
        }
        
        @media (max-width: 767px) {
            .dashboard-content {
                padding: 20px;
            }
            
            .welcome-banner {
                padding: 25px;
            }
            
            .welcome-banner h2 {
                font-size: 22px;
            }
            
            .stat-card {
                padding: 20px;
            }
            
            .stat-icon {
                width: 55px;
                height: 55px;
                font-size: 22px;
            }
            
            .stat-content h3 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar Overlay -->
    <div class="sidebar-overlay" id="sidebarOverlay"></div>
    
    <!-- Sidebar -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-brand">
                <i class="fas fa-leaf"></i>
                <span>Ayurveda Wellness</span>
            </a>
        </div>
        
        <nav class="sidebar-nav">
            <div class="nav-section">
                <div class="nav-section-title">Main Menu</div>
                <a href="${pageContext.request.contextPath}/user/dashboard" class="nav-item ${param.activeNav == 'dashboard' ? 'active' : ''}">
                    <i class="fas fa-th-large"></i>
                    <span>Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/user/hospitals" class="nav-item ${param.activeNav == 'hospitals' ? 'active' : ''}">
                    <i class="fas fa-search"></i>
                    <span>Search Hospitals</span>
                </a>
                <a href="${pageContext.request.contextPath}/user/saved-centers" class="nav-item ${param.activeNav == 'saved-centers' ? 'active' : ''}">
                    <i class="fas fa-heart"></i>
                    <span>Saved Centers</span>
                    <c:if test="${not empty stats && stats.savedCenters > 0}">
                        <span class="nav-badge">${stats.savedCenters}</span>
                    </c:if>
                </a>
            </div>
            
            <div class="nav-section">
                <div class="nav-section-title">Bookings</div>
                <a href="${pageContext.request.contextPath}/user/dashboard/consultations" class="nav-item ${param.activeNav == 'consultations' ? 'active' : ''}">
                    <i class="fas fa-stethoscope"></i>
                    <span>My Consultations</span>
                </a>
                <a href="${pageContext.request.contextPath}/user/bookings" class="nav-item ${param.activeNav == 'bookings' ? 'active' : ''}">
                    <i class="fas fa-calendar-check"></i>
                    <span>Package Bookings</span>
                </a>
                <a href="${pageContext.request.contextPath}/user/enquiries" class="nav-item ${param.activeNav == 'enquiries' ? 'active' : ''}">
                    <i class="fas fa-envelope"></i>
                    <span>My Enquiries</span>
                </a>
            </div>
            
            <div class="nav-section">
                <div class="nav-section-title">Shopping</div>
                <a href="${pageContext.request.contextPath}/user/products" class="nav-item ${param.activeNav == 'products' ? 'active' : ''}">
                    <i class="fas fa-shopping-bag"></i>
                    <span>Products</span>
                </a>
                <a href="${pageContext.request.contextPath}/user/cart" class="nav-item ${param.activeNav == 'cart' ? 'active' : ''}">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Shopping Cart</span>
                    <c:if test="${not empty cartCount && cartCount > 0}">
                        <span class="nav-badge">${cartCount}</span>
                    </c:if>
                </a>
                <a href="${pageContext.request.contextPath}/user/orders" class="nav-item ${param.activeNav == 'orders' ? 'active' : ''}">
                    <i class="fas fa-box"></i>
                    <span>My Orders</span>
                </a>
            </div>
            
            <div class="nav-section">
                <div class="nav-section-title">Account</div>
                <a href="${pageContext.request.contextPath}/user/profile" class="nav-item ${param.activeNav == 'profile' ? 'active' : ''}">
                    <i class="fas fa-user"></i>
                    <span>Profile Settings</span>
                </a>
            </div>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/user/logout" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Header -->
        <header class="top-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1 class="page-title"><c:choose><c:when test="${not empty param.pageTitle}">${param.pageTitle}</c:when><c:otherwise>Dashboard</c:otherwise></c:choose></h1>
            </div>
            
            <div class="header-right">
                <div class="header-search">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search...">
                </div>
                
                <div class="user-profile">
                    <div class="user-avatar">
                        <c:choose>
                            <c:when test="${not empty user && not empty user.fullName}">
                                ${fn:substring(user.fullName, 0, 1)}
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-user"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="user-info">
                        <div class="user-name">${not empty user ? user.fullName : 'Guest'}</div>
                        <div class="user-status">Online</div>
                    </div>
                </div>
            </div>
        </header>
        
        <!-- Dashboard Content Area -->
        <div class="dashboard-content">
