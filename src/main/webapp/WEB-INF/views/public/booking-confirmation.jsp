<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed - AyurVedaCare</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .confirmation-page {
            min-height: 100vh;
            background: var(--neutral-sand);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: var(--spacing-3xl) var(--spacing-xl);
        }
        
        .confirmation-card {
            background: white;
            border-radius: var(--radius-xl);
            padding: var(--spacing-3xl);
            max-width: 600px;
            width: 100%;
            text-align: center;
            box-shadow: var(--shadow-lg);
        }
        
        .success-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, var(--success), #66BB6A);
            border-radius: var(--radius-full);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto var(--spacing-xl);
        }
        
        .success-icon i {
            font-size: 3rem;
            color: white;
        }
        
        .confirmation-card h1 {
            color: var(--success);
            margin-bottom: var(--spacing-md);
        }
        
        .confirmation-card .lead {
            font-size: 1.1rem;
            color: var(--text-medium);
            margin-bottom: var(--spacing-xl);
        }
        
        .booking-ref {
            background: var(--neutral-sand);
            padding: var(--spacing-lg);
            border-radius: var(--radius-md);
            margin-bottom: var(--spacing-xl);
        }
        
        .booking-ref label {
            font-size: 0.875rem;
            color: var(--text-muted);
            display: block;
            margin-bottom: var(--spacing-xs);
        }
        
        .booking-ref .ref-number {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-forest);
            font-family: monospace;
        }
        
        .booking-details {
            text-align: left;
            background: var(--neutral-sand);
            padding: var(--spacing-lg);
            border-radius: var(--radius-md);
            margin-bottom: var(--spacing-xl);
        }
        
        .booking-details h4 {
            margin-bottom: var(--spacing-md);
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: var(--spacing-sm) 0;
            border-bottom: 1px solid var(--neutral-stone);
        }
        
        .detail-row:last-child {
            border-bottom: none;
        }
        
        .detail-row .label {
            color: var(--text-muted);
        }
        
        .detail-row .value {
            font-weight: 500;
        }
        
        .next-steps {
            text-align: left;
            margin-bottom: var(--spacing-xl);
        }
        
        .next-steps h4 {
            margin-bottom: var(--spacing-md);
        }
        
        .next-steps ul {
            list-style: none;
            padding: 0;
        }
        
        .next-steps li {
            display: flex;
            align-items: flex-start;
            gap: var(--spacing-md);
            padding: var(--spacing-sm) 0;
            color: var(--text-medium);
        }
        
        .next-steps li i {
            color: var(--primary-sage);
            margin-top: 3px;
        }
        
        .actions {
            display: flex;
            gap: var(--spacing-md);
            justify-content: center;
        }
    </style>
</head>
<body>
    <div class="confirmation-page">
        <div class="confirmation-card">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            
            <h1>Booking Enquiry Submitted!</h1>
            <p class="lead">Thank you for your interest. The center will review your request and contact you shortly.</p>
            
            <div class="booking-ref">
                <label>Your Booking Reference</label>
                <div class="ref-number">${booking.bookingNumber}</div>
            </div>
            
            <div class="booking-details">
                <h4>Booking Summary</h4>
                <div class="detail-row">
                    <span class="label">Center</span>
                    <span class="value">${booking.hospital.centerName}</span>
                </div>
                <c:if test="${booking.treatmentPackage != null}">
                    <div class="detail-row">
                        <span class="label">Package</span>
                        <span class="value">${booking.treatmentPackage.packageName}</span>
                    </div>
                </c:if>
                <%
                    com.ayurveda.entity.Booking bookingObj = (com.ayurveda.entity.Booking) request.getAttribute("booking");
                %>
                <div class="detail-row">
                    <span class="label">Check-in Date</span>
                    <span class="value">
                        <%
                            if (bookingObj != null && bookingObj.getCheckInDate() != null) {
                                out.print(bookingObj.getCheckInDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                            } else {
                                out.print("-");
                            }
                        %>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="label">Check-out Date</span>
                    <span class="value">
                        <%
                            if (bookingObj != null && bookingObj.getCheckOutDate() != null) {
                                out.print(bookingObj.getCheckOutDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                            } else {
                                out.print("-");
                            }
                        %>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="label">Room Type</span>
                    <span class="value">${booking.roomType}</span>
                </div>
                <div class="detail-row">
                    <span class="label">Status</span>
                    <span class="value"><span class="badge badge-warning">${booking.status}</span></span>
                </div>
                <c:if test="${booking.totalAmount != null && booking.totalAmount > 0}">
                    <div class="detail-row">
                        <span class="label">Total Amount</span>
                        <span class="value" style="font-size: 1.25rem; color: var(--primary-forest); font-weight: 700;">
                            ₹<fmt:formatNumber value="${booking.totalAmount}" maxFractionDigits="0"/>
                        </span>
                    </div>
                </c:if>
                <c:if test="${booking.paymentStatus != null}">
                    <div class="detail-row">
                        <span class="label">Payment Status</span>
                        <span class="value">
                            <c:choose>
                                <c:when test="${booking.paymentStatus == 'PAID'}">
                                    <span class="badge badge-success">Paid</span>
                                </c:when>
                                <c:when test="${booking.paymentStatus == 'PARTIAL'}">
                                    <span class="badge badge-warning">Partial</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-danger">Pending</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </c:if>
            </div>
            
            <c:choose>
                <c:when test="${booking.status == 'CONFIRMED' && booking.paymentStatus != 'PAID' && booking.totalAmount != null && booking.totalAmount > 0}">
                    <div class="payment-section" style="background: linear-gradient(135deg, rgba(201, 162, 39, 0.1), rgba(45, 74, 45, 0.1)); padding: var(--spacing-xl); border-radius: var(--radius-md); margin-bottom: var(--spacing-xl); text-align: center;">
                        <h4 style="margin-bottom: var(--spacing-md); color: var(--primary-forest);">
                            <i class="fas fa-credit-card"></i> Complete Your Payment
                        </h4>
                        <p style="color: var(--text-medium); margin-bottom: var(--spacing-lg);">
                            Your booking has been confirmed! Please complete the payment to secure your reservation.
                        </p>
                        <form action="${pageContext.request.contextPath}/payment/booking/initiate" method="post" style="display: inline;">
                            <input type="hidden" name="bookingNumber" value="${booking.bookingNumber}">
                            <button type="submit" class="btn btn-primary" style="padding: 15px 40px; font-size: 1.1rem; font-weight: 600;">
                                <i class="fas fa-lock"></i> Pay ₹<fmt:formatNumber value="${booking.totalAmount}" maxFractionDigits="0"/>
                            </button>
                        </form>
                    </div>
                </c:when>
                <c:when test="${booking.status == 'CONFIRMED' && booking.paymentStatus == 'PAID'}">
                    <div class="payment-section" style="background: rgba(16, 185, 129, 0.1); padding: var(--spacing-xl); border-radius: var(--radius-md); margin-bottom: var(--spacing-xl); text-align: center;">
                        <h4 style="margin-bottom: var(--spacing-md); color: var(--success);">
                            <i class="fas fa-check-circle"></i> Payment Completed
                        </h4>
                        <p style="color: var(--text-medium);">
                            Your payment has been successfully processed. Your booking is confirmed!
                        </p>
                    </div>
                </c:when>
            </c:choose>
            
            <div class="next-steps">
                <h4>What happens next?</h4>
                <ul>
                    <c:choose>
                        <c:when test="${booking.status == 'PENDING'}">
                            <li>
                                <i class="fas fa-check-circle"></i>
                                <span>The center will review your request within 24-48 hours</span>
                            </li>
                            <li>
                                <i class="fas fa-phone"></i>
                                <span>You'll receive a confirmation call or email</span>
                            </li>
                            <li>
                                <i class="fas fa-calendar-check"></i>
                                <span>Once confirmed, you'll receive detailed check-in instructions</span>
                            </li>
                        </c:when>
                        <c:when test="${booking.status == 'CONFIRMED' && booking.paymentStatus != 'PAID'}">
                            <li>
                                <i class="fas fa-credit-card"></i>
                                <span>Complete your payment to secure your booking</span>
                            </li>
                            <li>
                                <i class="fas fa-envelope"></i>
                                <span>You'll receive a confirmation email after payment</span>
                            </li>
                            <li>
                                <i class="fas fa-calendar-check"></i>
                                <span>Check-in instructions will be sent to your email</span>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <i class="fas fa-check-circle"></i>
                                <span>Your booking is confirmed and payment is complete</span>
                            </li>
                            <li>
                                <i class="fas fa-envelope"></i>
                                <span>Check your email for detailed check-in instructions</span>
                            </li>
                            <li>
                                <i class="fas fa-phone"></i>
                                <span>Contact the center if you have any questions</span>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            
            <div class="actions">
                <a href="${pageContext.request.contextPath}/hospital/profile/${booking.hospital.id}" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Center
                </a>
                <c:if test="${booking.user != null}">
                    <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-primary">
                        <i class="fas fa-user"></i> My Dashboard
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                    <i class="fas fa-home"></i> Go Home
                </a>
            </div>
        </div>
    </div>
</body>
</html>

