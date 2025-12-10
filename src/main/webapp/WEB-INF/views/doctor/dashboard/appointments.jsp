<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointments - Doctor Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body class="dashboard-body">
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-user-md"></i>
                <span>Doctor<span class="highlight">Portal</span></span>
            </a>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-item">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="nav-item active">
                <i class="fas fa-calendar-check"></i>
                <span>Appointments</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availability" class="nav-item">
                <i class="fas fa-clock"></i>
                <span>Availability</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/profile" class="nav-item">
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>Appointments</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <!-- Filter Tabs -->
            <div class="filter-tabs" style="display: flex; gap: 10px; margin-bottom: 24px; flex-wrap: wrap;">
                <a href="${pageContext.request.contextPath}/doctor/appointments" 
                   class="filter-tab ${empty currentStatus ? 'active' : ''}">
                    All
                </a>
                <a href="${pageContext.request.contextPath}/doctor/appointments?status=PENDING" 
                   class="filter-tab ${currentStatus == 'PENDING' ? 'active' : ''}">
                    Pending
                </a>
                <a href="${pageContext.request.contextPath}/doctor/appointments?status=CONFIRMED" 
                   class="filter-tab ${currentStatus == 'CONFIRMED' ? 'active' : ''}">
                    Confirmed
                </a>
                <a href="${pageContext.request.contextPath}/doctor/appointments?status=COMPLETED" 
                   class="filter-tab ${currentStatus == 'COMPLETED' ? 'active' : ''}">
                    Completed
                </a>
            </div>

            <c:choose>
                <c:when test="${not empty consultations}">
                    <div class="bookings-list" style="display: grid; gap: var(--spacing-lg);">
                        <c:forEach var="consultation" items="${consultations}">
                            <div class="booking-card" style="border-left: 4px solid ${consultation.status == 'CONFIRMED' ? '#10b981' : (consultation.status == 'PENDING' ? '#f59e0b' : (consultation.status == 'COMPLETED' ? '#3b82f6' : '#ef4444'))}; background: white; border-radius: var(--radius-lg); padding: var(--spacing-xl); box-shadow: 0 2px 8px rgba(0,0,0,0.1); transition: transform 0.2s, box-shadow 0.2s;" onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 4px 12px rgba(0,0,0,0.15)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 2px 8px rgba(0,0,0,0.1)'">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: var(--spacing-lg);">
                                    <div style="flex: 1;">
                                        <div style="display: flex; align-items: center; gap: var(--spacing-md); margin-bottom: var(--spacing-sm);">
                                            <div style="width: 50px; height: 50px; background: linear-gradient(135deg, var(--primary-sage), var(--primary-forest)); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.5rem;">
                                                <i class="fas fa-user"></i>
                                            </div>
                                            <div>
                                                <h3 style="margin: 0; font-size: 1.25rem; color: var(--text-dark);">
                                                    ${consultation.patientName}
                                                </h3>
                                                <p style="color: var(--text-muted); margin: 4px 0 0; font-size: 0.9rem;">
                                                    <i class="fas fa-envelope"></i> ${consultation.patientEmail}
                                                </p>
                                                <c:if test="${not empty consultation.patientPhone}">
                                                    <p style="color: var(--text-muted); margin: 4px 0 0; font-size: 0.9rem;">
                                                        <i class="fas fa-phone"></i> ${consultation.patientPhone}
                                                    </p>
                                                </c:if>
                                            </div>
                                        </div>
                                        <p style="color: var(--text-muted); font-size: 0.85rem; margin-top: var(--spacing-xs);">
                                            <i class="fas fa-hashtag"></i> ${consultation.consultationNumber}
                                        </p>
                                    </div>
                                    <div>
                                        <span class="status-badge status-${fn:toLowerCase(consultation.status)}" style="padding: 8px 16px; font-weight: 600; font-size: 0.9rem;">
                                            ${consultation.status}
                                        </span>
                                    </div>
                                </div>
                                
                                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: var(--spacing-lg); margin-bottom: var(--spacing-lg); padding: var(--spacing-lg); background: #f9fafb; border-radius: var(--radius-md);">
                                    <div style="display: flex; align-items: center; gap: var(--spacing-sm);">
                                        <div style="width: 40px; height: 40px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--primary-forest);">
                                            <i class="fas fa-calendar"></i>
                                        </div>
                                        <div>
                                            <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Date</div>
                                            <div style="font-weight: 600; color: var(--text-dark);">
                                                <fmt:parseDate value="${consultation.consultationDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                                <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                            </div>
                                        </div>
                                    </div>
                                    <c:if test="${consultation.consultationTime != null}">
                                        <div style="display: flex; align-items: center; gap: var(--spacing-sm);">
                                            <div style="width: 40px; height: 40px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--primary-forest);">
                                                <i class="fas fa-clock"></i>
                                            </div>
                                            <div>
                                                <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Time</div>
                                                <div style="font-weight: 600; color: var(--text-dark);">${consultation.consultationTime}</div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${consultation.consultationType != null}">
                                        <div style="display: flex; align-items: center; gap: var(--spacing-sm);">
                                            <div style="width: 40px; height: 40px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--primary-forest);">
                                                <i class="fas fa-${consultation.consultationType == 'ONLINE' ? 'video' : (consultation.consultationType == 'HOME_VISIT' ? 'home' : 'hospital')}"></i>
                                            </div>
                                            <div>
                                                <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Type</div>
                                                <div style="font-weight: 600; color: var(--text-dark);">${fn:replace(consultation.consultationType, '_', ' ')}</div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${consultation.durationMinutes != null}">
                                        <div style="display: flex; align-items: center; gap: var(--spacing-sm);">
                                            <div style="width: 40px; height: 40px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: var(--primary-forest);">
                                                <i class="fas fa-hourglass-half"></i>
                                            </div>
                                            <div>
                                                <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px;">Duration</div>
                                                <div style="font-weight: 600; color: var(--text-dark);">${consultation.durationMinutes} min</div>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <c:if test="${not empty consultation.reasonForVisit}">
                                    <div style="padding: var(--spacing-md); background: linear-gradient(135deg, rgba(45, 90, 61, 0.05), rgba(199, 163, 105, 0.05)); border-left: 3px solid var(--primary-sage); border-radius: var(--radius-md); margin-bottom: var(--spacing-md);">
                                        <div style="display: flex; align-items: center; gap: var(--spacing-sm); margin-bottom: var(--spacing-xs);">
                                            <i class="fas fa-comment-medical" style="color: var(--primary-forest);"></i>
                                            <strong style="color: var(--text-dark);">Reason</strong>
                                        </div>
                                        <p style="color: var(--text-medium); margin: 0; line-height: 1.6; font-size: 0.9rem;">${fn:substring(consultation.reasonForVisit, 0, 100)}${fn:length(consultation.reasonForVisit) > 100 ? '...' : ''}</p>
                                    </div>
                                </c:if>
                                
                                <div style="display: flex; justify-content: space-between; align-items: center; padding-top: var(--spacing-md); border-top: 1px solid #e5e7eb; margin-top: var(--spacing-md);">
                                    <div style="display: flex; align-items: center; gap: var(--spacing-xs); color: var(--text-muted); font-size: 0.9rem;">
                                        <i class="fas fa-calendar-plus"></i>
                                        <span>
                                            Requested on 
                                            <fmt:parseDate value="${consultation.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt" type="both"/>
                                            <fmt:formatDate value="${parsedCreatedAt}" pattern="dd MMM yyyy"/>
                                        </span>
                                    </div>
                                    <div style="display: flex; gap: var(--spacing-sm);">
                                        <c:if test="${consultation.status == 'PENDING'}">
                                            <form action="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}/confirm" method="post" style="display: inline-block; margin: 0;">
                                                <button type="submit" class="btn" style="background: #10b981; color: white; padding: 8px 16px; font-size: 0.9rem;">
                                                    <i class="fas fa-check"></i> Accept
                                                </button>
                                            </form>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}" class="btn" style="background: var(--primary-forest); color: white; padding: 8px 16px; font-size: 0.9rem; text-decoration: none; display: inline-flex; align-items: center; gap: 6px;">
                                            <i class="fas fa-eye"></i> View Details
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" style="background: white; border-radius: var(--radius-lg); padding: var(--spacing-3xl);">
                        <i class="fas fa-calendar"></i>
                        <h3>No Appointments</h3>
                        <p>You don't have any appointments yet</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</body>
</html>

