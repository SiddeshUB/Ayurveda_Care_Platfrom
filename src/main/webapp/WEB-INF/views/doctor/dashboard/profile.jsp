<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Doctor Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/doctor/availability" class="nav-item">
                <i class="fas fa-clock"></i>
                <span>Availability</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/profile" class="nav-item active">
                <i class="fas fa-user"></i>
                <span>Profile</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>Profile Management</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <div class="form-card">
                <form action="${pageContext.request.contextPath}/doctor/profile/update" method="post" enctype="multipart/form-data">
                    <h3><i class="fas fa-user"></i> Personal Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="name" class="form-input" value="${doctor.name}" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Gender</label>
                            <select name="gender" class="form-select">
                                <option value="">Select Gender</option>
                                <option value="MALE" ${doctor.gender == 'MALE' ? 'selected' : ''}>Male</option>
                                <option value="FEMALE" ${doctor.gender == 'FEMALE' ? 'selected' : ''}>Female</option>
                                <option value="OTHER" ${doctor.gender == 'OTHER' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-input" value="${doctor.email}" disabled>
                            <small style="color: var(--text-muted);">Email cannot be changed</small>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" name="phone" class="form-input" value="${doctor.phone}">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Photo</label>
                        <input type="file" name="photoFile" class="form-input" accept="image/*">
                        <c:if test="${not empty doctor.photoUrl}">
                            <div style="margin-top: 10px;">
                                <img src="${pageContext.request.contextPath}${doctor.photoUrl}" alt="Current Photo" style="width: 100px; height: 100px; border-radius: 8px; object-fit: cover;">
                            </div>
                        </c:if>
                    </div>
                    
                    <h3 style="margin-top: 30px;"><i class="fas fa-graduation-cap"></i> Professional Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Qualifications</label>
                            <input type="text" name="qualifications" class="form-input" value="${doctor.qualifications}">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Registration Number</label>
                            <input type="text" name="registrationNumber" class="form-input" value="${doctor.registrationNumber}">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Specializations</label>
                            <input type="text" name="specializations" class="form-input" value="${doctor.specializations}" placeholder="e.g., Panchakarma, Kayachikitsa">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Experience (Years)</label>
                            <input type="number" name="experienceYears" class="form-input" value="${doctor.experienceYears}" min="0">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Degree University</label>
                            <input type="text" name="degreeUniversity" class="form-input" value="${doctor.degreeUniversity}">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Languages Known</label>
                            <input type="text" name="languagesSpoken" class="form-input" value="${doctor.languagesSpoken}" placeholder="e.g., English, Hindi, Malayalam">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Biography</label>
                        <textarea name="biography" class="form-textarea" rows="5">${doctor.biography}</textarea>
                    </div>
                    
                    <h3 style="margin-top: 30px;"><i class="fas fa-clock"></i> Availability Settings</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Consultation Days</label>
                            <input type="text" name="consultationDays" class="form-input" value="${doctor.consultationDays}" placeholder="e.g., Monday to Saturday">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Consultation Timings</label>
                            <input type="text" name="consultationTimings" class="form-input" value="${doctor.consultationTimings}" placeholder="e.g., 9:00 AM - 5:00 PM">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Available Locations</label>
                        <input type="text" name="availableLocations" class="form-input" value="${doctor.availableLocations}" placeholder="e.g., OPD, Online, Home Visit">
                    </div>
                    
                    <div class="form-group">
                        <label class="checkbox-label">
                            <input type="checkbox" name="isAvailable" value="true" ${doctor.isAvailable == null || doctor.isAvailable ? 'checked' : ''}>
                            <span>Currently Available for Consultation</span>
                        </label>
                    </div>
                    
                    <div class="form-actions" style="border-top: none; margin-top: 30px;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update Profile
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>

