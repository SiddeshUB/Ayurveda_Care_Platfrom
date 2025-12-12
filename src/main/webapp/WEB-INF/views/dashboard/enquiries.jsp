<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enquiries - Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/dashboard/bookings" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Bookings</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/enquiries" class="nav-item active">
                <i class="fas fa-envelope"></i>
                <span>Enquiries</span>
                <c:if test="${pendingCount > 0}">
                    <span class="nav-badge">${pendingCount}</span>
                </c:if>
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
                <h1>Enquiry Management</h1>
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
                    <h2 style="margin: 0;">All Enquiries</h2>
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
                        <c:when test="${not empty enquiries}">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Enquiry #</th>
                                        <th>Patient</th>
                                        <th>Therapy</th>
                                        <th>Preferred Dates</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="enquiry" items="${enquiries}">
                                        <tr>
                                            <td>
                                                <strong>${enquiry.enquiryNumber}</strong>
                                            </td>
                                            <td>
                                                <div>
                                                    <strong>${enquiry.name != null ? enquiry.name : (enquiry.user != null ? enquiry.user.fullName : 'N/A')}</strong>
                                                    <br>
                                                    <small style="color: var(--text-muted);">
                                                        ${enquiry.email != null ? enquiry.email : (enquiry.user != null ? enquiry.user.email : '-')}
                                                    </small>
                                                    <c:if test="${not empty enquiry.phone}">
                                                        <br>
                                                        <small style="color: var(--text-muted);">
                                                            <i class="fas fa-phone"></i> ${enquiry.phone}
                                                        </small>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty enquiry.therapyRequired}">
                                                        ${fn:substring(enquiry.therapyRequired, 0, 40)}${fn:length(enquiry.therapyRequired) > 40 ? '...' : ''}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: var(--text-muted);">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty enquiry.preferredStartDate}">
                                                        <%
                                                            com.ayurveda.entity.UserEnquiry e = (com.ayurveda.entity.UserEnquiry) pageContext.getAttribute("enquiry");
                                                            if (e != null && e.getPreferredStartDate() != null) {
                                                                out.print(e.getPreferredStartDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                                            }
                                                        %>
                                                        <c:if test="${not empty enquiry.preferredEndDate}">
                                                            <br>
                                                            <small style="color: var(--text-muted);">
                                                                to <%
                                                                    if (e != null && e.getPreferredEndDate() != null) {
                                                                        out.print(e.getPreferredEndDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                                                    }
                                                                %>
                                                            </small>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: var(--text-muted);">Not specified</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="badge ${enquiry.status == 'PENDING' ? 'badge-warning' : (enquiry.status == 'REPLIED' ? 'badge-info' : (enquiry.status == 'QUOTATION_SENT' ? 'badge-success' : (enquiry.status == 'CLOSED' ? 'badge-secondary' : 'badge-primary')))}">
                                                    ${enquiry.status}
                                                </span>
                                            </td>
                                            <td>
                                                <%
                                                    com.ayurveda.entity.UserEnquiry e = (com.ayurveda.entity.UserEnquiry) pageContext.getAttribute("enquiry");
                                                    if (e != null && e.getCreatedAt() != null) {
                                                        out.print(e.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                                    }
                                                %>
                                                <br>
                                                <small style="color: var(--text-muted);">
                                                    <%
                                                        if (e != null && e.getCreatedAt() != null) {
                                                            out.print(e.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("hh:mm a")));
                                                        }
                                                    %>
                                                </small>
                                            </td>
                                            <td>
                                                <div class="actions" style="display: flex; gap: 0.5rem; align-items: center; flex-wrap: wrap;">
                                                    <a href="${pageContext.request.contextPath}/dashboard/enquiries/${enquiry.id}" 
                                                       class="btn btn-sm btn-secondary" 
                                                       title="View Details"
                                                       style="padding: 0.5rem 0.75rem; min-width: auto; display: inline-flex; align-items: center; gap: 0.375rem; text-decoration: none; border-radius: 6px; font-weight: 500;">
                                                        <i class="fas fa-eye"></i>
                                                        <span style="font-size: 0.875rem;">View</span>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-envelope"></i>
                                <h3>No Enquiries Yet</h3>
                                <p>When users send enquiries about your services, they'll appear here</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
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

