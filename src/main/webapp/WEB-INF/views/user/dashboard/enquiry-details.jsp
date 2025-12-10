<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    com.ayurveda.entity.UserEnquiry e = (com.ayurveda.entity.UserEnquiry) request.getAttribute("enquiry");
%>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="Enquiry Details"/>
    <jsp:param name="activeNav" value="enquiries"/>
</jsp:include>

<style>
    .enquiry-details-page .back-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: #888;
        text-decoration: none;
        font-weight: 500;
        margin-bottom: 25px;
        transition: all 0.3s ease;
    }
    
    .enquiry-details-page .back-link:hover {
        color: #c9a227;
    }
    
    .enquiry-details-page .detail-card {
        background: #fff;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 5px 25px rgba(0,0,0,0.06);
        margin-bottom: 25px;
    }
    
    .enquiry-details-page .status-bar {
        height: 6px;
    }
    
    .enquiry-details-page .status-bar.pending { background: linear-gradient(90deg, #f59e0b, #fbbf24); }
    .enquiry-details-page .status-bar.replied { background: linear-gradient(90deg, #06b6d4, #22d3ee); }
    .enquiry-details-page .status-bar.quotation_sent { background: linear-gradient(90deg, #10b981, #34d399); }
    .enquiry-details-page .status-bar.closed { background: linear-gradient(90deg, #6b7280, #9ca3af); }
    
    .enquiry-details-page .card-header {
        padding: 30px;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 20px;
        flex-wrap: wrap;
        background: linear-gradient(135deg, rgba(45, 74, 45, 0.03), rgba(201, 162, 39, 0.03));
        border-bottom: 1px solid #f0f0f0;
    }
    
    .enquiry-details-page .hospital-info {
        display: flex;
        align-items: center;
        gap: 20px;
    }
    
    .enquiry-details-page .hospital-icon {
        width: 70px;
        height: 70px;
        background: linear-gradient(135deg, #c9a227, #e6b55c);
        border-radius: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #1a2e1a;
        font-size: 28px;
    }
    
    .enquiry-details-page .hospital-name {
        font-size: 24px;
        font-weight: 600;
        color: #1a2e1a;
        margin: 0 0 8px 0;
    }
    
    .enquiry-details-page .hospital-location {
        display: flex;
        align-items: center;
        gap: 6px;
        color: #888;
        font-size: 14px;
        margin-bottom: 5px;
    }
    
    .enquiry-details-page .hospital-location i {
        color: #c9a227;
    }
    
    .enquiry-details-page .enquiry-number {
        font-size: 13px;
        color: #aaa;
        font-family: monospace;
        background: #f8f6f1;
        padding: 5px 12px;
        border-radius: 6px;
        display: inline-block;
        margin-top: 5px;
    }
    
    .enquiry-details-page .status-badge {
        padding: 12px 24px;
        border-radius: 30px;
        font-size: 14px;
        font-weight: 600;
        text-transform: uppercase;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }
    
    .enquiry-details-page .status-badge.pending {
        background: rgba(245, 158, 11, 0.15);
        color: #d97706;
    }
    
    .enquiry-details-page .status-badge.replied {
        background: rgba(6, 182, 212, 0.15);
        color: #0891b2;
    }
    
    .enquiry-details-page .status-badge.quotation_sent {
        background: rgba(16, 185, 129, 0.15);
        color: #059669;
    }
    
    .enquiry-details-page .status-badge.closed {
        background: rgba(107, 114, 128, 0.15);
        color: #4b5563;
    }
    
    .enquiry-details-page .card-body {
        padding: 30px;
    }
    
    .enquiry-details-page .section {
        margin-bottom: 30px;
        padding-bottom: 30px;
        border-bottom: 1px solid #f0f0f0;
    }
    
    .enquiry-details-page .section:last-child {
        margin-bottom: 0;
        padding-bottom: 0;
        border-bottom: none;
    }
    
    .enquiry-details-page .section-title {
        font-size: 18px;
        font-weight: 600;
        color: #1a2e1a;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .enquiry-details-page .section-title i {
        color: #c9a227;
        width: 24px;
    }
    
    .enquiry-details-page .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 25px;
    }
    
    .enquiry-details-page .info-item {
        display: flex;
        align-items: flex-start;
        gap: 15px;
    }
    
    .enquiry-details-page .info-icon {
        width: 45px;
        height: 45px;
        background: #f8f6f1;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #c9a227;
        font-size: 18px;
        flex-shrink: 0;
    }
    
    .enquiry-details-page .info-label {
        font-size: 12px;
        color: #888;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 5px;
    }
    
    .enquiry-details-page .info-value {
        font-size: 15px;
        font-weight: 600;
        color: #1a2e1a;
    }
    
    .enquiry-details-page .info-value.muted {
        color: #aaa;
        font-weight: 400;
        font-style: italic;
    }
    
    .enquiry-details-page .content-box {
        background: #f8f6f1;
        border-radius: 12px;
        padding: 20px;
        line-height: 1.8;
        color: #555;
    }
    
    .enquiry-details-page .reply-box {
        background: linear-gradient(135deg, rgba(6, 182, 212, 0.08), rgba(6, 182, 212, 0.03));
        border-left: 4px solid #06b6d4;
        border-radius: 12px;
        padding: 25px;
    }
    
    .enquiry-details-page .reply-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
        flex-wrap: wrap;
        gap: 10px;
    }
    
    .enquiry-details-page .reply-title {
        font-weight: 600;
        color: #0891b2;
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 16px;
    }
    
    .enquiry-details-page .reply-date {
        font-size: 13px;
        color: #888;
    }
    
    .enquiry-details-page .reply-content {
        color: #555;
        line-height: 1.8;
    }
    
    .enquiry-details-page .quotation-box {
        background: linear-gradient(135deg, rgba(16, 185, 129, 0.08), rgba(16, 185, 129, 0.03));
        border-left: 4px solid #10b981;
        border-radius: 12px;
        padding: 25px;
    }
    
    .enquiry-details-page .quotation-title {
        font-weight: 600;
        color: #059669;
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 16px;
        margin-bottom: 15px;
    }
    
    .enquiry-details-page .quotation-content {
        color: #555;
        line-height: 1.8;
        white-space: pre-line;
    }
    
    .enquiry-details-page .card-footer {
        padding: 25px 30px;
        background: #f8f6f1;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .enquiry-details-page .submitted-info {
        color: #888;
        font-size: 14px;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .enquiry-details-page .submitted-info i {
        color: #c9a227;
    }
    
    .enquiry-details-page .action-buttons {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }
    
    .enquiry-details-page .btn-back {
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
    
    .enquiry-details-page .btn-back:hover {
        border-color: #1a2e1a;
        color: #1a2e1a;
    }
    
    .enquiry-details-page .btn-hospital {
        padding: 12px 24px;
        background: #2d4a2d;
        color: #fff;
        border-radius: 12px;
        text-decoration: none;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
    }
    
    .enquiry-details-page .btn-hospital:hover {
        background: #1a2e1a;
        color: #fff;
        transform: translateY(-2px);
    }
    
    .enquiry-details-page .btn-book {
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
    
    .enquiry-details-page .btn-book:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(201, 162, 39, 0.4);
        color: #1a2e1a;
    }
    
    @media (max-width: 767px) {
        .enquiry-details-page .card-header {
            flex-direction: column;
        }
        
        .enquiry-details-page .hospital-info {
            flex-direction: column;
            text-align: center;
        }
        
        .enquiry-details-page .info-grid {
            grid-template-columns: 1fr;
        }
        
        .enquiry-details-page .card-footer {
            flex-direction: column;
            align-items: stretch;
        }
        
        .enquiry-details-page .action-buttons {
            flex-direction: column;
        }
        
        .enquiry-details-page .action-buttons a {
            justify-content: center;
        }
    }
</style>

<div class="enquiry-details-page">
    <!-- Back Link -->
    <a href="${pageContext.request.contextPath}/user/enquiries" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Enquiries
    </a>
    
    <div class="detail-card">
        <!-- Status Bar -->
        <div class="status-bar ${fn:toLowerCase(enquiry.status)}"></div>
        
        <!-- Card Header -->
        <div class="card-header">
            <div class="hospital-info">
                <div class="hospital-icon">
                    <i class="fas fa-hospital"></i>
                </div>
                <div>
                    <h2 class="hospital-name">${enquiry.hospital.centerName}</h2>
                    <p class="hospital-location">
                        <i class="fas fa-map-marker-alt"></i> ${enquiry.hospital.city}, ${enquiry.hospital.state}
                    </p>
                    <span class="enquiry-number">
                        <i class="fas fa-hashtag"></i> ${enquiry.enquiryNumber}
                    </span>
                </div>
            </div>
            
            <span class="status-badge ${fn:toLowerCase(enquiry.status)}">
                <c:choose>
                    <c:when test="${enquiry.status == 'PENDING'}">
                        <i class="fas fa-clock"></i> Pending
                    </c:when>
                    <c:when test="${enquiry.status == 'REPLIED'}">
                        <i class="fas fa-reply"></i> Replied
                    </c:when>
                    <c:when test="${enquiry.status == 'QUOTATION_SENT'}">
                        <i class="fas fa-file-invoice-dollar"></i> Quotation Sent
                    </c:when>
                    <c:when test="${enquiry.status == 'CLOSED'}">
                        <i class="fas fa-check-circle"></i> Closed
                    </c:when>
                    <c:otherwise>${enquiry.status}</c:otherwise>
                </c:choose>
            </span>
        </div>
        
        <!-- Card Body -->
        <div class="card-body">
            <!-- Your Information -->
            <div class="section">
                <h3 class="section-title">
                    <i class="fas fa-user"></i> Your Information
                </h3>
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <div>
                            <div class="info-label">Full Name</div>
                            <div class="info-value">${enquiry.name}</div>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div>
                            <div class="info-label">Email</div>
                            <div class="info-value">${enquiry.email}</div>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div>
                            <div class="info-label">Phone</div>
                            <div class="info-value">${not empty enquiry.phone ? enquiry.phone : 'Not provided'}</div>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-globe"></i>
                        </div>
                        <div>
                            <div class="info-label">Country</div>
                            <div class="info-value">${not empty enquiry.country ? enquiry.country : 'Not provided'}</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Preferred Dates -->
            <div class="section">
                <h3 class="section-title">
                    <i class="fas fa-calendar-alt"></i> Preferred Dates
                </h3>
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div>
                            <div class="info-label">Start Date</div>
                            <div class="info-value ${empty enquiry.preferredStartDate ? 'muted' : ''}">
                                <c:choose>
                                    <c:when test="${not empty enquiry.preferredStartDate}">
                                        <%
                                            if (e != null && e.getPreferredStartDate() != null) {
                                                out.print(e.getPreferredStartDate().format(java.time.format.DateTimeFormatter.ofPattern("EEEE, dd MMMM yyyy")));
                                            }
                                        %>
                                    </c:when>
                                    <c:otherwise>Not specified</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-calendar-times"></i>
                        </div>
                        <div>
                            <div class="info-label">End Date</div>
                            <div class="info-value ${empty enquiry.preferredEndDate ? 'muted' : ''}">
                                <c:choose>
                                    <c:when test="${not empty enquiry.preferredEndDate}">
                                        <%
                                            if (e != null && e.getPreferredEndDate() != null) {
                                                out.print(e.getPreferredEndDate().format(java.time.format.DateTimeFormatter.ofPattern("EEEE, dd MMMM yyyy")));
                                            }
                                        %>
                                    </c:when>
                                    <c:otherwise>Not specified</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Medical Condition -->
            <c:if test="${not empty enquiry.condition}">
                <div class="section">
                    <h3 class="section-title">
                        <i class="fas fa-heartbeat"></i> Medical Condition
                    </h3>
                    <div class="content-box">
                        ${enquiry.condition}
                    </div>
                </div>
            </c:if>
            
            <!-- Therapy Required -->
            <c:if test="${not empty enquiry.therapyRequired}">
                <div class="section">
                    <h3 class="section-title">
                        <i class="fas fa-spa"></i> Therapy Required
                    </h3>
                    <div class="content-box">
                        ${enquiry.therapyRequired}
                    </div>
                </div>
            </c:if>
            
            <!-- Your Message -->
            <c:if test="${not empty enquiry.message}">
                <div class="section">
                    <h3 class="section-title">
                        <i class="fas fa-comment-alt"></i> Your Message
                    </h3>
                    <div class="content-box">
                        ${enquiry.message}
                    </div>
                </div>
            </c:if>
            
            <!-- Hospital Reply -->
            <c:if test="${not empty enquiry.hospitalReply}">
                <div class="section">
                    <h3 class="section-title">
                        <i class="fas fa-reply"></i> Hospital Response
                    </h3>
                    <div class="reply-box">
                        <div class="reply-header">
                            <span class="reply-title">
                                <i class="fas fa-hospital"></i> ${enquiry.hospital.centerName}
                            </span>
                            <span class="reply-date">
                                <i class="fas fa-clock"></i>
                                <%
                                    if (e != null && e.getRepliedAt() != null) {
                                        out.print("Replied on " + e.getRepliedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy 'at' hh:mm a")));
                                    }
                                %>
                            </span>
                        </div>
                        <div class="reply-content">
                            ${enquiry.hospitalReply}
                        </div>
                    </div>
                </div>
            </c:if>
            
            <!-- Quotation -->
            <c:if test="${not empty enquiry.quotation}">
                <div class="section">
                    <h3 class="section-title">
                        <i class="fas fa-file-invoice-dollar"></i> Quotation Details
                    </h3>
                    <div class="quotation-box">
                        <div class="quotation-title">
                            <i class="fas fa-rupee-sign"></i> Treatment Package Quotation
                        </div>
                        <div class="quotation-content">${enquiry.quotation}</div>
                    </div>
                </div>
            </c:if>
        </div>
        
        <!-- Card Footer -->
        <div class="card-footer">
            <div class="submitted-info">
                <i class="fas fa-calendar-plus"></i>
                Submitted on 
                <%
                    if (e != null && e.getCreatedAt() != null) {
                        out.print(e.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy 'at' hh:mm a")));
                    }
                %>
            </div>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/user/enquiries" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Back to Enquiries
                </a>
                <a href="${pageContext.request.contextPath}/hospital/profile/${enquiry.hospital.id}" target="_blank" class="btn-hospital">
                    <i class="fas fa-external-link-alt"></i> View Hospital
                </a>
                <c:if test="${enquiry.status == 'QUOTATION_SENT'}">
                    <a href="${pageContext.request.contextPath}/user/enquiry/${enquiry.hospital.id}" class="btn-book">
                        <i class="fas fa-calendar-check"></i> Book Now
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
