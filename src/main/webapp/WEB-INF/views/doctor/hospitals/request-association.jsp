<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Association - Doctor Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/doctor/hospitals/associations" class="nav-item active">
                <i class="fas fa-hospital"></i>
                <span>Hospitals</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>Request Hospital Association</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/doctor/hospitals/search" class="back-link" style="display: inline-flex; align-items: center; gap: 8px; color: var(--text-medium); text-decoration: none; margin-bottom: 20px;">
                <i class="fas fa-arrow-left"></i> Back to Search
            </a>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <c:if test="${alreadyAssociated}">
                <div class="alert alert-warning" style="background: #fef3c7; color: #d97706; border: 1px solid #fde68a;">
                    <i class="fas fa-exclamation-triangle"></i> You already have an association request or are already associated with this hospital.
                </div>
            </c:if>

            <div class="form-card">
                <div style="display: grid; grid-template-columns: 200px 1fr; gap: 30px; margin-bottom: 30px;">
                    <div>
                        <c:choose>
                            <c:when test="${not empty hospital.logoUrl}">
                                <img src="${pageContext.request.contextPath}${hospital.logoUrl}" alt="${hospital.centerName}" style="width: 100%; border-radius: 12px;">
                            </c:when>
                            <c:otherwise>
                                <div style="width: 100%; aspect-ratio: 1; background: var(--primary-sage); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem;">
                                    <i class="fas fa-hospital"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <h2 style="margin: 0 0 10px;">${hospital.centerName}</h2>
                        <p style="color: var(--text-muted); margin-bottom: 15px;">
                            <i class="fas fa-map-marker-alt"></i> ${hospital.city}, ${hospital.state}
                        </p>
                        <c:if test="${not empty hospital.description}">
                            <p style="color: var(--text-medium);">${hospital.description}</p>
                        </c:if>
                    </div>
                </div>

                <c:if test="${!alreadyAssociated}">
                    <form action="${pageContext.request.contextPath}/doctor/hospitals/${hospital.id}/request" method="post">
                        <h3><i class="fas fa-comment"></i> Request Message</h3>
                        <p style="color: var(--text-muted); margin-bottom: 15px;">
                            Send a message to the hospital explaining why you'd like to join their team.
                        </p>
                        
                        <div class="form-group">
                            <label class="form-label">Message (Optional)</label>
                            <textarea name="requestMessage" class="form-textarea" rows="5" placeholder="Hello, I would like to request association with your hospital. I specialize in..."></textarea>
                        </div>
                        
                        <div class="form-actions" style="border-top: none; margin-top: 20px;">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane"></i> Send Request
                            </button>
                            <a href="${pageContext.request.contextPath}/doctor/hospitals/search" class="btn btn-secondary" style="text-decoration: none;">
                                Cancel
                            </a>
                        </div>
                    </form>
                </c:if>
            </div>
        </div>
    </main>
</body>
</html>

