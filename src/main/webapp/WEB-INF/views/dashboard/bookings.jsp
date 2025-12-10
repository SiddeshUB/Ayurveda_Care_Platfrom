<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookings - Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/dashboard/products" class="nav-item">
                <i class="fas fa-shopping-bag"></i>
                <span>Products</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/doctors" class="nav-item">
                <i class="fas fa-user-md"></i>
                <span>Doctors</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/bookings" class="nav-item active">
                <i class="fas fa-calendar-check"></i>
                <span>Bookings</span>
                <c:if test="${pendingCount > 0}">
                    <span class="nav-badge">${pendingCount}</span>
                </c:if>
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
                <h1>Booking Management</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success" data-auto-dismiss="5000">
                    <i class="fas fa-check-circle"></i>
                    ${success}
                </div>
            </c:if>

            <div class="page-header">
                <div>
                    <h2 style="margin: 0;">All Bookings</h2>
                    <p style="color: var(--text-muted); margin: var(--spacing-xs) 0 0;">
                        <c:if test="${pendingCount > 0}">
                            <span class="badge badge-warning">${pendingCount} pending</span>
                        </c:if>
                    </p>
                </div>
            </div>

            <div class="dashboard-card">
                <div class="card-body" style="padding: 0;">
                    <c:choose>
                        <c:when test="${not empty bookings}">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Booking #</th>
                                        <th>Patient</th>
                                        <th>Package</th>
                                        <th>Check-in</th>
                                        <th>Room</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="booking" items="${bookings}">
                                        <tr>
                                            <td>
                                                <strong>${booking.bookingNumber}</strong>
                                            </td>
                                            <td>
                                                <div>
                                                    <strong>${booking.patientName}</strong>
                                                    <br>
                                                    <small style="color: var(--text-muted);">${booking.patientEmail}</small>
                                                </div>
                                            </td>
                                            <td>${booking.treatmentPackage != null ? booking.treatmentPackage.packageName : '-'}</td>
                                            <td>
                                                <%
                                                    com.ayurveda.entity.Booking b = (com.ayurveda.entity.Booking) pageContext.getAttribute("booking");
                                                    if (b != null && b.getCheckInDate() != null) {
                                                        out.print(b.getCheckInDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                                    } else {
                                                        out.print("-");
                                                    }
                                                %>
                                            </td>
                                            <td>${booking.roomType != null ? booking.roomType : '-'}</td>
                                            <td>₹<fmt:formatNumber value="${booking.totalAmount != null ? booking.totalAmount : 0}" maxFractionDigits="0"/></td>
                                            <td>
                                                <span class="badge ${booking.status == 'PENDING' ? 'badge-warning' : (booking.status == 'CONFIRMED' ? 'badge-success' : (booking.status == 'REJECTED' || booking.status == 'CANCELLED' ? 'badge-error' : 'badge-primary'))}">
                                                    ${booking.status}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="actions" style="display: flex; gap: 0.5rem; align-items: center; flex-wrap: wrap;">
                                                    <a href="${pageContext.request.contextPath}/dashboard/bookings/${booking.id}" 
                                                       class="btn btn-sm btn-secondary" 
                                                       title="View Details"
                                                       style="padding: 0.5rem 0.75rem; min-width: auto; display: inline-flex; align-items: center; gap: 0.375rem; text-decoration: none; border-radius: 6px; font-weight: 500; transition: all 0.2s;">
                                                        <i class="fas fa-eye"></i>
                                                        <span style="font-size: 0.875rem;">View</span>
                                                    </a>
                                                    <c:if test="${booking.status == 'PENDING'}">
                                                        <form action="${pageContext.request.contextPath}/dashboard/bookings/${booking.id}/confirm" 
                                                              method="post" 
                                                              style="display: inline; margin: 0;"
                                                              onsubmit="return confirm('Are you sure you want to accept this booking?');">
                                                            <input type="hidden" name="hospitalNotes" value="">
                                                            <button type="submit" 
                                                                    class="btn btn-sm" 
                                                                    title="Accept Booking"
                                                                    style="background: #28a745; color: #fff; padding: 0.5rem 0.75rem; min-width: auto; border: none; border-radius: 6px; font-weight: 500; display: inline-flex; align-items: center; gap: 0.375rem; cursor: pointer; transition: all 0.2s;">
                                                                <i class="fas fa-check"></i>
                                                                <span style="font-size: 0.875rem;">Accept</span>
                                                            </button>
                                                        </form>
                                                        <button type="button" 
                                                                class="btn btn-sm" 
                                                                title="Reject Booking"
                                                                onclick="showRejectModal(${booking.id})"
                                                                style="background: #dc3545; color: #fff; padding: 0.5rem 0.75rem; min-width: auto; border: none; border-radius: 6px; font-weight: 500; display: inline-flex; align-items: center; gap: 0.375rem; cursor: pointer; transition: all 0.2s;">
                                                            <i class="fas fa-times"></i>
                                                            <span style="font-size: 0.875rem;">Reject</span>
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            
                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <div style="padding: var(--spacing-lg); display: flex; justify-content: center; gap: var(--spacing-sm);">
                                    <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                        <a href="${pageContext.request.contextPath}/dashboard/bookings?page=${i}" 
                                           class="btn btn-sm ${currentPage == i ? 'btn-primary' : 'btn-secondary'}">
                                            ${i + 1}
                                        </a>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-calendar-times"></i>
                                <h3>No Bookings Yet</h3>
                                <p>When patients book your packages, they'll appear here</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </main>

    <!-- Reject Booking Modal -->
    <div id="rejectModal" class="modal" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5);">
        <div class="modal-content" style="background-color: #fff; margin: 5% auto; padding: 2rem; border-radius: 12px; width: 90%; max-width: 500px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                <h3 style="margin: 0; color: var(--text-dark);">
                    <i class="fas fa-exclamation-triangle" style="color: #dc3545;"></i> Reject Booking
                </h3>
                <button type="button" onclick="closeRejectModal()" style="background: none; border: none; font-size: 1.5rem; cursor: pointer; color: var(--text-muted);">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <form id="rejectForm" method="post" action="">
                <div style="margin-bottom: 1.5rem;">
                    <label for="rejectReason" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: var(--text-dark);">
                        Rejection Reason <span style="color: #dc3545;">*</span>
                    </label>
                    <textarea id="rejectReason" 
                              name="reason" 
                              rows="4" 
                              required
                              placeholder="Please provide a reason for rejecting this booking..."
                              style="width: 100%; padding: 0.75rem; border: 1px solid #ddd; border-radius: 6px; font-family: inherit; resize: vertical; font-size: 0.95rem;"></textarea>
                </div>
                <div style="display: flex; gap: 1rem; justify-content: flex-end;">
                    <button type="button" 
                            onclick="closeRejectModal()" 
                            class="btn btn-outline"
                            style="padding: 0.75rem 1.5rem;">
                        Cancel
                    </button>
                    <button type="submit" 
                            class="btn"
                            style="background: #dc3545; color: #fff; padding: 0.75rem 1.5rem; border: none;">
                        <i class="fas fa-times-circle"></i> Reject Booking
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
            });
        }

        function showRejectModal(bookingId) {
            const modal = document.getElementById('rejectModal');
            const form = document.getElementById('rejectForm');
            form.action = '${pageContext.request.contextPath}/dashboard/bookings/' + bookingId + '/reject';
            modal.style.display = 'block';
        }

        function closeRejectModal() {
            const modal = document.getElementById('rejectModal');
            const form = document.getElementById('rejectForm');
            form.reset();
            modal.style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('rejectModal');
            if (event.target == modal) {
                closeRejectModal();
            }
        }
    </script>
</body>
</html>

