<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recommend Treatment - Doctor Dashboard</title>
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
                <h1>Recommend Treatment</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}" class="back-link" style="display: inline-flex; align-items: center; gap: 8px; color: var(--text-medium); text-decoration: none; margin-bottom: 20px;">
                <i class="fas fa-arrow-left"></i> Back to Appointment
            </a>

            <div class="form-card">
                <div style="background: #e0f2fe; padding: 15px; border-radius: 10px; margin-bottom: 25px; border-left: 4px solid #0284c7;">
                    <strong>Patient:</strong> ${consultation.patientName} | 
                    <strong>Date:</strong> 
                    <fmt:parseDate value="${consultation.consultationDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                    <fmt:formatDate value="${parsedDate}" pattern="dd MMMM yyyy"/>
                </div>

                <form action="${pageContext.request.contextPath}/doctor/treatments/create/${consultation.id}" method="post">
                    <h3><i class="fas fa-spa"></i> Treatment Details</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Treatment Type</label>
                            <select name="treatmentType" class="form-select" required>
                                <option value="">Select Treatment Type</option>
                                <c:forEach var="type" items="${treatmentTypes}">
                                    <option value="${type}">${type.toString().replace('_', ' ')}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Treatment Name</label>
                            <input type="text" name="treatmentName" class="form-input" placeholder="e.g., Panchakarma, Abhyanga, Shirodhara" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-textarea" rows="4" placeholder="Describe the treatment and why it's recommended..."></textarea>
                    </div>
                    
                    <h3 style="margin-top: 30px;"><i class="fas fa-calendar-alt"></i> Treatment Schedule</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Number of Sessions</label>
                            <input type="number" name="numberOfSessions" class="form-input" min="1" placeholder="e.g., 7, 14, 21">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Session Duration (minutes)</label>
                            <input type="number" name="sessionDurationMinutes" class="form-input" min="15" step="15" placeholder="e.g., 30, 45, 60">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Sessions Per Week</label>
                            <input type="number" name="sessionsPerWeek" class="form-input" min="1" max="7" placeholder="e.g., 3, 5">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Start Date</label>
                            <input type="date" name="startDate" class="form-input">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">End Date</label>
                        <input type="date" name="endDate" class="form-input">
                    </div>
                    
                    <h3 style="margin-top: 30px;"><i class="fas fa-clipboard-list"></i> Treatment Plan</h3>
                    
                    <div class="form-group">
                        <label class="form-label">Detailed Treatment Plan</label>
                        <textarea name="treatmentPlan" class="form-textarea" rows="5" placeholder="Provide a detailed treatment plan including procedures, steps, and schedule..."></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Expected Benefits</label>
                        <textarea name="expectedBenefits" class="form-textarea" rows="4" placeholder="What benefits can the patient expect from this treatment?"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Precautions</label>
                        <textarea name="precautions" class="form-textarea" rows="3" placeholder="Any precautions or contraindications the patient should be aware of..."></textarea>
                    </div>
                    
                    <div class="form-actions" style="border-top: none; margin-top: 30px;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-check"></i> Recommend Treatment
                        </button>
                        <a href="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}" class="btn btn-secondary" style="text-decoration: none;">
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>

