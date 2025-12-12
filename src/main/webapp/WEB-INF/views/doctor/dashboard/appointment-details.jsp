<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Details - Doctor Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        :root {
            --ayur-dark-green: #0a3d2c;
            --ayur-medium-green: #1a5c40;
            --ayur-light-green: #2e7d5a;
            --ayur-accent-gold: #d4af37;
            --ayur-teal: #2a9d8f;
            --ayur-olive: #6a994e;
            --ayur-moss: #386641;
            --ayur-spice: #bc6c25;
            --primary-forest: #0a3d2c;
            --primary-sage: #1a5c40;
            --text-dark: #2c3e50;
            --text-medium: #6b7280;
            --text-muted: #6b7280;
            --sidebar-width: 280px;
            --header-height: 80px;
            --border-radius: 16px;
            --card-shadow: 0 10px 40px rgba(10, 61, 44, 0.1);
            --hover-shadow: 0 15px 50px rgba(10, 61, 44, 0.15);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            --spacing-xs: 8px;
            --spacing-sm: 12px;
            --spacing-md: 16px;
            --spacing-lg: 24px;
            --spacing-xl: 30px;
            --spacing-3xl: 60px;
            --radius-md: 10px;
            --radius-lg: 16px;
            --error: #e74c3c;
        }
        
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Nunito Sans', sans-serif;
            background: linear-gradient(135deg, #f0f7f4 0%, #e8f1ed 100%);
            color: #2c3e50;
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        .dashboard-body { display: flex; min-height: 100vh; }
        
        .sidebar {
            width: var(--sidebar-width);
            background: linear-gradient(180deg, var(--ayur-dark-green) 0%, var(--ayur-medium-green) 100%);
            color: white;
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100vh;
            z-index: 1000;
            transition: var(--transition);
            box-shadow: 5px 0 25px rgba(10, 61, 44, 0.2);
            border-right: 3px solid var(--ayur-accent-gold);
        }
        
        .sidebar-header {
            padding: 30px 25px;
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            text-align: center;
            background: rgba(10, 61, 44, 0.9);
            position: relative;
            overflow: hidden;
        }
        
        .sidebar-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, transparent, var(--ayur-accent-gold), transparent);
        }
        
        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 15px;
            color: white;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: 700;
            justify-content: center;
            z-index: 1;
            position: relative;
        }
        
        .sidebar-logo i {
            font-size: 2.2rem;
            color: var(--ayur-accent-gold);
            text-shadow: 0 2px 10px rgba(212, 175, 55, 0.3);
        }
        
        .sidebar-logo .highlight {
            color: var(--ayur-accent-gold);
            font-weight: 800;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
        
        .sidebar-nav {
            flex: 1;
            padding: 25px 0;
            overflow-y: auto;
        }
        
        .nav-item {
            display: flex;
            align-items: center;
            gap: 18px;
            padding: 18px 30px;
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            transition: var(--transition);
            border-left: 4px solid transparent;
            margin: 8px 15px;
            position: relative;
            overflow: hidden;
            border-radius: 12px;
        }
        
        .nav-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(212, 175, 55, 0.1), transparent);
            transition: left 0.6s ease;
        }
        
        .nav-item:hover::before { left: 100%; }
        
        .nav-item:hover {
            background: linear-gradient(90deg, rgba(212, 175, 55, 0.15), rgba(46, 125, 90, 0.2));
            color: white;
            padding-left: 35px;
            transform: translateX(5px);
            border-left-color: var(--ayur-accent-gold);
        }
        
        .nav-item.active {
            background: linear-gradient(135deg, rgba(46, 125, 90, 0.3), rgba(212, 175, 55, 0.2));
            border-left-color: var(--ayur-accent-gold);
            color: white;
            font-weight: 600;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .nav-item i {
            width: 24px;
            font-size: 1.2rem;
            text-align: center;
            color: var(--ayur-accent-gold);
        }
        
        .nav-item span {
            flex: 1;
            white-space: nowrap;
            font-size: 0.95rem;
        }
        
        .sidebar-footer {
            padding: 25px;
            border-top: 1px solid rgba(212, 175, 55, 0.2);
            display: flex;
            flex-direction: column;
            gap: 15px;
            background: rgba(10, 61, 44, 0.8);
        }
        
        .btn-outline {
            background: transparent;
            border: 2px solid var(--ayur-accent-gold);
            color: var(--ayur-accent-gold);
            padding: 12px 20px;
            border-radius: 10px;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 600;
            transition: var(--transition);
            font-size: 0.9rem;
        }
        
        .btn-outline:hover {
            background: var(--ayur-accent-gold);
            color: var(--ayur-dark-green);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
        }
        
        .logout-link {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            border-radius: 10px;
            transition: var(--transition);
            font-size: 0.9rem;
        }
        
        .logout-link:hover {
            background: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            transform: translateX(5px);
        }
        
        .dashboard-main {
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: var(--transition);
            background: linear-gradient(135deg, #f5f9f7 0%, #edf5f1 100%);
            min-height: 100vh;
        }
        
        .dashboard-header {
            background: white;
            height: var(--header-height);
            padding: 0 35px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 6px 20px rgba(10, 61, 44, 0.08);
            position: sticky;
            top: 0;
            z-index: 999;
            border-bottom: 2px solid var(--ayur-accent-gold);
        }
        
        .header-left {
            display: flex;
            align-items: center;
            gap: 25px;
        }
        
        .sidebar-toggle {
            background: var(--ayur-light-green);
            border: none;
            width: 45px;
            height: 45px;
            border-radius: 12px;
            font-size: 1.3rem;
            color: white;
            cursor: pointer;
            display: none;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(46, 125, 90, 0.2);
        }
        
        .sidebar-toggle:hover {
            background: var(--ayur-teal);
            transform: rotate(90deg);
        }
        
        .header-left h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--ayur-dark-green);
            font-weight: 700;
            background: linear-gradient(135deg, var(--ayur-dark-green), var(--ayur-teal));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .dashboard-content {
            padding: 35px;
            max-width: 1500px;
            margin: 0 auto;
            width: 100%;
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--ayur-medium-green);
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: 600;
            transition: var(--transition);
            padding: 10px 15px;
            border-radius: 8px;
        }
        
        .back-link:hover {
            background: rgba(46, 125, 90, 0.1);
            color: var(--ayur-dark-green);
            transform: translateX(-5px);
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .alert-success {
            background: linear-gradient(135deg, rgba(106, 153, 78, 0.1), rgba(56, 102, 65, 0.1));
            color: var(--ayur-olive);
            border-left: 4px solid var(--ayur-olive);
        }
        
        .alert-error {
            background: linear-gradient(135deg, rgba(231, 76, 60, 0.1), rgba(236, 112, 99, 0.1));
            color: #e74c3c;
            border-left: 4px solid #e74c3c;
        }
        
        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 25px;
        }
        
        .detail-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 25px;
            box-shadow: var(--card-shadow);
            border: 2px solid rgba(46, 125, 90, 0.1);
            transition: var(--transition);
        }
        
        .detail-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--hover-shadow);
            border-color: rgba(212, 175, 55, 0.3);
        }
        
        .detail-card.full-width {
            grid-column: 1 / -1;
        }
        
        .detail-card h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: var(--ayur-dark-green);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .detail-card h3 i {
            color: var(--ayur-accent-gold);
        }
        
        .detail-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid rgba(46, 125, 90, 0.1);
        }
        
        .detail-item:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            font-weight: 600;
            color: var(--ayur-medium-green);
            font-size: 0.9rem;
        }
        
        .detail-value {
            color: var(--text-dark);
            font-weight: 500;
            text-align: right;
        }
        
        .status-badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-block;
        }
        
        .status-badge.pending {
            background: linear-gradient(135deg, var(--ayur-spice), #d08c2c);
            color: white;
        }
        
        .status-badge.confirmed {
            background: linear-gradient(135deg, var(--ayur-olive), var(--ayur-moss));
            color: white;
        }
        
        .status-badge.completed {
            background: linear-gradient(135deg, var(--ayur-teal), #38b2ac);
            color: white;
        }
        
        .status-badge.cancelled {
            background: linear-gradient(135deg, #e74c3c, #ec7063);
            color: white;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 25px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 700;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            font-size: 0.95rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--ayur-medium-green), var(--ayur-light-green));
            color: white;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--ayur-light-green), var(--ayur-teal));
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 25px rgba(46, 125, 90, 0.3);
        }
        
        .btn-success {
            background: linear-gradient(135deg, var(--ayur-olive), var(--ayur-moss));
            color: white;
        }
        
        .btn-success:hover {
            background: linear-gradient(135deg, var(--ayur-moss), var(--ayur-olive));
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 25px rgba(106, 153, 78, 0.3);
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #6b7280, #4b5563);
            color: white;
        }
        
        .btn-secondary:hover {
            background: linear-gradient(135deg, #4b5563, #374151);
            transform: translateY(-3px) scale(1.05);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: var(--ayur-dark-green);
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        .form-input, .form-textarea {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid rgba(46, 125, 90, 0.2);
            border-radius: 10px;
            font-size: 0.95rem;
            transition: var(--transition);
            font-family: 'Nunito Sans', sans-serif;
        }
        
        .form-input:focus, .form-textarea:focus {
            outline: none;
            border-color: var(--ayur-accent-gold);
            box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.1);
        }
        
        .form-textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }
        
        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            color: var(--ayur-dark-green);
            font-weight: 500;
        }
        
        .checkbox-label input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: var(--ayur-accent-gold);
        }
        
        @media (max-width: 1200px) {
            .sidebar {
                transform: translateX(-100%);
                box-shadow: 10px 0 40px rgba(10, 61, 44, 0.3);
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .dashboard-main {
                margin-left: 0;
            }
            
            .sidebar-toggle {
                display: flex;
                align-items: center;
                justify-content: center;
            }
        }
        
        @media (max-width: 768px) {
            .dashboard-content {
                padding: 25px;
            }
            
            .header-left h1 {
                font-size: 1.6rem;
            }
            
            .details-grid {
                grid-template-columns: 1fr;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body class="dashboard-body">
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-leaf"></i>
                <span>Ayur<span class="highlight">Doctor</span></span>
            </a>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-item">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/profile" class="nav-item">
                <i class="fas fa-user-circle"></i>
                <span>Profile</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="nav-item active">
                <i class="fas fa-calendar-check"></i>
                <span>Appointments</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/prescriptions" class="nav-item">
                <i class="fas fa-prescription"></i>
                <span>Prescriptions</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/reviews" class="nav-item">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availability" class="nav-item">
                <i class="fas fa-clock"></i>
                <span>Availability</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline btn-sm" target="_blank">
                <i class="fas fa-external-link-alt"></i> View AyurVedaCare
            </a>
            <a href="${pageContext.request.contextPath}/doctor/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Appointment Details</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Appointments
            </a>

            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <div class="details-grid">
                <!-- Patient Information -->
                <div class="detail-card">
                    <h3><i class="fas fa-user"></i> Patient Information</h3>
                    
                    <div class="detail-item">
                        <span class="detail-label">Name</span>
                        <span class="detail-value">${consultation.patientName}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Email</span>
                        <span class="detail-value">${consultation.patientEmail}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Phone</span>
                        <span class="detail-value">${consultation.patientPhone}</span>
                    </div>
                    <c:if test="${consultation.patientAge != null}">
                        <div class="detail-item">
                            <span class="detail-label">Age</span>
                            <span class="detail-value">${consultation.patientAge} years</span>
                        </div>
                    </c:if>
                    <c:if test="${not empty consultation.patientGender}">
                        <div class="detail-item">
                            <span class="detail-label">Gender</span>
                            <span class="detail-value">${consultation.patientGender}</span>
                        </div>
                    </c:if>
                    <c:if test="${not empty consultation.patientHeight}">
                        <div class="detail-item">
                            <span class="detail-label">Height</span>
                            <span class="detail-value">${consultation.patientHeight}</span>
                        </div>
                    </c:if>
                    <c:if test="${not empty consultation.patientWeight}">
                        <div class="detail-item">
                            <span class="detail-label">Weight</span>
                            <span class="detail-value">${consultation.patientWeight}</span>
                        </div>
                    </c:if>
                    <c:if test="${not empty consultation.bloodPressure}">
                        <div class="detail-item">
                            <span class="detail-label">Blood Pressure</span>
                            <span class="detail-value">${consultation.bloodPressure}</span>
                        </div>
                    </c:if>
                </div>

                <!-- Consultation Details -->
                <div class="detail-card">
                    <h3><i class="fas fa-calendar"></i> Consultation Details</h3>
                    
                    <div class="detail-item">
                        <span class="detail-label">Date</span>
                        <span class="detail-value">
                            <fmt:parseDate value="${consultation.consultationDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                            <fmt:formatDate value="${parsedDate}" pattern="dd MMMM yyyy"/>
                        </span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Time</span>
                        <span class="detail-value">
                            <c:if test="${consultation.consultationTime != null}">
                                ${consultation.consultationTime}
                            </c:if>
                        </span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Type</span>
                        <span class="detail-value">${consultation.consultationType != null ? consultation.consultationType : 'N/A'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Duration</span>
                        <span class="detail-value">${consultation.durationMinutes != null ? consultation.durationMinutes : 60} minutes</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Status</span>
                        <span class="detail-value">
                            <span class="status-badge ${consultation.status.toString().toLowerCase()}">
                                ${consultation.status}
                            </span>
                        </span>
                    </div>
                </div>

                <!-- Medical Information -->
                <c:if test="${not empty consultation.reasonForVisit || not empty consultation.symptoms || not empty consultation.medicalHistory}">
                    <div class="detail-card full-width">
                        <h3><i class="fas fa-stethoscope"></i> Medical Information</h3>
                        
                        <c:if test="${not empty consultation.reasonForVisit}">
                            <div style="margin-bottom: 15px;">
                                <strong>Reason for Visit:</strong>
                                <p style="color: var(--text-medium); margin-top: 5px;">${consultation.reasonForVisit}</p>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty consultation.symptoms}">
                            <div style="margin-bottom: 15px;">
                                <strong>Symptoms:</strong>
                                <p style="color: var(--text-medium); margin-top: 5px;">${consultation.symptoms}</p>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty consultation.medicalHistory}">
                            <div style="margin-bottom: 15px;">
                                <strong>Medical History:</strong>
                                <p style="color: var(--text-medium); margin-top: 5px;">${consultation.medicalHistory}</p>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty consultation.currentMedications}">
                            <div style="margin-bottom: 15px;">
                                <strong>Current Medications:</strong>
                                <p style="color: var(--text-medium); margin-top: 5px;">${consultation.currentMedications}</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty consultation.allergies}">
                            <div style="margin-bottom: 15px; background: #fef2f2; padding: 12px; border-radius: 6px; border-left: 4px solid #ef4444;">
                                <strong style="color: #991b1b;"><i class="fas fa-exclamation-triangle"></i> Allergies:</strong>
                                <p style="color: #991b1b; margin-top: 5px; font-weight: 500;">${consultation.allergies}</p>
                            </div>
                        </c:if>
                    </div>
                </c:if>

                <!-- Prescription & Treatment Links -->
                <c:if test="${consultation.status == 'COMPLETED' || consultation.status == 'CONFIRMED'}">
                    <div class="detail-card full-width" style="background: #f0fdf4; border: 2px solid #86efac;">
                        <h3><i class="fas fa-prescription"></i> Post-Consultation Actions</h3>
                        <div style="display: flex; gap: 15px; margin-top: 15px;">
                            <a href="${pageContext.request.contextPath}/doctor/prescriptions/create/${consultation.id}" class="btn btn-primary">
                                <i class="fas fa-prescription"></i> Create Prescription
                            </a>
                            <a href="${pageContext.request.contextPath}/doctor/treatments/create/${consultation.id}" class="btn" style="background: var(--primary-sage); color: white;">
                                <i class="fas fa-spa"></i> Recommend Treatment
                            </a>
                        </div>
                    </div>
                </c:if>

                <!-- Actions -->
                <div class="detail-card full-width" style="background: linear-gradient(135deg, rgba(45, 90, 61, 0.05), rgba(199, 163, 105, 0.05)); border: 2px solid var(--primary-sage);">
                    <h3 style="display: flex; align-items: center; gap: var(--spacing-md); margin-bottom: var(--spacing-xl);">
                        <div style="width: 50px; height: 50px; background: var(--primary-forest); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white;">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <span>Manage Appointment</span>
                    </h3>
                    
                    <c:if test="${consultation.status == 'PENDING'}">
                        <div style="background: #fffbeb; border: 2px solid #fbbf24; border-radius: var(--radius-lg); padding: var(--spacing-lg); margin-bottom: var(--spacing-xl);">
                            <div style="display: flex; align-items: center; gap: var(--spacing-md); margin-bottom: var(--spacing-md);">
                                <i class="fas fa-exclamation-circle" style="color: #f59e0b; font-size: 1.5rem;"></i>
                                <h4 style="margin: 0; color: #92400e;">Action Required</h4>
                            </div>
                            <p style="color: #78350f; margin: 0;">This appointment is pending your response. Please accept, reject, or reschedule the appointment.</p>
                        </div>
                        
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: var(--spacing-lg); margin-bottom: var(--spacing-xl);">
                            <form action="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}/confirm" method="post" style="margin: 0;">
                                <button type="submit" class="btn" style="width: 100%; padding: 16px; background: linear-gradient(135deg, #10b981, #059669); color: white; font-size: 1rem; font-weight: 600; border: none; border-radius: var(--radius-md); cursor: pointer; transition: all 0.3s; box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);" onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 16px rgba(16, 185, 129, 0.4)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 12px rgba(16, 185, 129, 0.3)'">
                                    <i class="fas fa-check-circle" style="font-size: 1.2rem; margin-right: 8px;"></i>
                                    Accept Appointment
                                </button>
                            </form>
                            
                            <button type="button" onclick="showRejectForm()" class="btn" style="width: 100%; padding: 16px; background: linear-gradient(135deg, #ef4444, #dc2626); color: white; font-size: 1rem; font-weight: 600; border: none; border-radius: var(--radius-md); cursor: pointer; transition: all 0.3s; box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);" onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 16px rgba(239, 68, 68, 0.4)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 12px rgba(239, 68, 68, 0.3)'">
                                <i class="fas fa-times-circle" style="font-size: 1.2rem; margin-right: 8px;"></i>
                                Reject
                            </button>
                            
                            <button type="button" onclick="showRescheduleForm()" class="btn" style="width: 100%; padding: 16px; background: linear-gradient(135deg, var(--primary-sage), var(--primary-forest)); color: white; font-size: 1rem; font-weight: 600; border: none; border-radius: var(--radius-md); cursor: pointer; transition: all 0.3s; box-shadow: 0 4px 12px rgba(45, 90, 61, 0.3);" onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 16px rgba(45, 90, 61, 0.4)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 12px rgba(45, 90, 61, 0.3)'">
                                <i class="fas fa-calendar-alt" style="font-size: 1.2rem; margin-right: 8px;"></i>
                                Reschedule
                            </button>
                        </div>
                        
                        <form id="rejectForm" action="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}/reject" method="post" style="display: none; margin-bottom: var(--spacing-xl); padding: var(--spacing-xl); background: #fef2f2; border-radius: var(--radius-lg); border: 3px solid #fecaca; box-shadow: 0 4px 12px rgba(239, 68, 68, 0.1);">
                            <div style="display: flex; align-items: center; gap: var(--spacing-md); margin-bottom: var(--spacing-lg);">
                                <div style="width: 50px; height: 50px; background: #ef4444; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.5rem;">
                                    <i class="fas fa-exclamation-triangle"></i>
                                </div>
                                <h4 style="margin: 0; color: #991b1b; font-size: 1.25rem;">Reject Appointment</h4>
                            </div>
                            <p style="color: #7f1d1d; margin-bottom: var(--spacing-lg);">Please provide a reason for rejecting this appointment. The patient will be notified.</p>
                            <div class="form-group">
                                <label class="form-label" style="font-weight: 600; color: var(--text-dark);">Rejection Reason <span style="color: #ef4444;">*</span></label>
                                <textarea name="reason" class="form-textarea" rows="4" placeholder="Please provide a reason for rejection..." required style="border: 2px solid #fecaca; font-size: 1rem;"></textarea>
                            </div>
                            <div style="display: flex; gap: var(--spacing-md); margin-top: var(--spacing-lg);">
                                <button type="submit" class="btn" style="flex: 1; padding: 14px; background: #ef4444; color: white; font-weight: 600; border: none; border-radius: var(--radius-md); cursor: pointer; transition: all 0.3s;" onmouseover="this.style.background='#dc2626'" onmouseout="this.style.background='#ef4444'">
                                    <i class="fas fa-times"></i> Confirm Rejection
                                </button>
                                <button type="button" onclick="hideRejectForm()" class="btn btn-secondary" style="flex: 1; padding: 14px;">Cancel</button>
                            </div>
                        </form>
                        
                        <form id="rescheduleForm" action="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}/reschedule" method="post" style="display: none; margin-bottom: var(--spacing-xl); padding: var(--spacing-xl); background: #f0fdf4; border-radius: var(--radius-lg); border: 3px solid #86efac; box-shadow: 0 4px 12px rgba(5, 150, 105, 0.1);">
                            <div style="display: flex; align-items: center; gap: var(--spacing-md); margin-bottom: var(--spacing-lg);">
                                <div style="width: 50px; height: 50px; background: #10b981; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.5rem;">
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                                <h4 style="margin: 0; color: #059669; font-size: 1.25rem;">Reschedule Appointment</h4>
                            </div>
                            <p style="color: #065f46; margin-bottom: var(--spacing-lg);">Select a new date and time for this appointment. The patient will be notified of the change.</p>
                            <div class="form-row" style="display: grid; grid-template-columns: repeat(2, 1fr); gap: var(--spacing-lg); margin-bottom: var(--spacing-lg);">
                                <div class="form-group">
                                    <label class="form-label" style="font-weight: 600; color: var(--text-dark);">New Date <span style="color: #ef4444;">*</span></label>
                                    <input type="date" name="newDate" class="form-input" required style="border: 2px solid #86efac; font-size: 1rem; padding: 12px;">
                                </div>
                                <div class="form-group">
                                    <label class="form-label" style="font-weight: 600; color: var(--text-dark);">New Time <span style="color: #ef4444;">*</span></label>
                                    <input type="time" name="newTime" class="form-input" required style="border: 2px solid #86efac; font-size: 1rem; padding: 12px;">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-label" style="font-weight: 600; color: var(--text-dark);">Reschedule Reason (Optional)</label>
                                <textarea name="reason" class="form-textarea" rows="3" placeholder="Reason for rescheduling..." style="border: 2px solid #86efac; font-size: 1rem;"></textarea>
                            </div>
                            <div style="display: flex; gap: var(--spacing-md); margin-top: var(--spacing-lg);">
                                <button type="submit" class="btn" style="flex: 1; padding: 14px; background: #10b981; color: white; font-weight: 600; border: none; border-radius: var(--radius-md); cursor: pointer; transition: all 0.3s;" onmouseover="this.style.background='#059669'" onmouseout="this.style.background='#10b981'">
                                    <i class="fas fa-calendar-check"></i> Confirm Reschedule
                                </button>
                                <button type="button" onclick="hideRescheduleForm()" class="btn btn-secondary" style="flex: 1; padding: 14px;">Cancel</button>
                            </div>
                        </form>
                    </c:if>
                    
                    <c:if test="${consultation.status == 'CONFIRMED' || consultation.status == 'PENDING'}">
                        <form action="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}/complete" method="post" style="display: inline-block; margin-right: 10px;">
                            <div style="margin-bottom: 15px;">
                                <label class="form-label">Doctor Notes</label>
                                <textarea name="doctorNotes" class="form-textarea" rows="4" placeholder="Add consultation notes...">${consultation.doctorNotes}</textarea>
                            </div>
                            <div style="margin-bottom: 15px;">
                                <label class="form-label">Prescription Notes</label>
                                <textarea name="prescriptionNotes" class="form-textarea" rows="4" placeholder="Add prescription details...">${consultation.prescriptionNotes}</textarea>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="requiresFollowUp" value="true" ${consultation.requiresFollowUp ? 'checked' : ''}>
                                        <span>Requires Follow-up</span>
                                    </label>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Follow-up Date</label>
                                    <input type="date" name="followUpDate" class="form-input" value="${consultation.followUpDate}">
                                </div>
                            </div>
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-check-circle"></i> Complete Consultation
                            </button>
                        </form>
                        
                        <button type="button" onclick="showCancelForm()" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Cancel Appointment
                        </button>
                        
                        <form id="cancelForm" action="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}/cancel" method="post" style="display: none; margin-top: 20px; padding-top: 20px; border-top: 2px solid #e5e7eb;">
                            <div class="form-group">
                                <label class="form-label">Cancellation Reason</label>
                                <textarea name="reason" class="form-textarea" rows="3" required></textarea>
                            </div>
                            <button type="submit" class="btn" style="background: var(--error); color: white;">
                                <i class="fas fa-times"></i> Cancel Appointment
                            </button>
                            <button type="button" onclick="hideCancelForm()" class="btn btn-secondary">Cancel</button>
                        </form>
                    </c:if>
                    
                    <c:if test="${consultation.status == 'COMPLETED'}">
                        <div style="background: #d1fae5; padding: 15px; border-radius: 8px; color: #059669;">
                            <i class="fas fa-check-circle"></i> This consultation has been completed.
                            <c:if test="${not empty consultation.doctorNotes}">
                                <div style="margin-top: 10px;">
                                    <strong>Doctor Notes:</strong>
                                    <p style="margin-top: 5px;">${consultation.doctorNotes}</p>
                                </div>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </main>

    <script>
        function showCancelForm() {
            document.getElementById('cancelForm').style.display = 'block';
        }
        
        function hideCancelForm() {
            document.getElementById('cancelForm').style.display = 'none';
        }
        
        function showRejectForm() {
            document.getElementById('rejectForm').style.display = 'block';
            hideRescheduleForm();
        }
        
        function hideRejectForm() {
            document.getElementById('rejectForm').style.display = 'none';
        }
        
        function showRescheduleForm() {
            document.getElementById('rescheduleForm').style.display = 'block';
            hideRejectForm();
        }
        
        function hideRescheduleForm() {
            document.getElementById('rescheduleForm').style.display = 'none';
        }
        
        // Set minimum date to today for reschedule
        const rescheduleDateInput = document.querySelector('#rescheduleForm input[name="newDate"]');
        if (rescheduleDateInput) {
            const today = new Date().toISOString().split('T')[0];
            rescheduleDateInput.setAttribute('min', today);
        }
        
        // Sidebar toggle for mobile
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
                this.style.transform = sidebar.classList.contains('active') ? 'rotate(90deg)' : 'rotate(0)';
            });
        }
    </script>
</body>
</html>

