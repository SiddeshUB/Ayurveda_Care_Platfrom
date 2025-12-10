<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointments - Doctor Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        /* ============================================
           AYURVEDIC DOCTOR DASHBOARD - WOW DESIGN
           ============================================ */
        
        /* Base Reset & Variables - Ayurvedic Color Palette */
        :root {
            --ayur-dark-green: #0a3d2c;
            --ayur-medium-green: #1a5c40;
            --ayur-light-green: #2e7d5a;
            --ayur-accent-gold: #d4af37;
            --ayur-teal: #2a9d8f;
            --ayur-olive: #6a994e;
            --ayur-moss: #386641;
            --ayur-spice: #bc6c25;
            --sidebar-width: 280px;
            --header-height: 80px;
            --border-radius: 16px;
            --card-shadow: 0 10px 40px rgba(10, 61, 44, 0.1);
            --hover-shadow: 0 15px 50px rgba(10, 61, 44, 0.15);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Nunito Sans', sans-serif;
            background: linear-gradient(135deg, #f0f7f4 0%, #e8f1ed 100%);
            color: #2c3e50;
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        .dashboard-body {
            display: flex;
            min-height: 100vh;
        }
        
        .sidebar {
            width: var(--sidebar-width);
            background: linear-gradient(180deg, var(--ayur-dark-green) 0%, var(--ayur-medium-green) 100%);
            color: white;
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100vh;
            z-index: 1000;
            transition: var(--transition);
            box-shadow: 5px 0 25px rgba(10, 61, 44, 0.2);
            border-right: 3px solid var(--ayur-accent-gold);
        }
        
        .sidebar-header {
            padding: 30px 25px;
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            text-align: center;
            background: rgba(10, 61, 44, 0.9);
            position: relative;
            overflow: hidden;
        }
        
        .sidebar-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, transparent, var(--ayur-accent-gold), transparent);
        }
        
        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 15px;
            color: white;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: 700;
            justify-content: center;
            z-index: 1;
            position: relative;
        }
        
        .sidebar-logo i {
            font-size: 2.2rem;
            color: var(--ayur-accent-gold);
            text-shadow: 0 2px 10px rgba(212, 175, 55, 0.3);
        }
        
        .sidebar-logo .highlight {
            color: var(--ayur-accent-gold);
            font-weight: 800;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
        
        .sidebar-nav {
            flex: 1;
            padding: 25px 0;
            overflow-y: auto;
        }
        
        .nav-item {
            display: flex;
            align-items: center;
            gap: 18px;
            padding: 18px 30px;
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            transition: var(--transition);
            border-left: 4px solid transparent;
            margin: 8px 15px;
            position: relative;
            overflow: hidden;
            border-radius: 12px;
        }
        
        .nav-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(212, 175, 55, 0.1), transparent);
            transition: left 0.6s ease;
        }
        
        .nav-item:hover::before {
            left: 100%;
        }
        
        .nav-item:hover {
            background: linear-gradient(90deg, rgba(212, 175, 55, 0.15), rgba(46, 125, 90, 0.2));
            color: white;
            padding-left: 35px;
            transform: translateX(5px);
            border-left-color: var(--ayur-accent-gold);
        }
        
        .nav-item.active {
            background: linear-gradient(135deg, rgba(46, 125, 90, 0.3), rgba(212, 175, 55, 0.2));
            border-left-color: var(--ayur-accent-gold);
            color: white;
            font-weight: 600;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .nav-item i {
            width: 24px;
            font-size: 1.2rem;
            text-align: center;
            color: var(--ayur-accent-gold);
        }
        
        .nav-item span {
            flex: 1;
            white-space: nowrap;
            font-size: 0.95rem;
        }
        
        .sidebar-footer {
            padding: 25px;
            border-top: 1px solid rgba(212, 175, 55, 0.2);
            display: flex;
            flex-direction: column;
            gap: 15px;
            background: rgba(10, 61, 44, 0.8);
        }
        
        .btn-outline {
            background: transparent;
            border: 2px solid var(--ayur-accent-gold);
            color: var(--ayur-accent-gold);
            padding: 12px 20px;
            border-radius: 10px;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 600;
            transition: var(--transition);
            font-size: 0.9rem;
        }
        
        .btn-outline:hover {
            background: var(--ayur-accent-gold);
            color: var(--ayur-dark-green);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
        }
        
        .logout-link {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            border-radius: 10px;
            transition: var(--transition);
            font-size: 0.9rem;
        }
        
        .logout-link:hover {
            background: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            transform: translateX(5px);
        }
        
        .dashboard-main {
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: var(--transition);
            background: linear-gradient(135deg, #f5f9f7 0%, #edf5f1 100%);
            min-height: 100vh;
        }
        
        .dashboard-header {
            background: white;
            height: var(--header-height);
            padding: 0 35px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 6px 20px rgba(10, 61, 44, 0.08);
            position: sticky;
            top: 0;
            z-index: 999;
            border-bottom: 2px solid var(--ayur-accent-gold);
        }
        
        .header-left {
            display: flex;
            align-items: center;
            gap: 25px;
        }
        
        .sidebar-toggle {
            background: var(--ayur-light-green);
            border: none;
            width: 45px;
            height: 45px;
            border-radius: 12px;
            font-size: 1.3rem;
            color: white;
            cursor: pointer;
            display: none;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(46, 125, 90, 0.2);
        }
        
        .sidebar-toggle:hover {
            background: var(--ayur-teal);
            transform: rotate(90deg);
        }
        
        .header-left h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--ayur-dark-green);
            font-weight: 700;
            background: linear-gradient(135deg, var(--ayur-dark-green), var(--ayur-teal));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .dashboard-content {
            padding: 35px;
            max-width: 1500px;
            margin: 0 auto;
            width: 100%;
        }
        
        /* Alert Styles */
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .alert-success {
            background: linear-gradient(135deg, rgba(106, 153, 78, 0.1), rgba(56, 102, 65, 0.1));
            color: var(--ayur-olive);
            border-left: 4px solid var(--ayur-olive);
        }
        
        .alert-error {
            background: linear-gradient(135deg, rgba(231, 76, 60, 0.1), rgba(236, 112, 99, 0.1));
            color: #e74c3c;
            border-left: 4px solid #e74c3c;
        }
        
        /* Filter Tabs */
        .filter-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }
        
        .filter-tab {
            padding: 12px 24px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: var(--transition);
            background: white;
            color: var(--ayur-medium-green);
            border: 2px solid rgba(46, 125, 90, 0.2);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }
        
        .filter-tab:hover {
            background: linear-gradient(135deg, rgba(46, 125, 90, 0.1), rgba(212, 175, 55, 0.1));
            border-color: var(--ayur-accent-gold);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(46, 125, 90, 0.15);
        }
        
        .filter-tab.active {
            background: linear-gradient(135deg, var(--ayur-medium-green), var(--ayur-light-green));
            color: white;
            border-color: var(--ayur-light-green);
            box-shadow: 0 4px 15px rgba(46, 125, 90, 0.3);
        }
        
        /* Booking Cards */
        .bookings-list {
            display: grid;
            gap: 25px;
        }
        
        .booking-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 30px;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            border: 2px solid rgba(46, 125, 90, 0.1);
            border-left: 4px solid var(--ayur-light-green);
            position: relative;
            overflow: hidden;
        }
        
        .booking-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(to bottom, var(--ayur-accent-gold), var(--ayur-light-green));
        }
        
        .booking-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
            border-color: rgba(212, 175, 55, 0.3);
        }
        
        /* Status Badge */
        .status-badge {
            padding: 8px 16px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-block;
        }
        
        .status-pending {
            background: linear-gradient(135deg, var(--ayur-spice), #d08c2c);
            color: white;
        }
        
        .status-confirmed {
            background: linear-gradient(135deg, var(--ayur-olive), var(--ayur-moss));
            color: white;
        }
        
        .status-completed {
            background: linear-gradient(135deg, var(--ayur-teal), #38b2ac);
            color: white;
        }
        
        .status-cancelled {
            background: linear-gradient(135deg, #e74c3c, #ec7063);
            color: white;
        }
        
        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        /* Empty State */
        .empty-state {
            background: white;
            border-radius: var(--border-radius);
            padding: 60px 40px;
            text-align: center;
            box-shadow: var(--card-shadow);
            border: 2px solid rgba(46, 125, 90, 0.1);
        }
        
        .empty-state i {
            font-size: 4rem;
            color: var(--ayur-accent-gold);
            margin-bottom: 20px;
            opacity: 0.7;
        }
        
        .empty-state h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--ayur-dark-green);
            margin-bottom: 10px;
        }
        
        .empty-state p {
            color: #6b7280;
            font-size: 1rem;
        }
        
        /* CSS Variables for inline styles */
        :root {
            --primary-forest: #0a3d2c;
            --primary-sage: #1a5c40;
            --text-dark: #2c3e50;
            --text-muted: #6b7280;
            --text-medium: #6b7280;
            --spacing-xs: 8px;
            --spacing-sm: 12px;
            --spacing-md: 16px;
            --spacing-lg: 24px;
            --spacing-xl: 30px;
            --spacing-3xl: 60px;
            --radius-md: 10px;
            --radius-lg: 16px;
        }
        
        @media (max-width: 1200px) {
            .sidebar {
                transform: translateX(-100%);
                box-shadow: 10px 0 40px rgba(10, 61, 44, 0.3);
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .dashboard-main {
                margin-left: 0;
            }
            
            .sidebar-toggle {
                display: flex;
                align-items: center;
                justify-content: center;
            }
        }
        
        @media (max-width: 768px) {
            .dashboard-content {
                padding: 25px;
            }
            
            .header-left h1 {
                font-size: 1.6rem;
            }
            
            .filter-tabs {
                gap: 8px;
            }
            
            .filter-tab {
                padding: 10px 16px;
                font-size: 0.85rem;
            }
            
            .booking-card {
                padding: 20px;
            }
            
            .empty-state {
                padding: 40px 25px;
            }
            
            .empty-state i {
                font-size: 3rem;
            }
            
            .empty-state h3 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body class="dashboard-body">
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-leaf"></i>
                <span>Ayur<span class="highlight">Doctor</span></span>
            </a>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-item">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/profile" class="nav-item">
                <i class="fas fa-user-circle"></i>
                <span>Profile</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="nav-item active">
                <i class="fas fa-calendar-check"></i>
                <span>Appointments</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/prescriptions" class="nav-item">
                <i class="fas fa-prescription"></i>
                <span>Prescriptions</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/reviews" class="nav-item">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availability" class="nav-item">
                <i class="fas fa-clock"></i>
                <span>Availability</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline btn-sm" target="_blank">
                <i class="fas fa-external-link-alt"></i> View AyurVedaCare
            </a>
            <a href="${pageContext.request.contextPath}/doctor/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Appointments</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <!-- Filter Tabs -->
            <div class="filter-tabs">
                <a href="${pageContext.request.contextPath}/doctor/appointments" 
                   class="filter-tab ${empty currentStatus ? 'active' : ''}">
                    All
                </a>
                <a href="${pageContext.request.contextPath}/doctor/appointments?status=PENDING" 
                   class="filter-tab ${currentStatus == 'PENDING' ? 'active' : ''}">
                    Pending
                </a>
                <a href="${pageContext.request.contextPath}/doctor/appointments?status=CONFIRMED" 
                   class="filter-tab ${currentStatus == 'CONFIRMED' ? 'active' : ''}">
                    Confirmed
                </a>
                <a href="${pageContext.request.contextPath}/doctor/appointments?status=COMPLETED" 
                   class="filter-tab ${currentStatus == 'COMPLETED' ? 'active' : ''}">
                    Completed
                </a>
            </div>

            <c:choose>
                <c:when test="${not empty consultations}">
                    <div class="bookings-list">
                        <c:forEach var="consultation" items="${consultations}">
                            <div class="booking-card" style="border-left-color: ${consultation.status == 'CONFIRMED' ? 'var(--ayur-olive)' : (consultation.status == 'PENDING' ? 'var(--ayur-spice)' : (consultation.status == 'COMPLETED' ? 'var(--ayur-teal)' : '#ef4444'))};">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: var(--spacing-lg);">
                                    <div style="flex: 1;">
                                        <div style="display: flex; align-items: center; gap: var(--spacing-md); margin-bottom: var(--spacing-sm);">
                                            <div style="width: 50px; height: 50px; background: linear-gradient(135deg, var(--primary-sage), var(--primary-forest)); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.5rem;">
                                                <i class="fas fa-user"></i>
                                            </div>
                                            <div>
                                                <h3 style="margin: 0; font-size: 1.25rem; color: var(--text-dark);">
                                                    ${consultation.patientName}
                                                </h3>
                                                <p style="color: var(--text-muted); margin: 4px 0 0; font-size: 0.9rem;">
                                                    <i class="fas fa-envelope"></i> ${consultation.patientEmail}
                                                </p>
                                                <c:if test="${not empty consultation.patientPhone}">
                                                    <p style="color: var(--text-muted); margin: 4px 0 0; font-size: 0.9rem;">
                                                        <i class="fas fa-phone"></i> ${consultation.patientPhone}
                                                    </p>
                                                </c:if>
                                            </div>
                                        </div>
                                        <p style="color: var(--text-muted); font-size: 0.85rem; margin-top: var(--spacing-xs);">
                                            <i class="fas fa-hashtag"></i> ${consultation.consultationNumber}
                                        </p>
                                    </div>
                                    <div>
                                        <span class="status-badge status-${fn:toLowerCase(consultation.status)}">
                                            ${consultation.status}
                                        </span>
                                    </div>
                                </div>
                                
                                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: var(--spacing-lg); margin-bottom: var(--spacing-lg); padding: var(--spacing-lg); background: #f9fafb; border-radius: var(--radius-md);">
                                    <div style="display: flex; align-items: center; gap: var(--spacing-sm);">
                                        <div style="width: 40px; height: 40px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--primary-forest);">
                                            <i class="fas fa-calendar"></i>
                                        </div>
                                        <div>
                                            <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Date</div>
                                            <div style="font-weight: 600; color: var(--text-dark);">
                                                <fmt:parseDate value="${consultation.consultationDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                                <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                            </div>
                                        </div>
                                    </div>
                                    <c:if test="${consultation.consultationTime != null}">
                                        <div style="display: flex; align-items: center; gap: var(--spacing-sm);">
                                            <div style="width: 40px; height: 40px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--primary-forest);">
                                                <i class="fas fa-clock"></i>
                                            </div>
                                            <div>
                                                <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Time</div>
                                                <div style="font-weight: 600; color: var(--text-dark);">${consultation.consultationTime}</div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${consultation.consultationType != null}">
                                        <div style="display: flex; align-items: center; gap: var(--spacing-sm);">
                                            <div style="width: 40px; height: 40px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--primary-forest);">
                                                <i class="fas fa-${consultation.consultationType == 'ONLINE' ? 'video' : (consultation.consultationType == 'HOME_VISIT' ? 'home' : 'hospital')}"></i>
                                            </div>
                                            <div>
                                                <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Type</div>
                                                <div style="font-weight: 600; color: var(--text-dark);">${fn:replace(consultation.consultationType, '_', ' ')}</div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${consultation.durationMinutes != null}">
                                        <div style="display: flex; align-items: center; gap: var(--spacing-sm);">
                                            <div style="width: 40px; height: 40px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--primary-forest);">
                                                <i class="fas fa-hourglass-half"></i>
                                            </div>
                                            <div>
                                                <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Duration</div>
                                                <div style="font-weight: 600; color: var(--text-dark);">${consultation.durationMinutes} min</div>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <c:if test="${not empty consultation.reasonForVisit}">
                                    <div style="padding: var(--spacing-md); background: linear-gradient(135deg, rgba(45, 90, 61, 0.05), rgba(199, 163, 105, 0.05)); border-left: 3px solid var(--primary-sage); border-radius: var(--radius-md); margin-bottom: var(--spacing-md);">
                                        <div style="display: flex; align-items: center; gap: var(--spacing-sm); margin-bottom: var(--spacing-xs);">
                                            <i class="fas fa-comment-medical" style="color: var(--primary-forest);"></i>
                                            <strong style="color: var(--text-dark);">Reason</strong>
                                        </div>
                                        <p style="color: var(--text-medium); margin: 0; line-height: 1.6; font-size: 0.9rem;">${fn:substring(consultation.reasonForVisit, 0, 100)}${fn:length(consultation.reasonForVisit) > 100 ? '...' : ''}</p>
                                    </div>
                                </c:if>
                                
                                <div style="display: flex; justify-content: space-between; align-items: center; padding-top: var(--spacing-md); border-top: 1px solid #e5e7eb; margin-top: var(--spacing-md);">
                                    <div style="display: flex; align-items: center; gap: var(--spacing-xs); color: var(--text-muted); font-size: 0.9rem;">
                                        <i class="fas fa-calendar-plus"></i>
                                        <span>
                                            Requested on 
                                            <fmt:parseDate value="${consultation.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt" type="both"/>
                                            <fmt:formatDate value="${parsedCreatedAt}" pattern="dd MMM yyyy"/>
                                        </span>
                                    </div>
                                    <div style="display: flex; gap: 12px;">
                                        <c:if test="${consultation.status == 'PENDING'}">
                                            <form action="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}/confirm" method="post" style="display: inline-block; margin: 0;">
                                                <button type="submit" class="btn" style="background: linear-gradient(135deg, var(--ayur-olive), var(--ayur-moss)); color: white;">
                                                    <i class="fas fa-check"></i> Accept
                                                </button>
                                            </form>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}" class="btn" style="background: linear-gradient(135deg, var(--ayur-dark-green), var(--ayur-medium-green)); color: white; text-decoration: none; display: inline-flex; align-items: center;">
                                            <i class="fas fa-eye"></i> View Details
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-calendar"></i>
                        <h3>No Appointments</h3>
                        <p>You don't have any appointments yet</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script>
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
                this.style.transform = sidebar.classList.contains('active') ? 'rotate(90deg)' : 'rotate(0)';
            });
        }
    </script>
</body>
</html>

