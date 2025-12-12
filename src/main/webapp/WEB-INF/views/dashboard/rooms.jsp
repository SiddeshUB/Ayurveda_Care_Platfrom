<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accommodation Rooms - Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body class="dashboard-body">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-leaf"></i>
                <span>AyurVeda<span class="highlight">Care</span></span>
            </a>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/profile" class="nav-item">
                <i class="fas fa-hospital"></i>
                <span>Profile</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/packages" class="nav-item">
                <i class="fas fa-box"></i>
                <span>Packages</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/doctors" class="nav-item">
                <i class="fas fa-user-md"></i>
                <span>Doctors</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/bookings" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Bookings</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/gallery" class="nav-item">
                <i class="fas fa-images"></i>
                <span>Gallery</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/documents" class="nav-item">
                <i class="fas fa-file-alt"></i>
                <span>Documents</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/reviews" class="nav-item">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}" class="btn btn-outline btn-sm" target="_blank">
                <i class="fas fa-external-link-alt"></i> View Public Profile
            </a>
            <a href="${pageContext.request.contextPath}/hospital/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Accommodation Rooms</h1>
            </div>
            
            <div class="header-right">
                <div class="header-profile">
                    <div class="profile-info">
                        <span class="profile-name">${hospital.centerName}</span>
                    </div>
                    <div class="profile-avatar">
                        <i class="fas fa-hospital"></i>
                    </div>
                </div>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success" data-auto-dismiss="5000">
                    <i class="fas fa-check-circle"></i>
                    ${success}
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error" data-auto-dismiss="5000">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <div class="page-header">
                <div>
                    <h2 style="margin: 0;">Your Accommodation Rooms</h2>
                    <p style="color: var(--text-muted); margin: var(--spacing-xs) 0 0;">Manage your accommodation rooms and pricing</p>
                </div>
                <a href="${pageContext.request.contextPath}/dashboard/rooms/add" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add New Room
                </a>
            </div>

            <c:choose>
                <c:when test="${not empty rooms}">
                    <div class="item-grid">
                        <c:forEach var="room" items="${rooms}">
                            <div class="item-card">
                                <div class="item-image">
                                    <c:choose>
                                        <c:when test="${not empty room.imageUrls}">
                                            <c:set var="imageArray" value="${fn:split(room.imageUrls, ',')}" />
                                            <img src="${pageContext.request.contextPath}${imageArray[0]}" alt="${room.roomName}">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; background: var(--neutral-sand);">
                                                <i class="fas fa-bed" style="font-size: 3rem; color: var(--text-muted);"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="item-status">
                                        <span class="badge ${room.isActive ? 'badge-success' : 'badge-error'}">
                                            ${room.isActive ? 'Active' : 'Inactive'}
                                        </span>
                                    </div>
                                </div>
                                <div class="item-body">
                                    <h4 class="item-title">${room.roomName}</h4>
                                    <div class="item-meta">
                                        <span><i class="fas fa-tag"></i> ${room.roomType}</span>
                                        <c:if test="${room.maxOccupancy != null}">
                                            <span><i class="fas fa-users"></i> ${room.maxOccupancy} Guests</span>
                                        </c:if>
                                    </div>
                                    <div style="margin-bottom: var(--spacing-md);">
                                        <span style="font-weight: 600; color: var(--primary-forest);">
                                            ₹<fmt:formatNumber value="${room.pricePerNight != null ? room.pricePerNight : 0}" maxFractionDigits="0"/>/night
                                        </span>
                                        <c:if test="${room.totalRooms != null}">
                                            <span style="color: var(--text-muted); margin-left: var(--spacing-md);">
                                                <i class="fas fa-door-open"></i> ${room.totalRooms} rooms
                                                <c:if test="${room.availableRooms != null}">
                                                    (${room.availableRooms} available)
                                                </c:if>
                                            </span>
                                        </c:if>
                                    </div>
                                    <div class="item-actions">
                                        <a href="${pageContext.request.contextPath}/dashboard/rooms/edit/${room.id}" class="btn btn-sm btn-secondary">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <form action="${pageContext.request.contextPath}/dashboard/rooms/toggle/${room.id}" method="post" style="display: inline;">
                                            <button type="submit" class="btn btn-sm btn-outline">
                                                <i class="fas ${room.isActive ? 'fa-eye-slash' : 'fa-eye'}"></i>
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/dashboard/rooms/delete/${room.id}" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this room?');">
                                            <button type="submit" class="btn btn-sm btn-outline" style="color: var(--error);">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" style="background: white; padding: var(--spacing-3xl); border-radius: var(--radius-lg);">
                        <i class="fas fa-bed" style="font-size: 4rem; color: var(--text-muted);"></i>
                        <h3>No Rooms Yet</h3>
                        <p>Create your first accommodation room to showcase your facilities</p>
                        <a href="${pageContext.request.contextPath}/dashboard/rooms/add" class="btn btn-primary" style="margin-top: var(--spacing-lg);">
                            <i class="fas fa-plus"></i> Add Your First Room
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
            });
        }
    </script>
</body>
</html>
