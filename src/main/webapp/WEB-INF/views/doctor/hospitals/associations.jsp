<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Associations - Doctor Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/doctor/hospitals/associations" class="nav-item active">
                <i class="fas fa-hospital"></i>
                <span>Hospitals</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>Hospital Associations</h1>
            </div>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/doctor/hospitals/search" class="btn btn-primary">
                    <i class="fas fa-search"></i> Search Hospitals
                </a>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <!-- Approved Associations -->
            <c:if test="${not empty approvedAssociations}">
                <div class="dashboard-card" style="margin-bottom: 30px;">
                    <div class="card-header">
                        <h3><i class="fas fa-check-circle" style="color: var(--success);"></i> Approved Associations</h3>
                    </div>
                    <div class="card-body">
                        <div class="item-grid">
                            <c:forEach var="association" items="${approvedAssociations}">
                                <div class="item-card">
                                    <div class="item-body">
                                        <h4 class="item-title">${association.hospital.centerName}</h4>
                                        <div class="item-meta">
                                            <i class="fas fa-map-marker-alt"></i> ${association.hospital.city}, ${association.hospital.state}
                                        </div>
                                        <c:if test="${not empty association.designation}">
                                            <p style="color: var(--primary-forest); font-weight: 600; margin: 10px 0;">
                                                ${association.designation}
                                            </p>
                                        </c:if>
                                        <c:if test="${not empty association.consultationTimings}">
                                            <p style="margin: 5px 0;"><i class="fas fa-clock"></i> ${association.consultationTimings}</p>
                                        </c:if>
                                        <div class="item-actions">
                                            <a href="${pageContext.request.contextPath}/hospital/profile/${association.hospital.id}" target="_blank" class="btn btn-sm btn-secondary">
                                                <i class="fas fa-external-link-alt"></i> View Hospital
                                            </a>
                                            <form action="${pageContext.request.contextPath}/doctor/hospitals/associations/${association.id}/remove" method="post" style="display: inline;" onsubmit="return confirm('Remove this association?');">
                                                <button type="submit" class="btn btn-sm btn-outline" style="color: var(--error);">
                                                    <i class="fas fa-times"></i> Remove
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Pending Requests -->
            <c:if test="${not empty pendingAssociations}">
                <div class="dashboard-card" style="margin-bottom: 30px;">
                    <div class="card-header">
                        <h3><i class="fas fa-clock" style="color: var(--warning);"></i> Pending Requests</h3>
                    </div>
                    <div class="card-body">
                        <div class="item-grid">
                            <c:forEach var="association" items="${pendingAssociations}">
                                <div class="item-card">
                                    <div class="item-body">
                                        <h4 class="item-title">${association.hospital.centerName}</h4>
                                        <div class="item-meta">
                                            <i class="fas fa-map-marker-alt"></i> ${association.hospital.city}, ${association.hospital.state}
                                        </div>
                                        <p style="color: var(--warning); margin: 10px 0;">
                                            <i class="fas fa-hourglass-half"></i> Waiting for approval
                                        </p>
                                        <div class="item-actions">
                                            <form action="${pageContext.request.contextPath}/doctor/hospitals/associations/${association.id}/remove" method="post" style="display: inline;" onsubmit="return confirm('Cancel this request?');">
                                                <button type="submit" class="btn btn-sm btn-outline">
                                                    <i class="fas fa-times"></i> Cancel Request
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Empty State -->
            <c:if test="${empty approvedAssociations && empty pendingAssociations}">
                <div class="empty-state" style="background: white; border-radius: var(--radius-lg); padding: var(--spacing-3xl);">
                    <i class="fas fa-hospital"></i>
                    <h3>No Hospital Associations</h3>
                    <p>Search and request to join hospitals to start accepting consultations</p>
                    <a href="${pageContext.request.contextPath}/doctor/hospitals/search" class="btn btn-primary" style="margin-top: var(--spacing-lg);">
                        <i class="fas fa-search"></i> Search Hospitals
                    </a>
                </div>
            </c:if>
        </div>
    </main>
</body>
</html>

