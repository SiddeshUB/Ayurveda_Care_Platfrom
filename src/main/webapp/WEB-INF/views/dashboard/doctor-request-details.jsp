<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Doctor Request - Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body class="dashboard-body">
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-leaf"></i>
                <span>AyurVeda<span class="highlight">Care</span></span>
            </a>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/dashboard/doctors" class="nav-item active">
                <i class="fas fa-user-md"></i>
                <span>Doctors</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>Review Doctor Request</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/dashboard/doctors/requests" class="back-link" style="display: inline-flex; align-items: center; gap: 8px; color: var(--text-medium); text-decoration: none; margin-bottom: 20px;">
                <i class="fas fa-arrow-left"></i> Back to Requests
            </a>

            <div class="form-card">
                <h3><i class="fas fa-user-md"></i> Doctor Information</h3>
                
                <div style="display: grid; grid-template-columns: 200px 1fr; gap: 30px; margin-bottom: 30px;">
                    <div>
                        <c:choose>
                            <c:when test="${not empty doctor.photoUrl}">
                                <img src="${pageContext.request.contextPath}${doctor.photoUrl}" alt="${doctor.name}" style="width: 100%; border-radius: 12px;">
                            </c:when>
                            <c:otherwise>
                                <div style="width: 100%; aspect-ratio: 1; background: var(--primary-sage); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem;">
                                    <i class="fas fa-user-md"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <h2 style="margin: 0 0 10px;">${doctor.name}</h2>
                        <p style="color: var(--primary-forest); font-weight: 600; margin-bottom: 5px;">${doctor.qualifications}</p>
                        <p style="color: var(--text-muted); margin-bottom: 15px;">${doctor.specializations}</p>
                        
                        <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; margin-top: 20px;">
                            <div>
                                <strong>Email:</strong><br>
                                <span style="color: var(--text-medium);">${doctor.email}</span>
                            </div>
                            <div>
                                <strong>Phone:</strong><br>
                                <span style="color: var(--text-medium);">${doctor.phone}</span>
                            </div>
                            <div>
                                <strong>Experience:</strong><br>
                                <span style="color: var(--text-medium);">${doctor.experienceYears} Years</span>
                            </div>
                            <div>
                                <strong>Registration:</strong><br>
                                <span style="color: var(--text-medium);">${doctor.registrationNumber}</span>
                            </div>
                        </div>
                        
                        <c:if test="${not empty doctor.biography}">
                            <div style="margin-top: 20px;">
                                <strong>Biography:</strong>
                                <p style="color: var(--text-medium); margin-top: 5px;">${doctor.biography}</p>
                            </div>
                        </c:if>
                    </div>
                </div>

                <c:if test="${not empty association.requestMessage}">
                    <div style="background: #f0f9ff; padding: 15px; border-radius: 8px; margin-bottom: 20px; border-left: 4px solid var(--primary-forest);">
                        <strong>Doctor's Message:</strong>
                        <p style="margin: 5px 0 0; color: var(--text-medium);">"${association.requestMessage}"</p>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/dashboard/doctors/requests/${association.id}/approve" method="post" style="margin-top: 30px;">
                    <h3 style="margin-bottom: 20px;"><i class="fas fa-check-circle"></i> Approve Doctor</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Designation</label>
                            <input type="text" name="designation" class="form-input" placeholder="e.g., Senior Consultant, Chief Physician">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Consultation Days</label>
                            <input type="text" name="consultationDays" class="form-input" placeholder="e.g., Monday, Wednesday, Friday">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Consultation Timings</label>
                            <input type="text" name="consultationTimings" class="form-input" placeholder="e.g., 9:00 AM - 1:00 PM">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Available Locations</label>
                            <input type="text" name="availableLocations" class="form-input" placeholder="e.g., OPD, Online">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Hospital Notes (Optional)</label>
                        <textarea name="hospitalNotes" class="form-textarea" rows="3" placeholder="Internal notes about this doctor..."></textarea>
                    </div>
                    
                    <div class="form-actions" style="border-top: none; margin-top: 20px;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-check"></i> Approve Doctor
                        </button>
                        <button type="button" onclick="showRejectForm()" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Reject Request
                        </button>
                    </div>
                </form>

                <!-- Reject Form (Hidden by default) -->
                <form id="rejectForm" action="${pageContext.request.contextPath}/dashboard/doctors/requests/${association.id}/reject" method="post" style="display: none; margin-top: 30px; padding-top: 30px; border-top: 2px solid #e5e7eb;">
                    <h3 style="margin-bottom: 20px; color: var(--error);"><i class="fas fa-times-circle"></i> Reject Doctor Request</h3>
                    
                    <div class="form-group">
                        <label class="form-label">Reason for Rejection</label>
                        <textarea name="reason" class="form-textarea" rows="4" placeholder="Please provide a reason for rejecting this doctor's request..." required></textarea>
                    </div>
                    
                    <div class="form-actions" style="border-top: none; margin-top: 20px;">
                        <button type="submit" class="btn" style="background: var(--error); color: white;">
                            <i class="fas fa-times"></i> Reject Request
                        </button>
                        <button type="button" onclick="hideRejectForm()" class="btn btn-secondary">
                            Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <script>
        function showRejectForm() {
            document.getElementById('rejectForm').style.display = 'block';
            document.getElementById('rejectForm').scrollIntoView({ behavior: 'smooth' });
        }
        
        function hideRejectForm() {
            document.getElementById('rejectForm').style.display = 'none';
        }
    </script>
</body>
</html>

