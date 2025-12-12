<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Treatment Recommendations - Doctor Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/" class="nav-item">
                <i class="fas fa-home"></i>
                <span>Home</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-item">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/prescriptions" class="nav-item">
                <i class="fas fa-prescription"></i>
                <span>Prescriptions</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/treatments" class="nav-item active">
                <i class="fas fa-spa"></i>
                <span>Treatments</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>Treatment Recommendations</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <c:choose>
                <c:when test="${not empty treatments}">
                    <div class="item-grid">
                        <c:forEach var="treatment" items="${treatments}">
                            <div class="item-card">
                                <div class="item-body">
                                    <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 15px;">
                                        <h4 class="item-title">${treatment.treatmentName}</h4>
                                        <span class="badge ${treatment.status.toString().toLowerCase()}">
                                            ${treatment.status}
                                        </span>
                                    </div>
                                    
                                    <div class="item-meta" style="margin-bottom: 10px;">
                                        <i class="fas fa-tag"></i> ${treatment.treatmentType}
                                    </div>
                                    
                                    <c:if test="${not empty treatment.description}">
                                        <p style="color: var(--text-medium); margin: 10px 0; font-size: 0.9rem;">
                                            ${treatment.description.length() > 150 ? treatment.description.substring(0, 150).concat('...') : treatment.description}
                                        </p>
                                    </c:if>
                                    
                                    <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px; margin-top: 15px; padding-top: 15px; border-top: 1px solid #e5e7eb;">
                                        <div>
                                            <small style="color: var(--text-muted);">Sessions</small><br>
                                            <strong>${treatment.numberOfSessions != null ? treatment.numberOfSessions : 'N/A'}</strong>
                                        </div>
                                        <div>
                                            <small style="color: var(--text-muted);">Duration</small><br>
                                            <strong>${treatment.sessionDurationMinutes != null ? treatment.sessionDurationMinutes : 'N/A'} min</strong>
                                        </div>
                                    </div>
                                    
                                    <c:if test="${treatment.startDate != null}">
                                        <div style="margin-top: 10px; color: var(--text-medium); font-size: 0.9rem;">
                                            <i class="fas fa-calendar"></i> 
                                            <fmt:parseDate value="${treatment.startDate}" pattern="yyyy-MM-dd" var="parsedStart" type="date"/>
                                            <fmt:formatDate value="${parsedStart}" pattern="dd MMM yyyy"/>
                                            <c:if test="${treatment.endDate != null}">
                                                - 
                                                <fmt:parseDate value="${treatment.endDate}" pattern="yyyy-MM-dd" var="parsedEnd" type="date"/>
                                                <fmt:formatDate value="${parsedEnd}" pattern="dd MMM yyyy"/>
                                            </c:if>
                                        </div>
                                    </c:if>
                                    
                                    <div class="item-actions" style="margin-top: 15px;">
                                        <a href="${pageContext.request.contextPath}/doctor/treatments/${treatment.id}" class="btn btn-sm btn-primary">
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
                        <i class="fas fa-spa"></i>
                        <h3>No Treatment Recommendations</h3>
                        <p>You haven't recommended any treatments yet</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</body>
</html>

