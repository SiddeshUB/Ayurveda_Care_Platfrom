<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/admin/layouts/admin-header.jsp">
    <jsp:param name="pageTitle" value="All Reviews"/>
    <jsp:param name="activePage" value="reviews"/>
</jsp:include>

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

<!-- Stats Cards -->
<div class="row g-4 mb-4">
    <div class="col-md-4">
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <i class="fas fa-user-md"></i>
            </div>
            <div class="stat-content">
                <h3>${reviewsByDoctor != null ? reviewsByDoctor.size() : 0}</h3>
                <p>Doctors with Reviews</p>
                <small class="text-muted">${totalDoctorReviews} total reviews</small>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                <i class="fas fa-hospital"></i>
            </div>
            <div class="stat-content">
                <h3>${reviewsByHospital != null ? reviewsByHospital.size() : 0}</h3>
                <p>Hospitals with Reviews</p>
                <small class="text-muted">${totalHospitalReviews} total reviews</small>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="stat-card">
            <div class="stat-icon" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                <i class="fas fa-shopping-bag"></i>
            </div>
            <div class="stat-content">
                <h3>${reviewsByProduct != null ? reviewsByProduct.size() : 0}</h3>
                <p>Products with Reviews</p>
                <small class="text-muted">${totalProductReviews} total reviews</small>
            </div>
        </div>
    </div>
</div>

<!-- Tabs -->
<ul class="nav nav-tabs mb-4" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="doctors-tab" data-bs-toggle="tab" data-bs-target="#doctors" type="button" role="tab">
            <i class="fas fa-user-md"></i> By Doctors
        </button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="hospitals-tab" data-bs-toggle="tab" data-bs-target="#hospitals" type="button" role="tab">
            <i class="fas fa-hospital"></i> By Hospitals
        </button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="products-tab" data-bs-toggle="tab" data-bs-target="#products" type="button" role="tab">
            <i class="fas fa-shopping-bag"></i> By Products
        </button>
    </li>
</ul>

<!-- Tab Content -->
<div class="tab-content">
    <!-- Doctors Tab -->
    <div class="tab-pane fade show active" id="doctors" role="tabpanel">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-user-md"></i> Reviews by Doctors</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty reviewsByDoctor}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Doctor Name</th>
                                        <th>Specialization</th>
                                        <th>Total Reviews</th>
                                        <th>Average Rating</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="entry" items="${reviewsByDoctor}">
                                        <c:set var="doctorId" value="${entry.key}"/>
                                        <c:set var="reviews" value="${entry.value}"/>
                                        <c:set var="doctor" value="${doctorMap[doctorId]}"/>
                                        <c:set var="totalRating" value="0"/>
                                        <c:set var="approvedCount" value="0"/>
                                        <c:forEach var="review" items="${reviews}">
                                            <c:if test="${review.status == 'APPROVED'}">
                                                <c:set var="totalRating" value="${totalRating + review.rating}"/>
                                                <c:set var="approvedCount" value="${approvedCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:set var="avgRating" value="${approvedCount > 0 ? totalRating / approvedCount : 0}"/>
                                        <tr>
                                            <td>
                                                <strong>${doctor != null ? doctor.fullName : 'Unknown Doctor'}</strong>
                                                <c:if test="${doctor != null && not empty doctor.email}">
                                                    <br><small class="text-muted">${doctor.email}</small>
                                                </c:if>
                                            </td>
                                            <td>
                                                ${doctor != null && not empty doctor.specialization ? doctor.specialization : 'N/A'}
                                            </td>
                                            <td>
                                                <span class="badge bg-primary">${reviews.size()}</span>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="fas fa-star ${i <= avgRating ? 'text-warning' : 'text-muted'}"></i>
                                                    </c:forEach>
                                                    <span class="ms-2"><fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/></span>
                                                </div>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/reviews/doctor/${doctorId}" class="btn btn-sm btn-primary">
                                                    <i class="fas fa-eye"></i> View All
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-user-md fa-3x text-muted mb-3"></i>
                            <p class="text-muted">No doctor reviews found</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Hospitals Tab -->
    <div class="tab-pane fade" id="hospitals" role="tabpanel">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-hospital"></i> Reviews by Hospitals</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty reviewsByHospital}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Hospital Name</th>
                                        <th>Address</th>
                                        <th>Total Reviews</th>
                                        <th>Average Rating</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="entry" items="${reviewsByHospital}">
                                        <c:set var="hospitalId" value="${entry.key}"/>
                                        <c:set var="reviews" value="${entry.value}"/>
                                        <c:set var="hospital" value="${hospitalMap[hospitalId]}"/>
                                        <c:set var="totalRating" value="0"/>
                                        <c:forEach var="review" items="${reviews}">
                                            <c:set var="totalRating" value="${totalRating + review.rating}"/>
                                        </c:forEach>
                                        <c:set var="avgRating" value="${reviews.size() > 0 ? totalRating / reviews.size() : 0}"/>
                                        <tr>
                                            <td>
                                                <strong>${hospital != null ? hospital.centerName : 'Unknown Hospital'}</strong>
                                            </td>
                                            <td>
                                                <small class="text-muted">
                                                    <c:choose>
                                                        <c:when test="${hospital != null}">
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
                                                            ${not empty addressParts ? addressParts : 'N/A'}
                                                        </c:when>
                                                        <c:otherwise>
                                                            N/A
                                                        </c:otherwise>
                                                    </c:choose>
                                                </small>
                                            </td>
                                            <td>
                                                <span class="badge bg-primary">${reviews.size()}</span>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="fas fa-star ${i <= avgRating ? 'text-warning' : 'text-muted'}"></i>
                                                    </c:forEach>
                                                    <span class="ms-2"><fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/></span>
                                                </div>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/reviews/hospital/${hospitalId}" class="btn btn-sm btn-primary">
                                                    <i class="fas fa-eye"></i> View All
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-hospital fa-3x text-muted mb-3"></i>
                            <p class="text-muted">No hospital reviews found</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Products Tab -->
    <div class="tab-pane fade" id="products" role="tabpanel">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-shopping-bag"></i> Reviews by Products</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty reviewsByProduct}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Product Name</th>
                                        <th>Vendor</th>
                                        <th>Total Reviews</th>
                                        <th>Average Rating</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="entry" items="${reviewsByProduct}">
                                        <c:set var="productId" value="${entry.key}"/>
                                        <c:set var="reviews" value="${entry.value}"/>
                                        <c:set var="product" value="${productMap[productId]}"/>
                                        <c:set var="totalRating" value="0"/>
                                        <c:set var="approvedCount" value="0"/>
                                        <c:forEach var="review" items="${reviews}">
                                            <c:if test="${review.status == 'APPROVED'}">
                                                <c:set var="totalRating" value="${totalRating + review.rating}"/>
                                                <c:set var="approvedCount" value="${approvedCount + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:set var="avgRating" value="${approvedCount > 0 ? totalRating / approvedCount : 0}"/>
                                        <tr>
                                            <td>
                                                <strong>${product != null ? product.productName : 'Unknown Product'}</strong>
                                            </td>
                                            <td>
                                                <small class="text-muted">${product != null && product.vendor != null ? product.vendor.storeDisplayName : 'N/A'}</small>
                                            </td>
                                            <td>
                                                <span class="badge bg-primary">${reviews.size()}</span>
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="fas fa-star ${i <= avgRating ? 'text-warning' : 'text-muted'}"></i>
                                                    </c:forEach>
                                                    <span class="ms-2"><fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/></span>
                                                </div>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/reviews/product/${productId}" class="btn btn-sm btn-primary">
                                                    <i class="fas fa-eye"></i> View All
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-shopping-bag fa-3x text-muted mb-3"></i>
                            <p class="text-muted">No product reviews found</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<style>
    .stat-card {
        background: white;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        display: flex;
        align-items: center;
        gap: 20px;
    }
    
    .stat-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 24px;
    }
    
    .stat-content h3 {
        margin: 0;
        font-size: 2rem;
        font-weight: 700;
        color: #1a1a3e;
    }
    
    .stat-content p {
        margin: 5px 0 0 0;
        color: #666;
        font-size: 0.9rem;
    }
    
    .stat-content small {
        color: #999;
        font-size: 0.8rem;
    }
</style>

<jsp:include page="/WEB-INF/views/admin/layouts/admin-footer.jsp"/>

