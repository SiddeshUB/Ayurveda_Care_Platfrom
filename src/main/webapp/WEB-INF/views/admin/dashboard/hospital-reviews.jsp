<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/admin/layouts/admin-header.jsp">
    <jsp:param name="pageTitle" value="Hospital Reviews"/>
    <jsp:param name="activePage" value="reviews"/>
</jsp:include>

<style>
    .page-title-section {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 24px;
    }
    
    .page-title-section h1 {
        font-size: 1.75rem;
        font-weight: 700;
        color: var(--admin-primary);
        margin: 0;
        display: flex;
        align-items: center;
        gap: 12px;
    }
    
    .page-title-section h1 i {
        color: var(--admin-accent);
    }
    
    .back-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        background: white;
        border: 2px solid #e5e7eb;
        border-radius: 8px;
        color: #374151;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s ease;
    }
    
    .back-btn:hover {
        background: var(--admin-primary);
        color: white;
        border-color: var(--admin-primary);
        transform: translateX(-3px);
    }
    
    .hospital-info-card {
        background: white;
        border-radius: 12px;
        padding: 24px;
        margin-bottom: 24px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }
    
    .hospital-info-card h3 {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--admin-primary);
        margin-bottom: 16px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .hospital-info-card h3 i {
        color: var(--admin-accent);
    }
    
    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 16px;
        margin-top: 16px;
    }
    
    .info-item {
        display: flex;
        flex-direction: column;
        gap: 4px;
    }
    
    .info-item label {
        font-size: 0.85rem;
        color: #6b7280;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .info-item span {
        font-size: 1rem;
        color: #1f2937;
        font-weight: 600;
    }
    
    .reviews-table-card {
        background: white;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }
    
    .reviews-table-card .card-header {
        background: linear-gradient(135deg, var(--admin-primary), var(--admin-secondary));
        color: white;
        padding: 20px 24px;
        border-bottom: none;
    }
    
    .reviews-table-card .card-header h5 {
        margin: 0;
        font-size: 1.25rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        background: white;
    }
    
    table thead {
        background: #f9fafb;
    }
    
    table th {
        padding: 16px;
        text-align: left;
        font-weight: 600;
        color: #374151;
        border-bottom: 2px solid #e5e7eb;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    table td {
        padding: 20px 16px;
        border-bottom: 1px solid #e5e7eb;
        vertical-align: top;
    }
    
    table tbody tr {
        transition: all 0.2s ease;
    }
    
    table tbody tr:hover {
        background: #f9fafb;
        transform: scale(1.01);
    }
    
    .reviewer-info {
        display: flex;
        flex-direction: column;
        gap: 4px;
    }
    
    .reviewer-info strong {
        color: var(--admin-primary);
        font-size: 1rem;
        font-weight: 600;
    }
    
    .reviewer-info small {
        color: #6b7280;
        font-size: 0.85rem;
    }
    
    .rating-display {
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .rating-display .stars {
        display: flex;
        gap: 2px;
    }
    
    .rating-display .stars i {
        font-size: 1rem;
    }
    
    .rating-display .stars i.text-warning {
        color: #fbbf24;
    }
    
    .rating-display .stars i.text-muted {
        color: #d1d5db;
    }
    
    .rating-display .rating-value {
        font-weight: 600;
        color: var(--admin-primary);
        font-size: 0.95rem;
    }
    
    .review-text {
        max-width: 350px;
        color: #4b5563;
        line-height: 1.6;
        font-size: 0.95rem;
    }
    
    .treatment-badge {
        display: inline-block;
        padding: 6px 12px;
        background: #e0e7ff;
        color: #4338ca;
        border-radius: 6px;
        font-size: 0.85rem;
        font-weight: 500;
    }
    
    .date-display {
        color: #6b7280;
        font-size: 0.9rem;
        white-space: nowrap;
    }
    
    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 600;
    }
    
    .status-badge.published {
        background: #d1fae5;
        color: #059669;
    }
    
    .status-badge.pending {
        background: #fef3c7;
        color: #d97706;
    }
    
    .empty-state {
        text-align: center;
        padding: 80px 20px;
        color: #9ca3af;
    }
    
    .empty-state i {
        font-size: 4rem;
        margin-bottom: 20px;
        color: #d1d5db;
    }
    
    .empty-state h3 {
        font-size: 1.5rem;
        color: #6b7280;
        margin-bottom: 8px;
    }
    
    .empty-state p {
        font-size: 1rem;
        color: #9ca3af;
    }
    
    .stats-row {
        display: flex;
        gap: 16px;
        margin-top: 20px;
        flex-wrap: wrap;
    }
    
    .stat-box {
        flex: 1;
        min-width: 150px;
        background: linear-gradient(135deg, #f9fafb, #f3f4f6);
        padding: 16px;
        border-radius: 8px;
        border-left: 4px solid var(--admin-accent);
    }
    
    .stat-box .stat-label {
        font-size: 0.75rem;
        color: #6b7280;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 4px;
    }
    
    .stat-box .stat-value {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--admin-primary);
    }
</style>

<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fas fa-check-circle"></i> ${success}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-circle"></i> ${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="page-title-section">
    <h1><i class="fas fa-hospital"></i> Hospital Reviews</h1>
    <a href="${pageContext.request.contextPath}/admin/reviews" class="back-btn">
        <i class="fas fa-arrow-left"></i> Back to All Reviews
    </a>
</div>

<c:if test="${hospital != null}">
    <div class="hospital-info-card">
        <h3><i class="fas fa-hospital"></i> ${hospital.centerName}</h3>
        <div class="info-grid">
            <div class="info-item">
                <label>Address</label>
                <span>
                    <c:choose>
                        <c:when test="${not empty hospital.streetAddress || not empty hospital.city || not empty hospital.state}">
                            <c:set var="addressParts" value=""/>
                            <c:if test="${not empty hospital.streetAddress}">
                                <c:set var="addressParts" value="${hospital.streetAddress}"/>
                            </c:if>
                            <c:if test="${not empty hospital.city}">
                                <c:set var="addressParts" value="${addressParts}${not empty addressParts ? ', ' : ''}${hospital.city}"/>
                            </c:if>
                            <c:if test="${not empty hospital.state}">
                                <c:set var="addressParts" value="${addressParts}${not empty addressParts ? ', ' : ''}${hospital.state}"/>
                            </c:if>
                            <c:if test="${not empty hospital.pinCode}">
                                <c:set var="addressParts" value="${addressParts}${not empty addressParts ? ' - ' : ''}${hospital.pinCode}"/>
                            </c:if>
                            ${addressParts}
                        </c:when>
                        <c:otherwise>
                            N/A
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div class="info-item">
                <label>Total Reviews</label>
                <span>${reviews.size()}</span>
            </div>
            <c:if test="${hospital.averageRating != null && hospital.averageRating > 0}">
                <div class="info-item">
                    <label>Average Rating</label>
                    <span>
                        <fmt:formatNumber value="${hospital.averageRating}" maxFractionDigits="1"/> / 5.0
                        <c:forEach begin="1" end="5" var="i">
                            <i class="fas fa-star ${i <= hospital.averageRating ? 'text-warning' : 'text-muted'}" style="font-size: 0.9rem;"></i>
                        </c:forEach>
                    </span>
                </div>
            </c:if>
        </div>
    </div>
</c:if>

<div class="reviews-table-card">
    <div class="card-header">
        <h5><i class="fas fa-star"></i> All Reviews</h5>
    </div>
    <div class="card-body" style="padding: 0;">
        <c:choose>
            <c:when test="${not empty reviews}">
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>Reviewer</th>
                                <th>Rating</th>
                                <th>Review</th>
                                <th>Treatment</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="review" items="${reviews}">
                                <tr>
                                    <td>
                                        <div class="reviewer-info">
                                            <strong>${review.patientName != null ? review.patientName : 'Anonymous'}</strong>
                                            <small>${review.patientEmail != null ? review.patientEmail : 'N/A'}</small>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="rating-display">
                                            <div class="stars">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-muted'}"></i>
                                                </c:forEach>
                                            </div>
                                            <span class="rating-value">${review.rating}/5</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="review-text">
                                            ${review.reviewText != null ? review.reviewText : 'N/A'}
                                        </div>
                                    </td>
                                    <td>
                                        <c:if test="${not empty review.treatmentTaken}">
                                            <span class="treatment-badge">${review.treatmentTaken}</span>
                                        </c:if>
                                        <c:if test="${empty review.treatmentTaken}">
                                            <span class="text-muted">N/A</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <div class="date-display">
                                            ${review.createdAt != null ? review.createdAt : 'N/A'}
                                        </div>
                                    </td>
                                    <td>
                                        <span class="status-badge ${review.isVisible ? 'published' : 'pending'}">
                                            <i class="fas ${review.isVisible ? 'fa-eye' : 'fa-clock'}"></i>
                                            ${review.isVisible ? 'Published' : 'Pending'}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-comments"></i>
                    <h3>No Reviews Found</h3>
                    <p>There are no reviews for this hospital yet.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/views/admin/layouts/admin-footer.jsp"/>

