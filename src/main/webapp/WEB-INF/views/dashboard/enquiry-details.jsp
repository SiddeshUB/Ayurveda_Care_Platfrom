<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enquiry Details - Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/dashboard/bookings" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Bookings</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/enquiries" class="nav-item active">
                <i class="fas fa-envelope"></i>
                <span>Enquiries</span>
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
                <h1>Enquiry Details</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <%
                com.ayurveda.entity.UserEnquiry e = (com.ayurveda.entity.UserEnquiry) request.getAttribute("enquiry");
            %>
            
            <div class="page-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <div>
                    <h2 style="margin: 0;">Enquiry #${enquiry.enquiryNumber}</h2>
                    <p style="color: var(--text-muted); margin: 0.5rem 0 0;">
                        Received: <%
                            if (e != null && e.getCreatedAt() != null) {
                                out.print(e.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")));
                            }
                        %>
                    </p>
                </div>
                <div style="display: flex; gap: 1rem; align-items: center;">
                    <span class="badge ${enquiry.status == 'PENDING' ? 'badge-warning' : (enquiry.status == 'REPLIED' ? 'badge-info' : (enquiry.status == 'QUOTATION_SENT' ? 'badge-success' : (enquiry.status == 'CLOSED' ? 'badge-secondary' : 'badge-primary')))}" style="font-size: 1rem; padding: 0.5rem 1rem;">
                        ${enquiry.status}
                    </span>
                    <a href="${pageContext.request.contextPath}/dashboard/enquiries" class="btn btn-outline">
                        <i class="fas fa-arrow-left"></i> Back to Enquiries
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
                            <span class="info-value">${enquiry.name != null ? enquiry.name : (enquiry.user != null ? enquiry.user.fullName : 'N/A')}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Email</span>
                            <span class="info-value">${enquiry.email != null ? enquiry.email : (enquiry.user != null ? enquiry.user.email : '-')}</span>
                        </div>
                        <c:if test="${not empty enquiry.phone}">
                            <div class="info-item">
                                <span class="info-label">Phone</span>
                                <span class="info-value">${enquiry.phone}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty enquiry.country}">
                            <div class="info-item">
                                <span class="info-label">Country</span>
                                <span class="info-value">${enquiry.country}</span>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Enquiry Details -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3><i class="fas fa-calendar-alt"></i> Preferred Dates</h3>
                    </div>
                    <div class="card-body">
                        <c:if test="${enquiry.preferredStartDate != null}">
                            <div class="info-item">
                                <span class="info-label">Start Date</span>
                                <span class="info-value">
                                    <%
                                        if (e != null && e.getPreferredStartDate() != null) {
                                            out.print(e.getPreferredStartDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                        }
                                    %>
                                </span>
                            </div>
                        </c:if>
                        <c:if test="${enquiry.preferredEndDate != null}">
                            <div class="info-item">
                                <span class="info-label">End Date</span>
                                <span class="info-value">
                                    <%
                                        if (e != null && e.getPreferredEndDate() != null) {
                                            out.print(e.getPreferredEndDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                        }
                                    %>
                                </span>
                            </div>
                        </c:if>
                        <c:if test="${empty enquiry.preferredStartDate && empty enquiry.preferredEndDate}">
                            <p style="color: var(--text-muted);">Not specified</p>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Additional Information -->
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem; margin-bottom: 1.5rem;">
                <c:if test="${not empty enquiry.condition}">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3><i class="fas fa-heartbeat"></i> Medical Condition</h3>
                        </div>
                        <div class="card-body">
                            <p style="color: var(--text-medium); line-height: 1.8; margin: 0;">${enquiry.condition}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty enquiry.therapyRequired}">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3><i class="fas fa-spa"></i> Therapy Required</h3>
                        </div>
                        <div class="card-body">
                            <p style="color: var(--text-medium); line-height: 1.8; margin: 0;">${enquiry.therapyRequired}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty enquiry.message}">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <h3><i class="fas fa-comment"></i> Additional Message</h3>
                        </div>
                        <div class="card-body">
                            <p style="color: var(--text-medium); line-height: 1.8; margin: 0;">${enquiry.message}</p>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Hospital Reply Section -->
            <c:if test="${not empty enquiry.hospitalReply}">
                <div class="dashboard-card" style="background: #e8f5e9; border-left: 4px solid #28a745;">
                    <div class="card-header">
                        <h3><i class="fas fa-reply"></i> Your Reply</h3>
                    </div>
                    <div class="card-body">
                        <p style="color: #2e7d32; line-height: 1.8; margin: 0 0 1rem 0;">${enquiry.hospitalReply}</p>
                        <small style="color: #2e7d32;">
                            Replied on: <%
                                if (e != null && e.getRepliedAt() != null) {
                                    out.print(e.getRepliedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")));
                                }
                            %>
                        </small>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty enquiry.quotation}">
                <div class="dashboard-card" style="background: #fff3cd; border-left: 4px solid #ffc107;">
                    <div class="card-header">
                        <h3><i class="fas fa-file-invoice-dollar"></i> Quotation Sent</h3>
                    </div>
                    <div class="card-body">
                        <p style="color: #856404; line-height: 1.8; margin: 0; white-space: pre-line;">${enquiry.quotation}</p>
                    </div>
                </div>
            </c:if>

            <!-- Reply Form (if pending) -->
            <c:if test="${enquiry.status == 'PENDING' || enquiry.status == 'REPLIED'}">
                <div class="dashboard-card" style="background: #fff3cd; border-left: 4px solid #ffc107;">
                    <div class="card-header">
                        <h3><i class="fas fa-reply"></i> Reply to Enquiry</h3>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/dashboard/enquiries/${enquiry.id}/reply" method="post">
                            <div style="margin-bottom: 1.5rem;">
                                <label for="hospitalReply" style="display: block; margin-bottom: 0.5rem; font-weight: 600;">
                                    Reply Message <span style="color: #dc3545;">*</span>:
                                </label>
                                <textarea id="hospitalReply" 
                                          name="hospitalReply" 
                                          rows="5" 
                                          required
                                          placeholder="Type your reply to the patient..."
                                          style="width: 100%; padding: 0.75rem; border: 1px solid #ddd; border-radius: 6px; font-family: inherit; resize: vertical; font-size: 0.95rem;">${enquiry.hospitalReply != null ? enquiry.hospitalReply : ''}</textarea>
                            </div>
                            <div style="margin-bottom: 1.5rem;">
                                <label for="quotation" style="display: block; margin-bottom: 0.5rem; font-weight: 600;">
                                    Quotation (Optional):
                                </label>
                                <textarea id="quotation" 
                                          name="quotation" 
                                          rows="4" 
                                          placeholder="Include pricing details, package information, or any quotation..."
                                          style="width: 100%; padding: 0.75rem; border: 1px solid #ddd; border-radius: 6px; font-family: inherit; resize: vertical; font-size: 0.95rem;">${enquiry.quotation != null ? enquiry.quotation : ''}</textarea>
                                <small style="color: var(--text-muted); display: block; margin-top: 0.5rem;">
                                    If you provide a quotation, the enquiry status will be updated to "Quotation Sent"
                                </small>
                            </div>
                            <div style="display: flex; gap: 1rem;">
                                <button type="submit" class="btn btn-primary" style="flex: 1;">
                                    <i class="fas fa-paper-plane"></i> Send Reply
                                </button>
                                <c:if test="${enquiry.status != 'PENDING'}">
                                    <a href="${pageContext.request.contextPath}/dashboard/enquiries/${enquiry.id}/close" 
                                       class="btn" 
                                       style="background: #6c757d; color: #fff; flex: 1; text-align: center; text-decoration: none;"
                                       onclick="return confirm('Are you sure you want to close this enquiry?');">
                                        <i class="fas fa-times-circle"></i> Close Enquiry
                                    </a>
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>
            </c:if>

            <!-- Close Enquiry (if not closed) -->
            <c:if test="${enquiry.status != 'CLOSED' && enquiry.status != 'PENDING'}">
                <div class="dashboard-card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/dashboard/enquiries/${enquiry.id}/close" method="post" style="display: inline;">
                            <button type="submit" class="btn" style="background: #6c757d; color: #fff;" 
                                    onclick="return confirm('Are you sure you want to close this enquiry?');">
                                <i class="fas fa-times-circle"></i> Close Enquiry
                            </button>
                        </form>
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

