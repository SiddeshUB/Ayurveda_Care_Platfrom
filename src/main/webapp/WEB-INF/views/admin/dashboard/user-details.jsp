<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="User Details" scope="request"/>
<c:set var="activePage" value="users" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layouts/admin-header.jsp" %>
<style>
    .page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 24px; }
    .card { border: none; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 20px; background: white; }
    .card-header { background: #f9fafb; border-bottom: 1px solid #e5e7eb; padding: 16px 20px; font-weight: 600; color: #374151; }
    .card-body { padding: 20px; }
    .user-header { background: linear-gradient(135deg, #2d5a27, #4a7c43); color: white; border-radius: 12px; padding: 30px; margin-bottom: 20px; }
    .user-avatar { width: 150px; height: 150px; border-radius: 50%; background: white; display: flex; align-items: center; justify-content: center; overflow: hidden; font-size: 3rem; color: #2d5a27; font-weight: 600; }
    .info-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 20px; }
    .info-item { }
    .info-item label { font-size: 0.85rem; color: #6b7280; margin-bottom: 5px; display: block; font-weight: 500; }
    .info-item p { margin: 0; font-size: 1rem; color: #111827; font-weight: 500; }
    .status-badge { display: inline-flex; align-items: center; gap: 6px; padding: 6px 15px; border-radius: 20px; font-size: 0.85rem; font-weight: 600; }
    .status-badge.active { background: #d1fae5; color: #059669; }
    .status-badge.inactive { background: #fee2e2; color: #dc2626; }
    .status-badge.verified { background: #dbeafe; color: #1e40af; }
    .text-section { margin-bottom: 20px; }
    .text-section label { font-size: 0.9rem; color: #6b7280; margin-bottom: 8px; display: block; font-weight: 500; }
    .text-content { color: #4b5563; line-height: 1.7; white-space: pre-wrap; }
</style>

<main class="main-content">
    <div class="page-header">
        <div>
            <a href="${pageContext.request.contextPath}/admin/users" class="text-decoration-none" style="color: #6b7280;">
                <i class="fas fa-arrow-left me-2"></i>Back to Users
            </a>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>

    <c:if test="${not empty user}">
        <!-- User Header -->
        <div class="user-header">
            <div style="display: flex; align-items: center; gap: 25px;">
                <div class="user-avatar">
                    ${user.fullName != null ? user.fullName.substring(0, 1).toUpperCase() : 'U'}
                </div>
                <div style="flex: 1;">
                    <h2 class="mb-2" style="margin: 0; font-size: 1.75rem;">${user.fullName}</h2>
                    <p class="mb-3 opacity-75" style="margin: 0; font-size: 1rem;">${user.email}</p>
                    <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                        <span class="status-badge ${user.isActive ? 'active' : 'inactive'}">
                            ${user.isActive ? 'Active' : 'Inactive'}
                        </span>
                        <c:if test="${user.emailVerified}">
                            <span class="status-badge verified">
                                <i class="fas fa-check-circle"></i> Email Verified
                            </span>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Basic Information -->
        <div class="card">
            <div class="card-header"><i class="fas fa-user me-2"></i>Basic Information</div>
            <div class="card-body">
                <div class="info-row">
                    <div class="info-item">
                        <label>User ID</label>
                        <p>${user.id}</p>
                    </div>
                    <div class="info-item">
                        <label>Full Name</label>
                        <p>${user.fullName}</p>
                    </div>
                    <div class="info-item">
                        <label>Email</label>
                        <p>${user.email}</p>
                    </div>
                    <div class="info-item">
                        <label>Phone</label>
                        <p>${not empty user.phone ? user.phone : 'N/A'}</p>
                    </div>
                    <div class="info-item">
                        <label>Gender</label>
                        <p>${not empty user.gender ? user.gender : 'N/A'}</p>
                    </div>
                    <c:if test="${user.dateOfBirth != null}">
                        <div class="info-item">
                            <label>Date of Birth</label>
                            <p>
                                <%
                                    com.ayurveda.entity.User userObj1 = (com.ayurveda.entity.User) pageContext.getAttribute("user");
                                    if (userObj1 != null && userObj1.getDateOfBirth() != null) {
                                        out.print(userObj1.getDateOfBirth().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                    } else {
                                        out.print("N/A");
                                    }
                                %>
                            </p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Address Information -->
        <c:if test="${not empty user.address || not empty user.city || not empty user.state || not empty user.country}">
            <div class="card">
                <div class="card-header"><i class="fas fa-map-marker-alt me-2"></i>Address Information</div>
                <div class="card-body">
                    <div class="info-row">
                        <c:if test="${not empty user.address}">
                            <div class="info-item" style="grid-column: 1 / -1;">
                                <label>Address</label>
                                <p class="text-content">${user.address}</p>
                            </div>
                        </c:if>
                        <div class="info-item">
                            <label>City</label>
                            <p>${not empty user.city ? user.city : 'N/A'}</p>
                        </div>
                        <div class="info-item">
                            <label>State</label>
                            <p>${not empty user.state ? user.state : 'N/A'}</p>
                        </div>
                        <div class="info-item">
                            <label>Country</label>
                            <p>${not empty user.country ? user.country : 'N/A'}</p>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Purpose/Interest -->
        <c:if test="${not empty user.purpose}">
            <div class="card">
                <div class="card-header"><i class="fas fa-heart me-2"></i>Purpose/Interest</div>
                <div class="card-body">
                    <div class="text-section">
                        <p class="text-content">${user.purpose}</p>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Account Information -->
        <div class="card">
            <div class="card-header"><i class="fas fa-info-circle me-2"></i>Account Information</div>
            <div class="card-body">
                <div class="info-row">
                    <div class="info-item">
                        <label>Account Status</label>
                        <p>
                            <span class="status-badge ${user.isActive ? 'active' : 'inactive'}">
                                ${user.isActive ? 'Active' : 'Inactive'}
                            </span>
                        </p>
                    </div>
                    <div class="info-item">
                        <label>Email Verified</label>
                        <p>
                            <span class="status-badge ${user.emailVerified ? 'verified' : 'inactive'}">
                                ${user.emailVerified ? 'Verified' : 'Not Verified'}
                            </span>
                        </p>
                    </div>
                    <div class="info-item">
                        <label>Created At</label>
                        <p>
                            <%
                                com.ayurveda.entity.User userObj = (com.ayurveda.entity.User) pageContext.getAttribute("user");
                                if (userObj != null && userObj.getCreatedAt() != null) {
                                    out.print(userObj.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
                                } else {
                                    out.print("N/A");
                                }
                            %>
                        </p>
                    </div>
                    <div class="info-item">
                        <label>Last Updated</label>
                        <p>
                            <%
                                com.ayurveda.entity.User userObj2 = (com.ayurveda.entity.User) pageContext.getAttribute("user");
                                if (userObj2 != null && userObj2.getUpdatedAt() != null) {
                                    out.print(userObj2.getUpdatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
                                } else {
                                    out.print("N/A");
                                }
                            %>
                        </p>
                    </div>
                    <c:if test="${user.lastLoginAt != null}">
                        <div class="info-item">
                            <label>Last Login</label>
                            <p>
                                <%
                                    com.ayurveda.entity.User userObj3 = (com.ayurveda.entity.User) pageContext.getAttribute("user");
                                    if (userObj3 != null && userObj3.getLastLoginAt() != null) {
                                        out.print(userObj3.getLastLoginAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
                                    } else {
                                        out.print("N/A");
                                    }
                                %>
                            </p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${empty user}">
        <div class="card">
            <div class="card-body text-center" style="padding: 60px 20px;">
                <i class="fas fa-exclamation-triangle" style="font-size: 3rem; color: #f59e0b; margin-bottom: 20px;"></i>
                <h3>User Not Found</h3>
                <p class="text-muted">The user you are looking for does not exist.</p>
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary mt-3">
                    <i class="fas fa-arrow-left me-2"></i>Back to Users
                </a>
            </div>
        </div>
    </c:if>
</main>

<%@ include file="/WEB-INF/views/admin/layouts/admin-footer.jsp" %>

