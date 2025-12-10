<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${not empty pageTitle}">${pageTitle} - Admin Dashboard</c:when><c:otherwise>Admin Dashboard</c:otherwise></c:choose></title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        :root {
            --admin-primary: #1a1a3e;
            --admin-secondary: #2d2d5e;
            --admin-accent: #C7A369;
        }
        .sidebar { background: linear-gradient(180deg, var(--admin-primary) 0%, #0f0f23 100%); }
        .sidebar-logo .highlight { color: var(--admin-accent); }
        .nav-item.active { border-left-color: var(--admin-accent); }
        .nav-badge { background: #ef4444; }
    </style>
</head>
<body class="dashboard-body">
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-shield-alt"></i>
                <span>Admin<span class="highlight">Panel</span></span>
            </a>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item ${activePage == 'dashboard' ? 'active' : ''}">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/hospitals" class="nav-item ${activePage == 'hospitals' ? 'active' : ''}">
                <i class="fas fa-hospital"></i>
                <span>All Hospitals</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/hospitals?status=PENDING" class="nav-item ${activePage == 'pending-hospitals' ? 'active' : ''}">
                <i class="fas fa-clock"></i>
                <span>Pending Approval</span>
                <c:if test="${stats != null && stats.pendingHospitals > 0}">
                    <span class="nav-badge">${stats.pendingHospitals}</span>
                </c:if>
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-item ${activePage == 'users' ? 'active' : ''}">
                <i class="fas fa-users"></i>
                <span>All Users</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/doctors" class="nav-item ${activePage == 'doctors' ? 'active' : ''}">
                <i class="fas fa-user-md"></i>
                <span>All Doctors</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-item ${activePage == 'bookings' ? 'active' : ''}">
                <i class="fas fa-calendar-check"></i>
                <span>All Bookings</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/products" class="nav-item ${activePage == 'products' ? 'active' : ''}">
                <i class="fas fa-shopping-bag"></i>
                <span>All Products</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/vendors" class="nav-item ${activePage == 'vendors' ? 'active' : ''}">
                <i class="fas fa-store"></i>
                <span>All Vendors</span>
                <c:if test="${stats != null && stats.pendingVendors > 0}">
                    <span class="nav-badge">${stats.pendingVendors}</span>
                </c:if>
            </a>
            <a href="${pageContext.request.contextPath}/admin/vendors?status=PENDING" class="nav-item ${activePage == 'pending-vendors' ? 'active' : ''}">
                <i class="fas fa-user-clock"></i>
                <span>Pending Vendors</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/enquiries" class="nav-item ${activePage == 'enquiries' ? 'active' : ''}">
                <i class="fas fa-envelope"></i>
                <span>All Enquiries</span>
                <c:if test="${stats != null && stats.pendingEnquiries > 0}">
                    <span class="nav-badge">${stats.pendingEnquiries}</span>
                </c:if>
            </a>
            <a href="${pageContext.request.contextPath}/admin/reviews" class="nav-item ${activePage == 'reviews' ? 'active' : ''}">
                <i class="fas fa-star"></i>
                <span>See Reviews</span>
            </a>
        </nav>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline btn-sm" target="_blank">
                <i class="fas fa-external-link-alt"></i> View Website
            </a>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle"><i class="fas fa-bars"></i></button>
                <h1><c:if test="${not empty pageTitle}">${pageTitle}</c:if></h1>
            </div>
            <div class="header-right">
                <div class="header-profile">
                    <div class="profile-info">
                        <span class="profile-name">${admin.fullName}</span>
                        <span class="profile-role">Administrator</span>
                    </div>
                </div>
            </div>
        </header>

        <div class="dashboard-content">

