<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="Search Hospitals"/>
    <jsp:param name="activeNav" value="hospitals"/>
</jsp:include>

<style>
    /* Page Specific Styles */
    .hospitals-page .page-header-box {
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #e9ecef;
    }
    
    .hospitals-page .page-subtitle {
        color: #888;
        margin: 0;
        font-size: 15px;
    }
    
    .hospitals-page .search-card {
        background: #fff;
        border-radius: 16px;
        padding: 25px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        margin-bottom: 25px;
    }
    
    .hospitals-page .form-label-custom {
        display: block;
        font-weight: 600;
        color: #1a2e1a;
        margin-bottom: 8px;
        font-size: 14px;
    }
    
    .hospitals-page .form-label-custom i {
        color: #c9a227;
        margin-right: 6px;
    }
    
    .hospitals-page .form-input {
        width: 100%;
        padding: 14px 18px;
        border: 2px solid #e9ecef;
        border-radius: 12px;
        font-size: 15px;
        transition: all 0.3s ease;
        background: #f8f6f1;
    }
    
    .hospitals-page .form-input:focus {
        outline: none;
        border-color: #c9a227;
        background: #fff;
        box-shadow: 0 0 0 4px rgba(201, 162, 39, 0.1);
    }
    
    .hospitals-page .btn-search {
        background: linear-gradient(135deg, #c9a227, #e6b55c);
        color: #1a2e1a;
        padding: 14px 28px;
        border-radius: 12px;
        font-weight: 600;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        width: 100%;
    }
    
    .hospitals-page .btn-search:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 25px rgba(201, 162, 39, 0.4);
    }
    
    .hospitals-page .results-header-box {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .hospitals-page .results-title {
        font-size: 20px;
        color: #1a2e1a;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 12px;
        font-family: 'Poppins', sans-serif;
        font-weight: 600;
    }
    
    .hospitals-page .results-title i {
        color: #c9a227;
    }
    
    .hospitals-page .btn-clear {
        background: transparent;
        border: 2px solid #c9a227;
        color: #c9a227;
        padding: 10px 20px;
        border-radius: 10px;
        font-weight: 600;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
        font-size: 14px;
    }
    
    .hospitals-page .btn-clear:hover {
        background: #c9a227;
        color: #1a2e1a;
    }
    
    .hospitals-page .hospital-card {
        background: #fff;
        border-radius: 20px;
        overflow: visible;
        box-shadow: 0 5px 25px rgba(0,0,0,0.06);
        border: 1px solid rgba(0,0,0,0.04);
        transition: all 0.4s ease;
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    
    .hospitals-page .hospital-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 40px rgba(0,0,0,0.12);
    }
    
    .hospitals-page .hospital-image {
        position: relative;
        height: 200px;
        overflow: hidden;
        flex-shrink: 0;
        border-radius: 20px 20px 0 0;
    }
    
    .hospitals-page .hospital-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }
    
    .hospitals-page .hospital-card:hover .hospital-image img {
        transform: scale(1.08);
    }
    
    .hospitals-page .image-placeholder {
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, #1a2e1a 0%, #2d4a2d 100%);
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .hospitals-page .image-placeholder i {
        font-size: 60px;
        color: rgba(255,255,255,0.2);
    }
    
    .hospitals-page .hospital-type-badge {
        position: absolute;
        top: 15px;
        left: 15px;
        background: #2d4a2d;
        color: #fff;
        padding: 6px 14px;
        border-radius: 25px;
        font-size: 12px;
        font-weight: 600;
        text-transform: uppercase;
    }
    
    .hospitals-page .btn-save {
        position: absolute;
        top: 15px;
        right: 15px;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: rgba(255,255,255,0.95);
        border: none;
        color: #dc3545;
        font-size: 18px;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .hospitals-page .btn-save:hover {
        background: #dc3545;
        color: #fff;
        transform: scale(1.1);
    }
    
    .hospitals-page .hospital-body {
        padding: 25px;
        flex: 1;
        flex-grow: 1;
        flex-shrink: 1;
    }
    
    .hospitals-page .hospital-name {
        font-size: 20px;
        font-weight: 600;
        color: #1a2e1a;
        margin: 0 0 12px 0;
        font-family: 'Poppins', sans-serif;
        line-height: 1.4;
    }
    
    .hospitals-page .hospital-location {
        display: flex;
        align-items: center;
        gap: 8px;
        color: #666;
        font-size: 14px;
        margin-bottom: 10px;
    }
    
    .hospitals-page .hospital-location i {
        color: #c9a227;
    }
    
    .hospitals-page .hospital-rating {
        display: flex;
        align-items: center;
        gap: 6px;
        margin-bottom: 12px;
        font-size: 14px;
    }
    
    .hospitals-page .hospital-rating i {
        color: #c9a227;
    }
    
    .hospitals-page .hospital-rating strong {
        color: #1a2e1a;
    }
    
    .hospitals-page .hospital-rating span {
        color: #888;
        font-size: 13px;
    }
    
    .hospitals-page .hospital-desc {
        color: #666;
        font-size: 14px;
        line-height: 1.6;
        margin-bottom: 15px;
    }
    
    .hospitals-page .hospital-features {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
    }
    
    .hospitals-page .feature-tag {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 5px 12px;
        background: rgba(201, 162, 39, 0.1);
        color: #c9a227;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
    }
    
    .hospitals-page .hospital-footer {
        padding: 20px 25px;
        background: #f8f6f1;
        display: flex !important;
        gap: 12px;
        margin-top: auto;
        border-top: 1px solid #e9ecef;
        flex-shrink: 0;
        min-height: 88px;
        border-radius: 0 0 20px 20px;
    }
    
    .hospitals-page .btn-view {
        flex: 1;
        padding: 12px 15px;
        border-radius: 12px;
        font-weight: 600;
        font-size: 14px;
        text-decoration: none !important;
        text-align: center;
        display: inline-flex !important;
        align-items: center;
        justify-content: center;
        gap: 8px;
        transition: all 0.3s ease;
        background: #2d4a2d !important;
        color: #fff !important;
        min-height: 48px;
    }
    
    .hospitals-page .btn-view:hover {
        background: #1a2e1a !important;
        color: #fff !important;
        transform: translateY(-2px);
    }
    
    .hospitals-page .btn-enquiry {
        flex: 1;
        padding: 12px 15px;
        border-radius: 12px;
        font-weight: 600;
        font-size: 14px;
        text-decoration: none !important;
        text-align: center;
        display: inline-flex !important;
        align-items: center;
        justify-content: center;
        gap: 8px;
        transition: all 0.3s ease;
        background: transparent !important;
        border: 2px solid #c9a227 !important;
        color: #c9a227 !important;
        min-height: 48px;
    }
    
    .hospitals-page .btn-enquiry:hover {
        background: #c9a227 !important;
        color: #1a2e1a !important;
        transform: translateY(-2px);
    }
    
    .hospitals-page .pagination-box {
        margin-top: 40px;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 20px;
        flex-wrap: wrap;
    }
    
    .hospitals-page .page-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 12px 24px;
        border-radius: 12px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
        background: #fff;
        color: #1a2e1a;
        border: 2px solid #e9ecef;
    }
    
    .hospitals-page .page-btn:hover {
        background: #c9a227;
        color: #1a2e1a;
        border-color: #c9a227;
    }
    
    .hospitals-page .page-info {
        font-weight: 600;
        color: #1a2e1a;
    }
    
    .hospitals-page .empty-box {
        background: #fff;
        border-radius: 16px;
        padding: 60px 30px;
        text-align: center;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    }
    
    .hospitals-page .empty-icon {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: #f8f6f1;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 25px;
    }
    
    .hospitals-page .empty-icon i {
        font-size: 40px;
        color: #ccc;
    }
    
    .hospitals-page .empty-box h4 {
        font-size: 22px;
        color: #1a2e1a;
        margin-bottom: 10px;
    }
    
    .hospitals-page .empty-box p {
        color: #888;
        margin-bottom: 25px;
    }
    
    @media (max-width: 767px) {
        .hospitals-page .hospital-footer {
            flex-direction: column;
        }
        
        .hospitals-page .pagination-box {
            flex-direction: column;
        }
        
        .hospitals-page .results-header-box {
            flex-direction: column;
            align-items: flex-start;
        }
    }
    
    /* Force visibility of buttons */
    .hospitals-page .hospital-card .hospital-footer {
        visibility: visible !important;
        opacity: 1 !important;
        display: flex !important;
    }
    
    .hospitals-page .hospital-card .hospital-footer a.btn-view,
    .hospitals-page .hospital-card .hospital-footer a.btn-enquiry {
        visibility: visible !important;
        opacity: 1 !important;
        display: inline-flex !important;
    }
</style>

<div class="hospitals-page">
    <!-- Page Header -->
    <div class="page-header-box">
        <p class="page-subtitle">Find the perfect Ayurvedic center for your wellness journey</p>
    </div>

    <!-- Search Filters -->
    <div class="search-card">
        <form method="get" action="${pageContext.request.contextPath}/user/hospitals">
            <div class="row g-3 align-items-end">
                <div class="col-md-5">
                    <label class="form-label-custom">
                        <i class="fas fa-search"></i> Search Hospitals
                    </label>
                    <input type="text" name="search" class="form-input" 
                           placeholder="Search by name, treatment, specialty..." 
                           value="${search}">
                </div>
                <div class="col-md-4">
                    <label class="form-label-custom">
                        <i class="fas fa-map-marker-alt"></i> Location
                    </label>
                    <input type="text" name="location" class="form-input" 
                           placeholder="City or State" 
                           value="${location}">
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn-search">
                        <i class="fas fa-search"></i> Search
                    </button>
                </div>
            </div>
        </form>
    </div>

    <!-- Results Header -->
    <div class="results-header-box">
        <h3 class="results-title">
            <i class="fas fa-hospital"></i>
            <c:choose>
                <c:when test="${not empty hospitals}">
                    Found ${fn:length(hospitals)} Hospital<c:if test="${fn:length(hospitals) != 1}">s</c:if>
                </c:when>
                <c:otherwise>
                    No Hospitals Found
                </c:otherwise>
            </c:choose>
        </h3>
        <c:if test="${not empty search || not empty location}">
            <a href="${pageContext.request.contextPath}/user/hospitals" class="btn-clear">
                <i class="fas fa-times"></i> Clear Filters
            </a>
        </c:if>
    </div>

    <!-- Hospital Cards -->
    <c:choose>
        <c:when test="${not empty hospitals}">
            <div class="row g-4">
                <c:forEach var="hospital" items="${hospitals}">
                    <div class="col-md-6 col-xl-4">
                        <div class="hospital-card">
                            <div class="hospital-image">
                                <c:choose>
                                    <c:when test="${not empty hospital.coverPhotoUrl}">
                                        <img src="${pageContext.request.contextPath}${hospital.coverPhotoUrl}" alt="${hospital.centerName}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="image-placeholder">
                                            <i class="fas fa-hospital"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <span class="hospital-type-badge">${hospital.centerType}</span>
                                <button class="btn-save" title="Save to favorites">
                                    <i class="far fa-heart"></i>
                                </button>
                            </div>
                            
                            <div class="hospital-body">
                                <h4 class="hospital-name">${hospital.centerName}</h4>
                                
                                <div class="hospital-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>${hospital.city}, ${hospital.state}</span>
                                </div>
                                
                                <c:if test="${not empty hospital.averageRating}">
                                    <div class="hospital-rating">
                                        <i class="fas fa-star"></i>
                                        <strong>${hospital.averageRating}</strong>
                                        <span>(${hospital.totalReviews} reviews)</span>
                                    </div>
                                </c:if>
                                
                                <c:if test="${not empty hospital.description}">
                                    <p class="hospital-desc">
                                        ${fn:substring(hospital.description, 0, 100)}${fn:length(hospital.description) > 100 ? '...' : ''}
                                    </p>
                                </c:if>
                                
                                <div class="hospital-features">
                                    <span class="feature-tag"><i class="fas fa-leaf"></i> Ayurvedic</span>
                                    <span class="feature-tag"><i class="fas fa-spa"></i> Wellness</span>
                                </div>
                            </div>
                            
                            <div class="hospital-footer">
                                <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}" class="btn-view" target="_blank">
                                    <i class="fas fa-eye"></i> View Details
                                </a>
                                <a href="${pageContext.request.contextPath}/user/enquiry/${hospital.id}" class="btn-enquiry">
                                    <i class="fas fa-envelope"></i> Enquiry
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="pagination-box">
                    <c:if test="${currentPage > 0}">
                        <a href="?search=${search}&location=${location}&page=${currentPage - 1}" class="page-btn">
                            <i class="fas fa-chevron-left"></i> Previous
                        </a>
                    </c:if>
                    
                    <span class="page-info">Page ${currentPage + 1} of ${totalPages}</span>
                    
                    <c:if test="${currentPage < totalPages - 1}">
                        <a href="?search=${search}&location=${location}&page=${currentPage + 1}" class="page-btn">
                            Next <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:if>
                </div>
            </c:if>
        </c:when>
        <c:otherwise>
            <div class="empty-box">
                <div class="empty-icon">
                    <i class="fas fa-hospital"></i>
                </div>
                <h4>No Hospitals Found</h4>
                <p>Try adjusting your search criteria or browse all available centers.</p>
                <a href="${pageContext.request.contextPath}/user/hospitals" class="btn-search" style="width: auto; display: inline-flex;">
                    <i class="fas fa-redo"></i> Show All Hospitals
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
