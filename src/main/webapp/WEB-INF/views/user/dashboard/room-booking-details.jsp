<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="Room Booking Details"/>
    <jsp:param name="activeNav" value="room-bookings"/>
</jsp:include>

<div class="dashboard-content">
    <div class="page-header">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h1><i class="fas fa-bed"></i> Room Booking Details</h1>
                <p>Booking #${booking.bookingNumber}</p>
            </div>
            <span class="status-badge status-${fn:toLowerCase(booking.status)}">
                ${booking.status}
            </span>
        </div>
    </div>

    <div class="details-grid">
        <!-- Room Information -->
        <div class="detail-card">
            <div class="card-header">
                <h3><i class="fas fa-bed"></i> Room Information</h3>
            </div>
            <div class="card-body">
                <c:if test="${not empty booking.room.imageUrls}">
                    <div class="room-image" style="margin-bottom: var(--spacing-lg);">
                        <c:set var="imageArray" value="${fn:split(booking.room.imageUrls, ',')}" />
                        <img src="${pageContext.request.contextPath}${imageArray[0]}" 
                             alt="${booking.room.roomName}" 
                             style="width: 100%; height: 200px; object-fit: cover; border-radius: var(--radius-md);">
                    </div>
                </c:if>
                <div class="info-item">
                    <span class="info-label">Room Name</span>
                    <span class="info-value">${booking.room.roomName}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Room Type</span>
                    <span class="info-value">${booking.room.roomType}</span>
                </div>
                <c:if test="${booking.room.maxOccupancy != null}">
                    <div class="info-item">
                        <span class="info-label">Max Occupancy</span>
                        <span class="info-value">${booking.room.maxOccupancy} guests</span>
                    </div>
                </c:if>
                <c:if test="${booking.room.bedType != null}">
                    <div class="info-item">
                        <span class="info-label">Bed Type</span>
                        <span class="info-value">${booking.room.bedType}</span>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Booking Dates -->
        <div class="detail-card">
            <div class="card-header">
                <h3><i class="fas fa-calendar-alt"></i> Booking Dates</h3>
            </div>
            <div class="card-body">
                <div class="info-item">
                    <span class="info-label">Check-in Date</span>
                    <span class="info-value">
                        <fmt:formatDate value="${booking.checkInDate}" pattern="EEEE, MMMM dd, yyyy"/>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">Check-out Date</span>
                    <span class="info-value">
                        <fmt:formatDate value="${booking.checkOutDate}" pattern="EEEE, MMMM dd, yyyy"/>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">Number of Nights</span>
                    <span class="info-value">${booking.numberOfNights} nights</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Number of Guests</span>
                    <span class="info-value">${booking.numberOfGuests != null ? booking.numberOfGuests : '-'}</span>
                </div>
            </div>
        </div>

        <!-- Guest Information -->
        <div class="detail-card">
            <div class="card-header">
                <h3><i class="fas fa-user"></i> Guest Information</h3>
            </div>
            <div class="card-body">
                <div class="info-item">
                    <span class="info-label">Guest Name</span>
                    <span class="info-value">${booking.guestName}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Email</span>
                    <span class="info-value">${booking.guestEmail}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Phone</span>
                    <span class="info-value">${booking.guestPhone}</span>
                </div>
                <c:if test="${not empty booking.guestCountry}">
                    <div class="info-item">
                        <span class="info-label">Country</span>
                        <span class="info-value">${booking.guestCountry}</span>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Hospital Information -->
        <div class="detail-card">
            <div class="card-header">
                <h3><i class="fas fa-hospital"></i> Hospital</h3>
            </div>
            <div class="card-body">
                <div class="info-item">
                    <span class="info-label">Hospital Name</span>
                    <span class="info-value">${booking.hospital.centerName}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Location</span>
                    <span class="info-value">${booking.hospital.city}, ${booking.hospital.state}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Phone</span>
                    <span class="info-value">${booking.hospital.phone != null ? booking.hospital.phone : '-'}</span>
                </div>
                <div style="margin-top: var(--spacing-md);">
                    <a href="${pageContext.request.contextPath}/hospital/profile/${booking.hospital.id}" 
                       class="btn btn-outline">
                        <i class="fas fa-external-link-alt"></i> View Hospital Profile
                    </a>
                </div>
            </div>
        </div>

        <!-- Payment Summary -->
        <div class="detail-card">
            <div class="card-header">
                <h3><i class="fas fa-money-bill-wave"></i> Payment Summary</h3>
            </div>
            <div class="card-body">
                <div class="info-item">
                    <span class="info-label">Price per Night</span>
                    <span class="info-value">
                        ₹<fmt:formatNumber value="${booking.pricePerNight != null ? booking.pricePerNight : 0}" maxFractionDigits="0"/>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">Number of Nights</span>
                    <span class="info-value">${booking.numberOfNights}</span>
                </div>
                <div class="info-item" style="border-top: 2px solid var(--primary-forest); padding-top: var(--spacing-md); margin-top: var(--spacing-md);">
                    <span class="info-label" style="font-size: 1.1rem; font-weight: 700;">Total Amount</span>
                    <span class="info-value" style="font-size: 1.5rem; font-weight: 700; color: var(--primary-forest);">
                        ₹<fmt:formatNumber value="${booking.totalAmount != null ? booking.totalAmount : 0}" maxFractionDigits="0"/>
                    </span>
                </div>
            </div>
        </div>

        <!-- Special Requests -->
        <c:if test="${not empty booking.specialRequests}">
            <div class="detail-card">
                <div class="card-header">
                    <h3><i class="fas fa-comment"></i> Special Requests</h3>
                </div>
                <div class="card-body">
                    <p style="color: var(--text-medium); line-height: 1.8;">${booking.specialRequests}</p>
                </div>
            </div>
        </c:if>

        <!-- Booking Timeline -->
        <div class="detail-card">
            <div class="card-header">
                <h3><i class="fas fa-clock"></i> Booking Timeline</h3>
            </div>
            <div class="card-body">
                <div class="timeline-item">
                    <i class="fas fa-calendar-plus"></i>
                    <div>
                        <span class="timeline-label">Booking Created</span>
                        <span class="timeline-value">
                            <fmt:formatDate value="${booking.createdAt}" pattern="MMM dd, yyyy 'at' hh:mm a"/>
                        </span>
                    </div>
                </div>
                <c:if test="${not empty booking.confirmedAt}">
                    <div class="timeline-item">
                        <i class="fas fa-check-circle"></i>
                        <div>
                            <span class="timeline-label">Confirmed</span>
                            <span class="timeline-value">
                                <fmt:formatDate value="${booking.confirmedAt}" pattern="MMM dd, yyyy 'at' hh:mm a"/>
                            </span>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty booking.cancelledAt}">
                    <div class="timeline-item">
                        <i class="fas fa-times-circle"></i>
                        <div>
                            <span class="timeline-label">Cancelled</span>
                            <span class="timeline-value">
                                <fmt:formatDate value="${booking.cancelledAt}" pattern="MMM dd, yyyy 'at' hh:mm a"/>
                            </span>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <div class="action-buttons" style="margin-top: var(--spacing-xl);">
        <a href="${pageContext.request.contextPath}/user/room-bookings" class="btn btn-outline">
            <i class="fas fa-arrow-left"></i> Back to Bookings
        </a>
    </div>
</div>

<style>
    .details-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: var(--spacing-lg);
        margin-bottom: var(--spacing-xl);
    }
    
    .detail-card {
        background: white;
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow-sm);
        overflow: hidden;
    }
    
    .card-header {
        background: var(--primary-forest);
        color: white;
        padding: var(--spacing-lg);
    }
    
    .card-header h3 {
        margin: 0;
        display: flex;
        align-items: center;
        gap: var(--spacing-sm);
        font-size: 1.1rem;
    }
    
    .card-body {
        padding: var(--spacing-lg);
    }
    
    .info-item {
        display: flex;
        flex-direction: column;
        margin-bottom: var(--spacing-md);
    }
    
    .info-item:last-child {
        margin-bottom: 0;
    }
    
    .info-label {
        font-size: 0.85rem;
        color: var(--text-muted);
        margin-bottom: var(--spacing-xs);
    }
    
    .info-value {
        font-weight: 600;
        color: var(--text-dark);
    }
    
    .timeline-item {
        display: flex;
        align-items: flex-start;
        gap: var(--spacing-md);
        margin-bottom: var(--spacing-md);
    }
    
    .timeline-item i {
        color: var(--primary-forest);
        margin-top: var(--spacing-xs);
    }
    
    .timeline-label {
        display: block;
        font-size: 0.85rem;
        color: var(--text-muted);
        margin-bottom: var(--spacing-xs);
    }
    
    .timeline-value {
        display: block;
        font-weight: 600;
        color: var(--text-dark);
    }
    
    .status-badge {
        padding: var(--spacing-xs) var(--spacing-md);
        border-radius: var(--radius-full);
        font-size: 0.9rem;
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
    
    .action-buttons {
        display: flex;
        gap: var(--spacing-md);
    }
</style>

<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-footer.jsp"/>

