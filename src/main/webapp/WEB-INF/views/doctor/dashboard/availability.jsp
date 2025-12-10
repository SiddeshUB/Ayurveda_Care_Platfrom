<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Availability - Doctor Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        .availability-section {
            background: white;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        
        .slot-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px;
            background: #f8fafc;
            border-radius: 10px;
            margin-bottom: 12px;
            border: 1px solid #e5e7eb;
        }
        
        .slot-info {
            flex: 1;
        }
        
        .slot-info h4 {
            margin: 0 0 5px;
            font-size: 1rem;
        }
        
        .slot-info p {
            margin: 0;
            color: var(--text-muted);
            font-size: 0.9rem;
        }
        
        .slot-actions {
            display: flex;
            gap: 8px;
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
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-item">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Appointments</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availability" class="nav-item active">
                <i class="fas fa-clock"></i>
                <span>Availability</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/profile" class="nav-item">
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
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
</body>
</html>

