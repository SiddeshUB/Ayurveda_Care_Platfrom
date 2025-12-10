<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Requests - Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/dashboard/doctors" class="nav-item active">
                <i class="fas fa-user-md"></i>
                <span>Doctors</span>
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
                <h1>Doctor Requests</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/dashboard/doctors" class="back-link" style="display: inline-flex; align-items: center; gap: 8px; color: var(--text-medium); text-decoration: none; margin-bottom: 20px;">
                <i class="fas fa-arrow-left"></i> Back to Doctors
            </a>

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

            <div class="page-header">
                <div>
                    <h2 style="margin: 0;">Pending Doctor Requests</h2>
                    <p style="color: var(--text-muted); margin: var(--spacing-xs) 0 0;">Review and approve doctor association requests</p>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty pendingRequests}">
                    <div class="item-grid">
                        <c:forEach var="request" items="${pendingRequests}">
                            <c:set var="doctor" value="${request.doctor}"/>
                            <div class="doctor-card">
                                <div class="doctor-header">
                                    <div class="doctor-photo">
                                        <c:choose>
                                            <c:when test="${not empty doctor.photoUrl}">
                                                <img src="${pageContext.request.contextPath}${doctor.photoUrl}" alt="${doctor.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-user-md"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="doctor-info">
                                        <h4>${doctor.name}</h4>
                                        <div class="qualifications">${doctor.qualifications}</div>
                                        <div class="specialization">${doctor.specializations}</div>
                                    </div>
                                </div>
                                <div class="doctor-body">
                                    <c:if test="${doctor.experienceYears != null}">
                                        <div class="doctor-detail">
                                            <i class="fas fa-briefcase"></i>
                                            <span>${doctor.experienceYears} Years Experience</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty doctor.registrationNumber}">
                                        <div class="doctor-detail">
                                            <i class="fas fa-id-card"></i>
                                            <span>Reg: ${doctor.registrationNumber}</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty request.requestMessage}">
                                        <div class="doctor-detail">
                                            <i class="fas fa-comment"></i>
                                            <span style="font-style: italic;">"${request.requestMessage}"</span>
                                        </div>
                                    </c:if>
                                    <div class="doctor-detail">
                                        <i class="fas fa-clock"></i>
                                        <span style="color: var(--text-muted); font-size: 0.85rem;">
                                            Requested: <fmt:formatDate value="${request.createdAt}" pattern="dd MMM yyyy"/>
                                        </span>
                                    </div>
                                </div>
                                <div class="doctor-actions">
                                    <a href="${pageContext.request.contextPath}/dashboard/doctors/requests/${request.id}" class="btn btn-sm btn-primary">
                                        <i class="fas fa-eye"></i> Review
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" style="background: white; border-radius: var(--radius-lg); padding: var(--spacing-3xl);">
                        <i class="fas fa-check-double"></i>
                        <h3>No Pending Requests</h3>
                        <p>All doctor requests have been reviewed</p>
                    </div>
                </c:otherwise>
            </c:choose>
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

