<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Management - Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        .doctor-card {
            background: white;
            border-radius: var(--radius-lg);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
        }
        
        .doctor-header {
            display: flex;
            align-items: center;
            gap: var(--spacing-lg);
            padding: var(--spacing-lg);
            background: var(--neutral-sand);
        }
        
        .doctor-photo {
            width: 80px;
            height: 80px;
            border-radius: var(--radius-full);
            background: var(--primary-sage);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .doctor-photo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .doctor-photo i {
            font-size: 2rem;
            color: white;
        }
        
        .doctor-info h4 {
            margin: 0 0 var(--spacing-xs);
        }
        
        .doctor-info .qualifications {
            color: var(--primary-forest);
            font-weight: 500;
            font-size: 0.9rem;
        }
        
        .doctor-info .specialization {
            color: var(--text-muted);
            font-size: 0.85rem;
        }
        
        .doctor-body {
            padding: var(--spacing-lg);
        }
        
        .doctor-detail {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            margin-bottom: var(--spacing-sm);
            font-size: 0.9rem;
            color: var(--text-medium);
        }
        
        .doctor-detail i {
            width: 20px;
            color: var(--primary-sage);
        }
        
        .doctor-actions {
            display: flex;
            gap: var(--spacing-sm);
            padding: var(--spacing-md) var(--spacing-lg);
            border-top: 1px solid var(--neutral-stone);
        }
    </style>
</head>
<body class="dashboard-body">
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-leaf"></i>
                <span>AyurVeda<span class="highlight">Care</span></span>
            </a>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/profile" class="nav-item">
                <i class="fas fa-hospital"></i>
                <span>Profile</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/packages" class="nav-item">
                <i class="fas fa-box"></i>
                <span>Packages</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/doctors" class="nav-item active">
                <i class="fas fa-user-md"></i>
                <span>Doctors</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/bookings" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Bookings</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/enquiries" class="nav-item">
                <i class="fas fa-envelope"></i>
                <span>Enquiries</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/gallery" class="nav-item">
                <i class="fas fa-images"></i>
                <span>Gallery</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/reviews" class="nav-item">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/hospital/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Doctor Management</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success" data-auto-dismiss="10000" style="background: #d1fae5; color: #065f46; border: 1px solid #6ee7b7; padding: 15px 20px; border-radius: 10px; margin-bottom: 24px;">
                    <i class="fas fa-check-circle"></i>
                    <div style="display: inline-block; margin-left: 10px;">
                        ${success}
                        <c:if test="${not empty doctorEmail}">
                            <div style="margin-top: 8px; padding: 10px; background: white; border-radius: 6px; font-family: monospace; font-size: 0.9rem;">
                                <strong>Doctor Email:</strong> ${doctorEmail}
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error" data-auto-dismiss="5000">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <div class="page-header">
                <div>
                    <h2 style="margin: 0;">Your Doctors</h2>
                    <p style="color: var(--text-muted); margin: var(--spacing-xs) 0 0;">Manage your medical team</p>
                </div>
                <div style="display: flex; gap: 12px;">
                    <c:if test="${not empty pendingRequests && pendingRequests.size() > 0}">
                        <a href="${pageContext.request.contextPath}/dashboard/doctors/requests" class="btn btn-secondary">
                            <i class="fas fa-clock"></i> Pending Requests 
                            <span style="background: #ef4444; color: white; padding: 2px 8px; border-radius: 12px; margin-left: 6px; font-size: 0.85rem;">
                                ${pendingRequests.size()}
                            </span>
                        </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/dashboard/doctors/add" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add Doctor
                    </a>
                </div>
            </div>

            <!-- Pending Requests Alert -->
            <c:if test="${not empty pendingRequests && pendingRequests.size() > 0}">
                <div class="alert alert-warning" style="background: #fef3c7; color: #d97706; border: 1px solid #fde68a; padding: 15px 20px; border-radius: 10px; margin-bottom: 24px; display: flex; align-items: center; gap: 12px;">
                    <i class="fas fa-exclamation-triangle"></i>
                    <div style="flex: 1;">
                        <strong>${pendingRequests.size()} doctor request(s) pending approval</strong>
                        <p style="margin: 4px 0 0; font-size: 0.9rem;">Review and approve doctor association requests</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/dashboard/doctors/requests" class="btn btn-sm" style="background: #d97706; color: white;">
                        Review Requests
                    </a>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${not empty allDoctors && allDoctors.size() > 0}">
                    <div class="item-grid">
                        <c:forEach var="doctor" items="${allDoctors}">
                            <%
                                // Find association for this doctor if it exists
                                com.ayurveda.entity.Doctor d = (com.ayurveda.entity.Doctor) pageContext.getAttribute("doctor");
                                com.ayurveda.entity.DoctorHospitalAssociation doctorAssociation = null;
                                if (d != null && request.getAttribute("approvedAssociations") != null) {
                                    java.util.List<com.ayurveda.entity.DoctorHospitalAssociation> associations = 
                                        (java.util.List<com.ayurveda.entity.DoctorHospitalAssociation>) request.getAttribute("approvedAssociations");
                                    for (com.ayurveda.entity.DoctorHospitalAssociation assoc : associations) {
                                        if (assoc.getDoctor() != null && assoc.getDoctor().getId().equals(d.getId())) {
                                            doctorAssociation = assoc;
                                            break;
                                        }
                                    }
                                }
                                pageContext.setAttribute("doctorAssociation", doctorAssociation);
                            %>
                            <div class="doctor-card">
                                <div class="doctor-header">
                                    <div class="doctor-photo">
                                        <c:choose>
                                            <c:when test="${not empty doctor.photoUrl}">
                                                <img src="${pageContext.request.contextPath}${doctor.photoUrl}" alt="${doctor.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-user-md"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="doctor-info">
                                        <h4>${doctor.name}</h4>
                                        <c:if test="${not empty doctor.qualifications}">
                                            <div class="qualifications">${doctor.qualifications}</div>
                                        </c:if>
                                        <c:if test="${not empty doctor.specializations}">
                                            <div class="specialization">${doctor.specializations}</div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="doctor-body">
                                    <c:if test="${doctor.experienceYears != null}">
                                        <div class="doctor-detail">
                                            <i class="fas fa-briefcase"></i>
                                            <span>${doctor.experienceYears} Years Experience</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty doctor.languagesSpoken}">
                                        <div class="doctor-detail">
                                            <i class="fas fa-language"></i>
                                            <span>${doctor.languagesSpoken}</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty doctor.phone}">
                                        <div class="doctor-detail">
                                            <i class="fas fa-phone"></i>
                                            <span>${doctor.phone}</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty doctor.email}">
                                        <div class="doctor-detail">
                                            <i class="fas fa-envelope"></i>
                                            <span>${doctor.email}</span>
                                        </div>
                                    </c:if>
                                    <div class="doctor-detail">
                                        <i class="fas fa-circle" style="font-size: 0.6rem; color: ${doctor.isActive ? '#28a745' : '#dc3545'}"></i>
                                        <span>${doctor.isActive ? 'Active' : 'Inactive'}</span>
                                    </div>
                                    <c:if test="${doctorAssociation != null}">
                                        <c:if test="${not empty doctorAssociation.designation}">
                                            <div class="doctor-detail" style="margin-top: 0.5rem; padding-top: 0.5rem; border-top: 1px solid #e9ecef;">
                                                <i class="fas fa-id-badge"></i>
                                                <span><strong>Designation:</strong> ${doctorAssociation.designation}</span>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty doctorAssociation.consultationTimings}">
                                            <div class="doctor-detail">
                                                <i class="fas fa-clock"></i>
                                                <span><strong>Timings:</strong> ${doctorAssociation.consultationTimings}</span>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty doctorAssociation.consultationDays}">
                                            <div class="doctor-detail">
                                                <i class="fas fa-calendar"></i>
                                                <span><strong>Days:</strong> ${doctorAssociation.consultationDays}</span>
                                            </div>
                                        </c:if>
                                    </c:if>
                                </div>
                                <div class="doctor-actions">
                                    <a href="${pageContext.request.contextPath}/dashboard/doctors/edit/${doctor.id}" class="btn btn-sm btn-secondary">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <c:if test="${doctorAssociation != null}">
                                        <form action="${pageContext.request.contextPath}/dashboard/doctors/${doctorAssociation.id}/suspend" method="post" style="display: inline;" onsubmit="return confirm('Suspend this doctor association?');">
                                            <button type="submit" class="btn btn-sm btn-outline" style="color: var(--warning);">
                                                <i class="fas fa-ban"></i> Suspend
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test="${doctorAssociation == null}">
                                        <span class="badge" style="background: #28a745; color: white; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem;">
                                            <i class="fas fa-check-circle"></i> Directly Registered
                                        </span>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" style="background: white; border-radius: var(--radius-lg); padding: var(--spacing-3xl); text-align: center;">
                        <i class="fas fa-user-md" style="font-size: 4rem; color: var(--text-light); margin-bottom: var(--spacing-lg); opacity: 0.5;"></i>
                        <h3>No Doctors Registered</h3>
                        <p style="color: var(--text-muted); margin-bottom: var(--spacing-lg);">You haven't registered any doctors yet. Add doctors to build your medical team.</p>
                        <div style="display: flex; gap: 12px; justify-content: center; margin-top: var(--spacing-lg);">
                            <a href="${pageContext.request.contextPath}/dashboard/doctors/add" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Add Doctor
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
            });
        }
    </script>
</body>
</html>

