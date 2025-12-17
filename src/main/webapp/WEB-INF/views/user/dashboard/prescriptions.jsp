<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="My Prescriptions"/>
    <jsp:param name="activeNav" value="prescriptions"/>
</jsp:include>

<style>
    .prescriptions-page .page-header-box {
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #e9ecef;
    }
    
    .prescriptions-page .page-subtitle {
        color: #888;
        margin: 0;
        font-size: 15px;
    }
    
    .prescriptions-page .alert-box {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 16px 20px;
        border-radius: 12px;
        margin-bottom: 25px;
        font-weight: 500;
    }
    
    .prescriptions-page .alert-box.success {
        background: rgba(40, 167, 69, 0.1);
        color: #28a745;
        border: 1px solid rgba(40, 167, 69, 0.2);
    }
    
    .prescriptions-page .alert-box.error {
        background: rgba(220, 53, 69, 0.1);
        color: #dc3545;
        border: 1px solid rgba(220, 53, 69, 0.2);
    }
    
    .prescriptions-page .prescription-card {
        background: #fff;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 5px 25px rgba(0,0,0,0.06);
        margin-bottom: 25px;
        transition: all 0.3s ease;
        border: 1px solid rgba(0,0,0,0.04);
    }
    
    .prescriptions-page .prescription-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 40px rgba(0,0,0,0.1);
    }
    
    .prescriptions-page .card-header {
        padding: 25px;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 20px;
        border-bottom: 1px solid #f0f0f0;
    }
    
    .prescriptions-page .prescription-info {
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .prescriptions-page .prescription-icon {
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
    
    .prescriptions-page .prescription-number {
        font-size: 20px;
        font-weight: 600;
        color: #1a2e1a;
        margin: 0 0 5px 0;
        font-family: 'Poppins', sans-serif;
    }
    
    .prescriptions-page .prescription-date {
        display: flex;
        align-items: center;
        gap: 6px;
        color: #888;
        font-size: 14px;
        margin: 0;
    }
    
    .prescriptions-page .prescription-date i {
        color: #2d4a2d;
    }
    
    .prescriptions-page .doctor-info {
        text-align: right;
    }
    
    .prescriptions-page .doctor-name {
        font-size: 16px;
        font-weight: 600;
        color: #1a2e1a;
        margin: 0 0 5px 0;
    }
    
    .prescriptions-page .doctor-hospital {
        display: flex;
        align-items: center;
        gap: 6px;
        color: #888;
        font-size: 13px;
        margin: 0;
        justify-content: flex-end;
    }
    
    .prescriptions-page .doctor-hospital i {
        color: #2d4a2d;
    }
    
    .prescriptions-page .card-body {
        padding: 25px;
        background: #f8f6f1;
    }
    
    .prescriptions-page .details-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
    }
    
    .prescriptions-page .detail-box {
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .prescriptions-page .detail-icon {
        width: 45px;
        height: 45px;
        background: #fff;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #2d4a2d;
        font-size: 18px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.08);
    }
    
    .prescriptions-page .detail-label {
        font-size: 11px;
        color: #888;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 3px;
    }
    
    .prescriptions-page .detail-value {
        font-size: 15px;
        font-weight: 600;
        color: #1a2e1a;
    }
    
    .prescriptions-page .diagnosis-box {
        margin-top: 20px;
        padding: 20px;
        background: linear-gradient(135deg, rgba(45, 74, 45, 0.05), rgba(201, 162, 39, 0.05));
        border-left: 4px solid #2d4a2d;
        border-radius: 12px;
    }
    
    .prescriptions-page .diagnosis-title {
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: 600;
        color: #1a2e1a;
        margin-bottom: 10px;
        font-size: 14px;
    }
    
    .prescriptions-page .diagnosis-title i {
        color: #2d4a2d;
    }
    
    .prescriptions-page .diagnosis-text {
        color: #555;
        line-height: 1.7;
        margin: 0;
        font-size: 14px;
    }
    
    .prescriptions-page .card-footer {
        padding: 20px 25px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
        border-top: 1px solid #f0f0f0;
    }
    
    .prescriptions-page .medicines-count {
        display: flex;
        align-items: center;
        gap: 8px;
        color: #888;
        font-size: 13px;
    }
    
    .prescriptions-page .medicines-count i {
        color: #2d4a2d;
    }
    
    .prescriptions-page .action-buttons {
        display: flex;
        gap: 10px;
    }
    
    .prescriptions-page .btn-view {
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
    
    .prescriptions-page .btn-view:hover {
        background: #1a2e1a;
        color: #fff;
        transform: translateY(-2px);
    }
    
    .prescriptions-page .empty-box {
        background: #fff;
        border-radius: 20px;
        padding: 60px 30px;
        text-align: center;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    }
    
    .prescriptions-page .empty-icon {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: #f8f6f1;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 25px;
    }
    
    .prescriptions-page .empty-icon i {
        font-size: 40px;
        color: #ccc;
    }
    
    .prescriptions-page .empty-box h4 {
        font-size: 22px;
        color: #1a2e1a;
        margin-bottom: 10px;
    }
    
    .prescriptions-page .empty-box p {
        color: #888;
        margin-bottom: 25px;
        max-width: 400px;
        margin-left: auto;
        margin-right: auto;
    }
    
    @media (max-width: 767px) {
        .prescriptions-page .card-header {
            flex-direction: column;
        }
        
        .prescriptions-page .doctor-info {
            text-align: left;
        }
        
        .prescriptions-page .card-footer {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .prescriptions-page .action-buttons {
            width: 100%;
        }
        
        .prescriptions-page .action-buttons a {
            flex: 1;
            justify-content: center;
        }
    }
</style>

<div class="prescriptions-page">
    <!-- Page Header -->
    <div class="page-header-box">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <p class="page-subtitle">View all your prescriptions from consultations</p>
            </div>
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

    <!-- Prescriptions List -->
    <c:choose>
        <c:when test="${not empty prescriptions}">
            <c:forEach var="prescription" items="${prescriptions}">
                <div class="prescription-card">
                    <!-- Card Header -->
                    <div class="card-header">
                        <div class="prescription-info">
                            <div class="prescription-icon">
                                <i class="fas fa-prescription"></i>
                            </div>
                            <div>
                                <h3 class="prescription-number">${prescription.prescriptionNumber}</h3>
                                <p class="prescription-date">
                                    <i class="fas fa-calendar"></i>
                                    <c:catch var="dateError">
                                        <fmt:parseDate value="${prescription.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                        <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy 'at' hh:mm a"/>
                                    </c:catch>
                                    <c:if test="${not empty dateError}">
                                        <fmt:formatDate value="${prescription.createdAt}" pattern="dd MMM yyyy"/>
                                    </c:if>
                                </p>
                            </div>
                        </div>
                        <div class="doctor-info">
                            <p class="doctor-name">Dr. ${prescription.doctor.name}</p>
                            <c:if test="${not empty prescription.hospital}">
                                <p class="doctor-hospital">
                                    <i class="fas fa-hospital"></i> ${prescription.hospital.centerName}
                                </p>
                            </c:if>
                        </div>
                    </div>
                    
                    <!-- Card Body -->
                    <div class="card-body">
                        <div class="details-grid">
                            <c:if test="${not empty prescription.consultation}">
                                <div class="detail-box">
                                    <div class="detail-icon">
                                        <i class="fas fa-stethoscope"></i>
                                    </div>
                                    <div>
                                        <div class="detail-label">Consultation</div>
                                        <div class="detail-value">${prescription.consultation.consultationNumber}</div>
                                    </div>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty prescription.doshaImbalance}">
                                <div class="detail-box">
                                    <div class="detail-icon">
                                        <i class="fas fa-leaf"></i>
                                    </div>
                                    <div>
                                        <div class="detail-label">Dosha Imbalance</div>
                                        <div class="detail-value">${prescription.doshaImbalance}</div>
                                    </div>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty prescription.followUpDate}">
                                <div class="detail-box">
                                    <div class="detail-icon">
                                        <i class="fas fa-calendar-check"></i>
                                    </div>
                                    <div>
                                        <div class="detail-label">Follow-up Date</div>
                                        <div class="detail-value">
                                            <fmt:parseDate value="${prescription.followUpDate}" pattern="yyyy-MM-dd" var="parsedFollowUp" type="date"/>
                                            <fmt:formatDate value="${parsedFollowUp}" pattern="dd MMM yyyy"/>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                        
                        <c:if test="${not empty prescription.diagnosis}">
                            <div class="diagnosis-box">
                                <div class="diagnosis-title">
                                    <i class="fas fa-notes-medical"></i>
                                    Diagnosis
                                </div>
                                <p class="diagnosis-text">${prescription.diagnosis}</p>
                            </div>
                        </c:if>
                    </div>
                    
                    <!-- Card Footer -->
                    <div class="card-footer">
                        <div class="medicines-count">
                            <i class="fas fa-pills"></i>
                            <span>
                                <c:choose>
                                    <c:when test="${not empty prescription.medicines}">
                                        ${fn:length(prescription.medicines)} Medicine<c:if test="${fn:length(prescription.medicines) > 1}">s</c:if>
                                    </c:when>
                                    <c:otherwise>
                                        No medicines prescribed
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/user/dashboard/prescriptions/${prescription.id}" class="btn-view">
                                <i class="fas fa-eye"></i> View Details
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-box">
                <div class="empty-icon">
                    <i class="fas fa-prescription"></i>
                </div>
                <h4>No Prescriptions Yet</h4>
                <p>You don't have any prescriptions yet. Prescriptions will appear here after your consultations are completed and the doctor writes a prescription.</p>
                <a href="${pageContext.request.contextPath}/user/dashboard/consultations" class="btn-view">
                    <i class="fas fa-stethoscope"></i> View Consultations
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

