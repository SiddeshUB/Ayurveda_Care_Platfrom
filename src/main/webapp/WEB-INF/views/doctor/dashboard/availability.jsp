<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Availability - Doctor Dashboard</title>
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
            --text-muted: #6b7280;
            --sidebar-width: 280px;
            --header-height: 80px;
            --border-radius: 16px;
            --card-shadow: 0 10px 40px rgba(10, 61, 44, 0.1);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
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
        }
        
        .availability-section {
            background: white;
            border-radius: 20px;
            padding: 35px;
            margin-bottom: 30px;
            box-shadow: 0 8px 30px rgba(10, 61, 44, 0.1);
            border: 1px solid rgba(46, 125, 90, 0.1);
            transition: var(--transition);
        }
        
        .availability-section:hover {
            box-shadow: 0 12px 40px rgba(10, 61, 44, 0.15);
            transform: translateY(-2px);
        }
        
        .availability-section h3 {
            font-family: 'Playfair Display', serif;
            color: var(--ayur-dark-green);
            font-size: 1.75rem;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 12px;
            padding-bottom: 15px;
            border-bottom: 2px solid rgba(212, 175, 55, 0.2);
        }
        
        .availability-section h3 i {
            color: var(--ayur-accent-gold);
            font-size: 1.5rem;
        }
        
        /* Form Styling */
        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--ayur-dark-green);
            margin-bottom: 10px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-label::before {
            content: '';
            width: 4px;
            height: 16px;
            background: linear-gradient(180deg, var(--ayur-accent-gold), var(--ayur-light-green));
            border-radius: 2px;
        }
        
        .form-select,
        .form-input {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 0.95rem;
            transition: var(--transition);
            background: #fafbfc;
            color: #2c3e50;
            font-family: 'Nunito Sans', sans-serif;
        }
        
        .form-select:focus,
        .form-input:focus {
            outline: none;
            border-color: var(--ayur-light-green);
            background: white;
            box-shadow: 0 0 0 4px rgba(46, 125, 90, 0.1);
            transform: translateY(-2px);
        }
        
        .form-select:hover,
        .form-input:hover {
            border-color: var(--ayur-teal);
            background: white;
        }
        
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 2px solid rgba(46, 125, 90, 0.1);
        }
        
        .btn {
            padding: 14px 28px;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            font-family: 'Nunito Sans', sans-serif;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--ayur-light-green), var(--ayur-teal));
            color: white;
            box-shadow: 0 4px 15px rgba(46, 125, 90, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(46, 125, 90, 0.4);
            background: linear-gradient(135deg, var(--ayur-teal), var(--ayur-light-green));
        }
        
        .btn-primary:active {
            transform: translateY(-1px);
        }
        
        .btn-sm {
            padding: 10px 18px;
            font-size: 0.85rem;
        }
        
        .btn-outline {
            background: transparent;
            border: 2px solid #e74c3c;
            color: #e74c3c;
        }
        
        .btn-outline:hover {
            background: #e74c3c;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
        }
        
        /* Slot Items */
        .slot-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 22px 25px;
            background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
            border-radius: 16px;
            margin-bottom: 16px;
            border: 2px solid #e5e7eb;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }
        
        .slot-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 5px;
            background: linear-gradient(180deg, var(--ayur-accent-gold), var(--ayur-light-green));
            transform: scaleY(0);
            transition: transform 0.3s ease;
        }
        
        .slot-item:hover {
            border-color: var(--ayur-light-green);
            box-shadow: 0 8px 25px rgba(46, 125, 90, 0.15);
            transform: translateX(5px);
        }
        
        .slot-item:hover::before {
            transform: scaleY(1);
        }
        
        .slot-info {
            flex: 1;
            padding-left: 15px;
        }
        
        .slot-info h4 {
            margin: 0 0 10px;
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--ayur-dark-green);
            font-family: 'Playfair Display', serif;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .slot-info h4::before {
            content: '📅';
            font-size: 1.2rem;
        }
        
        .slot-info p {
            margin: 0;
            color: var(--text-muted);
            font-size: 0.95rem;
            line-height: 1.6;
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }
        
        .slot-info p::before {
            content: '⏰';
            font-size: 1rem;
        }
        
        .slot-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        
        .badge-success {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            box-shadow: 0 2px 8px rgba(16, 185, 129, 0.3);
        }
        
        .badge-error {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            box-shadow: 0 2px 8px rgba(239, 68, 68, 0.3);
        }
        
        /* Alert Messages */
        .alert {
            padding: 18px 24px;
            border-radius: 12px;
            margin-bottom: 25px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .alert-success {
            background: linear-gradient(135deg, #d1fae5, #a7f3d0);
            color: #065f46;
            border-left: 4px solid #10b981;
        }
        
        .alert-error {
            background: linear-gradient(135deg, #fee2e2, #fecaca);
            color: #991b1b;
            border-left: 4px solid #ef4444;
        }
        
        /* Empty State */
        .empty-state {
            padding: 60px 40px;
            text-align: center;
            background: linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%);
            border-radius: 16px;
            border: 2px dashed #d1d5db;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: var(--ayur-teal);
            opacity: 0.6;
        }
        
        .empty-state p {
            font-size: 1.1rem;
            color: var(--text-muted);
            font-weight: 500;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .availability-section {
                padding: 25px;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .slot-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .slot-actions {
                width: 100%;
                justify-content: space-between;
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
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="nav-item">
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
            <a href="${pageContext.request.contextPath}/doctor/availability" class="nav-item active">
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
                <h1>Availability Management</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <!-- Add New Slot -->
            <div class="availability-section">
                <h3 style="margin-bottom: 20px;"><i class="fas fa-plus-circle"></i> Add Time Slot</h3>
                
                <form action="${pageContext.request.contextPath}/doctor/availability/slots/add" method="post">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Hospital</label>
                            <select name="hospitalId" class="form-select" required>
                                <option value="">Select Hospital</option>
                                <!-- Show direct hospital (if doctor was registered by hospital) -->
                                <c:if test="${doctor.hospital != null}">
                                    <option value="${doctor.hospital.id}">${doctor.hospital.centerName}</option>
                                </c:if>
                                <!-- Show hospitals from approved associations -->
                                <c:forEach var="association" items="${associations}">
                                    <c:if test="${doctor.hospital == null || doctor.hospital.id != association.hospital.id}">
                                        <option value="${association.hospital.id}">${association.hospital.centerName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            <c:if test="${empty associations && doctor.hospital == null}">
                                <small style="color: var(--text-muted); font-size: 0.85rem; display: block; margin-top: 5px;">
                                    <i class="fas fa-info-circle"></i> No hospitals available. You need to be associated with a hospital first.
                                </small>
                            </c:if>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Day of Week</label>
                            <select name="dayOfWeek" class="form-select" required>
                                <option value="">Select Day</option>
                                <option value="MONDAY">Monday</option>
                                <option value="TUESDAY">Tuesday</option>
                                <option value="WEDNESDAY">Wednesday</option>
                                <option value="THURSDAY">Thursday</option>
                                <option value="FRIDAY">Friday</option>
                                <option value="SATURDAY">Saturday</option>
                                <option value="SUNDAY">Sunday</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Start Time</label>
                            <input type="time" name="startTime" class="form-input" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">End Time</label>
                            <input type="time" name="endTime" class="form-input" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Duration (minutes)</label>
                            <select name="durationMinutes" class="form-select" required>
                                <option value="30">30 minutes</option>
                                <option value="60" selected>60 minutes</option>
                                <option value="90">90 minutes</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Max Bookings per Slot</label>
                            <input type="number" name="maxBookingsPerSlot" class="form-input" value="1" min="1" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Slot Type</label>
                        <select name="slotType" class="form-select">
                            <option value="MORNING">Morning</option>
                            <option value="AFTERNOON">Afternoon</option>
                            <option value="EVENING">Evening</option>
                        </select>
                    </div>
                    
                    <div class="form-actions" style="border-top: none; margin-top: 20px;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add Slot
                        </button>
                    </div>
                </form>
            </div>

            <!-- Existing Slots -->
            <div class="availability-section">
                <h3 style="margin-bottom: 20px;"><i class="fas fa-list"></i> Your Time Slots</h3>
                
                <c:choose>
                    <c:when test="${not empty slots}">
                        <c:forEach var="slot" items="${slots}">
                            <div class="slot-item">
                                <div class="slot-info">
                                    <h4>
                                        <c:if test="${slot.hospital != null}">
                                            ${slot.hospital.centerName} - 
                                        </c:if>
                                        ${slot.dayOfWeek}
                                    </h4>
                                    <p>
                                        ${slot.startTime} - ${slot.endTime}
                                        • Duration: ${slot.durationMinutes} min
                                        • Max: ${slot.maxBookingsPerSlot} booking(s)
                                        <c:if test="${not empty slot.slotType}">
                                            • ${slot.slotType}
                                        </c:if>
                                    </p>
                                </div>
                                <div class="slot-actions">
                                    <span class="badge ${slot.isAvailable ? 'badge-success' : 'badge-error'}">
                                        ${slot.isAvailable ? 'Available' : 'Unavailable'}
                                    </span>
                                    <form action="${pageContext.request.contextPath}/doctor/availability/slots/${slot.id}/delete" method="post" style="display: inline;" onsubmit="return confirm('Delete this slot?');">
                                        <button type="submit" class="btn btn-sm btn-outline" style="color: var(--error);">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state" style="padding: 40px; text-align: center; color: var(--text-muted);">
                            <i class="fas fa-clock" style="font-size: 3rem; margin-bottom: 15px; opacity: 0.5;"></i>
                            <p>No time slots added yet. Add your availability above.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <script>
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

