<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details - Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body class="dashboard-body">
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
            <a href="${pageContext.request.contextPath}/dashboard/bookings" class="nav-item active">
                <i class="fas fa-calendar-check"></i>
                <span>Bookings</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/enquiries" class="nav-item">
                <i class="fas fa-envelope"></i>
                <span>Enquiries</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/gallery" class="nav-item">
                <i class="fas fa-images"></i>
                <span>Gallery</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/reviews" class="nav-item">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/hospital/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Booking Details</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <%
                com.ayurveda.entity.Booking b = (com.ayurveda.entity.Booking) request.getAttribute("booking");
            %>
            
            <div class="page-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <div>
                    <h2 style="margin: 0;">Booking #${booking.bookingNumber}</h2>
                    <p style="color: var(--text-muted); margin: 0.5rem 0 0;">
                        Created: <%
                            if (b != null && b.getCreatedAt() != null) {
                                out.print(b.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")));
                            }
                        %>
                    </p>
                </div>
                <div style="display: flex; gap: 1rem; align-items: center;">
                    <span class="badge ${booking.status == 'PENDING' ? 'badge-warning' : (booking.status == 'CONFIRMED' ? 'badge-success' : (booking.status == 'REJECTED' || booking.status == 'CANCELLED' ? 'badge-error' : 'badge-primary'))}" style="font-size: 1rem; padding: 0.5rem 1rem;">
                        ${booking.status}
                    </span>
                    <a href="${pageContext.request.contextPath}/dashboard/bookings" class="btn btn-outline">
                        <i class="fas fa-arrow-left"></i> Back to Bookings
                    </a>
                </div>
            </div>

            <c:if test="${not empty success}">
                <div class="alert alert-success" data-auto-dismiss="5000">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error" data-auto-dismiss="5000">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem; margin-bottom: 1.5rem;">
                <!-- Patient Information -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3><i class="fas fa-user"></i> Patient Information</h3>
                    </div>
                    <div class="card-body">
                        <div class="info-item">
                            <span class="info-label">Name</span>
                            <span class="info-value">${booking.patientName}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Email</span>
                            <span class="info-value">${booking.patientEmail}</span>
                        </div>
                        <c:if test="${not empty booking.patientPhone}">
                            <div class="info-item">
                                <span class="info-label">Phone</span>
                                <span class="info-value">${booking.patientPhone}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty booking.patientAge}">
                            <div class="info-item">
                                <span class="info-label">Age</span>
                                <span class="info-value">${booking.patientAge} years</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty booking.patientGender}">
                            <div class="info-item">
                                <span class="info-label">Gender</span>
                                <span class="info-value">${booking.patientGender}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty booking.patientCity || not empty booking.patientCountry}">
                            <div class="info-item">
                                <span class="info-label">Location</span>
                                <span class="info-value">
                                    <c:if test="${not empty booking.patientCity}">${booking.patientCity}</c:if>
                                    <c:if test="${not empty booking.patientCity && not empty booking.patientCountry}">, </c:if>
                                    <c:if test="${not empty booking.patientCountry}">${booking.patientCountry}</c:if>
                                </span>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Booking Information -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3><i class="fas fa-calendar-alt"></i> Booking Details</h3>
                    </div>
                    <div class="card-body">
                        <div class="info-item">
                            <span class="info-label">Package</span>
                            <span class="info-value">${booking.treatmentPackage != null ? booking.treatmentPackage.packageName : 'General Inquiry'}</span>
                        </div>
                        <c:if test="${booking.checkInDate != null}">
                            <div class="info-item">
                                <span class="info-label">Check-in</span>
                                <span class="info-value">
                                    <%
                                        if (b != null && b.getCheckInDate() != null) {
                                            out.print(b.getCheckInDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                        }
                                    %>
                                </span>
                            </div>
                        </c:if>
                        <c:if test="${booking.checkOutDate != null}">
                            <div class="info-item">
                                <span class="info-label">Check-out</span>
                                <span class="info-value">
                                    <%
                                        if (b != null && b.getCheckOutDate() != null) {
                                            out.print(b.getCheckOutDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                        }
                                    %>
                                </span>
                            </div>
                        </c:if>
                        <c:if test="${booking.roomType != null}">
                            <div class="info-item">
                                <span class="info-label">Room Type</span>
                                <span class="info-value">${booking.roomType}</span>
                            </div>
                        </c:if>
                        <c:if test="${booking.numberOfGuests != null}">
                            <div class="info-item">
                                <span class="info-label">Guests</span>
                                <span class="info-value">${booking.numberOfGuests}</span>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Payment Information -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3><i class="fas fa-money-bill-wave"></i> Payment Details</h3>
                    </div>
                    <div class="card-body">
                        <c:if test="${booking.basePrice != null}">
                            <div class="info-item">
                                <span class="info-label">Base Price</span>
                                <span class="info-value">₹<fmt:formatNumber value="${booking.basePrice}" maxFractionDigits="0"/></span>
                            </div>
                        </c:if>
                        <c:if test="${booking.gstAmount != null && booking.gstAmount > 0}">
                            <div class="info-item">
                                <span class="info-label">GST</span>
                                <span class="info-value">₹<fmt:formatNumber value="${booking.gstAmount}" maxFractionDigits="0"/></span>
                            </div>
                        </c:if>
                        <div class="info-item" style="border-top: 2px solid var(--primary-forest); padding-top: 1rem; margin-top: 1rem;">
                            <span class="info-label" style="font-weight: 700; font-size: 1.1rem;">Total Amount</span>
                            <span class="info-value" style="font-weight: 700; font-size: 1.5rem; color: var(--primary-forest);">
                                ₹<fmt:formatNumber value="${booking.totalAmount != null ? booking.totalAmount : 0}" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <c:if test="${booking.paymentStatus != null}">
                            <div class="info-item">
                                <span class="info-label">Payment Status</span>
                                <span class="info-value">
                                    <span class="badge ${booking.paymentStatus == 'PAID' ? 'badge-success' : (booking.paymentStatus == 'PARTIAL' ? 'badge-warning' : 'badge-error')}">
                                        ${booking.paymentStatus}
                                    </span>
                                </span>
                            </div>
                        </c:if>
                        <c:if test="${booking.advancePaid != null && booking.advancePaid > 0}">
                            <div class="info-item">
                                <span class="info-label">Advance Paid</span>
                                <span class="info-value">₹<fmt:formatNumber value="${booking.advancePaid}" maxFractionDigits="0"/></span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Additional Information -->
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem; margin-bottom: 1.5rem;">
                <c:if test="${not empty booking.medicalConditions}">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3><i class="fas fa-heartbeat"></i> Medical Conditions</h3>
                        </div>
                        <div class="card-body">
                            <p style="color: var(--text-medium); line-height: 1.8; margin: 0;">${booking.medicalConditions}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty booking.currentMedications}">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3><i class="fas fa-pills"></i> Current Medications</h3>
                        </div>
                        <div class="card-body">
                            <p style="color: var(--text-medium); line-height: 1.8; margin: 0;">${booking.currentMedications}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty booking.specialRequests}">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3><i class="fas fa-comment"></i> Special Requests</h3>
                        </div>
                        <div class="card-body">
                            <p style="color: var(--text-medium); line-height: 1.8; margin: 0;">${booking.specialRequests}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty booking.patientNotes}">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3><i class="fas fa-sticky-note"></i> Patient Notes</h3>
                        </div>
                        <div class="card-body">
                            <p style="color: var(--text-medium); line-height: 1.8; margin: 0;">${booking.patientNotes}</p>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Hospital Notes (if confirmed) -->
            <c:if test="${booking.status == 'CONFIRMED' && not empty booking.hospitalNotes}">
                <div class="dashboard-card" style="background: #e8f5e9; border-left: 4px solid #28a745;">
                    <div class="card-header">
                        <h3><i class="fas fa-info-circle"></i> Hospital Notes</h3>
                    </div>
                    <div class="card-body">
                        <p style="color: #2e7d32; line-height: 1.8; margin: 0;">${booking.hospitalNotes}</p>
                    </div>
                </div>
            </c:if>

            <!-- Rejection Reason (if rejected) -->
            <c:if test="${booking.status == 'REJECTED' && not empty booking.rejectionReason}">
                <div class="dashboard-card" style="background: #ffebee; border-left: 4px solid #dc3545;">
                    <div class="card-header">
                        <h3><i class="fas fa-exclamation-triangle"></i> Rejection Reason</h3>
                    </div>
                    <div class="card-body">
                        <p style="color: #c62828; line-height: 1.8; margin: 0;">${booking.rejectionReason}</p>
                    </div>
                </div>
            </c:if>

            <!-- Action Buttons -->
            <c:if test="${booking.status == 'PENDING'}">
                <div class="dashboard-card" style="background: #fff3cd; border-left: 4px solid #ffc107;">
                    <div class="card-header">
                        <h3><i class="fas fa-tasks"></i> Booking Actions</h3>
                    </div>
                    <div class="card-body">
                        <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                            <form action="${pageContext.request.contextPath}/dashboard/bookings/${booking.id}/confirm" method="post" style="flex: 1; min-width: 200px;">
                                <div style="margin-bottom: 1rem;">
                                    <label for="hospitalNotes" style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Hospital Notes (Optional):</label>
                                    <textarea id="hospitalNotes" name="hospitalNotes" rows="3" 
                                              placeholder="Add any notes or instructions for this booking..."
                                              style="width: 100%; padding: 0.75rem; border: 1px solid #ddd; border-radius: 6px; font-family: inherit; resize: vertical;"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary" style="width: 100%;">
                                    <i class="fas fa-check-circle"></i> Accept Booking
                                </button>
                            </form>
                            
                            <form action="${pageContext.request.contextPath}/dashboard/bookings/${booking.id}/reject" method="post" style="flex: 1; min-width: 200px;">
                                <div style="margin-bottom: 1rem;">
                                    <label for="rejectionReason" style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Rejection Reason <span style="color: #dc3545;">*</span>:</label>
                                    <textarea id="rejectionReason" name="reason" rows="3" required
                                              placeholder="Please provide a reason for rejecting this booking..."
                                              style="width: 100%; padding: 0.75rem; border: 1px solid #ddd; border-radius: 6px; font-family: inherit; resize: vertical;"></textarea>
                                </div>
                                <button type="submit" class="btn" style="width: 100%; background: #dc3545; color: #fff;" 
                                        onclick="return confirm('Are you sure you want to reject this booking?');">
                                    <i class="fas fa-times-circle"></i> Reject Booking
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>
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

