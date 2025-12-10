<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Prescription - Doctor Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        .prescription-header {
            background: linear-gradient(135deg, var(--primary-forest) 0%, var(--primary-sage) 100%);
            color: white;
            padding: 30px;
            border-radius: 16px;
            margin-bottom: 30px;
        }
        
        .prescription-section {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .medicine-list {
            margin-top: 15px;
        }
        
        .medicine-item {
            background: #f8fafc;
            border-left: 4px solid var(--primary-sage);
            padding: 15px;
            margin-bottom: 12px;
            border-radius: 8px;
        }
        
        .medicine-item h4 {
            margin: 0 0 8px;
            color: var(--primary-forest);
        }
        
        .medicine-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 10px;
            color: var(--text-medium);
            font-size: 0.9rem;
        }
    </style>
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
            <a href="${pageContext.request.contextPath}/doctor/prescriptions" class="nav-item active">
                <i class="fas fa-prescription"></i>
                <span>Prescriptions</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>Prescription Details</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/doctor/prescriptions" class="back-link" style="display: inline-flex; align-items: center; gap: 8px; color: var(--text-medium); text-decoration: none; margin-bottom: 20px;">
                <i class="fas fa-arrow-left"></i> Back to Prescriptions
            </a>

            <div class="prescription-header">
                <div style="display: flex; justify-content: space-between; align-items: start;">
                    <div>
                        <h2 style="margin: 0 0 10px;">Prescription #${prescription.prescriptionNumber}</h2>
                        <p style="margin: 0; opacity: 0.9;">
                            <i class="fas fa-user"></i> ${prescription.patientName} | 
                            <i class="fas fa-calendar"></i> 
                            <fmt:parseDate value="${prescription.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                            <fmt:formatDate value="${parsedDate}" pattern="dd MMMM yyyy 'at' hh:mm a"/>
                        </p>
                    </div>
                    <div style="text-align: right;">
                        <div style="background: rgba(255,255,255,0.2); padding: 10px 20px; border-radius: 8px; display: inline-block;">
                            <strong>Dr. ${prescription.doctor.name}</strong><br>
                            <small>${prescription.hospital != null ? prescription.hospital.centerName : 'Independent Practice'}</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Patient Information -->
            <div class="prescription-section">
                <h3><i class="fas fa-user"></i> Patient Information</h3>
                <div class="detail-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-top: 15px;">
                    <div>
                        <strong>Name:</strong> ${prescription.patientName}
                    </div>
                    <div>
                        <strong>Age:</strong> ${prescription.patientAge != null ? prescription.patientAge : 'N/A'} years
                    </div>
                    <div>
                        <strong>Gender:</strong> ${prescription.patientGender != null ? prescription.patientGender : 'N/A'}
                    </div>
                    <div>
                        <strong>Email:</strong> ${prescription.patientEmail}
                    </div>
                    <div>
                        <strong>Phone:</strong> ${prescription.patientPhone}
                    </div>
                </div>
            </div>

            <!-- Diagnosis -->
            <div class="prescription-section">
                <h3><i class="fas fa-stethoscope"></i> Diagnosis & Assessment</h3>
                <c:if test="${not empty prescription.chiefComplaints}">
                    <div style="margin-bottom: 15px;">
                        <strong>Chief Complaints:</strong>
                        <p style="color: var(--text-medium); margin-top: 5px;">${prescription.chiefComplaints}</p>
                    </div>
                </c:if>
                <c:if test="${not empty prescription.diagnosis}">
                    <div style="margin-bottom: 15px;">
                        <strong>Diagnosis:</strong>
                        <p style="color: var(--text-medium); margin-top: 5px;">${prescription.diagnosis}</p>
                    </div>
                </c:if>
                <c:if test="${not empty prescription.doshaImbalance}">
                    <div>
                        <strong>Dosha Imbalance:</strong>
                        <span style="background: var(--primary-sage); color: white; padding: 5px 12px; border-radius: 6px; display: inline-block; margin-left: 10px;">
                            ${prescription.doshaImbalance}
                        </span>
                    </div>
                </c:if>
            </div>

            <!-- Medicines -->
            <c:if test="${not empty prescription.medicines}">
                <div class="prescription-section">
                    <h3><i class="fas fa-pills"></i> Prescribed Medicines</h3>
                    <div class="medicine-list">
                        <c:forEach var="medicine" items="${prescription.medicines}">
                            <div class="medicine-item">
                                <h4>${medicine.medicineName}</h4>
                                <div class="medicine-details">
                                    <div><i class="fas fa-capsules"></i> <strong>Dosage:</strong> ${medicine.dosage != null ? medicine.dosage : 'As prescribed'}</div>
                                    <div><i class="fas fa-clock"></i> <strong>Frequency:</strong> ${medicine.frequency != null ? medicine.frequency : 'N/A'}</div>
                                    <div><i class="fas fa-sun"></i> <strong>Timing:</strong> ${medicine.timing != null ? medicine.timing : 'N/A'}</div>
                                    <c:if test="${medicine.durationDays != null}">
                                        <div><i class="fas fa-calendar-alt"></i> <strong>Duration:</strong> ${medicine.durationDays} days</div>
                                    </c:if>
                                </div>
                                <c:if test="${not empty medicine.instructions}">
                                    <div style="margin-top: 10px; padding-top: 10px; border-top: 1px solid #e5e7eb;">
                                        <strong>Instructions:</strong> ${medicine.instructions}
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!-- Lifestyle Guidelines -->
            <c:if test="${not empty prescription.dietGuidelines || not empty prescription.lifestyleGuidelines || not empty prescription.yogaPranayama}">
                <div class="prescription-section">
                    <h3><i class="fas fa-leaf"></i> Lifestyle & Diet Guidelines</h3>
                    <c:if test="${not empty prescription.dietGuidelines}">
                        <div style="margin-bottom: 20px;">
                            <strong><i class="fas fa-utensils"></i> Diet Guidelines:</strong>
                            <p style="color: var(--text-medium); margin-top: 8px; white-space: pre-wrap;">${prescription.dietGuidelines}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty prescription.lifestyleGuidelines}">
                        <div style="margin-bottom: 20px;">
                            <strong><i class="fas fa-heart"></i> Lifestyle Guidelines:</strong>
                            <p style="color: var(--text-medium); margin-top: 8px; white-space: pre-wrap;">${prescription.lifestyleGuidelines}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty prescription.yogaPranayama}">
                        <div>
                            <strong><i class="fas fa-spa"></i> Yoga & Pranayama:</strong>
                            <p style="color: var(--text-medium); margin-top: 8px; white-space: pre-wrap;">${prescription.yogaPranayama}</p>
                        </div>
                    </c:if>
                </div>
            </c:if>

            <!-- Other Instructions -->
            <c:if test="${not empty prescription.otherInstructions}">
                <div class="prescription-section">
                    <h3><i class="fas fa-info-circle"></i> Other Instructions</h3>
                    <p style="color: var(--text-medium); white-space: pre-wrap;">${prescription.otherInstructions}</p>
                </div>
            </c:if>

            <!-- Follow-up -->
            <c:if test="${prescription.followUpDate != null || prescription.followUpDays != null}">
                <div class="prescription-section">
                    <h3><i class="fas fa-calendar-check"></i> Follow-up</h3>
                    <div style="display: flex; gap: 20px; align-items: center;">
                        <c:if test="${prescription.followUpDate != null}">
                            <div>
                                <strong>Follow-up Date:</strong>
                                <fmt:parseDate value="${prescription.followUpDate}" pattern="yyyy-MM-dd" var="parsedFollowUp" type="date"/>
                                <fmt:formatDate value="${parsedFollowUp}" pattern="dd MMMM yyyy"/>
                            </div>
                        </c:if>
                        <c:if test="${prescription.followUpDays != null}">
                            <div>
                                <strong>Follow-up After:</strong> ${prescription.followUpDays} days
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>

            <div style="text-align: center; margin-top: 30px;">
                <button onclick="window.print()" class="btn btn-primary">
                    <i class="fas fa-print"></i> Print Prescription
                </button>
            </div>
        </div>
    </main>
</body>
</html>

