<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Room - ${room.roomName}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .booking-page {
            min-height: 100vh;
            background: var(--neutral-sand);
            padding: 100px 0 var(--spacing-3xl);
        }
        
        .booking-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 var(--spacing-xl);
        }
        
        .booking-header {
            text-align: center;
            margin-bottom: var(--spacing-2xl);
        }
        
        .room-summary {
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-lg);
            margin-bottom: var(--spacing-xl);
            box-shadow: var(--shadow-sm);
            display: grid;
            grid-template-columns: 200px 1fr;
            gap: var(--spacing-lg);
        }
        
        .room-summary-image {
            width: 100%;
            height: 150px;
            border-radius: var(--radius-md);
            background: var(--neutral-sand);
            overflow: hidden;
        }
        
        .room-summary-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .room-summary-info h3 {
            margin: 0 0 var(--spacing-sm) 0;
            color: var(--primary-forest);
        }
        
        .room-summary-info .price {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-forest);
            margin-top: var(--spacing-sm);
        }
        
        .booking-form {
            background: white;
            border-radius: var(--radius-xl);
            padding: var(--spacing-2xl);
            box-shadow: var(--shadow-md);
        }
        
        .form-section {
            margin-bottom: var(--spacing-2xl);
        }
        
        .form-section h3 {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-lg);
            padding-bottom: var(--spacing-md);
            border-bottom: 2px solid var(--neutral-sand);
        }
        
        .form-section h3 i {
            width: 40px;
            height: 40px;
            background: var(--primary-sage);
            border-radius: var(--radius-full);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-forest);
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: var(--spacing-lg);
        }
        
        .form-group {
            margin-bottom: var(--spacing-lg);
        }
        
        .form-label {
            display: block;
            margin-bottom: var(--spacing-xs);
            font-weight: 600;
            color: var(--text-dark);
        }
        
        .form-label.required::after {
            content: " *";
            color: var(--accent-coral);
        }
        
        .form-input, .form-select, .form-textarea {
            width: 100%;
            padding: var(--spacing-md);
            border: 2px solid var(--neutral-stone);
            border-radius: var(--radius-md);
            font-size: 1rem;
            transition: border-color var(--transition-fast);
        }
        
        .form-input:focus, .form-select:focus, .form-textarea:focus {
            outline: none;
            border-color: var(--primary-forest);
        }
        
        .form-textarea {
            min-height: 100px;
            resize: vertical;
        }
        
        .booking-summary {
            background: var(--neutral-sand);
            border-radius: var(--radius-lg);
            padding: var(--spacing-lg);
            margin-top: var(--spacing-xl);
        }
        
        .booking-summary h4 {
            margin-bottom: var(--spacing-md);
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: var(--spacing-sm);
        }
        
        .summary-total {
            display: flex;
            justify-content: space-between;
            margin-top: var(--spacing-md);
            padding-top: var(--spacing-md);
            border-top: 2px solid var(--primary-forest);
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary-forest);
        }
        
        .btn-submit {
            width: 100%;
            padding: var(--spacing-lg);
            background: var(--primary-forest);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: var(--spacing-xl);
            transition: background var(--transition-fast);
        }
        
        .btn-submit:hover {
            background: var(--primary-sage);
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/layouts/base.jsp">
        <jsp:param name="activeNav" value="hospitals"/>
    </jsp:include>

    <div class="booking-page">
        <div class="booking-container">
            <div class="booking-header">
                <h1>Book Your Room</h1>
                <p>Complete your booking details below</p>
            </div>
            
            <div class="room-summary">
                <div class="room-summary-image">
                    <c:choose>
                        <c:when test="${not empty room.imageUrls}">
                            <c:forTokens items="${room.imageUrls}" delims="," var="imageUrl" varStatus="status">
                                <c:if test="${status.first}">
                                    <img src="${pageContext.request.contextPath}${fn:trim(imageUrl)}" alt="${room.roomName}">
                                </c:if>
                            </c:forTokens>
                        </c:when>
                        <c:otherwise>
                            <div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
                                <i class="fas fa-bed" style="font-size: 3rem; color: var(--text-muted);"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="room-summary-info">
                    <h3>${room.roomName}</h3>
                    <p style="color: var(--text-medium); margin-bottom: var(--spacing-xs);">${room.roomType}</p>
                    <c:if test="${room.maxOccupancy != null}">
                        <p style="color: var(--text-muted); font-size: 0.9rem; margin-bottom: var(--spacing-xs);">
                            <i class="fas fa-users"></i> Up to ${room.maxOccupancy} guests
                        </p>
                    </c:if>
                    <div class="price">
                        ₹<fmt:formatNumber value="${room.pricePerNight != null ? room.pricePerNight : 0}" maxFractionDigits="0"/>/night
                    </div>
                </div>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <form class="booking-form" action="${pageContext.request.contextPath}<c:choose><c:when test="${not empty sessionScope.SPRING_SECURITY_CONTEXT}">/user/room/booking/${room.id}</c:when><c:otherwise>/room/booking/${room.id}</c:otherwise></c:choose>" method="post" id="bookingForm">
                <!-- Dates -->
                <div class="form-section">
                    <h3><i class="fas fa-calendar-alt"></i> Select Dates</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Check-in Date</label>
                            <input type="date" name="checkInDate" class="form-input" id="checkInDate" 
                                   value="${checkIn}" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label required">Check-out Date</label>
                            <input type="date" name="checkOutDate" class="form-input" id="checkOutDate" 
                                   value="${checkOut}" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label required">Number of Guests</label>
                        <select name="numberOfGuests" class="form-select" required>
                            <option value="1">1 Guest</option>
                            <option value="2">2 Guests</option>
                            <option value="3">3 Guests</option>
                            <option value="4">4 Guests</option>
                            <c:if test="${room.maxOccupancy != null && room.maxOccupancy > 4}">
                                <option value="5">5+ Guests</option>
                            </c:if>
                        </select>
                    </div>
                </div>
                
                <!-- Guest Information -->
                <div class="form-section">
                    <h3><i class="fas fa-user"></i> Guest Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Full Name</label>
                            <input type="text" name="guestName" class="form-input" placeholder="Your full name" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label required">Email</label>
                            <input type="email" name="guestEmail" class="form-input" placeholder="your@email.com" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Phone Number</label>
                            <input type="tel" name="guestPhone" class="form-input" placeholder="+91 98765 43210" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Country</label>
                            <input type="text" name="guestCountry" class="form-input" placeholder="India" value="India">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Special Requests</label>
                        <textarea name="specialRequests" class="form-textarea" 
                                  placeholder="Any special requests or requirements..."></textarea>
                    </div>
                </div>
                
                <!-- Booking Summary -->
                <div class="booking-summary">
                    <h4>Booking Summary</h4>
                    <div class="summary-row">
                        <span>Room Rate (per night):</span>
                        <span>₹<fmt:formatNumber value="${room.pricePerNight != null ? room.pricePerNight : 0}" maxFractionDigits="0"/></span>
                    </div>
                    <div class="summary-row">
                        <span>Number of Nights:</span>
                        <span id="nightsCount">-</span>
                    </div>
                    <div class="summary-total">
                        <span>Total Amount:</span>
                        <span id="totalAmount">₹0</span>
                    </div>
                </div>
                
                <button type="submit" class="btn-submit">
                    <i class="fas fa-check-circle"></i> Confirm Booking
                </button>
            </form>
        </div>
    </div>

    <script>
        // Set minimum date to today
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const todayStr = today.toISOString().split('T')[0];
        document.getElementById('checkInDate').setAttribute('min', todayStr);
        
        // Set default check-in to tomorrow if not pre-filled
        if (!document.getElementById('checkInDate').value) {
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            document.getElementById('checkInDate').value = tomorrow.toISOString().split('T')[0];
        }
        
        // Calculate nights and total
        function calculateTotal() {
            const checkIn = document.getElementById('checkInDate').value;
            const checkOut = document.getElementById('checkOutDate').value;
            const pricePerNight = ${room.pricePerNight != null ? room.pricePerNight : 0};
            
            if (checkIn && checkOut) {
                const checkInDate = new Date(checkIn);
                const checkOutDate = new Date(checkOut);
                
                if (checkOutDate > checkInDate) {
                    const diffTime = Math.abs(checkOutDate - checkInDate);
                    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                    
                    document.getElementById('nightsCount').textContent = diffDays;
                    document.getElementById('totalAmount').textContent = '₹' + (diffDays * pricePerNight).toLocaleString('en-IN');
                } else {
                    document.getElementById('nightsCount').textContent = '-';
                    document.getElementById('totalAmount').textContent = '₹0';
                }
            }
        }
        
        document.getElementById('checkInDate').addEventListener('change', function() {
            const checkIn = this.value;
            const checkOut = document.getElementById('checkOutDate');
            if (checkIn) {
                checkOut.setAttribute('min', checkIn);
            }
            calculateTotal();
        });
        
        document.getElementById('checkOutDate').addEventListener('change', calculateTotal);
        
        // Initial calculation if dates are pre-filled
        if (document.getElementById('checkInDate').value && document.getElementById('checkOutDate').value) {
            calculateTotal();
        }
    </script>
</body>
</html>

