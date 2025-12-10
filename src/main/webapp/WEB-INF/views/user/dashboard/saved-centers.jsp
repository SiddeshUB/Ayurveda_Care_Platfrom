<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="Saved Centers"/>
    <jsp:param name="activeNav" value="saved-centers"/>
</jsp:include>

<!-- Page Header -->
<div class="page-header-section">
    <div class="row align-items-center">
        <div class="col">
            <p class="page-subtitle">Your favorite Ayurvedic centers saved for quick access</p>
        </div>
        <div class="col-auto">
            <a href="${pageContext.request.contextPath}/user/hospitals" class="btn-gold">
                <i class="fas fa-plus"></i> Find More Centers
            </a>
        </div>
    </div>
</div>

<!-- Alerts -->
<c:if test="${not empty success}">
    <div class="alert-box success mb-4">
        <i class="fas fa-check-circle"></i>
        <span>${success}</span>
        <button class="alert-close"><i class="fas fa-times"></i></button>
    </div>
</c:if>

<c:if test="${not empty error}">
    <div class="alert-box danger mb-4">
        <i class="fas fa-exclamation-circle"></i>
        <span>${error}</span>
        <button class="alert-close"><i class="fas fa-times"></i></button>
    </div>
</c:if>

<!-- Stats -->
<div class="row g-4 mb-4">
    <div class="col-sm-6 col-lg-3">
        <div class="mini-stat-card">
            <div class="mini-stat-icon heart">
                <i class="fas fa-heart"></i>
            </div>
            <div class="mini-stat-info">
                <h4>${fn:length(savedCenters)}</h4>
                <p>Saved Centers</p>
            </div>
        </div>
    </div>
</div>

<!-- Saved Centers Grid -->
<c:choose>
    <c:when test="${not empty savedCenters}">
        <div class="row g-4">
            <c:forEach var="saved" items="${savedCenters}">
                <div class="col-md-6 col-xl-4">
                    <div class="saved-card">
                        <div class="saved-card-image">
                            <c:choose>
                                <c:when test="${not empty saved.hospital.coverPhotoUrl}">
                                    <img src="${pageContext.request.contextPath}${saved.hospital.coverPhotoUrl}" alt="${saved.hospital.centerName}">
                                </c:when>
                                <c:otherwise>
                                    <div class="image-placeholder">
                                        <i class="fas fa-hospital"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <span class="center-type">${saved.hospital.centerType}</span>
                            <form action="${pageContext.request.contextPath}/user/remove-saved-center/${saved.id}" method="post" class="remove-form">
                                <button type="submit" class="btn-remove" onclick="return confirm('Remove from saved centers?')">
                                    <i class="fas fa-heart"></i>
                                </button>
                            </form>
                        </div>
                        
                        <div class="saved-card-body">
                            <h4 class="center-name">${saved.hospital.centerName}</h4>
                            
                            <div class="center-location">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>${saved.hospital.city}, ${saved.hospital.state}</span>
                            </div>
                            
                            <c:if test="${not empty saved.hospital.averageRating}">
                                <div class="center-rating">
                                    <i class="fas fa-star"></i>
                                    <strong>${saved.hospital.averageRating}</strong>
                                    <span>(${saved.hospital.totalReviews} reviews)</span>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty saved.hospital.description}">
                                <p class="center-desc">${fn:substring(saved.hospital.description, 0, 80)}...</p>
                            </c:if>
                            
                            <div class="saved-date">
                                <i class="fas fa-clock"></i>
                                Saved on <fmt:formatDate value="${saved.savedAt}" pattern="MMM dd, yyyy"/>
                            </div>
                        </div>
                        
                        <div class="saved-card-footer">
                            <a href="${pageContext.request.contextPath}/hospital/profile/${saved.hospital.id}" class="btn-view" target="_blank">
                                <i class="fas fa-eye"></i> View Profile
                            </a>
                            <a href="${pageContext.request.contextPath}/user/enquiry/${saved.hospital.id}" class="btn-enquiry">
                                <i class="fas fa-envelope"></i> Enquiry
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="dashboard-card">
            <div class="empty-state">
                <div class="empty-state-icon heart">
                    <i class="fas fa-heart"></i>
                </div>
                <h4>No Saved Centers</h4>
                <p>Start exploring Ayurvedic centers and save your favorites for quick access later.</p>
                <a href="${pageContext.request.contextPath}/user/hospitals" class="btn-gold">
                    <i class="fas fa-search"></i> Find Centers
                </a>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<style>
    .page-header-section {
        margin-bottom: 25px;
        padding-bottom: 15px;
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
    
    .mini-stat-icon.heart {
        background: rgba(220, 53, 69, 0.1);
        color: #dc3545;
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
    
    /* Alerts */
    .alert-box {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 16px 20px;
        border-radius: 12px;
        font-weight: 500;
    }
    
    .alert-box.success {
        background: rgba(40, 167, 69, 0.1);
        color: #28a745;
        border: 1px solid rgba(40, 167, 69, 0.2);
    }
    
    .alert-box.danger {
        background: rgba(220, 53, 69, 0.1);
        color: #dc3545;
        border: 1px solid rgba(220, 53, 69, 0.2);
    }
    
    .alert-box span {
        flex: 1;
    }
    
    .alert-close {
        background: none;
        border: none;
        cursor: pointer;
        color: inherit;
        opacity: 0.7;
    }
    
    /* Saved Card */
    .saved-card {
        background: #fff;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 5px 25px rgba(0,0,0,0.06);
        border: 1px solid rgba(0,0,0,0.04);
        transition: all 0.4s ease;
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    
    .saved-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 40px rgba(0,0,0,0.12);
    }
    
    .saved-card-image {
        position: relative;
        height: 180px;
        overflow: hidden;
    }
    
    .saved-card-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }
    
    .saved-card:hover .saved-card-image img {
        transform: scale(1.08);
    }
    
    .image-placeholder {
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary-green) 100%);
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .image-placeholder i {
        font-size: 50px;
        color: rgba(255,255,255,0.2);
    }
    
    .center-type {
        position: absolute;
        top: 12px;
        left: 12px;
        background: var(--primary-green);
        color: #fff;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
    }
    
    .btn-remove {
        position: absolute;
        top: 12px;
        right: 12px;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: #dc3545;
        border: none;
        color: #fff;
        font-size: 16px;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .btn-remove:hover {
        background: #c82333;
        transform: scale(1.1);
    }
    
    .saved-card-body {
        padding: 20px;
        flex: 1;
    }
    
    .center-name {
        font-size: 18px;
        font-weight: 600;
        color: var(--primary-dark);
        margin: 0 0 10px 0;
        font-family: 'Poppins', sans-serif;
    }
    
    .center-location {
        display: flex;
        align-items: center;
        gap: 8px;
        color: #666;
        font-size: 13px;
        margin-bottom: 8px;
    }
    
    .center-location i {
        color: var(--accent-gold);
    }
    
    .center-rating {
        display: flex;
        align-items: center;
        gap: 5px;
        margin-bottom: 10px;
        font-size: 13px;
    }
    
    .center-rating i {
        color: var(--accent-gold);
    }
    
    .center-rating strong {
        color: var(--primary-dark);
    }
    
    .center-rating span {
        color: #888;
    }
    
    .center-desc {
        color: #666;
        font-size: 13px;
        line-height: 1.5;
        margin-bottom: 12px;
    }
    
    .saved-date {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 12px;
        color: #888;
    }
    
    .saved-date i {
        color: var(--accent-gold);
    }
    
    .saved-card-footer {
        padding: 15px 20px;
        background: var(--bg-light);
        display: flex;
        gap: 10px;
    }
    
    .btn-view, .btn-enquiry {
        flex: 1;
        padding: 10px 12px;
        border-radius: 10px;
        font-weight: 600;
        font-size: 13px;
        text-decoration: none;
        text-align: center;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        transition: all 0.3s ease;
    }
    
    .btn-view {
        background: var(--primary-green);
        color: #fff;
    }
    
    .btn-view:hover {
        background: var(--primary-dark);
        color: #fff;
    }
    
    .btn-enquiry {
        background: transparent;
        border: 2px solid var(--accent-gold);
        color: var(--accent-gold);
    }
    
    .btn-enquiry:hover {
        background: var(--accent-gold);
        color: var(--primary-dark);
    }
    
    .empty-state-icon.heart {
        background: rgba(220, 53, 69, 0.1);
    }
    
    .empty-state-icon.heart i {
        color: #dc3545;
    }
    
    /* Responsive */
    @media (max-width: 767px) {
        .saved-card-footer {
            flex-direction: column;
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
        
        // Alert Close
        document.querySelectorAll('.alert-close').forEach(btn => {
            btn.addEventListener('click', function() {
                this.closest('.alert-box').remove();
            });
        });
    </script>
</body>
</html>
