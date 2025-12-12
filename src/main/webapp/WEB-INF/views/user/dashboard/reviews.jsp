<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="My Reviews"/>
    <jsp:param name="activeNav" value="reviews"/>
</jsp:include>

<div class="content-wrapper">
    <div class="content-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1 class="page-title">
                    <i class="fas fa-star"></i> My Reviews
                </h1>
                <p class="text-muted">Manage your reviews for hospitals and products</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/user/hospitals" class="btn btn-outline-primary me-2">
                    <i class="fas fa-hospital"></i> Review Hospital
                </a>
                <a href="${pageContext.request.contextPath}/user/products" class="btn btn-primary">
                    <i class="fas fa-shopping-bag"></i> Review Product
                </a>
            </div>
        </div>
    </div>

    <div class="content-body">
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

        <!-- Tabs -->
        <ul class="nav nav-tabs mb-4" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="hospital-tab" data-bs-toggle="tab" data-bs-target="#hospital-reviews" type="button" role="tab">
                    <i class="fas fa-hospital"></i> Hospital Reviews
                    <span class="badge bg-secondary ms-2">${not empty hospitalReviews ? hospitalReviews.size() : 0}</span>
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="product-tab" data-bs-toggle="tab" data-bs-target="#product-reviews" type="button" role="tab">
                    <i class="fas fa-shopping-bag"></i> Product Reviews
                    <span class="badge bg-secondary ms-2">${not empty productReviews ? productReviews.size() : 0}</span>
                </button>
            </li>
        </ul>

        <!-- Tab Content -->
        <div class="tab-content">
            <!-- Hospital Reviews Tab -->
            <div class="tab-pane fade show active" id="hospital-reviews" role="tabpanel">
                <c:choose>
                    <c:when test="${not empty hospitalReviews}">
                        <div class="row g-4">
                            <c:forEach var="review" items="${hospitalReviews}">
                                <div class="col-12">
                                    <div class="card review-card">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                <div>
                                                    <h5 class="card-title mb-1">
                                                        <a href="${pageContext.request.contextPath}/hospitals/${review.hospital.id}" class="text-decoration-none">
                                                            ${review.hospital.centerName}
                                                        </a>
                                                    </h5>
                                                    <div class="rating-stars mb-2">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-muted'}"></i>
                                                        </c:forEach>
                                                        <span class="ms-2 text-muted">${review.rating}/5</span>
                                                    </div>
                                                </div>
                                                <div class="text-end">
                                                    <span class="badge ${review.isVisible ? 'bg-success' : 'bg-warning'}">
                                                        ${review.isVisible ? 'Published' : 'Pending'}
                                                    </span>
                                                    <div class="text-muted small mt-1">
                                                        ${review.createdAt}
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <c:if test="${not empty review.reviewText}">
                                                <p class="card-text">${review.reviewText}</p>
                                            </c:if>
                                            
                                            <c:if test="${not empty review.treatmentTaken}">
                                                <div class="mt-2">
                                                    <strong>Treatment:</strong> ${review.treatmentTaken}
                                                </div>
                                            </c:if>
                                            
                                            <c:if test="${not empty review.hospitalResponse}">
                                                <div class="alert alert-info mt-3 mb-0">
                                                    <strong><i class="fas fa-reply"></i> Hospital Response:</strong>
                                                    <p class="mb-0 mt-1">${review.hospitalResponse}</p>
                                                    <small class="text-muted">
                                                        ${review.responseDate}
                                                    </small>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state text-center py-5">
                            <i class="fas fa-hospital fa-4x text-muted mb-3"></i>
                            <h4>No Hospital Reviews</h4>
                            <p class="text-muted">You haven't reviewed any hospitals yet.</p>
                            <a href="${pageContext.request.contextPath}/user/hospitals" class="btn btn-primary">
                                <i class="fas fa-search"></i> Find Hospitals
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Product Reviews Tab -->
            <div class="tab-pane fade" id="product-reviews" role="tabpanel">
                <c:choose>
                    <c:when test="${not empty productReviews}">
                        <div class="row g-4">
                            <c:forEach var="review" items="${productReviews}">
                                <div class="col-12">
                                    <div class="card review-card">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                <div class="d-flex align-items-start">
                                                    <c:if test="${not empty review.product.imageUrl}">
                                                        <img src="${pageContext.request.contextPath}${review.product.imageUrl}" 
                                                             alt="${review.product.productName}" 
                                                             class="me-3" 
                                                             style="width: 80px; height: 80px; object-fit: cover; border-radius: 8px;">
                                                    </c:if>
                                                    <div>
                                                        <h5 class="card-title mb-1">
                                                            <a href="${pageContext.request.contextPath}/products/${review.product.slug}" class="text-decoration-none">
                                                                ${review.product.productName}
                                                            </a>
                                                        </h5>
                                                        <c:if test="${not empty review.title}">
                                                            <h6 class="text-muted mb-2">${review.title}</h6>
                                                        </c:if>
                                                        <div class="rating-stars mb-2">
                                                            <c:forEach begin="1" end="5" var="i">
                                                                <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-muted'}"></i>
                                                            </c:forEach>
                                                            <span class="ms-2 text-muted">${review.rating}/5</span>
                                                            <c:if test="${review.isVerifiedPurchase}">
                                                                <span class="badge bg-success ms-2">
                                                                    <i class="fas fa-check-circle"></i> Verified Purchase
                                                                </span>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="text-end">
                                                    <span class="badge ${review.status == 'APPROVED' ? 'bg-success' : review.status == 'PENDING' ? 'bg-warning' : 'bg-danger'}">
                                                        ${review.status}
                                                    </span>
                                                    <div class="text-muted small mt-1">
                                                        ${review.createdAt}
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <c:if test="${not empty review.comment}">
                                                <p class="card-text">${review.comment}</p>
                                            </c:if>
                                            
                                            <c:if test="${not empty review.pros || not empty review.cons}">
                                                <div class="row mt-3">
                                                    <c:if test="${not empty review.pros}">
                                                        <div class="col-md-6">
                                                            <div class="pros-cons-box bg-success bg-opacity-10 p-3 rounded">
                                                                <strong class="text-success"><i class="fas fa-thumbs-up"></i> Pros:</strong>
                                                                <p class="mb-0 mt-1">${review.pros}</p>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${not empty review.cons}">
                                                        <div class="col-md-6">
                                                            <div class="pros-cons-box bg-danger bg-opacity-10 p-3 rounded">
                                                                <strong class="text-danger"><i class="fas fa-thumbs-down"></i> Cons:</strong>
                                                                <p class="mb-0 mt-1">${review.cons}</p>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </c:if>
                                            
                                            <c:if test="${review.isRecommended != null && review.isRecommended}">
                                                <div class="mt-2">
                                                    <span class="badge bg-info">
                                                        <i class="fas fa-check"></i> I recommend this product
                                                    </span>
                                                </div>
                                            </c:if>
                                            
                                            <c:if test="${not empty review.vendorResponse}">
                                                <div class="alert alert-info mt-3 mb-0">
                                                    <strong><i class="fas fa-reply"></i> Vendor Response:</strong>
                                                    <p class="mb-0 mt-1">${review.vendorResponse}</p>
                                                    <small class="text-muted">
                                                        ${review.vendorRespondedAt}
                                                    </small>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state text-center py-5">
                            <i class="fas fa-shopping-bag fa-4x text-muted mb-3"></i>
                            <h4>No Product Reviews</h4>
                            <p class="text-muted">You haven't reviewed any products yet.</p>
                            <a href="${pageContext.request.contextPath}/user/products" class="btn btn-primary">
                                <i class="fas fa-shopping-bag"></i> Browse Products
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<style>
    .review-card {
        border: none;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        transition: transform 0.2s, box-shadow 0.2s;
    }
    
    .review-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 20px rgba(0,0,0,0.12);
    }
    
    .rating-stars {
        font-size: 1rem;
    }
    
    .pros-cons-box {
        min-height: 80px;
    }
    
    .empty-state {
        background: white;
        border-radius: 12px;
        padding: 60px 20px;
    }
</style>

<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-footer.jsp"/>

