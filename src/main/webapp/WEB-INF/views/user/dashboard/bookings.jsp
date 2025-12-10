<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="My Bookings"/>
    <jsp:param name="activeNav" value="bookings"/>
</jsp:include>

<!-- Page Header -->
<div class="page-header-section">
    <div class="row align-items-center">
        <div class="col">
            <p class="page-subtitle">View and manage your treatment package bookings</p>
        </div>
        <div class="col-auto">
            <a href="${pageContext.request.contextPath}/user/hospitals" class="btn-gold">
                <i class="fas fa-plus"></i> New Booking
            </a>
        </div>
    </div>
</div>

<!-- Bookings Content -->
<c:choose>
    <c:when test="${not empty bookings}">
        <div class="row g-4">
            <c:forEach var="booking" items="${bookings}">
                <%
                    com.ayurveda.entity.Booking b = (com.ayurveda.entity.Booking) pageContext.getAttribute("booking");
                %>
                <div class="col-12">
                    <div class="booking-card">
                        <div class="booking-card-header">
                            <div class="booking-main-info">
                                <h3 class="booking-title">
                                    ${booking.treatmentPackage != null ? booking.treatmentPackage.packageName : 'General Booking'}
                                </h3>
                                <div class="booking-meta">
                                    <span class="meta-item">
                                        <i class="fas fa-hospital"></i> ${booking.hospital.centerName}
                                    </span>
                                    <span class="meta-item">
                                        <i class="fas fa-hashtag"></i> ${booking.bookingNumber}
                                    </span>
                                </div>
                            </div>
                            <div class="booking-status-badge">
                                <c:choose>
                                    <c:when test="${booking.status == 'PENDING'}">
                                        <span class="status-badge pending">
                                            <i class="fas fa-clock"></i> Pending
                                        </span>
                                    </c:when>
                                    <c:when test="${booking.status == 'CONFIRMED'}">
                                        <span class="status-badge confirmed">
                                            <i class="fas fa-check-circle"></i> Confirmed
                                        </span>
                                    </c:when>
                                    <c:when test="${booking.status == 'REJECTED'}">
                                        <span class="status-badge rejected">
                                            <i class="fas fa-times-circle"></i> Rejected
                                        </span>
                                    </c:when>
                                    <c:when test="${booking.status == 'CANCELLED'}">
                                        <span class="status-badge cancelled">
                                            <i class="fas fa-ban"></i> Cancelled
                                        </span>
                                    </c:when>
                                    <c:when test="${booking.status == 'COMPLETED'}">
                                        <span class="status-badge completed">
                                            <i class="fas fa-check-double"></i> Completed
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge">${booking.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="booking-details">
                            <c:if test="${booking.checkInDate != null}">
                                <div class="detail-box">
                                    <div class="detail-icon">
                                        <i class="fas fa-calendar-check"></i>
                                    </div>
                                    <div class="detail-content">
                                        <span class="detail-label">Check-in</span>
                                        <span class="detail-value">
                                            <%
                                                if (b != null && b.getCheckInDate() != null) {
                                                    out.print(b.getCheckInDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                                }
                                            %>
                                        </span>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${booking.checkOutDate != null}">
                                <div class="detail-box">
                                    <div class="detail-icon">
                                        <i class="fas fa-calendar-times"></i>
                                    </div>
                                    <div class="detail-content">
                                        <span class="detail-label">Check-out</span>
                                        <span class="detail-value">
                                            <%
                                                if (b != null && b.getCheckOutDate() != null) {
                                                    out.print(b.getCheckOutDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                                }
                                            %>
                                        </span>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${booking.roomType != null}">
                                <div class="detail-box">
                                    <div class="detail-icon">
                                        <i class="fas fa-bed"></i>
                                    </div>
                                    <div class="detail-content">
                                        <span class="detail-label">Room Type</span>
                                        <span class="detail-value">${booking.roomType}</span>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${booking.numberOfGuests != null}">
                                <div class="detail-box">
                                    <div class="detail-icon">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <div class="detail-content">
                                        <span class="detail-label">Guests</span>
                                        <span class="detail-value">${booking.numberOfGuests}</span>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                        
                        <div class="booking-card-footer">
                            <div class="price-section">
                                <span class="price-label">Total Amount</span>
                                <span class="price-value">₹<fmt:formatNumber value="${booking.totalAmount != null ? booking.totalAmount : 0}" maxFractionDigits="0"/></span>
                            </div>
                            <div class="action-section">
                                <span class="booking-date">
                                    <i class="fas fa-clock"></i>
                                    <%
                                        if (b != null && b.getCreatedAt() != null) {
                                            out.print(b.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                        }
                                    %>
                                </span>
                                <a href="${pageContext.request.contextPath}/booking/confirmation/${booking.bookingNumber}" class="btn-view">
                                    <i class="fas fa-eye"></i> View Details
                                </a>
                            </div>
                        </div>
                        
                        <c:if test="${booking.status == 'CONFIRMED' && booking.hospitalNotes != null && !empty booking.hospitalNotes}">
                            <div class="booking-notes success">
                                <i class="fas fa-info-circle"></i>
                                <div>
                                    <strong>Hospital Notes</strong>
                                    <p>${booking.hospitalNotes}</p>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${booking.status == 'REJECTED' && booking.rejectionReason != null && !empty booking.rejectionReason}">
                            <div class="booking-notes danger">
                                <i class="fas fa-exclamation-triangle"></i>
                                <div>
                                    <strong>Rejection Reason</strong>
                                    <p>${booking.rejectionReason}</p>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="dashboard-card">
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fas fa-calendar-times"></i>
                </div>
                <h4>No Bookings Yet</h4>
                <p>You haven't made any treatment package bookings yet. Start exploring our Ayurvedic centers!</p>
                <a href="${pageContext.request.contextPath}/user/hospitals" class="btn-gold">
                    <i class="fas fa-search"></i> Find Centers
                </a>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<style>
    .page-header-section {
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 1px solid #e9ecef;
    }
    
    .page-subtitle {
        color: #888;
        margin: 0;
        font-size: 15px;
    }
    
    /* Booking Card */
    .booking-card {
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        border: 1px solid rgba(0,0,0,0.03);
        overflow: hidden;
        transition: all 0.3s ease;
    }
    
    .booking-card:hover {
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        transform: translateY(-3px);
    }
    
    .booking-card-header {
        padding: 25px;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 20px;
        border-bottom: 1px solid #f0f0f0;
        background: linear-gradient(to right, rgba(201, 162, 39, 0.03), transparent);
    }
    
    .booking-title {
        font-size: 20px;
        font-weight: 600;
        color: var(--primary-dark);
        margin: 0 0 10px 0;
        font-family: 'Poppins', sans-serif;
    }
    
    .booking-meta {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .meta-item {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
        color: #666;
    }
    
    .meta-item i {
        color: var(--accent-gold);
    }
    
    /* Status Badges */
    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
        border-radius: 30px;
        font-size: 13px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .status-badge.pending {
        background: rgba(255, 193, 7, 0.15);
        color: #d39e00;
    }
    
    .status-badge.confirmed {
        background: rgba(40, 167, 69, 0.15);
        color: #28a745;
    }
    
    .status-badge.rejected {
        background: rgba(220, 53, 69, 0.15);
        color: #dc3545;
    }
    
    .status-badge.cancelled {
        background: rgba(108, 117, 125, 0.15);
        color: #6c757d;
    }
    
    .status-badge.completed {
        background: rgba(23, 162, 184, 0.15);
        color: #17a2b8;
    }
    
    /* Booking Details */
    .booking-details {
        padding: 25px;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        background: var(--bg-light);
    }
    
    .detail-box {
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .detail-icon {
        width: 45px;
        height: 45px;
        border-radius: 12px;
        background: #fff;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--accent-gold);
        font-size: 18px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.08);
    }
    
    .detail-label {
        display: block;
        font-size: 12px;
        color: #888;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 3px;
    }
    
    .detail-value {
        display: block;
        font-size: 15px;
        font-weight: 600;
        color: var(--primary-dark);
    }
    
    /* Booking Footer */
    .booking-card-footer {
        padding: 20px 25px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .price-section {
        display: flex;
        flex-direction: column;
    }
    
    .price-label {
        font-size: 13px;
        color: #888;
    }
    
    .price-value {
        font-size: 26px;
        font-weight: 700;
        color: var(--primary-green);
    }
    
    .action-section {
        display: flex;
        align-items: center;
        gap: 20px;
    }
    
    .booking-date {
        display: flex;
        align-items: center;
        gap: 8px;
        color: #888;
        font-size: 13px;
    }
    
    .booking-date i {
        color: var(--accent-gold);
    }
    
    .btn-view {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        background: var(--primary-green);
        color: #fff;
        border-radius: 10px;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s ease;
    }
    
    .btn-view:hover {
        background: var(--primary-dark);
        color: #fff;
        transform: translateY(-2px);
    }
    
    /* Booking Notes */
    .booking-notes {
        margin: 0 25px 25px;
        padding: 15px 20px;
        border-radius: 12px;
        display: flex;
        gap: 15px;
        align-items: flex-start;
    }
    
    .booking-notes.success {
        background: rgba(40, 167, 69, 0.1);
        border-left: 4px solid #28a745;
    }
    
    .booking-notes.success i {
        color: #28a745;
        font-size: 20px;
        margin-top: 2px;
    }
    
    .booking-notes.danger {
        background: rgba(220, 53, 69, 0.1);
        border-left: 4px solid #dc3545;
    }
    
    .booking-notes.danger i {
        color: #dc3545;
        font-size: 20px;
        margin-top: 2px;
    }
    
    .booking-notes strong {
        display: block;
        font-size: 14px;
        margin-bottom: 5px;
    }
    
    .booking-notes p {
        margin: 0;
        font-size: 14px;
        color: #555;
        line-height: 1.6;
    }
    
    /* Responsive */
    @media (max-width: 767px) {
        .booking-card-header {
            flex-direction: column;
        }
        
        .booking-card-footer {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .action-section {
            width: 100%;
            justify-content: space-between;
        }
        
        .booking-details {
            grid-template-columns: 1fr 1fr;
        }
    }
    
    @media (max-width: 480px) {
        .booking-details {
            grid-template-columns: 1fr;
        }
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
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', () => {
                sidebar.classList.toggle('active');
                sidebarOverlay.classList.toggle('active');
            });
        }
        
        if (sidebarOverlay) {
            sidebarOverlay.addEventListener('click', () => {
                sidebar.classList.remove('active');
                sidebarOverlay.classList.remove('active');
            });
        }
    </script>
</body>
</html>
