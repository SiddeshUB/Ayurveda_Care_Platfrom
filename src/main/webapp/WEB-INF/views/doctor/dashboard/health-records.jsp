<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Health Records - Doctor Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/doctor/health-records" class="nav-item active">
                <i class="fas fa-file-medical"></i>
                <span>Health Records</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/reviews" class="nav-item">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>Patient Health Records</h1>
            </div>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/doctor/health-records/create" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Create Health Record
                </a>
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
                <c:when test="${not empty records}">
                    <div class="hospitals-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Record #</th>
                                    <th>Patient</th>
                                    <th>Age/Gender</th>
                                    <th>Blood Group</th>
                                    <th>BMI</th>
                                    <th>Last Updated</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="record" items="${records}">
                                    <tr>
                                        <td><strong>${record.recordNumber}</strong></td>
                                        <td>
                                            <strong>${record.patientName}</strong><br>
                                            <small style="color: var(--text-muted);">${record.patientEmail}</small>
                                        </td>
                                        <td>
                                            <c:if test="${record.dateOfBirth != null}">
                                                <fmt:parseDate value="${record.dateOfBirth}" pattern="yyyy-MM-dd" var="parsedDOB" type="date"/>
                                                <fmt:formatDate value="${parsedDOB}" pattern="dd MMM yyyy"/>
                                            </c:if>
                                            <c:if test="${not empty record.gender}">
                                                / ${record.gender}
                                            </c:if>
                                        </td>
                                        <td>${record.bloodGroup != null ? record.bloodGroup : 'N/A'}</td>
                                        <td>
                                            <c:if test="${record.bmi != null}">
                                                <span class="badge ${record.bmi < 18.5 ? 'badge-warning' : (record.bmi > 25 ? 'badge-error' : 'badge-success')}">
                                                    ${record.bmi}
                                                </span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <fmt:parseDate value="${record.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedUpdated" type="both"/>
                                            <fmt:formatDate value="${parsedUpdated}" pattern="dd MMM yyyy"/>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/doctor/health-records/${record.id}" class="btn-action view">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/doctor/health-records/${record.id}/edit" class="btn-action edit">
                                                <i class="fas fa-edit"></i>
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
                        <i class="fas fa-file-medical"></i>
                        <h3>No Health Records</h3>
                        <p>You haven't created any patient health records yet</p>
                        <a href="${pageContext.request.contextPath}/doctor/health-records/create" class="btn btn-primary" style="margin-top: 20px;">
                            <i class="fas fa-plus"></i> Create First Health Record
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</body>
</html>

