<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="My Consultations"/>
    <jsp:param name="activeNav" value="consultations"/>
</jsp:include>

<style>
    .consultations-page .page-header-box {
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #e9ecef;
    }
    
    .consultations-page .page-subtitle {
        color: #888;
        margin: 0;
        font-size: 15px;
    }
    
    .consultations-page .alert-box {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 16px 20px;
        border-radius: 12px;
        margin-bottom: 25px;
        font-weight: 500;
    }
    
    .consultations-page .alert-box.success {
        background: rgba(40, 167, 69, 0.1);
        color: #28a745;
        border: 1px solid rgba(40, 167, 69, 0.2);
    }
    
    .consultations-page .alert-box.error {
        background: rgba(220, 53, 69, 0.1);
        color: #dc3545;
        border: 1px solid rgba(220, 53, 69, 0.2);
    }
    
    .consultations-page .stats-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .consultations-page .mini-stat {
        background: #fff;
        border-radius: 16px;
        padding: 20px;
        display: flex;
        align-items: center;
        gap: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    }
    
    .consultations-page .mini-stat-icon {
        width: 50px;
        height: 50px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
    }
    
    .consultations-page .mini-stat-icon.total { background: rgba(45, 74, 45, 0.1); color: #2d4a2d; }
    .consultations-page .mini-stat-icon.pending { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
    .consultations-page .mini-stat-icon.confirmed { background: rgba(16, 185, 129, 0.1); color: #10b981; }
    .consultations-page .mini-stat-icon.completed { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
    
    .consultations-page .mini-stat h4 {
        font-size: 24px;
        font-weight: 700;
        color: #1a2e1a;
        margin: 0;
        font-family: 'Poppins', sans-serif;
    }
    
    .consultations-page .mini-stat p {
        font-size: 13px;
        color: #888;
        margin: 0;
    }
    
    .consultations-page .consultation-card {
        background: #fff;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 5px 25px rgba(0,0,0,0.06);
        margin-bottom: 25px;
        transition: all 0.3s ease;
        border: 1px solid rgba(0,0,0,0.04);
    }
    
    .consultations-page .consultation-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 40px rgba(0,0,0,0.1);
    }
    
    .consultations-page .card-status-bar {
        height: 5px;
    }
    
    .consultations-page .card-status-bar.pending { background: linear-gradient(90deg, #f59e0b, #fbbf24); }
    .consultations-page .card-status-bar.confirmed { background: linear-gradient(90deg, #10b981, #34d399); }
    .consultations-page .card-status-bar.completed { background: linear-gradient(90deg, #3b82f6, #60a5fa); }
    .consultations-page .card-status-bar.cancelled { background: linear-gradient(90deg, #ef4444, #f87171); }
    
    .consultations-page .card-header {
        padding: 25px;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 20px;
        border-bottom: 1px solid #f0f0f0;
    }
    
    .consultations-page .doctor-info {
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .consultations-page .doctor-avatar {
        width: 60px;
        height: 60px;
        background: linear-gradient(135deg, #2d4a2d, #1a2e1a);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        font-size: 24px;
    }
    
    .consultations-page .doctor-name {
        font-size: 20px;
        font-weight: 600;
        color: #1a2e1a;
        margin: 0 0 5px 0;
        font-family: 'Poppins', sans-serif;
    }
    
    .consultations-page .doctor-hospital {
        display: flex;
        align-items: center;
        gap: 6px;
        color: #888;
        font-size: 14px;
        margin: 0;
    }
    
    .consultations-page .doctor-hospital i {
        color: #c9a227;
    }
    
    .consultations-page .consultation-number {
        font-size: 13px;
        color: #aaa;
        margin-top: 8px;
    }
    
    .consultations-page .status-badge {
        padding: 8px 18px;
        border-radius: 25px;
        font-size: 13px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .consultations-page .status-badge.pending {
        background: rgba(245, 158, 11, 0.15);
        color: #d97706;
    }
    
    .consultations-page .status-badge.confirmed {
        background: rgba(16, 185, 129, 0.15);
        color: #059669;
    }
    
    .consultations-page .status-badge.completed {
        background: rgba(59, 130, 246, 0.15);
        color: #2563eb;
    }
    
    .consultations-page .status-badge.cancelled {
        background: rgba(239, 68, 68, 0.15);
        color: #dc2626;
    }
    
    .consultations-page .card-details {
        padding: 25px;
        background: #f8f6f1;
    }
    
    .consultations-page .details-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
        gap: 20px;
    }
    
    .consultations-page .detail-box {
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .consultations-page .detail-icon {
        width: 45px;
        height: 45px;
        background: #fff;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #c9a227;
        font-size: 18px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.08);
    }
    
    .consultations-page .detail-label {
        font-size: 11px;
        color: #888;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 3px;
    }
    
    .consultations-page .detail-value {
        font-size: 15px;
        font-weight: 600;
        color: #1a2e1a;
    }
    
    .consultations-page .reason-box {
        margin: 0 25px 25px;
        padding: 20px;
        background: linear-gradient(135deg, rgba(45, 74, 45, 0.05), rgba(201, 162, 39, 0.05));
        border-left: 4px solid #2d4a2d;
        border-radius: 12px;
    }
    
    .consultations-page .reason-title {
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: 600;
        color: #1a2e1a;
        margin-bottom: 10px;
        font-size: 14px;
    }
    
    .consultations-page .reason-title i {
        color: #c9a227;
    }
    
    .consultations-page .reason-text {
        color: #555;
        line-height: 1.7;
        margin: 0;
        font-size: 14px;
    }
    
    .consultations-page .card-footer {
        padding: 20px 25px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
        border-top: 1px solid #f0f0f0;
    }
    
    .consultations-page .booked-date {
        display: flex;
        align-items: center;
        gap: 8px;
        color: #888;
        font-size: 13px;
    }
    
    .consultations-page .booked-date i {
        color: #c9a227;
    }
    
    .consultations-page .action-buttons {
        display: flex;
        gap: 10px;
    }
    
    .consultations-page .btn-view {
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
    
    .consultations-page .btn-view:hover {
        background: #1a2e1a;
        color: #fff;
        transform: translateY(-2px);
    }
    
    .consultations-page .btn-cancel {
        padding: 10px 20px;
        background: transparent;
        color: #dc3545;
        border: 2px solid #dc3545;
        border-radius: 10px;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
        cursor: pointer;
    }
    
    .consultations-page .btn-cancel:hover {
        background: #dc3545;
        color: #fff;
    }
    
    .consultations-page .btn-find {
        background: linear-gradient(135deg, #c9a227, #e6b55c);
        color: #1a2e1a;
        padding: 14px 28px;
        border-radius: 12px;
        font-weight: 600;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        transition: all 0.3s ease;
    }
    
    .consultations-page .btn-find:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(201, 162, 39, 0.4);
        color: #1a2e1a;
    }
    
    .consultations-page .empty-box {
        background: #fff;
        border-radius: 20px;
        padding: 60px 30px;
        text-align: center;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    }
    
    .consultations-page .empty-icon {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: #f8f6f1;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 25px;
    }
    
    .consultations-page .empty-icon i {
        font-size: 40px;
        color: #ccc;
    }
    
    .consultations-page .empty-box h4 {
        font-size: 22px;
        color: #1a2e1a;
        margin-bottom: 10px;
    }
    
    .consultations-page .empty-box p {
        color: #888;
        margin-bottom: 25px;
        max-width: 400px;
        margin-left: auto;
        margin-right: auto;
    }
    
    @media (max-width: 767px) {
        .consultations-page .card-header {
            flex-direction: column;
        }
        
        .consultations-page .card-footer {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .consultations-page .action-buttons {
            width: 100%;
        }
        
        .consultations-page .action-buttons a,
        .consultations-page .action-buttons button {
            flex: 1;
            justify-content: center;
        }
    }
</style>

<div class="consultations-page">
    <!-- Page Header -->
    <div class="page-header-box">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <p class="page-subtitle">View and manage your doctor consultations</p>
            </div>
            <a href="${pageContext.request.contextPath}/doctors" class="btn-find">
                <i class="fas fa-user-md"></i> Book New Consultation
            </a>
        </div>
    </div>

    <!-- Alerts -->
    <c:if test="${not empty success}">
        <div class="alert-box success">
            <i class="fas fa-check-circle"></i>
            <span>${success}</span>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert-box error">
            <i class="fas fa-exclamation-circle"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <!-- Stats Row -->
    <div class="stats-row">
        <div class="mini-stat">
            <div class="mini-stat-icon total">
                <i class="fas fa-stethoscope"></i>
            </div>
            <div>
                <h4>${fn:length(consultations)}</h4>
                <p>Total</p>
            </div>
        </div>
        <div class="mini-stat">
            <div class="mini-stat-icon pending">
                <i class="fas fa-clock"></i>
            </div>
            <div>
                <h4>
                    <c:set var="pendingCount" value="0"/>
                    <c:forEach var="c" items="${consultations}">
                        <c:if test="${c.status == 'PENDING'}">
                            <c:set var="pendingCount" value="${pendingCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${pendingCount}
                </h4>
                <p>Pending</p>
            </div>
        </div>
        <div class="mini-stat">
            <div class="mini-stat-icon confirmed">
                <i class="fas fa-check-circle"></i>
            </div>
            <div>
                <h4>
                    <c:set var="confirmedCount" value="0"/>
                    <c:forEach var="c" items="${consultations}">
                        <c:if test="${c.status == 'CONFIRMED'}">
                            <c:set var="confirmedCount" value="${confirmedCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${confirmedCount}
                </h4>
                <p>Confirmed</p>
            </div>
        </div>
        <div class="mini-stat">
            <div class="mini-stat-icon completed">
                <i class="fas fa-check-double"></i>
            </div>
            <div>
                <h4>
                    <c:set var="completedCount" value="0"/>
                    <c:forEach var="c" items="${consultations}">
                        <c:if test="${c.status == 'COMPLETED'}">
                            <c:set var="completedCount" value="${completedCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${completedCount}
                </h4>
                <p>Completed</p>
            </div>
        </div>
    </div>

    <!-- Consultations List -->
    <c:choose>
        <c:when test="${not empty consultations}">
            <c:forEach var="consultation" items="${consultations}">
                <div class="consultation-card">
                    <!-- Status Bar -->
                    <div class="card-status-bar ${fn:toLowerCase(consultation.status)}"></div>
                    
                    <!-- Card Header -->
                    <div class="card-header">
                        <div class="doctor-info">
                            <div class="doctor-avatar">
                                <i class="fas fa-user-md"></i>
                            </div>
                            <div>
                                <h3 class="doctor-name">Dr. ${consultation.doctor.name}</h3>
                                <c:if test="${not empty consultation.doctor.hospital}">
                                    <p class="doctor-hospital">
                                        <i class="fas fa-hospital"></i> ${consultation.doctor.hospital.centerName}
                                    </p>
                                </c:if>
                                <p class="consultation-number">
                                    <i class="fas fa-hashtag"></i> ${consultation.consultationNumber}
                                </p>
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
                    
                    <!-- Card Details -->
                    <div class="card-details">
                        <div class="details-grid">
                            <c:if test="${consultation.consultationDate != null}">
                                <div class="detail-box">
                                    <div class="detail-icon">
                                        <i class="fas fa-calendar"></i>
                                    </div>
                                    <div>
                                        <div class="detail-label">Date</div>
                                        <div class="detail-value">
                                            <fmt:parseDate value="${consultation.consultationDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                            <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            
                            <c:if test="${consultation.consultationTime != null}">
                                <div class="detail-box">
                                    <div class="detail-icon">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <div>
                                        <div class="detail-label">Time</div>
                                        <div class="detail-value">${consultation.consultationTime}</div>
                                    </div>
                                </div>
                            </c:if>
                            
                            <c:if test="${consultation.consultationType != null}">
                                <div class="detail-box">
                                    <div class="detail-icon">
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
                                        <div class="detail-label">Type</div>
                                        <div class="detail-value">${fn:replace(consultation.consultationType, '_', ' ')}</div>
                                    </div>
                                </div>
                            </c:if>
                            
                            <c:if test="${consultation.durationMinutes != null}">
                                <div class="detail-box">
                                    <div class="detail-icon">
                                        <i class="fas fa-hourglass-half"></i>
                                    </div>
                                    <div>
                                        <div class="detail-label">Duration</div>
                                        <div class="detail-value">${consultation.durationMinutes} min</div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    
                    <!-- Reason for Visit -->
                    <c:if test="${not empty consultation.reasonForVisit}">
                        <div class="reason-box">
                            <div class="reason-title">
                                <i class="fas fa-comment-medical"></i>
                                Reason for Consultation
                            </div>
                            <p class="reason-text">${consultation.reasonForVisit}</p>
                        </div>
                    </c:if>
                    
                    <!-- Card Footer -->
                    <div class="card-footer">
                        <div class="booked-date">
                            <i class="fas fa-calendar-plus"></i>
                            <span>
                                Booked on 
                                <c:catch var="dateError">
                                    <fmt:parseDate value="${consultation.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt" type="both"/>
                                    <fmt:formatDate value="${parsedCreatedAt}" pattern="dd MMM yyyy"/>
                                </c:catch>
                                <c:if test="${not empty dateError}">
                                    N/A
                                </c:if>
                            </span>
                        </div>
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/user/dashboard/consultations/${consultation.id}" class="btn-view">
                                <i class="fas fa-eye"></i> View Details
                            </a>
                            <c:if test="${consultation.status == 'PENDING' || consultation.status == 'CONFIRMED'}">
                                <a href="${pageContext.request.contextPath}/contact" class="btn-cancel">
                                    <i class="fas fa-phone"></i> Contact to Cancel
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-box">
                <div class="empty-icon">
                    <i class="fas fa-stethoscope"></i>
                </div>
                <h4>No Consultations Yet</h4>
                <p>You haven't booked any consultations yet. Browse our experienced Ayurvedic doctors and book your first consultation!</p>
                <a href="${pageContext.request.contextPath}/doctors" class="btn-find">
                    <i class="fas fa-search"></i> Find Doctors
                </a>
            </div>
        </c:otherwise>
    </c:choose>
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
