<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="Consultation Details"/>
    <jsp:param name="activeNav" value="consultations"/>
</jsp:include>

<style>
    .consultation-details-page .back-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: #888;
        text-decoration: none;
        font-weight: 500;
        margin-bottom: 20px;
        transition: all 0.3s ease;
    }
    
    .consultation-details-page .back-link:hover {
        color: #c9a227;
    }
    
    .consultation-details-page .detail-card {
        background: #fff;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 5px 25px rgba(0,0,0,0.06);
        margin-bottom: 25px;
    }
    
    .consultation-details-page .status-bar {
        height: 6px;
    }
    
    .consultation-details-page .status-bar.pending { background: linear-gradient(90deg, #f59e0b, #fbbf24); }
    .consultation-details-page .status-bar.confirmed { background: linear-gradient(90deg, #10b981, #34d399); }
    .consultation-details-page .status-bar.completed { background: linear-gradient(90deg, #3b82f6, #60a5fa); }
    .consultation-details-page .status-bar.cancelled { background: linear-gradient(90deg, #ef4444, #f87171); }
    
    .consultation-details-page .card-header {
        padding: 30px;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 20px;
        flex-wrap: wrap;
        border-bottom: 1px solid #f0f0f0;
    }
    
    .consultation-details-page .doctor-section {
        display: flex;
        align-items: center;
        gap: 20px;
    }
    
    .consultation-details-page .doctor-avatar {
        width: 80px;
        height: 80px;
        background: linear-gradient(135deg, #2d4a2d, #1a2e1a);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        font-size: 32px;
    }
    
    .consultation-details-page .doctor-name {
        font-size: 24px;
        font-weight: 600;
        color: #1a2e1a;
        margin: 0 0 8px 0;
    }
    
    .consultation-details-page .doctor-specialty {
        color: #c9a227;
        font-weight: 500;
        margin-bottom: 5px;
    }
    
    .consultation-details-page .doctor-hospital {
        display: flex;
        align-items: center;
        gap: 8px;
        color: #888;
        font-size: 14px;
    }
    
    .consultation-details-page .doctor-hospital i {
        color: #c9a227;
    }
    
    .consultation-details-page .status-badge {
        padding: 12px 24px;
        border-radius: 30px;
        font-size: 14px;
        font-weight: 600;
        text-transform: uppercase;
    }
    
    .consultation-details-page .status-badge.pending {
        background: rgba(245, 158, 11, 0.15);
        color: #d97706;
    }
    
    .consultation-details-page .status-badge.confirmed {
        background: rgba(16, 185, 129, 0.15);
        color: #059669;
    }
    
    .consultation-details-page .status-badge.completed {
        background: rgba(59, 130, 246, 0.15);
        color: #2563eb;
    }
    
    .consultation-details-page .status-badge.cancelled {
        background: rgba(239, 68, 68, 0.15);
        color: #dc2626;
    }
    
    .consultation-details-page .card-body {
        padding: 30px;
    }
    
    .consultation-details-page .info-section {
        margin-bottom: 30px;
    }
    
    .consultation-details-page .section-title {
        font-size: 18px;
        font-weight: 600;
        color: #1a2e1a;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
        padding-bottom: 10px;
        border-bottom: 2px solid #f0f0f0;
    }
    
    .consultation-details-page .section-title i {
        color: #c9a227;
    }
    
    .consultation-details-page .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 25px;
    }
    
    .consultation-details-page .info-item {
        display: flex;
        align-items: flex-start;
        gap: 15px;
    }
    
    .consultation-details-page .info-icon {
        width: 50px;
        height: 50px;
        background: #f8f6f1;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #c9a227;
        font-size: 20px;
        flex-shrink: 0;
    }
    
    .consultation-details-page .info-label {
        font-size: 12px;
        color: #888;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 5px;
    }
    
    .consultation-details-page .info-value {
        font-size: 16px;
        font-weight: 600;
        color: #1a2e1a;
    }
    
    .consultation-details-page .reason-box {
        background: linear-gradient(135deg, rgba(45, 74, 45, 0.05), rgba(201, 162, 39, 0.05));
        border-left: 4px solid #2d4a2d;
        border-radius: 12px;
        padding: 25px;
    }
    
    .consultation-details-page .reason-title {
        font-weight: 600;
        color: #1a2e1a;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .consultation-details-page .reason-title i {
        color: #c9a227;
    }
    
    .consultation-details-page .reason-text {
        color: #555;
        line-height: 1.8;
        margin: 0;
    }
    
    .consultation-details-page .notes-box {
        background: rgba(59, 130, 246, 0.05);
        border-left: 4px solid #3b82f6;
        border-radius: 12px;
        padding: 25px;
        margin-top: 20px;
    }
    
    .consultation-details-page .notes-title {
        font-weight: 600;
        color: #1e40af;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .consultation-details-page .notes-text {
        color: #555;
        line-height: 1.8;
        margin: 0;
    }
    
    .consultation-details-page .card-footer {
        padding: 25px 30px;
        background: #f8f6f1;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .consultation-details-page .booking-info {
        color: #888;
        font-size: 14px;
    }
    
    .consultation-details-page .booking-info i {
        color: #c9a227;
        margin-right: 8px;
    }
    
    .consultation-details-page .action-buttons {
        display: flex;
        gap: 12px;
    }
    
    .consultation-details-page .btn-back {
        padding: 12px 24px;
        background: #fff;
        color: #1a2e1a;
        border: 2px solid #e9ecef;
        border-radius: 12px;
        text-decoration: none;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
    }
    
    .consultation-details-page .btn-back:hover {
        border-color: #c9a227;
        color: #c9a227;
    }
    
    .consultation-details-page .btn-contact {
        padding: 12px 24px;
        background: linear-gradient(135deg, #c9a227, #e6b55c);
        color: #1a2e1a;
        border-radius: 12px;
        text-decoration: none;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
    }
    
    .consultation-details-page .btn-contact:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(201, 162, 39, 0.4);
        color: #1a2e1a;
    }
    
    .consultation-details-page .btn-view {
        padding: 10px 20px;
        background: #2d4a2d;
        color: #fff;
        border-radius: 10px;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
    }
    
    .consultation-details-page .btn-view:hover {
        background: #1a2e1a;
        color: #fff;
        transform: translateY(-2px);
    }
    
    .consultation-details-page .consultation-id {
        background: #f8f6f1;
        padding: 10px 20px;
        border-radius: 8px;
        font-family: monospace;
        font-size: 14px;
        color: #888;
    }
    
    @media (max-width: 767px) {
        .consultation-details-page .card-header {
            flex-direction: column;
        }
        
        .consultation-details-page .doctor-section {
            flex-direction: column;
            text-align: center;
        }
        
        .consultation-details-page .card-footer {
            flex-direction: column;
            align-items: stretch;
        }
        
        .consultation-details-page .action-buttons {
            flex-direction: column;
        }
        
        .consultation-details-page .action-buttons a {
            justify-content: center;
        }
    }
</style>

<div class="consultation-details-page">
    <!-- Back Link -->
    <a href="${pageContext.request.contextPath}/user/dashboard/consultations" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Consultations
    </a>
    
    <div class="detail-card">
        <!-- Status Bar -->
        <div class="status-bar ${fn:toLowerCase(consultation.status)}"></div>
        
        <!-- Card Header -->
        <div class="card-header">
            <div class="doctor-section">
                <div class="doctor-avatar">
                    <i class="fas fa-user-md"></i>
                </div>
                <div>
                    <h2 class="doctor-name">Dr. ${consultation.doctor.name}</h2>
                    <c:if test="${not empty consultation.doctor.specializations}">
                        <p class="doctor-specialty">${consultation.doctor.specializations}</p>
                    </c:if>
                    <c:if test="${not empty consultation.doctor.hospital}">
                        <p class="doctor-hospital">
                            <i class="fas fa-hospital"></i> ${consultation.doctor.hospital.centerName}
                        </p>
                    </c:if>
                </div>
            </div>
            
            <span class="status-badge ${fn:toLowerCase(consultation.status)}">
                <c:choose>
                    <c:when test="${consultation.status == 'PENDING'}">
                        <i class="fas fa-clock"></i> Pending
                    </c:when>
                    <c:when test="${consultation.status == 'CONFIRMED'}">
                        <i class="fas fa-check-circle"></i> Confirmed
                    </c:when>
                    <c:when test="${consultation.status == 'COMPLETED'}">
                        <i class="fas fa-check-double"></i> Completed
                    </c:when>
                    <c:when test="${consultation.status == 'CANCELLED'}">
                        <i class="fas fa-times-circle"></i> Cancelled
                    </c:when>
                    <c:otherwise>${consultation.status}</c:otherwise>
                </c:choose>
            </span>
        </div>
        
        <!-- Card Body -->
        <div class="card-body">
            <!-- Consultation Details -->
            <div class="info-section">
                <h3 class="section-title">
                    <i class="fas fa-info-circle"></i> Consultation Details
                </h3>
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-hashtag"></i>
                        </div>
                        <div>
                            <div class="info-label">Consultation ID</div>
                            <div class="info-value">${consultation.consultationNumber}</div>
                        </div>
                    </div>
                    
                    <c:if test="${consultation.consultationDate != null}">
                        <div class="info-item">
                            <div class="info-icon">
                                <i class="fas fa-calendar"></i>
                            </div>
                            <div>
                                <div class="info-label">Date</div>
                                <div class="info-value">
                                    <fmt:parseDate value="${consultation.consultationDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                    <fmt:formatDate value="${parsedDate}" pattern="EEEE, dd MMMM yyyy"/>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${consultation.consultationTime != null}">
                        <div class="info-item">
                            <div class="info-icon">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div>
                                <div class="info-label">Time</div>
                                <div class="info-value">${consultation.consultationTime}</div>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${consultation.consultationType != null}">
                        <div class="info-item">
                            <div class="info-icon">
                                <c:choose>
                                    <c:when test="${consultation.consultationType == 'ONLINE'}">
                                        <i class="fas fa-video"></i>
                                    </c:when>
                                    <c:when test="${consultation.consultationType == 'HOME_VISIT'}">
                                        <i class="fas fa-home"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-hospital"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div>
                                <div class="info-label">Consultation Type</div>
                                <div class="info-value">${fn:replace(consultation.consultationType, '_', ' ')}</div>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${consultation.durationMinutes != null}">
                        <div class="info-item">
                            <div class="info-icon">
                                <i class="fas fa-hourglass-half"></i>
                            </div>
                            <div>
                                <div class="info-label">Duration</div>
                                <div class="info-value">${consultation.durationMinutes} minutes</div>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${consultation.consultationFee != null}">
                        <div class="info-item">
                            <div class="info-icon">
                                <i class="fas fa-rupee-sign"></i>
                            </div>
                            <div>
                                <div class="info-label">Consultation Fee</div>
                                <div class="info-value">₹${consultation.consultationFee}</div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
            
            <!-- Reason for Visit -->
            <c:if test="${not empty consultation.reasonForVisit}">
                <div class="info-section">
                    <h3 class="section-title">
                        <i class="fas fa-comment-medical"></i> Reason for Consultation
                    </h3>
                    <div class="reason-box">
                        <p class="reason-text">${consultation.reasonForVisit}</p>
                    </div>
                </div>
            </c:if>
            
            <!-- Doctor's Notes (if completed) -->
            <c:if test="${consultation.status == 'COMPLETED' && not empty consultation.doctorNotes}">
                <div class="info-section">
                    <h3 class="section-title">
                        <i class="fas fa-notes-medical"></i> Doctor's Notes
                    </h3>
                    <div class="notes-box">
                        <p class="notes-text">${consultation.doctorNotes}</p>
                    </div>
                </div>
            </c:if>
            
            <!-- Prescription Link (if available) -->
            <c:if test="${not empty prescription}">
                <div class="info-section">
                    <h3 class="section-title">
                        <i class="fas fa-prescription"></i> Prescription
                    </h3>
                    <div class="reason-box" style="background: linear-gradient(135deg, rgba(45, 74, 45, 0.1), rgba(201, 162, 39, 0.1));">
                        <p class="reason-text" style="margin-bottom: 15px;">
                            A prescription has been created for this consultation.
                        </p>
                        <a href="${pageContext.request.contextPath}/user/dashboard/prescriptions/${prescription.id}" class="btn-view" style="display: inline-flex;">
                            <i class="fas fa-eye"></i> View Prescription
                        </a>
                    </div>
                </div>
            </c:if>
            
            <!-- Cancellation Reason (if cancelled) -->
            <c:if test="${consultation.status == 'CANCELLED' && not empty consultation.cancellationReason}">
                <div class="info-section">
                    <h3 class="section-title" style="color: #dc2626;">
                        <i class="fas fa-exclamation-triangle"></i> Cancellation Reason
                    </h3>
                    <div class="reason-box" style="border-left-color: #dc2626; background: rgba(220, 53, 69, 0.05);">
                        <p class="reason-text">${consultation.cancellationReason}</p>
                    </div>
                </div>
            </c:if>
        </div>
        
        <!-- Card Footer -->
        <div class="card-footer">
            <div class="booking-info">
                <i class="fas fa-calendar-plus"></i>
                Booked on 
                <c:catch var="dateError">
                    <fmt:parseDate value="${consultation.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt" type="both"/>
                    <fmt:formatDate value="${parsedCreatedAt}" pattern="dd MMM yyyy 'at' hh:mm a"/>
                </c:catch>
                <c:if test="${not empty dateError}">N/A</c:if>
            </div>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/user/dashboard/consultations" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
                <c:if test="${consultation.status == 'PENDING' || consultation.status == 'CONFIRMED'}">
                    <a href="${pageContext.request.contextPath}/contact" class="btn-contact">
                        <i class="fas fa-phone"></i> Contact Support
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</div>

        </div>
    </main>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Sidebar Toggle
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebarOverlay = document.getElementById('sidebarOverlay');
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', () => {
                sidebar.classList.toggle('active');
                sidebarOverlay.classList.toggle('active');
            });
        }
        
        if (sidebarOverlay) {
            sidebarOverlay.addEventListener('click', () => {
                sidebar.classList.remove('active');
                sidebarOverlay.classList.remove('active');
            });
        }
    </script>
</body>
</html>

