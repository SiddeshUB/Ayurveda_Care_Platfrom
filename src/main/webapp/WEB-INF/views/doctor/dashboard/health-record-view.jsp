<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Health Record Details - Doctor Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/doctor/health-records" class="nav-item active">
                <i class="fas fa-file-medical"></i>
                <span>Health Records</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>Health Record Details</h1>
            </div>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/doctor/health-records/${record.id}/edit" class="btn btn-secondary">
                    <i class="fas fa-edit"></i> Edit Record
                </a>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/doctor/health-records" class="back-link" style="display: inline-flex; align-items: center; gap: 8px; color: var(--text-medium); text-decoration: none; margin-bottom: 20px;">
                <i class="fas fa-arrow-left"></i> Back to Health Records
            </a>

            <div class="details-grid">
                <!-- Patient Information -->
                <div class="detail-card">
                    <h3><i class="fas fa-user"></i> Patient Information</h3>
                    <div class="detail-item">
                        <span class="detail-label">Record Number</span>
                        <span class="detail-value">${record.recordNumber}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Name</span>
                        <span class="detail-value">${record.patientName}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Email</span>
                        <span class="detail-value">${record.patientEmail}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Phone</span>
                        <span class="detail-value">${record.patientPhone != null ? record.patientPhone : 'N/A'}</span>
                    </div>
                    <c:if test="${record.dateOfBirth != null}">
                        <div class="detail-item">
                            <span class="detail-label">Date of Birth</span>
                            <span class="detail-value">
                                <fmt:parseDate value="${record.dateOfBirth}" pattern="yyyy-MM-dd" var="parsedDOB" type="date"/>
                                <fmt:formatDate value="${parsedDOB}" pattern="dd MMMM yyyy"/>
                            </span>
                        </div>
                    </c:if>
                    <div class="detail-item">
                        <span class="detail-label">Gender</span>
                        <span class="detail-value">${record.gender != null ? record.gender : 'N/A'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Blood Group</span>
                        <span class="detail-value">${record.bloodGroup != null ? record.bloodGroup : 'N/A'}</span>
                    </div>
                </div>

                <!-- Vital Signs -->
                <div class="detail-card">
                    <h3><i class="fas fa-heartbeat"></i> Vital Signs</h3>
                    <c:if test="${record.height != null}">
                        <div class="detail-item">
                            <span class="detail-label">Height</span>
                            <span class="detail-value">${record.height} cm</span>
                        </div>
                    </c:if>
                    <c:if test="${record.weight != null}">
                        <div class="detail-item">
                            <span class="detail-label">Weight</span>
                            <span class="detail-value">${record.weight} kg</span>
                        </div>
                    </c:if>
                    <c:if test="${record.bmi != null}">
                        <div class="detail-item">
                            <span class="detail-label">BMI</span>
                            <span class="detail-value">
                                <span class="badge ${record.bmi < 18.5 ? 'badge-warning' : (record.bmi > 25 ? 'badge-error' : 'badge-success')}">
                                    ${record.bmi}
                                </span>
                            </span>
                        </div>
                    </c:if>
                    <c:if test="${record.bloodPressure != null}">
                        <div class="detail-item">
                            <span class="detail-label">Blood Pressure</span>
                            <span class="detail-value">${record.bloodPressure}</span>
                        </div>
                    </c:if>
                    <c:if test="${record.temperature != null}">
                        <div class="detail-item">
                            <span class="detail-label">Temperature</span>
                            <span class="detail-value">${record.temperature} °C</span>
                        </div>
                    </c:if>
                    <c:if test="${record.pulseRate != null}">
                        <div class="detail-item">
                            <span class="detail-label">Pulse Rate</span>
                            <span class="detail-value">${record.pulseRate} bpm</span>
                        </div>
                    </c:if>
                    <c:if test="${record.respiratoryRate != null}">
                        <div class="detail-item">
                            <span class="detail-label">Respiratory Rate</span>
                            <span class="detail-value">${record.respiratoryRate} bpm</span>
                        </div>
                    </c:if>
                </div>

                <!-- Medical History -->
                <c:if test="${not empty record.allergies || not empty record.chronicConditions || not empty record.pastSurgeries || not empty record.familyHistory || not empty record.currentMedications}">
                    <div class="detail-card full-width">
                        <h3><i class="fas fa-history"></i> Medical History</h3>
                        <c:if test="${not empty record.allergies}">
                            <div style="margin-bottom: 15px;">
                                <strong>Allergies:</strong>
                                <p style="color: var(--text-medium); margin-top: 5px; white-space: pre-wrap;">${record.allergies}</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty record.chronicConditions}">
                            <div style="margin-bottom: 15px;">
                                <strong>Chronic Conditions:</strong>
                                <p style="color: var(--text-medium); margin-top: 5px; white-space: pre-wrap;">${record.chronicConditions}</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty record.pastSurgeries}">
                            <div style="margin-bottom: 15px;">
                                <strong>Past Surgeries:</strong>
                                <p style="color: var(--text-medium); margin-top: 5px; white-space: pre-wrap;">${record.pastSurgeries}</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty record.familyHistory}">
                            <div style="margin-bottom: 15px;">
                                <strong>Family History:</strong>
                                <p style="color: var(--text-medium); margin-top: 5px; white-space: pre-wrap;">${record.familyHistory}</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty record.currentMedications}">
                            <div>
                                <strong>Current Medications:</strong>
                                <p style="color: var(--text-medium); margin-top: 5px; white-space: pre-wrap;">${record.currentMedications}</p>
                            </div>
                        </c:if>
                    </div>
                </c:if>

                <!-- Ayurvedic Assessment -->
                <c:if test="${not empty record.prakriti || not empty record.vikriti || not empty record.agni || not empty record.ama}">
                    <div class="detail-card full-width">
                        <h3><i class="fas fa-leaf"></i> Ayurvedic Assessment</h3>
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                            <c:if test="${not empty record.prakriti}">
                                <div>
                                    <strong>Prakriti (Constitution):</strong>
                                    <p style="color: var(--text-medium); margin-top: 5px;">${record.prakriti}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty record.vikriti}">
                                <div>
                                    <strong>Vikriti (Imbalance):</strong>
                                    <p style="color: var(--text-medium); margin-top: 5px;">${record.vikriti}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty record.agni}">
                                <div>
                                    <strong>Agni (Digestive Fire):</strong>
                                    <p style="color: var(--text-medium); margin-top: 5px;">${record.agni}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty record.ama}">
                                <div>
                                    <strong>Ama (Toxins):</strong>
                                    <p style="color: var(--text-medium); margin-top: 5px;">${record.ama}</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>

                <!-- Lifestyle Information -->
                <c:if test="${not empty record.dietType || not empty record.sleepPattern || not empty record.exerciseRoutine || not empty record.stressLevel || not empty record.occupation}">
                    <div class="detail-card full-width">
                        <h3><i class="fas fa-running"></i> Lifestyle Information</h3>
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                            <c:if test="${not empty record.dietType}">
                                <div>
                                    <strong>Diet Type:</strong>
                                    <p style="color: var(--text-medium); margin-top: 5px;">${record.dietType}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty record.stressLevel}">
                                <div>
                                    <strong>Stress Level:</strong>
                                    <p style="color: var(--text-medium); margin-top: 5px;">${record.stressLevel}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty record.occupation}">
                                <div>
                                    <strong>Occupation:</strong>
                                    <p style="color: var(--text-medium); margin-top: 5px;">${record.occupation}</p>
                                </div>
                            </c:if>
                        </div>
                        <c:if test="${not empty record.sleepPattern}">
                            <div style="margin-top: 15px;">
                                <strong>Sleep Pattern:</strong>
                                <p style="color: var(--text-medium); margin-top: 5px;">${record.sleepPattern}</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty record.exerciseRoutine}">
                            <div style="margin-top: 15px;">
                                <strong>Exercise Routine:</strong>
                                <p style="color: var(--text-medium); margin-top: 5px; white-space: pre-wrap;">${record.exerciseRoutine}</p>
                            </div>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </main>
</body>
</html>

