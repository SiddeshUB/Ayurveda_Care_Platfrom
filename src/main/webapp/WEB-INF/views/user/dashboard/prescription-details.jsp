<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="Prescription Details"/>
    <jsp:param name="activeNav" value="prescriptions"/>
</jsp:include>

<style>
    .prescription-details-page .back-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: #888;
        text-decoration: none;
        font-weight: 500;
        margin-bottom: 20px;
        transition: all 0.3s ease;
    }
    
    .prescription-details-page .back-link:hover {
        color: #2d4a2d;
    }
    
    .prescription-details-page .prescription-header {
        background: linear-gradient(135deg, #2d4a2d, #1a2e1a);
        color: white;
        padding: 30px;
        border-radius: 20px;
        margin-bottom: 25px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.1);
    }
    
    .prescription-details-page .prescription-header h2 {
        font-size: 24px;
        font-weight: 600;
        margin: 0 0 10px 0;
    }
    
    .prescription-details-page .prescription-header p {
        margin: 0;
        opacity: 0.9;
        font-size: 14px;
    }
    
    .prescription-details-page .prescription-header i {
        margin-right: 8px;
    }
    
    .prescription-details-page .doctor-info-box {
        background: rgba(255,255,255,0.2);
        padding: 15px 20px;
        border-radius: 12px;
        display: inline-block;
        margin-top: 15px;
    }
    
    .prescription-details-page .prescription-section {
        background: #fff;
        border-radius: 20px;
        padding: 25px;
        margin-bottom: 25px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.06);
        border: 1px solid rgba(0,0,0,0.04);
    }
    
    .prescription-details-page .section-title {
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
    
    .prescription-details-page .section-title i {
        color: #2d4a2d;
    }
    
    .prescription-details-page .detail-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-top: 15px;
    }
    
    .prescription-details-page .detail-item {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }
    
    .prescription-details-page .detail-label {
        font-size: 12px;
        color: #888;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .prescription-details-page .detail-value {
        font-size: 15px;
        font-weight: 600;
        color: #1a2e1a;
    }
    
    .prescription-details-page .text-content {
        color: #555;
        line-height: 1.8;
        margin-top: 10px;
        white-space: pre-wrap;
    }
    
    .prescription-details-page .dosha-badge {
        background: #2d4a2d;
        color: white;
        padding: 8px 16px;
        border-radius: 20px;
        display: inline-block;
        margin-top: 10px;
        font-weight: 600;
        font-size: 14px;
    }
    
    .prescription-details-page .medicine-item {
        background: linear-gradient(135deg, rgba(45, 74, 45, 0.05), rgba(201, 162, 39, 0.05));
        border-left: 4px solid #2d4a2d;
        padding: 20px;
        margin-bottom: 15px;
        border-radius: 12px;
        transition: all 0.3s ease;
    }
    
    .prescription-details-page .medicine-item:hover {
        transform: translateX(5px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .prescription-details-page .medicine-item h4 {
        font-size: 18px;
        font-weight: 600;
        color: #1a2e1a;
        margin: 0 0 15px 0;
    }
    
    .prescription-details-page .medicine-details {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
        gap: 15px;
        color: #555;
        font-size: 14px;
    }
    
    .prescription-details-page .medicine-details i {
        color: #2d4a2d;
        margin-right: 8px;
    }
    
    .prescription-details-page .medicine-instructions {
        margin-top: 15px;
        padding-top: 15px;
        border-top: 1px solid rgba(0,0,0,0.1);
    }
    
    .prescription-details-page .medicine-instructions strong {
        color: #1a2e1a;
    }
    
    .prescription-details-page .guidelines-box {
        background: linear-gradient(135deg, rgba(45, 74, 45, 0.05), rgba(201, 162, 39, 0.05));
        border-left: 4px solid #2d4a2d;
        padding: 20px;
        border-radius: 12px;
        margin-bottom: 20px;
    }
    
    .prescription-details-page .guidelines-box strong {
        display: flex;
        align-items: center;
        gap: 10px;
        color: #1a2e1a;
        margin-bottom: 10px;
        font-size: 15px;
    }
    
    .prescription-details-page .guidelines-box strong i {
        color: #2d4a2d;
    }
    
    .prescription-details-page .guidelines-box p {
        color: #555;
        line-height: 1.8;
        margin: 0;
        white-space: pre-wrap;
    }
    
    .prescription-details-page .card-footer {
        padding: 25px;
        background: #f8f6f1;
        border-radius: 0 0 20px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
        margin-top: 25px;
    }
    
    .prescription-details-page .btn-back {
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
    
    .prescription-details-page .btn-back:hover {
        border-color: #2d4a2d;
        color: #2d4a2d;
    }
    
    @media (max-width: 767px) {
        .prescription-details-page .prescription-header {
            padding: 20px;
        }
        
        .prescription-details-page .prescription-section {
            padding: 20px;
        }
        
        .prescription-details-page .card-footer {
            flex-direction: column;
            align-items: stretch;
        }
        
        .prescription-details-page .btn-back {
            width: 100%;
            justify-content: center;
        }
    }
</style>

<div class="prescription-details-page">
    <!-- Back Link -->
    <a href="${pageContext.request.contextPath}/user/dashboard/prescriptions" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Prescriptions
    </a>
    
    <!-- Prescription Header -->
    <div class="prescription-header">
        <h2>Prescription #${prescription.prescriptionNumber}</h2>
        <p>
            <i class="fas fa-calendar"></i>
            <c:catch var="dateError">
                <fmt:parseDate value="${prescription.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                <fmt:formatDate value="${parsedDate}" pattern="dd MMMM yyyy 'at' hh:mm a"/>
            </c:catch>
            <c:if test="${not empty dateError}">
                <fmt:formatDate value="${prescription.createdAt}" pattern="dd MMMM yyyy"/>
            </c:if>
        </p>
        <div class="doctor-info-box">
            <strong>Dr. ${prescription.doctor.name}</strong><br>
            <small>${prescription.hospital != null ? prescription.hospital.centerName : 'Independent Practice'}</small>
        </div>
    </div>
    
    <!-- Patient Information -->
    <div class="prescription-section">
        <h3 class="section-title">
            <i class="fas fa-user"></i> Patient Information
        </h3>
        <div class="detail-grid">
            <div class="detail-item">
                <div class="detail-label">Name</div>
                <div class="detail-value">${prescription.patientName}</div>
            </div>
            <c:if test="${prescription.patientAge != null}">
                <div class="detail-item">
                    <div class="detail-label">Age</div>
                    <div class="detail-value">${prescription.patientAge} years</div>
                </div>
            </c:if>
            <c:if test="${not empty prescription.patientGender}">
                <div class="detail-item">
                    <div class="detail-label">Gender</div>
                    <div class="detail-value">${prescription.patientGender}</div>
                </div>
            </c:if>
            <div class="detail-item">
                <div class="detail-label">Email</div>
                <div class="detail-value">${prescription.patientEmail}</div>
            </div>
            <c:if test="${not empty prescription.patientPhone}">
                <div class="detail-item">
                    <div class="detail-label">Phone</div>
                    <div class="detail-value">${prescription.patientPhone}</div>
                </div>
            </c:if>
        </div>
    </div>
    
    <!-- Diagnosis & Assessment -->
    <div class="prescription-section">
        <h3 class="section-title">
            <i class="fas fa-stethoscope"></i> Diagnosis & Assessment
        </h3>
        <c:if test="${not empty prescription.chiefComplaints}">
            <div style="margin-bottom: 20px;">
                <div class="detail-label">Chief Complaints</div>
                <p class="text-content">${prescription.chiefComplaints}</p>
            </div>
        </c:if>
        <c:if test="${not empty prescription.diagnosis}">
            <div style="margin-bottom: 20px;">
                <div class="detail-label">Diagnosis</div>
                <p class="text-content">${prescription.diagnosis}</p>
            </div>
        </c:if>
        <c:if test="${not empty prescription.doshaImbalance}">
            <div>
                <div class="detail-label">Dosha Imbalance</div>
                <span class="dosha-badge">${prescription.doshaImbalance}</span>
            </div>
        </c:if>
    </div>
    
    <!-- Prescribed Medicines -->
    <c:if test="${not empty prescription.medicines}">
        <div class="prescription-section">
            <h3 class="section-title">
                <i class="fas fa-pills"></i> Prescribed Medicines
            </h3>
            <c:forEach var="medicine" items="${prescription.medicines}">
                <div class="medicine-item">
                    <h4>${medicine.medicineName}</h4>
                    <div class="medicine-details">
                        <div>
                            <i class="fas fa-capsules"></i>
                            <strong>Dosage:</strong> ${medicine.dosage != null ? medicine.dosage : 'As prescribed'}
                        </div>
                        <div>
                            <i class="fas fa-clock"></i>
                            <strong>Frequency:</strong> ${medicine.frequency != null ? medicine.frequency : 'N/A'}
                        </div>
                        <div>
                            <i class="fas fa-sun"></i>
                            <strong>Timing:</strong> ${medicine.timing != null ? medicine.timing : 'N/A'}
                        </div>
                        <c:if test="${medicine.durationDays != null}">
                            <div>
                                <i class="fas fa-calendar-alt"></i>
                                <strong>Duration:</strong> ${medicine.durationDays} days
                            </div>
                        </c:if>
                    </div>
                    <c:if test="${not empty medicine.instructions}">
                        <div class="medicine-instructions">
                            <strong>Instructions:</strong> ${medicine.instructions}
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <!-- Lifestyle & Diet Guidelines -->
    <c:if test="${not empty prescription.dietGuidelines || not empty prescription.lifestyleGuidelines || not empty prescription.yogaPranayama}">
        <div class="prescription-section">
            <h3 class="section-title">
                <i class="fas fa-leaf"></i> Lifestyle & Diet Guidelines
            </h3>
            <c:if test="${not empty prescription.dietGuidelines}">
                <div class="guidelines-box">
                    <strong>
                        <i class="fas fa-utensils"></i> Diet Guidelines
                    </strong>
                    <p>${prescription.dietGuidelines}</p>
                </div>
            </c:if>
            <c:if test="${not empty prescription.lifestyleGuidelines}">
                <div class="guidelines-box">
                    <strong>
                        <i class="fas fa-heart"></i> Lifestyle Guidelines
                    </strong>
                    <p>${prescription.lifestyleGuidelines}</p>
                </div>
            </c:if>
            <c:if test="${not empty prescription.yogaPranayama}">
                <div class="guidelines-box">
                    <strong>
                        <i class="fas fa-spa"></i> Yoga & Pranayama
                    </strong>
                    <p>${prescription.yogaPranayama}</p>
                </div>
            </c:if>
        </div>
    </c:if>
    
    <!-- Other Instructions -->
    <c:if test="${not empty prescription.otherInstructions}">
        <div class="prescription-section">
            <h3 class="section-title">
                <i class="fas fa-notes-medical"></i> Additional Instructions
            </h3>
            <p class="text-content">${prescription.otherInstructions}</p>
        </div>
    </c:if>
    
    <!-- Follow-up Information -->
    <c:if test="${not empty prescription.followUpDate || prescription.followUpDays != null}">
        <div class="prescription-section">
            <h3 class="section-title">
                <i class="fas fa-calendar-check"></i> Follow-up Information
            </h3>
            <div class="detail-grid">
                <c:if test="${not empty prescription.followUpDate}">
                    <div class="detail-item">
                        <div class="detail-label">Follow-up Date</div>
                        <div class="detail-value">
                            <fmt:parseDate value="${prescription.followUpDate}" pattern="yyyy-MM-dd" var="parsedFollowUp" type="date"/>
                            <fmt:formatDate value="${parsedFollowUp}" pattern="dd MMMM yyyy"/>
                        </div>
                    </div>
                </c:if>
                <c:if test="${prescription.followUpDays != null}">
                    <div class="detail-item">
                        <div class="detail-label">Follow-up After</div>
                        <div class="detail-value">${prescription.followUpDays} days</div>
                    </div>
                </c:if>
            </div>
        </div>
    </c:if>
    
    <!-- Footer -->
    <div class="card-footer">
        <div>
            <c:if test="${not empty prescription.consultation}">
                <a href="${pageContext.request.contextPath}/user/dashboard/consultations/${prescription.consultation.id}" class="btn-back">
                    <i class="fas fa-stethoscope"></i> View Consultation
                </a>
            </c:if>
        </div>
        <a href="${pageContext.request.contextPath}/user/dashboard/prescriptions" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Prescriptions
        </a>
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

