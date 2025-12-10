<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prescriptions - Doctor Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Appointments</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/prescriptions" class="nav-item active">
                <i class="fas fa-prescription"></i>
                <span>Prescriptions</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/treatments" class="nav-item">
                <i class="fas fa-spa"></i>
                <span>Treatments</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>Prescriptions</h1>
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
                <c:when test="${not empty prescriptions}">
                    <div class="hospitals-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Prescription #</th>
                                    <th>Patient</th>
                                    <th>Date</th>
                                    <th>Diagnosis</th>
                                    <th>Medicines</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="prescription" items="${prescriptions}">
                                    <tr>
                                        <td><strong>${prescription.prescriptionNumber}</strong></td>
                                        <td>
                                            <strong>${prescription.patientName}</strong><br>
                                            <small style="color: var(--text-muted);">${prescription.patientEmail}</small>
                                        </td>
                                        <td>
                                            <fmt:parseDate value="${prescription.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                            <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty prescription.diagnosis}">
                                                    ${prescription.diagnosis.length() > 50 ? prescription.diagnosis.substring(0, 50).concat('...') : prescription.diagnosis}
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: var(--text-muted);">Not specified</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty prescription.medicines}">
                                                    ${prescription.medicines.size()} medicine(s)
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: var(--text-muted);">No medicines</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/doctor/prescriptions/${prescription.id}" class="btn-action view">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" style="background: white; border-radius: var(--radius-lg); padding: var(--spacing-3xl);">
                        <i class="fas fa-prescription"></i>
                        <h3>No Prescriptions</h3>
                        <p>You haven't created any prescriptions yet</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</body>
</html>

