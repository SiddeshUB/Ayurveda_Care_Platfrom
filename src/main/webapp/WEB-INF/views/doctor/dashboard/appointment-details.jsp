<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Details - Doctor Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="nav-item active">
                <i class="fas fa-calendar-check"></i>
                <span>Appointments</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <h1>Appointment Details</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="back-link" style="display: inline-flex; align-items: center; gap: 8px; color: var(--text-medium); text-decoration: none; margin-bottom: 20px;">
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
    </script>
</body>
</html>

