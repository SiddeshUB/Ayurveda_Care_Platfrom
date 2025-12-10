<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="Dashboard"/>
    <jsp:param name="activeNav" value="dashboard"/>
</jsp:include>

<!-- Welcome Banner -->
<div class="welcome-banner">
    <div class="content">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h2>Welcome back, ${not empty user ? user.fullName : 'Guest'}! 👋</h2>
                <p>Discover authentic Ayurvedic centers and book your wellness journey. Your path to holistic health starts here.</p>
                <a href="${pageContext.request.contextPath}/user/hospitals" class="btn-gold">
                    <i class="fas fa-search"></i> Find Ayurvedic Centers
                </a>
            </div>
            <div class="col-lg-4 d-none d-lg-block text-end">
                <img src="https://cdn-icons-png.flaticon.com/512/2966/2966327.png" alt="Wellness" style="width: 150px; opacity: 0.9;">
            </div>
        </div>
    </div>
</div>

<!-- Stats Grid -->
<div class="row g-4 mb-4">
    <div class="col-sm-6 col-lg-4 col-xl-2">
        <div class="stat-card">
            <div class="stat-icon green">
                <i class="fas fa-heart"></i>
            </div>
            <div class="stat-content">
                <h3>${not empty stats ? stats.savedCenters : 0}</h3>
                <p>Saved Centers</p>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-4 col-xl-2">
        <div class="stat-card">
            <div class="stat-icon gold">
                <i class="fas fa-calendar-check"></i>
            </div>
            <div class="stat-content">
                <h3>${not empty stats ? stats.totalBookings : 0}</h3>
                <p>Total Bookings</p>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-4 col-xl-2">
        <div class="stat-card">
            <div class="stat-icon teal">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-content">
                <h3>${not empty stats ? stats.confirmedBookings : 0}</h3>
                <p>Confirmed</p>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-4 col-xl-2">
        <div class="stat-card">
            <div class="stat-icon orange">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-content">
                <h3>${not empty stats ? stats.pendingBookings : 0}</h3>
                <p>Pending</p>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-4 col-xl-2">
        <div class="stat-card">
            <div class="stat-icon blue">
                <i class="fas fa-envelope"></i>
            </div>
            <div class="stat-content">
                <h3>${not empty stats ? stats.totalEnquiries : 0}</h3>
                <p>Enquiries</p>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-4 col-xl-2">
        <div class="stat-card">
            <div class="stat-icon red">
                <i class="fas fa-hourglass-half"></i>
            </div>
            <div class="stat-content">
                <h3>${not empty stats ? stats.pendingEnquiries : 0}</h3>
                <p>Awaiting Reply</p>
            </div>
        </div>
    </div>
</div>

<!-- Quick Actions -->
<div class="row g-4 mb-4">
    <div class="col-12">
        <div class="dashboard-card">
            <div class="card-header-custom">
                <h3 class="card-title">
                    <i class="fas fa-bolt"></i> Quick Actions
                </h3>
            </div>
            <div class="card-body-custom">
                <div class="row g-3">
                    <div class="col-6 col-md-3">
                        <a href="${pageContext.request.contextPath}/user/hospitals" class="quick-action-btn">
                            <div class="action-icon">
                                <i class="fas fa-search"></i>
                            </div>
                            <span>Find Hospitals</span>
                        </a>
                    </div>
                    <div class="col-6 col-md-3">
                        <a href="${pageContext.request.contextPath}/doctors" class="quick-action-btn">
                            <div class="action-icon">
                                <i class="fas fa-user-md"></i>
                            </div>
                            <span>Find Doctors</span>
                        </a>
                    </div>
                    <div class="col-6 col-md-3">
                        <a href="${pageContext.request.contextPath}/user/bookings" class="quick-action-btn">
                            <div class="action-icon">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                            <span>My Bookings</span>
                        </a>
                    </div>
                    <div class="col-6 col-md-3">
                        <a href="${pageContext.request.contextPath}/user/products" class="quick-action-btn">
                            <div class="action-icon">
                                <i class="fas fa-shopping-bag"></i>
                            </div>
                            <span>Shop Products</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Recent Activity Section -->
<div class="row g-4 mb-4">
    <!-- Recent Bookings -->
    <div class="col-lg-6">
        <div class="dashboard-card h-100">
            <div class="card-header-custom">
                <h3 class="card-title">
                    <i class="fas fa-calendar-check"></i> Recent Bookings
                </h3>
                <a href="${pageContext.request.contextPath}/user/bookings" class="btn-outline-gold btn-sm">
                    View All <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            <div class="card-body-custom">
                <c:choose>
                    <c:when test="${not empty recentBookings}">
                        <c:forEach var="booking" items="${recentBookings}" end="3">
                            <div class="list-item">
                                <div class="list-item-content">
                                    <h4>${booking.treatmentPackage != null ? booking.treatmentPackage.packageName : 'General Booking'}</h4>
                                    <p><i class="fas fa-hospital me-1"></i> ${booking.hospital.centerName}</p>
                                </div>
                                <div class="list-item-meta text-end">
                                    <c:choose>
                                        <c:when test="${booking.status == 'PENDING'}">
                                            <span class="badge-status badge-pending">Pending</span>
                                        </c:when>
                                        <c:when test="${booking.status == 'CONFIRMED'}">
                                            <span class="badge-status badge-confirmed">Confirmed</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-status badge-cancelled">${booking.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="mt-2">
                                        <strong style="color: var(--primary-green);">₹<fmt:formatNumber value="${booking.totalAmount != null ? booking.totalAmount : 0}" maxFractionDigits="0"/></strong>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-state-icon">
                                <i class="fas fa-calendar-times"></i>
                            </div>
                            <h4>No Bookings Yet</h4>
                            <p>Start by exploring our Ayurvedic centers and book your first wellness package.</p>
                            <a href="${pageContext.request.contextPath}/user/hospitals" class="btn-gold btn-sm">
                                <i class="fas fa-search"></i> Explore Now
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Recent Enquiries -->
    <div class="col-lg-6">
        <div class="dashboard-card h-100">
            <div class="card-header-custom">
                <h3 class="card-title">
                    <i class="fas fa-envelope"></i> Recent Enquiries
                </h3>
                <a href="${pageContext.request.contextPath}/user/enquiries" class="btn-outline-gold btn-sm">
                    View All <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            <div class="card-body-custom">
                <c:choose>
                    <c:when test="${not empty recentEnquiries}">
                        <c:forEach var="enquiry" items="${recentEnquiries}" end="3">
                            <div class="list-item" style="border-left-color: var(--primary-green);">
                                <div class="list-item-content">
                                    <h4>${enquiry.hospital.centerName}</h4>
                                    <p>
                                        <c:choose>
                                            <c:when test="${not empty enquiry.therapyRequired}">
                                                ${fn:substring(enquiry.therapyRequired, 0, 40)}${fn:length(enquiry.therapyRequired) > 40 ? '...' : ''}
                                            </c:when>
                                            <c:otherwise>
                                                General enquiry
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                <div class="list-item-meta text-end">
                                    <c:choose>
                                        <c:when test="${enquiry.status == 'PENDING'}">
                                            <span class="badge-status badge-pending">Pending</span>
                                        </c:when>
                                        <c:when test="${enquiry.status == 'REPLIED'}">
                                            <span class="badge-status badge-replied">Replied</span>
                                        </c:when>
                                        <c:when test="${enquiry.status == 'QUOTATION_SENT'}">
                                            <span class="badge-status badge-confirmed">Quotation</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-status badge-cancelled">${enquiry.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="mt-2">
                                        <a href="${pageContext.request.contextPath}/user/enquiry/details/${enquiry.id}" class="btn-outline-gold btn-sm" style="padding: 5px 12px; font-size: 12px;">
                                            View
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-state-icon">
                                <i class="fas fa-envelope-open"></i>
                            </div>
                            <h4>No Enquiries Yet</h4>
                            <p>Have questions? Send an enquiry to any Ayurvedic center.</p>
                            <a href="${pageContext.request.contextPath}/user/hospitals" class="btn-gold btn-sm">
                                <i class="fas fa-hospital"></i> Browse Centers
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Saved Centers Section -->
<div class="row g-4">
    <div class="col-12">
        <div class="dashboard-card">
            <div class="card-header-custom">
                <h3 class="card-title">
                    <i class="fas fa-heart"></i> Saved Centers
                </h3>
                <a href="${pageContext.request.contextPath}/user/saved-centers" class="btn-outline-gold btn-sm">
                    View All <i class="fas fa-arrow-right"></i>
                </a>
            </div>
            <div class="card-body-custom">
                <c:choose>
                    <c:when test="${not empty savedCenters}">
                        <div class="row g-4">
                            <c:forEach var="saved" items="${savedCenters}" end="3">
                                <div class="col-md-6 col-xl-3">
                                    <div class="saved-center-card">
                                        <div class="center-header">
                                            <span class="center-type">${saved.hospital.centerType}</span>
                                            <button class="btn-favorite active">
                                                <i class="fas fa-heart"></i>
                                            </button>
                                        </div>
                                        <h4 class="center-name">${saved.hospital.centerName}</h4>
                                        <p class="center-location">
                                            <i class="fas fa-map-marker-alt"></i> ${saved.hospital.city}, ${saved.hospital.state}
                                        </p>
                                        <c:if test="${not empty saved.hospital.averageRating}">
                                            <div class="center-rating">
                                                <i class="fas fa-star"></i>
                                                <strong>${saved.hospital.averageRating}</strong>
                                                <span>(${saved.hospital.totalReviews} reviews)</span>
                                            </div>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/hospital/profile/${saved.hospital.id}" class="btn-view-center">
                                            View Profile <i class="fas fa-arrow-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-state-icon">
                                <i class="fas fa-heart"></i>
                            </div>
                            <h4>No Saved Centers</h4>
                            <p>Start exploring and save your favorite Ayurvedic centers for quick access.</p>
                            <a href="${pageContext.request.contextPath}/user/hospitals" class="btn-gold">
                                <i class="fas fa-search"></i> Explore Centers
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<style>
    /* Quick Actions */
    .quick-action-btn {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 12px;
        padding: 25px 15px;
        background: var(--bg-light);
        border-radius: 16px;
        text-decoration: none;
        transition: all 0.3s ease;
        border: 2px solid transparent;
    }
    
    .quick-action-btn:hover {
        background: #fff;
        border-color: var(--accent-gold);
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(201, 162, 39, 0.15);
    }
    
    .quick-action-btn .action-icon {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        color: var(--primary-dark);
        transition: all 0.3s ease;
    }
    
    .quick-action-btn:hover .action-icon {
        transform: scale(1.1);
    }
    
    .quick-action-btn span {
        font-weight: 600;
        color: var(--primary-dark);
        font-size: 14px;
    }
    
    /* Saved Center Cards */
    .saved-center-card {
        background: var(--bg-light);
        border-radius: 16px;
        padding: 20px;
        transition: all 0.3s ease;
        border: 1px solid transparent;
        height: 100%;
    }
    
    .saved-center-card:hover {
        background: #fff;
        border-color: rgba(201, 162, 39, 0.3);
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    }
    
    .center-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }
    
    .center-type {
        background: var(--primary-green);
        color: #fff;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
    }
    
    .btn-favorite {
        background: none;
        border: none;
        font-size: 18px;
        color: #dc3545;
        cursor: pointer;
    }
    
    .center-name {
        font-size: 18px;
        color: var(--primary-dark);
        margin-bottom: 8px;
        font-family: 'Poppins', sans-serif;
        font-weight: 600;
    }
    
    .center-location {
        color: #888;
        font-size: 13px;
        margin-bottom: 10px;
    }
    
    .center-location i {
        color: var(--primary-green);
        margin-right: 5px;
    }
    
    .center-rating {
        display: flex;
        align-items: center;
        gap: 5px;
        margin-bottom: 15px;
        font-size: 14px;
    }
    
    .center-rating i {
        color: var(--accent-gold);
    }
    
    .center-rating strong {
        color: var(--primary-dark);
    }
    
    .center-rating span {
        color: #888;
        font-size: 12px;
    }
    
    .btn-view-center {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        width: 100%;
        padding: 12px;
        background: var(--primary-green);
        color: #fff;
        border-radius: 10px;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s ease;
    }
    
    .btn-view-center:hover {
        background: var(--primary-dark);
        color: #fff;
    }
    
    .btn-sm {
        padding: 8px 16px !important;
        font-size: 13px !important;
    }
</style>

        </div>
    </main>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Sidebar Toggle
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebarOverlay = document.getElementById('sidebarOverlay');
        
        sidebarToggle.addEventListener('click', () => {
            sidebar.classList.toggle('active');
            sidebarOverlay.classList.toggle('active');
        });
        
        sidebarOverlay.addEventListener('click', () => {
            sidebar.classList.remove('active');
            sidebarOverlay.classList.remove('active');
        });
    </script>
</body>
</html>
