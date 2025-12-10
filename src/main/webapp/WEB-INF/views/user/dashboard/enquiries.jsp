<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="My Enquiries"/>
    <jsp:param name="activeNav" value="enquiries"/>
</jsp:include>

<!-- Page Header -->
<div class="page-header-section">
    <div class="row align-items-center">
        <div class="col">
            <p class="page-subtitle">Track all your booking enquiries and responses from centers</p>
        </div>
        <div class="col-auto">
            <a href="${pageContext.request.contextPath}/user/hospitals" class="btn-gold">
                <i class="fas fa-plus"></i> New Enquiry
            </a>
        </div>
    </div>
</div>

<!-- Stats Row -->
<div class="row g-4 mb-4">
    <div class="col-sm-6 col-lg-3">
        <div class="mini-stat-card">
            <div class="mini-stat-icon all">
                <i class="fas fa-envelope"></i>
            </div>
            <div class="mini-stat-info">
                <h4>${fn:length(enquiries)}</h4>
                <p>Total Enquiries</p>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-3">
        <div class="mini-stat-card">
            <div class="mini-stat-icon pending">
                <i class="fas fa-clock"></i>
            </div>
            <div class="mini-stat-info">
                <h4>${stats.pendingEnquiries}</h4>
                <p>Pending</p>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-3">
        <div class="mini-stat-card">
            <div class="mini-stat-icon replied">
                <i class="fas fa-reply"></i>
            </div>
            <div class="mini-stat-info">
                <h4>${stats.repliedEnquiries != null ? stats.repliedEnquiries : 0}</h4>
                <p>Replied</p>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-lg-3">
        <div class="mini-stat-card">
            <div class="mini-stat-icon quotation">
                <i class="fas fa-file-invoice"></i>
            </div>
            <div class="mini-stat-info">
                <h4>${stats.quotationSent != null ? stats.quotationSent : 0}</h4>
                <p>Quotations</p>
            </div>
        </div>
    </div>
</div>

<!-- Enquiries List -->
<c:choose>
    <c:when test="${not empty enquiries}">
        <div class="row g-4">
            <c:forEach var="enquiry" items="${enquiries}">
                <%
                    com.ayurveda.entity.UserEnquiry e = (com.ayurveda.entity.UserEnquiry) pageContext.getAttribute("enquiry");
                %>
                <div class="col-lg-6">
                    <div class="enquiry-card">
                        <div class="enquiry-card-header">
                            <div class="hospital-info">
                                <div class="hospital-icon">
                                    <i class="fas fa-hospital"></i>
                                </div>
                                <div>
                                    <h4>${enquiry.hospital.centerName}</h4>
                                    <p><i class="fas fa-map-marker-alt"></i> ${enquiry.hospital.city}, ${enquiry.hospital.state}</p>
                                </div>
                            </div>
                            <c:choose>
                                <c:when test="${enquiry.status == 'PENDING'}">
                                    <span class="enquiry-status pending">
                                        <i class="fas fa-clock"></i> Pending
                                    </span>
                                </c:when>
                                <c:when test="${enquiry.status == 'REPLIED'}">
                                    <span class="enquiry-status replied">
                                        <i class="fas fa-reply"></i> Replied
                                    </span>
                                </c:when>
                                <c:when test="${enquiry.status == 'QUOTATION_SENT'}">
                                    <span class="enquiry-status quotation">
                                        <i class="fas fa-file-invoice"></i> Quotation
                                    </span>
                                </c:when>
                                <c:when test="${enquiry.status == 'CLOSED'}">
                                    <span class="enquiry-status closed">
                                        <i class="fas fa-check"></i> Closed
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="enquiry-status">${enquiry.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <div class="enquiry-card-body">
                            <div class="enquiry-detail">
                                <span class="detail-label">Therapy Required</span>
                                <span class="detail-value">
                                    <c:choose>
                                        <c:when test="${not empty enquiry.therapyRequired}">
                                            ${fn:substring(enquiry.therapyRequired, 0, 50)}${fn:length(enquiry.therapyRequired) > 50 ? '...' : ''}
                                        </c:when>
                                        <c:otherwise>
                                            Not specified
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="enquiry-dates">
                                <div class="date-item">
                                    <i class="fas fa-calendar-alt"></i>
                                    <div>
                                        <span class="date-label">Preferred Dates</span>
                                        <span class="date-value">
                                            <c:choose>
                                                <c:when test="${not empty enquiry.preferredStartDate}">
                                                    <%
                                                        if (e != null && e.getPreferredStartDate() != null) {
                                                            out.print(e.getPreferredStartDate().format(java.time.format.DateTimeFormatter.ofPattern("MMM dd")));
                                                        }
                                                    %>
                                                    <c:if test="${not empty enquiry.preferredEndDate}">
                                                        - <%
                                                            if (e != null && e.getPreferredEndDate() != null) {
                                                                out.print(e.getPreferredEndDate().format(java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy")));
                                                            }
                                                        %>
                                                    </c:if>
                                                </c:when>
                                                <c:otherwise>
                                                    Not specified
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                                <div class="date-item">
                                    <i class="fas fa-clock"></i>
                                    <div>
                                        <span class="date-label">Submitted</span>
                                        <span class="date-value">
                                            <%
                                                if (e != null && e.getCreatedAt() != null) {
                                                    out.print(e.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy")));
                                                }
                                            %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="enquiry-card-footer">
                            <a href="${pageContext.request.contextPath}/user/enquiry/details/${enquiry.id}" class="btn-view-enquiry">
                                <i class="fas fa-eye"></i> View Details
                            </a>
                            <c:if test="${enquiry.status == 'QUOTATION_SENT'}">
                                <span class="quotation-badge">
                                    <i class="fas fa-file-invoice-dollar"></i> View Quotation
                                </span>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="dashboard-card">
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fas fa-envelope-open"></i>
                </div>
                <h4>No Enquiries Yet</h4>
                <p>Start exploring our Ayurvedic centers and send your first enquiry to get personalized quotes.</p>
                <a href="${pageContext.request.contextPath}/user/hospitals" class="btn-gold">
                    <i class="fas fa-search"></i> Find Centers
                </a>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<style>
    .page-header-section {
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 1px solid #e9ecef;
    }
    
    .page-subtitle {
        color: #888;
        margin: 0;
        font-size: 15px;
    }
    
    /* Mini Stat Cards */
    .mini-stat-card {
        background: #fff;
        border-radius: 16px;
        padding: 20px;
        display: flex;
        align-items: center;
        gap: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    }
    
    .mini-stat-icon {
        width: 50px;
        height: 50px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
    }
    
    .mini-stat-icon.all {
        background: rgba(45, 74, 45, 0.1);
        color: var(--primary-green);
    }
    
    .mini-stat-icon.pending {
        background: rgba(255, 193, 7, 0.1);
        color: #ffc107;
    }
    
    .mini-stat-icon.replied {
        background: rgba(23, 162, 184, 0.1);
        color: #17a2b8;
    }
    
    .mini-stat-icon.quotation {
        background: rgba(40, 167, 69, 0.1);
        color: #28a745;
    }
    
    .mini-stat-info h4 {
        font-size: 24px;
        font-weight: 700;
        color: var(--primary-dark);
        margin: 0;
        font-family: 'Poppins', sans-serif;
    }
    
    .mini-stat-info p {
        font-size: 13px;
        color: #888;
        margin: 0;
    }
    
    /* Enquiry Card */
    .enquiry-card {
        background: #fff;
        border-radius: 16px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        overflow: hidden;
        transition: all 0.3s ease;
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    
    .enquiry-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 35px rgba(0,0,0,0.1);
    }
    
    .enquiry-card-header {
        padding: 20px;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 15px;
        border-bottom: 1px solid #f0f0f0;
        background: linear-gradient(to right, rgba(201, 162, 39, 0.03), transparent);
    }
    
    .hospital-info {
        display: flex;
        gap: 15px;
        align-items: flex-start;
    }
    
    .hospital-icon {
        width: 45px;
        height: 45px;
        border-radius: 12px;
        background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--primary-dark);
        font-size: 18px;
    }
    
    .hospital-info h4 {
        font-size: 16px;
        font-weight: 600;
        color: var(--primary-dark);
        margin: 0 0 5px 0;
        font-family: 'Poppins', sans-serif;
    }
    
    .hospital-info p {
        font-size: 13px;
        color: #888;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 5px;
    }
    
    .hospital-info p i {
        color: var(--accent-gold);
        font-size: 11px;
    }
    
    /* Enquiry Status */
    .enquiry-status {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
        white-space: nowrap;
    }
    
    .enquiry-status.pending {
        background: rgba(255, 193, 7, 0.15);
        color: #d39e00;
    }
    
    .enquiry-status.replied {
        background: rgba(23, 162, 184, 0.15);
        color: #17a2b8;
    }
    
    .enquiry-status.quotation {
        background: rgba(40, 167, 69, 0.15);
        color: #28a745;
    }
    
    .enquiry-status.closed {
        background: rgba(108, 117, 125, 0.15);
        color: #6c757d;
    }
    
    /* Enquiry Body */
    .enquiry-card-body {
        padding: 20px;
        flex: 1;
    }
    
    .enquiry-detail {
        margin-bottom: 15px;
    }
    
    .detail-label {
        display: block;
        font-size: 12px;
        color: #888;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 5px;
    }
    
    .detail-value {
        font-size: 14px;
        color: var(--primary-dark);
        font-weight: 500;
    }
    
    .enquiry-dates {
        display: flex;
        gap: 20px;
        padding-top: 15px;
        border-top: 1px solid #f0f0f0;
    }
    
    .date-item {
        display: flex;
        align-items: flex-start;
        gap: 10px;
    }
    
    .date-item i {
        color: var(--accent-gold);
        font-size: 14px;
        margin-top: 3px;
    }
    
    .date-label {
        display: block;
        font-size: 11px;
        color: #888;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .date-value {
        display: block;
        font-size: 13px;
        color: var(--primary-dark);
        font-weight: 500;
    }
    
    /* Enquiry Footer */
    .enquiry-card-footer {
        padding: 15px 20px;
        background: var(--bg-light);
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 10px;
    }
    
    .btn-view-enquiry {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        background: var(--primary-green);
        color: #fff;
        border-radius: 10px;
        text-decoration: none;
        font-weight: 600;
        font-size: 13px;
        transition: all 0.3s ease;
    }
    
    .btn-view-enquiry:hover {
        background: var(--primary-dark);
        color: #fff;
    }
    
    .quotation-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 12px;
        color: #28a745;
        font-weight: 600;
    }
    
    /* Responsive */
    @media (max-width: 767px) {
        .enquiry-card-header {
            flex-direction: column;
        }
        
        .enquiry-dates {
            flex-direction: column;
            gap: 15px;
        }
    }
</style>

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
