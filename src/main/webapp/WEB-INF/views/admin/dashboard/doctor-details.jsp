<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Doctor Details" scope="request"/>
<c:set var="activePage" value="doctors" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layouts/admin-header.jsp" %>
<style>
    .page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 24px; }
    .card { border: none; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 20px; background: white; }
    .card-header { background: #f9fafb; border-bottom: 1px solid #e5e7eb; padding: 16px 20px; font-weight: 600; color: #374151; }
    .card-body { padding: 20px; }
    .doctor-header { background: linear-gradient(135deg, #2d5a27, #4a7c43); color: white; border-radius: 12px; padding: 30px; margin-bottom: 20px; }
    .doctor-photo { width: 150px; height: 150px; border-radius: 50%; background: white; display: flex; align-items: center; justify-content: center; overflow: hidden; font-size: 3rem; color: #2d5a27; font-weight: 600; }
    .doctor-photo img { width: 100%; height: 100%; object-fit: cover; }
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
            <a href="${pageContext.request.contextPath}/admin/doctors" class="text-decoration-none" style="color: #6b7280;">
                <i class="fas fa-arrow-left me-2"></i>Back to Doctors
            </a>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>

    <c:if test="${not empty doctor}">
        <!-- Doctor Header -->
        <div class="doctor-header">
            <div style="display: flex; align-items: center; gap: 25px;">
                <div class="doctor-photo">
                    <c:choose>
                        <c:when test="${not empty doctor.photoUrl}">
                            <img src="${pageContext.request.contextPath}${doctor.photoUrl}" alt="${doctor.name}">
                        </c:when>
                        <c:otherwise>
                            ${doctor.name != null ? doctor.name.substring(0, 1).toUpperCase() : 'D'}
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="flex: 1;">
                    <h2 class="mb-2" style="margin: 0; font-size: 1.75rem;">${doctor.name}</h2>
                    <p class="mb-3 opacity-75" style="margin: 0; font-size: 1rem;">${doctor.qualifications}</p>
                    <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                        <span class="status-badge ${doctor.isActive ? 'active' : 'inactive'}">
                            ${doctor.isActive ? 'Active' : 'Inactive'}
                        </span>
                        <c:if test="${doctor.isVerified}">
                            <span class="status-badge verified">
                                <i class="fas fa-check-circle"></i> Verified
                            </span>
                        </c:if>
                        <c:if test="${doctor.isAvailable}">
                            <span class="status-badge active">
                                <i class="fas fa-clock"></i> Available
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
                        <label>Doctor ID</label>
                        <p>${doctor.id}</p>
                    </div>
                    <div class="info-item">
                        <label>Email</label>
                        <p>${doctor.email}</p>
                    </div>
                    <div class="info-item">
                        <label>Phone</label>
                        <p>${not empty doctor.phone ? doctor.phone : 'N/A'}</p>
                    </div>
                    <div class="info-item">
                        <label>Gender</label>
                        <p>${not empty doctor.gender ? doctor.gender : 'N/A'}</p>
                    </div>
                    <div class="info-item">
                        <label>Hospital</label>
                        <p>${not empty doctor.hospital ? doctor.hospital.centerName : 'Independent / Not Assigned'}</p>
                    </div>
                    <div class="info-item">
                        <label>Profile Complete</label>
                        <p>${doctor.profileComplete ? 'Yes' : 'No'}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Professional Information -->
        <div class="card">
            <div class="card-header"><i class="fas fa-graduation-cap me-2"></i>Professional Information</div>
            <div class="card-body">
                <c:if test="${not empty doctor.qualifications}">
                    <div class="text-section">
                        <label>Qualifications</label>
                        <p class="text-content">${doctor.qualifications}</p>
                    </div>
                </c:if>
                <c:if test="${not empty doctor.specializations}">
                    <div class="text-section">
                        <label>Specializations</label>
                        <p class="text-content">${doctor.specializations}</p>
                    </div>
                </c:if>
                <div class="info-row">
                    <c:if test="${doctor.experienceYears != null}">
                        <div class="info-item">
                            <label>Experience (Years)</label>
                            <p>${doctor.experienceYears}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty doctor.registrationNumber}">
                        <div class="info-item">
                            <label>Registration Number</label>
                            <p>${doctor.registrationNumber}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty doctor.degreeUniversity}">
                        <div class="info-item">
                            <label>Degree University</label>
                            <p>${doctor.degreeUniversity}</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Biography -->
        <c:if test="${not empty doctor.biography}">
            <div class="card">
                <div class="card-header"><i class="fas fa-book me-2"></i>Biography</div>
                <div class="card-body">
                    <p class="text-content">${doctor.biography}</p>
                </div>
            </div>
        </c:if>

        <!-- Consultation Information -->
        <div class="card">
            <div class="card-header"><i class="fas fa-calendar-check me-2"></i>Consultation Information</div>
            <div class="card-body">
                <div class="info-row">
                    <c:if test="${not empty doctor.consultationDays}">
                        <div class="info-item">
                            <label>Consultation Days</label>
                            <p>${doctor.consultationDays}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty doctor.consultationTimings}">
                        <div class="info-item">
                            <label>Consultation Timings</label>
                            <p>${doctor.consultationTimings}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty doctor.availableLocations}">
                        <div class="info-item">
                            <label>Available Locations</label>
                            <p>${doctor.availableLocations}</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Additional Information -->
        <c:if test="${not empty doctor.languagesSpoken}">
            <div class="card">
                <div class="card-header"><i class="fas fa-language me-2"></i>Additional Information</div>
                <div class="card-body">
                    <div class="info-item">
                        <label>Languages Spoken</label>
                        <p class="text-content">${doctor.languagesSpoken}</p>
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
                        <label>Created At</label>
                        <p>
                            <%
                                com.ayurveda.entity.Doctor d = (com.ayurveda.entity.Doctor) pageContext.getAttribute("doctor");
                                if (d != null && d.getCreatedAt() != null) {
                                    out.print(d.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
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
                                if (d != null && d.getUpdatedAt() != null) {
                                    out.print(d.getUpdatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
                                } else {
                                    out.print("N/A");
                                }
                            %>
                        </p>
                    </div>
                    <c:if test="${doctor.lastLoginAt != null}">
                        <div class="info-item">
                            <label>Last Login</label>
                            <p>
                                <%
                                    if (d != null && d.getLastLoginAt() != null) {
                                        out.print(d.getLastLoginAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
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

    <c:if test="${empty doctor}">
        <div class="card">
            <div class="card-body text-center" style="padding: 60px 20px;">
                <i class="fas fa-exclamation-triangle" style="font-size: 3rem; color: #f59e0b; margin-bottom: 20px;"></i>
                <h3>Doctor Not Found</h3>
                <p class="text-muted">The doctor you are looking for does not exist.</p>
                <a href="${pageContext.request.contextPath}/admin/doctors" class="btn btn-primary mt-3">
                    <i class="fas fa-arrow-left me-2"></i>Back to Doctors
                </a>
            </div>
        </div>
    </c:if>
</main>

<%@ include file="/WEB-INF/views/admin/layouts/admin-footer.jsp" %>

