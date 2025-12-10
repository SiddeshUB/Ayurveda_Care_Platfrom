<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="My Room Bookings"/>
    <jsp:param name="activeNav" value="room-bookings"/>
</jsp:include>

<div class="dashboard-content">
    <div class="page-header">
        <h1><i class="fas fa-bed"></i> My Room Bookings</h1>
        <p>View and manage your room bookings</p>
    </div>

    <c:if test="${not empty bookings}">
        <div class="bookings-list">
            <c:forEach var="booking" items="${bookings}">
                <div class="booking-card">
                    <div class="booking-header">
                        <div class="booking-info">
                            <h3>
                                <a href="${pageContext.request.contextPath}/user/room-booking/details/${booking.id}" 
                                   style="text-decoration: none; color: inherit;">
                                    ${booking.room.roomName}
                                </a>
                            </h3>
                            <p style="color: var(--text-muted); margin: var(--spacing-xs) 0;">
                                <i class="fas fa-hospital"></i> ${booking.hospital.centerName}
                            </p>
                            <p style="color: var(--text-muted); font-size: 0.9rem;">
                                Booking #${booking.bookingNumber}
                            </p>
                        </div>
                        <div class="booking-status">
                            <span class="status-badge status-${fn:toLowerCase(booking.status)}">
                                ${booking.status}
                            </span>
                        </div>
                    </div>
                    
                    <div class="booking-details-grid">
                        <div class="detail-item">
                            <i class="fas fa-calendar-check"></i>
                            <div>
                                <span class="detail-label">Check-in</span>
                                <span class="detail-value">
                                    <%
                                        com.ayurveda.entity.RoomBooking rb = (com.ayurveda.entity.RoomBooking) pageContext.getAttribute("booking");
                                        if (rb != null && rb.getCheckInDate() != null) {
                                            out.print(rb.getCheckInDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                        }
                                    %>
                                </span>
                            </div>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-calendar-times"></i>
                            <div>
                                <span class="detail-label">Check-out</span>
                                <span class="detail-value">
                                    <%
                                        if (rb != null && rb.getCheckOutDate() != null) {
                                            out.print(rb.getCheckOutDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                        }
                                    %>
                                </span>
                            </div>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-moon"></i>
                            <div>
                                <span class="detail-label">Nights</span>
                                <span class="detail-value">${booking.numberOfNights}</span>
                            </div>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-users"></i>
                            <div>
                                <span class="detail-label">Guests</span>
                                <span class="detail-value">${booking.numberOfGuests != null ? booking.numberOfGuests : '-'}</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="booking-footer">
                        <div class="booking-price">
                            <span class="price-label">Total Amount:</span>
                            <span class="price-value">
                                ₹<fmt:formatNumber value="${booking.totalAmount != null ? booking.totalAmount : 0}" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <a href="${pageContext.request.contextPath}/user/room-booking/details/${booking.id}" 
                           class="btn btn-outline">
                            View Details <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty bookings}">
        <div class="empty-state">
            <i class="fas fa-bed" style="font-size: 4rem; color: var(--text-muted); margin-bottom: var(--spacing-lg);"></i>
            <h3>No Room Bookings Yet</h3>
            <p style="color: var(--text-medium); margin-bottom: var(--spacing-xl);">
                You haven't made any room bookings yet. Start exploring hospitals and book your stay!
            </p>
            <a href="${pageContext.request.contextPath}/user/hospitals" class="btn">
                <i class="fas fa-search"></i> Browse Hospitals
            </a>
        </div>
    </c:if>
</div>

<style>
    .bookings-list {
        display: flex;
        flex-direction: column;
        gap: var(--spacing-lg);
    }
    
    .booking-card {
        background: white;
        border-radius: var(--radius-lg);
        padding: var(--spacing-xl);
        box-shadow: var(--shadow-sm);
        transition: box-shadow var(--transition-fast);
    }
    
    .booking-card:hover {
        box-shadow: var(--shadow-md);
    }
    
    .booking-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: var(--spacing-lg);
        padding-bottom: var(--spacing-lg);
        border-bottom: 1px solid var(--neutral-sand);
    }
    
    .booking-info h3 {
        margin: 0 0 var(--spacing-xs) 0;
        color: var(--primary-forest);
    }
    
    .status-badge {
        padding: var(--spacing-xs) var(--spacing-md);
        border-radius: var(--radius-full);
        font-size: 0.85rem;
        font-weight: 600;
        text-transform: uppercase;
    }
    
    .status-badge.status-pending {
        background: #FFF3CD;
        color: #856404;
    }
    
    .status-badge.status-confirmed {
        background: #D4EDDA;
        color: #155724;
    }
    
    .status-badge.status-cancelled {
        background: #F8D7DA;
        color: #721C24;
    }
    
    .status-badge.status-completed {
        background: #D1ECF1;
        color: #0C5460;
    }
    
    .booking-details-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        gap: var(--spacing-md);
        margin-bottom: var(--spacing-lg);
    }
    
    .detail-item {
        display: flex;
        align-items: center;
        gap: var(--spacing-sm);
    }
    
    .detail-item i {
        color: var(--primary-forest);
        font-size: 1.25rem;
    }
    
    .detail-label {
        display: block;
        font-size: 0.85rem;
        color: var(--text-muted);
        margin-bottom: var(--spacing-xs);
    }
    
    .detail-value {
        display: block;
        font-weight: 600;
        color: var(--text-dark);
    }
    
    .booking-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: var(--spacing-lg);
        border-top: 1px solid var(--neutral-sand);
    }
    
    .booking-price {
        display: flex;
        flex-direction: column;
    }
    
    .price-label {
        font-size: 0.85rem;
        color: var(--text-muted);
        margin-bottom: var(--spacing-xs);
    }
    
    .price-value {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--primary-forest);
    }
    
    .empty-state {
        text-align: center;
        padding: var(--spacing-3xl) var(--spacing-xl);
        background: white;
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow-sm);
    }
</style>

<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-footer.jsp"/>

