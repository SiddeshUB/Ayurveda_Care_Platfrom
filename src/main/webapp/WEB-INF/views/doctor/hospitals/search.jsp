<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Hospitals - Doctor Dashboard</title>
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
                <h1>Search Hospitals</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/doctor/hospitals/associations" class="back-link" style="display: inline-flex; align-items: center; gap: 8px; color: var(--text-medium); text-decoration: none; margin-bottom: 20px;">
                <i class="fas fa-arrow-left"></i> Back to Associations
            </a>

            <div class="form-card" style="margin-bottom: 30px;">
                <form action="${pageContext.request.contextPath}/doctor/hospitals/search" method="get">
                    <div class="form-group">
                        <label class="form-label">Search Hospitals</label>
                        <div style="display: flex; gap: 10px;">
                            <input type="text" name="query" class="form-input" placeholder="Search by name or city..." value="${query}" style="flex: 1;">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <c:if test="${not empty hospitals}">
                <div class="item-grid">
                    <c:forEach var="hospital" items="${hospitals}">
                        <div class="item-card">
                            <div class="item-body">
                                <h4 class="item-title">${hospital.centerName}</h4>
                                <div class="item-meta">
                                    <i class="fas fa-map-marker-alt"></i> ${hospital.city}, ${hospital.state}
                                </div>
                                <c:if test="${not empty hospital.description}">
                                    <p style="color: var(--text-medium); margin: 10px 0; font-size: 0.9rem;">
                                        ${hospital.description.length() > 100 ? hospital.description.substring(0, 100).concat('...') : hospital.description}
                                    </p>
                                </c:if>
                                <div class="item-actions">
                                    <a href="${pageContext.request.contextPath}/doctor/hospitals/${hospital.id}/request" class="btn btn-sm btn-primary">
                                        <i class="fas fa-user-plus"></i> Request Association
                                    </a>
                                    <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}" target="_blank" class="btn btn-sm btn-secondary">
                                        <i class="fas fa-external-link-alt"></i> View
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <c:if test="${empty hospitals && not empty query}">
                <div class="empty-state" style="background: white; border-radius: var(--radius-lg); padding: var(--spacing-3xl);">
                    <i class="fas fa-search"></i>
                    <h3>No Hospitals Found</h3>
                    <p>Try a different search term</p>
                </div>
            </c:if>
        </div>
    </main>
</body>
</html>

