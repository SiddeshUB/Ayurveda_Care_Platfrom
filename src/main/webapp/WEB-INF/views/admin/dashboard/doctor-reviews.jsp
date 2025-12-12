<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/admin/layouts/admin-header.jsp">
    <jsp:param name="pageTitle" value="Doctor Reviews"/>
    <jsp:param name="activePage" value="reviews"/>
</jsp:include>

<div class="mb-4">
    <a href="${pageContext.request.contextPath}/admin/reviews" class="btn btn-outline-secondary">
        <i class="fas fa-arrow-left"></i> Back to All Reviews
    </a>
</div>

<div class="card mb-4">
    <div class="card-header">
        <h5 class="mb-0"><i class="fas fa-user-md"></i> All Reviews for ${doctor != null ? doctor.fullName : 'Doctor'}</h5>
    </div>
    <div class="card-body">
        <c:if test="${doctor != null}">
            <div class="mb-3">
                <strong>Doctor:</strong> ${doctor.fullName}<br>
                <strong>Specialization:</strong> ${doctor.specialization != null ? doctor.specialization : 'N/A'}<br>
                <strong>Email:</strong> ${doctor.email}<br>
                <strong>Total Reviews:</strong> ${reviews.size()}
            </div>
        </c:if>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <c:choose>
            <c:when test="${not empty reviews}">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Reviewer</th>
                                <th>Rating</th>
                                <th>Review</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="review" items="${reviews}">
                                <tr>
                                    <td>
                                        <strong>${review.reviewerName != null ? review.reviewerName : 'Anonymous'}</strong>
                                        <br><small class="text-muted">${review.reviewerEmail != null ? review.reviewerEmail : 'N/A'}</small>
                                        <c:if test="${review.isVerified != null && review.isVerified}">
                                            <br><span class="badge bg-success"><i class="fas fa-check"></i> Verified</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-muted'}"></i>
                                            </c:forEach>
                                            <span class="ms-2">${review.rating}/5</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div style="max-width: 300px;">
                                            ${review.reviewText != null ? review.reviewText : 'N/A'}
                                        </div>
                                    </td>
                                    <td>
                                        ${review.createdAt}
                                    </td>
                                    <td>
                                        <span class="badge ${review.status == 'APPROVED' ? 'bg-success' : review.status == 'PENDING' ? 'bg-warning' : 'bg-danger'}">
                                            ${review.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <p class="text-muted text-center py-5">No reviews found for this doctor</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/views/admin/layouts/admin-footer.jsp"/>

