<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - ${hospital.centerName}</title>
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
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item active">
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
                <c:if test="${stats.pendingBookings > 0}">
                    <span class="nav-badge">${stats.pendingBookings}</span>
                </c:if>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/enquiries" class="nav-item">
                <i class="fas fa-envelope"></i>
                <span>Enquiries</span>
                <c:if test="${stats.pendingEnquiries > 0}">
                    <span class="nav-badge">${stats.pendingEnquiries}</span>
                </c:if>
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
        <!-- Top Bar -->
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Dashboard</h1>
            </div>
            
            <div class="header-right">
                <div class="header-search">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search...">
                </div>
                
                <div class="header-notifications">
                    <button class="notification-btn">
                        <i class="fas fa-bell"></i>
                        <c:if test="${stats.pendingBookings > 0}">
                            <span class="notification-badge">${stats.pendingBookings}</span>
                        </c:if>
                    </button>
                </div>
                
                <div class="header-profile">
                    <div class="profile-info">
                        <span class="profile-name">${hospital.centerName}</span>
                        <span class="profile-status">
                            <c:choose>
                                <c:when test="${hospital.status == 'APPROVED'}">
                                    <span class="status-dot active"></span> Verified
                                </c:when>
                                <c:otherwise>
                                    <span class="status-dot pending"></span> ${hospital.status}
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="profile-avatar">
                        <c:choose>
                            <c:when test="${not empty hospital.logoUrl}">
                                <img src="${pageContext.request.contextPath}${hospital.logoUrl}" alt="${hospital.centerName}">
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-hospital"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </header>

        <!-- Dashboard Content -->
        <div class="dashboard-content">
            <!-- Welcome Banner -->
            <div class="welcome-banner">
                <div class="welcome-text">
                    <h2>Welcome back, ${hospital.contactPersonName}!</h2>
                    <p>Here's what's happening with your center today.</p>
                </div>
                <div class="welcome-actions">
                    <a href="${pageContext.request.contextPath}/dashboard/packages/add" class="btn btn-gold">
                        <i class="fas fa-plus"></i> Add Package
                    </a>
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon bookings">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${stats.thisMonthBookings != null ? stats.thisMonthBookings : 0}</h3>
                        <p>Bookings This Month</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon pending">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${stats.pendingBookings != null ? stats.pendingBookings : 0}</h3>
                        <p>Pending Bookings</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon revenue">
                        <i class="fas fa-rupee-sign"></i>
                    </div>
                    <div class="stat-info">
                        <h3><fmt:formatNumber value="${stats.monthlyRevenue != null ? stats.monthlyRevenue : 0}" type="currency" currencySymbol="₹" maxFractionDigits="0"/></h3>
                        <p>Revenue This Month</p>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h3 class="section-title">Quick Actions</h3>
                <div class="actions-grid">
                    <a href="${pageContext.request.contextPath}/dashboard/packages/add" class="action-card">
                        <div class="action-icon">
                            <i class="fas fa-box"></i>
                        </div>
                        <span>Add Package</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/dashboard/doctors/add" class="action-card">
                        <div class="action-icon">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <span>Add Doctor</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/dashboard/gallery" class="action-card">
                        <div class="action-icon">
                            <i class="fas fa-camera"></i>
                        </div>
                        <span>Upload Photos</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/dashboard/profile" class="action-card">
                        <div class="action-icon">
                            <i class="fas fa-edit"></i>
                        </div>
                        <span>Update Profile</span>
                    </a>
                </div>
            </div>

            <!-- Two Column Layout -->
            <div class="dashboard-grid">
                <!-- Recent Bookings -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3>Recent Bookings</h3>
                        <a href="${pageContext.request.contextPath}/dashboard/bookings" class="view-all">View All</a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty recentBookings}">
                                <div class="booking-list">
                                    <c:forEach var="booking" items="${recentBookings}">
                                        <div class="booking-item">
                                            <div class="booking-avatar">
                                                <i class="fas fa-user"></i>
                                            </div>
                                            <div class="booking-info">
                                                <h4>${booking.patientName}</h4>
                                                <p>${booking.treatmentPackage != null ? booking.treatmentPackage.packageName : 'General Inquiry'}</p>
                                            </div>
                                            <div class="booking-meta">
                                                <span class="badge ${booking.status == 'PENDING' ? 'badge-warning' : (booking.status == 'CONFIRMED' ? 'badge-success' : 'badge-error')}">${booking.status}</span>
                                                <span class="booking-date">
                                                    <%
                                                        com.ayurveda.entity.Booking b = (com.ayurveda.entity.Booking) pageContext.getAttribute("booking");
                                                        if (b != null && b.getCreatedAt() != null) {
                                                            out.print(b.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM")));
                                                        }
                                                    %>
                                                </span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="fas fa-calendar"></i>
                                    <p>No recent bookings</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Recent Reviews -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3>Recent Reviews</h3>
                        <a href="${pageContext.request.contextPath}/dashboard/reviews" class="view-all">View All</a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty recentReviews}">
                                <div class="review-list">
                                    <c:forEach var="review" items="${recentReviews}">
                                        <div class="review-item">
                                            <div class="review-header">
                                                <span class="reviewer-name">${review.patientName}</span>
                                                <div class="review-rating">
                                                    <c:forEach begin="1" end="5" var="star">
                                                        <i class="fas fa-star ${star <= review.rating ? '' : 'empty'}"></i>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <p class="review-text">${review.reviewText.length() > 100 ? review.reviewText.substring(0, 100).concat('...') : review.reviewText}</p>
                                            <span class="review-date">
                                                <%
                                                    com.ayurveda.entity.Review r = (com.ayurveda.entity.Review) pageContext.getAttribute("review");
                                                    if (r != null && r.getCreatedAt() != null) {
                                                        out.print(r.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                                    }
                                                %>
                                            </span>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="fas fa-star"></i>
                                    <p>No reviews yet</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Profile Completion (if not complete) -->
            <c:if test="${!hospital.profileComplete}">
                <div class="completion-card">
                    <div class="completion-header">
                        <h3><i class="fas fa-tasks"></i> Complete Your Profile</h3>
                        <p>A complete profile helps you get more bookings</p>
                    </div>
                    <div class="completion-items">
                        <div class="completion-item ${not empty hospital.description ? 'completed' : ''}">
                            <i class="fas ${not empty hospital.description ? 'fa-check-circle' : 'fa-circle'}"></i>
                            <span>Add description</span>
                        </div>
                        <div class="completion-item ${stats.packageCount > 0 ? 'completed' : ''}">
                            <i class="fas ${stats.packageCount > 0 ? 'fa-check-circle' : 'fa-circle'}"></i>
                            <span>Add treatment packages</span>
                        </div>
                        <div class="completion-item ${stats.doctorCount > 0 ? 'completed' : ''}">
                            <i class="fas ${stats.doctorCount > 0 ? 'fa-check-circle' : 'fa-circle'}"></i>
                            <span>Add doctors</span>
                        </div>
                        <div class="completion-item ${not empty hospital.coverPhotoUrl ? 'completed' : ''}">
                            <i class="fas ${not empty hospital.coverPhotoUrl ? 'fa-check-circle' : 'fa-circle'}"></i>
                            <span>Upload photos</span>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </main>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Sidebar toggle for mobile
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

