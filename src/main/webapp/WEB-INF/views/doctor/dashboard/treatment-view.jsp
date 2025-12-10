<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Treatment Details - Doctor Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/doctor/treatments" class="nav-item active">
                <i class="fas fa-spa"></i>
                <span>Treatments</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>Treatment Recommendation Details</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/doctor/treatments" class="back-link" style="display: inline-flex; align-items: center; gap: 8px; color: var(--text-medium); text-decoration: none; margin-bottom: 20px;">
                <i class="fas fa-arrow-left"></i> Back to Treatments
            </a>

            <div class="details-grid">
                <div class="detail-card full-width">
                    <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 20px;">
                        <div>
                            <h2 style="margin: 0 0 10px;">${treatment.treatmentName}</h2>
                            <span class="badge ${treatment.status.toString().toLowerCase()}">
                                ${treatment.status}
                            </span>
                        </div>
                        <div style="text-align: right;">
                            <div style="background: var(--primary-sage); color: white; padding: 10px 20px; border-radius: 8px; display: inline-block;">
                                <strong>${treatment.treatmentType.toString().replace('_', ' ')}</strong>
                            </div>
                        </div>
                    </div>
                    
                    <c:if test="${not empty treatment.description}">
                        <div style="margin-bottom: 20px;">
                            <strong>Description:</strong>
                            <p style="color: var(--text-medium); margin-top: 8px;">${treatment.description}</p>
                        </div>
                    </c:if>
                </div>

                <div class="detail-card">
                    <h3><i class="fas fa-calendar-alt"></i> Schedule</h3>
                    <div class="detail-item">
                        <span class="detail-label">Number of Sessions</span>
                        <span class="detail-value">${treatment.numberOfSessions != null ? treatment.numberOfSessions : 'N/A'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Session Duration</span>
                        <span class="detail-value">${treatment.sessionDurationMinutes != null ? treatment.sessionDurationMinutes : 'N/A'} minutes</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Sessions Per Week</span>
                        <span class="detail-value">${treatment.sessionsPerWeek != null ? treatment.sessionsPerWeek : 'N/A'}</span>
                    </div>
                    <c:if test="${treatment.startDate != null}">
                        <div class="detail-item">
                            <span class="detail-label">Start Date</span>
                            <span class="detail-value">
                                <fmt:parseDate value="${treatment.startDate}" pattern="yyyy-MM-dd" var="parsedStart" type="date"/>
                                <fmt:formatDate value="${parsedStart}" pattern="dd MMMM yyyy"/>
                            </span>
                        </div>
                    </c:if>
                    <c:if test="${treatment.endDate != null}">
                        <div class="detail-item">
                            <span class="detail-label">End Date</span>
                            <span class="detail-value">
                                <fmt:parseDate value="${treatment.endDate}" pattern="yyyy-MM-dd" var="parsedEnd" type="date"/>
                                <fmt:formatDate value="${parsedEnd}" pattern="dd MMMM yyyy"/>
                            </span>
                        </div>
                    </c:if>
                </div>

                <div class="detail-card">
                    <h3><i class="fas fa-user"></i> Patient Information</h3>
                    <div class="detail-item">
                        <span class="detail-label">Patient</span>
                        <span class="detail-value">${treatment.consultation.patientName}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Consultation Date</span>
                        <span class="detail-value">
                            <fmt:parseDate value="${treatment.consultation.consultationDate}" pattern="yyyy-MM-dd" var="parsedConsultDate" type="date"/>
                            <fmt:formatDate value="${parsedConsultDate}" pattern="dd MMMM yyyy"/>
                        </span>
                    </div>
                </div>

                <c:if test="${not empty treatment.treatmentPlan}">
                    <div class="detail-card full-width">
                        <h3><i class="fas fa-clipboard-list"></i> Treatment Plan</h3>
                        <p style="color: var(--text-medium); white-space: pre-wrap;">${treatment.treatmentPlan}</p>
                    </div>
                </c:if>

                <c:if test="${not empty treatment.expectedBenefits}">
                    <div class="detail-card full-width">
                        <h3><i class="fas fa-check-circle"></i> Expected Benefits</h3>
                        <p style="color: var(--text-medium); white-space: pre-wrap;">${treatment.expectedBenefits}</p>
                    </div>
                </c:if>

                <c:if test="${not empty treatment.precautions}">
                    <div class="detail-card full-width">
                        <h3><i class="fas fa-exclamation-triangle"></i> Precautions</h3>
                        <p style="color: var(--text-medium); white-space: pre-wrap;">${treatment.precautions}</p>
                    </div>
                </c:if>
            </div>
        </div>
    </main>
</body>
</html>

