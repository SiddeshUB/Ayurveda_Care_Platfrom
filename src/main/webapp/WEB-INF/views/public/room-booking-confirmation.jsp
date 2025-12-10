<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation - ${booking.bookingNumber}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .confirmation-page {
            min-height: 100vh;
            background: var(--neutral-sand);
            padding: 100px 0 var(--spacing-3xl);
        }
        
        .confirmation-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 0 var(--spacing-xl);
        }
        
        .confirmation-card {
            background: white;
            border-radius: var(--radius-xl);
            padding: var(--spacing-2xl);
            box-shadow: var(--shadow-md);
            text-align: center;
            margin-bottom: var(--spacing-xl);
        }
        
        .success-icon {
            width: 100px;
            height: 100px;
            background: var(--primary-sage);
            border-radius: var(--radius-full);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto var(--spacing-lg);
            color: white;
            font-size: 3rem;
        }
        
        .confirmation-card h1 {
            color: var(--primary-forest);
            margin-bottom: var(--spacing-sm);
        }
        
        .confirmation-card p {
            color: var(--text-medium);
            font-size: 1.1rem;
        }
        
        .booking-details {
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-xl);
            box-shadow: var(--shadow-sm);
            margin-bottom: var(--spacing-lg);
        }
        
        .booking-details h2 {
            margin-bottom: var(--spacing-lg);
            color: var(--primary-forest);
        }
        
        .detail-section {
            margin-bottom: var(--spacing-lg);
            padding-bottom: var(--spacing-lg);
            border-bottom: 1px solid var(--neutral-sand);
        }
        
        .detail-section:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        
        .detail-section h3 {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            margin-bottom: var(--spacing-md);
            color: var(--text-dark);
            font-size: 1rem;
        }
        
        .detail-section h3 i {
            color: var(--primary-forest);
        }
        
        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: var(--spacing-md);
        }
        
        .detail-item {
            display: flex;
            flex-direction: column;
        }
        
        .detail-label {
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-bottom: var(--spacing-xs);
        }
        
        .detail-value {
            font-weight: 600;
            color: var(--text-dark);
        }
        
        .status-badge {
            display: inline-block;
            padding: var(--spacing-xs) var(--spacing-md);
            border-radius: var(--radius-full);
            font-size: 0.9rem;
            font-weight: 600;
        }
        
        .status-badge.pending {
            background: #FFF3CD;
            color: #856404;
        }
        
        .status-badge.confirmed {
            background: #D4EDDA;
            color: #155724;
        }
        
        .action-buttons {
            display: flex;
            gap: var(--spacing-md);
            justify-content: center;
            margin-top: var(--spacing-xl);
        }
        
        .btn {
            padding: var(--spacing-md) var(--spacing-xl);
            border-radius: var(--radius-md);
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: var(--spacing-sm);
            transition: all var(--transition-fast);
        }
        
        .btn-primary {
            background: var(--primary-forest);
            color: white;
        }
        
        .btn-primary:hover {
            background: var(--primary-sage);
        }
        
        .btn-outline {
            background: white;
            color: var(--primary-forest);
            border: 2px solid var(--primary-forest);
        }
        
        .btn-outline:hover {
            background: var(--neutral-sand);
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/layouts/base.jsp">
        <jsp:param name="activeNav" value="hospitals"/>
    </jsp:include>

    <div class="confirmation-page">
        <div class="confirmation-container">
            <div class="confirmation-card">
                <div class="success-icon">
                    <i class="fas fa-check"></i>
                </div>
                <h1>Booking Confirmed!</h1>
                <p>Your room booking has been submitted successfully.</p>
                <p style="margin-top: var(--spacing-sm);">
                    <strong>Booking Number:</strong> ${booking.bookingNumber}
                </p>
            </div>
            
            <div class="booking-details">
                <h2>Booking Details</h2>
                
                <div class="detail-section">
                    <h3><i class="fas fa-bed"></i> Room Information</h3>
                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-label">Room Name</span>
                            <span class="detail-value">${booking.room.roomName}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Room Type</span>
                            <span class="detail-value">${booking.room.roomType}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Price per Night</span>
                            <span class="detail-value">₹<fmt:formatNumber value="${booking.pricePerNight != null ? booking.pricePerNight : 0}" maxFractionDigits="0"/></span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Number of Nights</span>
                            <span class="detail-value">${booking.numberOfNights}</span>
                        </div>
                    </div>
                </div>
                
                <div class="detail-section">
                    <h3><i class="fas fa-calendar-alt"></i> Dates</h3>
                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-label">Check-in Date</span>
                            <span class="detail-value"><fmt:formatDate value="${booking.checkInDate}" pattern="dd MMM yyyy"/></span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Check-out Date</span>
                            <span class="detail-value"><fmt:formatDate value="${booking.checkOutDate}" pattern="dd MMM yyyy"/></span>
                        </div>
                    </div>
                </div>
                
                <div class="detail-section">
                    <h3><i class="fas fa-user"></i> Guest Information</h3>
                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-label">Guest Name</span>
                            <span class="detail-value">${booking.guestName}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Email</span>
                            <span class="detail-value">${booking.guestEmail}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Phone</span>
                            <span class="detail-value">${booking.guestPhone}</span>
                        </div>
                        <c:if test="${not empty booking.guestCountry}">
                            <div class="detail-item">
                                <span class="detail-label">Country</span>
                                <span class="detail-value">${booking.guestCountry}</span>
                            </div>
                        </c:if>
                        <c:if test="${booking.numberOfGuests != null}">
                            <div class="detail-item">
                                <span class="detail-label">Number of Guests</span>
                                <span class="detail-value">${booking.numberOfGuests}</span>
                            </div>
                        </c:if>
                    </div>
                </div>
                
                <div class="detail-section">
                    <h3><i class="fas fa-hospital"></i> Hospital</h3>
                    <div class="detail-item">
                        <span class="detail-label">Hospital Name</span>
                        <span class="detail-value">${booking.hospital.centerName}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Location</span>
                        <span class="detail-value">${booking.hospital.city}, ${booking.hospital.state}</span>
                    </div>
                </div>
                
                <div class="detail-section">
                    <h3><i class="fas fa-money-bill-wave"></i> Payment Summary</h3>
                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-label">Total Amount</span>
                            <span class="detail-value" style="font-size: 1.25rem; color: var(--primary-forest);">
                                ₹<fmt:formatNumber value="${booking.totalAmount != null ? booking.totalAmount : 0}" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Status</span>
                            <span class="status-badge ${fn:toLowerCase(booking.status)}">${booking.status}</span>
                        </div>
                    </div>
                </div>
                
                <c:if test="${not empty booking.specialRequests}">
                    <div class="detail-section">
                        <h3><i class="fas fa-comment"></i> Special Requests</h3>
                        <p style="color: var(--text-medium);">${booking.specialRequests}</p>
                    </div>
                </c:if>
            </div>
            
            <div class="action-buttons">
                <c:if test="${booking.user != null}">
                    <a href="${pageContext.request.contextPath}/user/room-booking/details/${booking.id}" class="btn btn-primary">
                        <i class="fas fa-eye"></i> View Booking
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/hospital/profile/${booking.hospital.id}" class="btn btn-outline">
                    <i class="fas fa-arrow-left"></i> Back to Hospital
                </a>
            </div>
        </div>
    </div>
</body>
</html>

