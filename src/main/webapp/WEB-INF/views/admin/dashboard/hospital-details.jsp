<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${hospital.centerName} - Admin Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        :root {
            --admin-primary: #1a1a3e;
            --admin-secondary: #2d2d5e;
            --admin-accent: #C7A369;
            --admin-dark: #0f0f23;
        }
        
        .sidebar {
            background: linear-gradient(180deg, var(--admin-primary) 0%, var(--admin-dark) 100%);
        }
        
        .sidebar-logo .highlight {
            color: var(--admin-accent);
        }
        
        .nav-item.active {
            border-left-color: var(--admin-accent);
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #64748b;
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 20px;
            transition: color 0.3s ease;
        }
        
        .back-link:hover {
            color: var(--admin-primary);
        }
        
        .hospital-header {
            background: white;
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        
        .hospital-header-content {
            display: flex;
            align-items: flex-start;
            gap: 24px;
        }
        
        .hospital-logo {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, var(--admin-primary), var(--admin-secondary));
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2.5rem;
            flex-shrink: 0;
            overflow: hidden;
        }
        
        .hospital-logo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .hospital-header-info {
            flex: 1;
        }
        
        .hospital-header-info h1 {
            margin: 0 0 8px;
            font-size: 1.8rem;
            color: var(--admin-primary);
        }
        
        .hospital-meta {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 16px;
            flex-wrap: wrap;
        }
        
        .hospital-meta span {
            display: flex;
            align-items: center;
            gap: 6px;
            color: #64748b;
            font-size: 0.95rem;
        }
        
        .hospital-meta i {
            color: var(--admin-accent);
        }
        
        .hospital-badges {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .badge.status-pending {
            background: #fef3c7;
            color: #d97706;
        }
        
        .badge.status-approved {
            background: #d1fae5;
            color: #059669;
        }
        
        .badge.status-rejected {
            background: #fee2e2;
            color: #dc2626;
        }
        
        .badge.status-suspended {
            background: #f3f4f6;
            color: #6b7280;
        }
        
        .badge.verified {
            background: #dbeafe;
            color: #2563eb;
        }
        
        .badge.featured {
            background: linear-gradient(135deg, var(--admin-accent), #d4b07a);
            color: var(--admin-dark);
        }
        
        .badge.active {
            background: #d1fae5;
            color: #059669;
        }
        
        .badge.inactive {
            background: #fee2e2;
            color: #dc2626;
        }
        
        .hospital-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
        }
        
        .btn-admin {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.9rem;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-admin.approve {
            background: #10b981;
            color: white;
        }
        
        .btn-admin.approve:hover {
            background: #059669;
        }
        
        .btn-admin.reject {
            background: #ef4444;
            color: white;
        }
        
        .btn-admin.reject:hover {
            background: #dc2626;
        }
        
        .btn-admin.verify {
            background: #3b82f6;
            color: white;
        }
        
        .btn-admin.verify:hover {
            background: #2563eb;
        }
        
        .btn-admin.unverify {
            background: #6b7280;
            color: white;
        }
        
        .btn-admin.unverify:hover {
            background: #4b5563;
        }
        
        .btn-admin.suspend {
            background: #f59e0b;
            color: white;
        }
        
        .btn-admin.suspend:hover {
            background: #d97706;
        }
        
        .btn-admin.activate {
            background: #10b981;
            color: white;
        }
        
        .btn-admin.activate:hover {
            background: #059669;
        }
        
        .btn-admin.featured {
            background: linear-gradient(135deg, var(--admin-accent), #d4b07a);
            color: var(--admin-dark);
        }
        
        .btn-admin.featured:hover {
            opacity: 0.9;
        }
        
        .btn-admin.outline {
            background: white;
            color: var(--admin-primary);
            border: 2px solid #e5e7eb;
        }
        
        .btn-admin.outline:hover {
            border-color: var(--admin-primary);
        }
        
        .details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
        }
        
        .detail-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        
        .detail-card h3 {
            margin: 0 0 20px;
            font-size: 1.1rem;
            color: var(--admin-primary);
            display: flex;
            align-items: center;
            gap: 10px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f1f5f9;
        }
        
        .detail-card h3 i {
            color: var(--admin-accent);
        }
        
        .detail-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f1f5f9;
        }
        
        .detail-item:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            color: #64748b;
            font-size: 0.9rem;
        }
        
        .detail-value {
            color: var(--admin-primary);
            font-weight: 600;
            font-size: 0.9rem;
            text-align: right;
        }
        
        .detail-value.empty {
            color: #9ca3af;
            font-style: italic;
            font-weight: normal;
        }
        
        .certifications-list {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }
        
        .cert-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 14px;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .cert-badge.active {
            background: #d1fae5;
            color: #059669;
        }
        
        .cert-badge.inactive {
            background: #f3f4f6;
            color: #9ca3af;
        }
        
        .description-text {
            color: #64748b;
            line-height: 1.7;
            font-size: 0.95rem;
        }
        
        .stats-row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }
        
        .mini-stat {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        
        .mini-stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--admin-primary);
            margin-bottom: 5px;
        }
        
        .mini-stat-label {
            color: #64748b;
            font-size: 0.85rem;
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-success {
            background: #d1fae5;
            color: #059669;
        }
        
        .alert-error {
            background: #fee2e2;
            color: #dc2626;
        }
        
        .full-width {
            grid-column: span 2;
        }
        
        @media (max-width: 1200px) {
            .details-grid {
                grid-template-columns: 1fr;
            }
            
            .full-width {
                grid-column: span 1;
            }
            
            .stats-row {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .hospital-header-content {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }
            
            .hospital-meta {
                justify-content: center;
            }
            
            .hospital-badges {
                justify-content: center;
            }
            
            .hospital-actions {
                justify-content: center;
            }
            
            .stats-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body class="dashboard-body">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-shield-alt"></i>
                <span>Admin<span class="highlight">Panel</span></span>
            </a>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/hospitals" class="nav-item active">
                <i class="fas fa-hospital"></i>
                <span>All Hospitals</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/hospitals?status=PENDING" class="nav-item">
                <i class="fas fa-clock"></i>
                <span>Pending Approval</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/hospitals?status=APPROVED" class="nav-item">
                <i class="fas fa-check-circle"></i>
                <span>Approved</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/hospitals?status=REJECTED" class="nav-item">
                <i class="fas fa-times-circle"></i>
                <span>Rejected</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline btn-sm" target="_blank">
                <i class="fas fa-external-link-alt"></i> View Website
            </a>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="dashboard-main">
        <!-- Top Bar -->
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Hospital Details</h1>
            </div>
            
            <div class="header-right">
                <div class="header-profile">
                    <div class="profile-info">
                        <span class="profile-name">${admin.fullName}</span>
                        <span style="font-size: 0.8rem; color: #9ca3af;">Administrator</span>
                    </div>
                    <div class="profile-avatar">
                        <i class="fas fa-user-shield"></i>
                    </div>
                </div>
            </div>
        </header>

        <!-- Dashboard Content -->
        <div class="dashboard-content">
            <!-- Back Link -->
            <a href="${pageContext.request.contextPath}/admin/hospitals" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to All Hospitals
            </a>
            
            <!-- Alert Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <!-- Hospital Header -->
            <div class="hospital-header">
                <div class="hospital-header-content">
                    <div class="hospital-logo">
                        <c:choose>
                            <c:when test="${not empty hospital.logoUrl}">
                                <img src="${pageContext.request.contextPath}${hospital.logoUrl}" alt="${hospital.centerName}">
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-hospital"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="hospital-header-info">
                        <h1>${hospital.centerName}</h1>
                        
                        <div class="hospital-meta">
                            <span><i class="fas fa-envelope"></i> ${hospital.email}</span>
                            <span><i class="fas fa-map-marker-alt"></i> ${hospital.city}, ${hospital.state}</span>
                            <c:if test="${not empty hospital.receptionPhone}">
                                <span><i class="fas fa-phone"></i> ${hospital.receptionPhone}</span>
                            </c:if>
                        </div>
                        
                        <div class="hospital-badges">
                            <span class="badge status-${hospital.status.toString().toLowerCase()}">
                                <c:choose>
                                    <c:when test="${hospital.status == 'PENDING'}"><i class="fas fa-clock"></i></c:when>
                                    <c:when test="${hospital.status == 'APPROVED'}"><i class="fas fa-check"></i></c:when>
                                    <c:when test="${hospital.status == 'REJECTED'}"><i class="fas fa-times"></i></c:when>
                                    <c:otherwise><i class="fas fa-ban"></i></c:otherwise>
                                </c:choose>
                                ${hospital.status}
                            </span>
                            
                            <c:if test="${hospital.isVerified}">
                                <span class="badge verified">
                                    <i class="fas fa-check-circle"></i> Verified
                                </span>
                            </c:if>
                            
                            <c:if test="${hospital.isFeatured}">
                                <span class="badge featured">
                                    <i class="fas fa-star"></i> Featured
                                </span>
                            </c:if>
                            
                            <span class="badge ${hospital.isActive ? 'active' : 'inactive'}">
                                <i class="fas fa-${hospital.isActive ? 'check' : 'times'}-circle"></i>
                                ${hospital.isActive ? 'Active' : 'Inactive'}
                            </span>
                        </div>
                    </div>
                </div>
                
                <div class="hospital-actions">
                    <!-- Status Actions -->
                    <c:if test="${hospital.status == 'PENDING'}">
                        <form action="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}/approve" method="post" style="display: inline;">
                            <button type="submit" class="btn-admin approve">
                                <i class="fas fa-check"></i> Approve Hospital
                            </button>
                        </form>
                        <form action="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}/reject" method="post" style="display: inline;">
                            <button type="submit" class="btn-admin reject">
                                <i class="fas fa-times"></i> Reject Hospital
                            </button>
                        </form>
                    </c:if>
                    
                    <c:if test="${hospital.status == 'APPROVED'}">
                        <!-- Verification -->
                        <c:choose>
                            <c:when test="${hospital.isVerified}">
                                <form action="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}/unverify" method="post" style="display: inline;">
                                    <button type="submit" class="btn-admin unverify">
                                        <i class="fas fa-times-circle"></i> Remove Verification
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}/verify" method="post" style="display: inline;">
                                    <button type="submit" class="btn-admin verify">
                                        <i class="fas fa-check-circle"></i> Verify Hospital
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                        
                        <!-- Featured -->
                        <form action="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}/toggle-featured" method="post" style="display: inline;">
                            <button type="submit" class="btn-admin featured">
                                <i class="fas fa-star"></i> ${hospital.isFeatured ? 'Remove from Featured' : 'Mark as Featured'}
                            </button>
                        </form>
                        
                        <!-- Suspend -->
                        <form action="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}/suspend" method="post" style="display: inline;">
                            <button type="submit" class="btn-admin suspend">
                                <i class="fas fa-ban"></i> Suspend Hospital
                            </button>
                        </form>
                    </c:if>
                    
                    <c:if test="${hospital.status == 'SUSPENDED' || hospital.status == 'REJECTED'}">
                        <form action="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}/approve" method="post" style="display: inline;">
                            <button type="submit" class="btn-admin activate">
                                <i class="fas fa-check"></i> Reactivate Hospital
                            </button>
                        </form>
                    </c:if>
                    
                    <!-- View Public Profile -->
                    <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}" target="_blank" class="btn-admin outline">
                        <i class="fas fa-external-link-alt"></i> View Public Profile
                    </a>
                </div>
            </div>
            
            <!-- Stats Row -->
            <div class="stats-row">
                <div class="mini-stat">
                    <div class="mini-stat-value">${hospital.totalViews != null ? hospital.totalViews : 0}</div>
                    <div class="mini-stat-label">Profile Views</div>
                </div>
                <div class="mini-stat">
                    <div class="mini-stat-value">${hospital.totalBookings != null ? hospital.totalBookings : 0}</div>
                    <div class="mini-stat-label">Total Bookings</div>
                </div>
                <div class="mini-stat">
                    <div class="mini-stat-value">${hospital.totalReviews != null ? hospital.totalReviews : 0}</div>
                    <div class="mini-stat-label">Reviews</div>
                </div>
                <div class="mini-stat">
                    <div class="mini-stat-value">
                        <fmt:formatNumber value="${hospital.averageRating != null ? hospital.averageRating : 0}" maxFractionDigits="1"/>
                        <i class="fas fa-star" style="color: var(--admin-accent); font-size: 1rem;"></i>
                    </div>
                    <div class="mini-stat-label">Avg Rating</div>
                </div>
            </div>
            
            <!-- Details Grid -->
            <div class="details-grid">
                <!-- Basic Information -->
                <div class="detail-card">
                    <h3><i class="fas fa-info-circle"></i> Basic Information</h3>
                    
                    <div class="detail-item">
                        <span class="detail-label">Center Name</span>
                        <span class="detail-value">${hospital.centerName}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Center Type</span>
                        <span class="detail-value ${empty hospital.centerType ? 'empty' : ''}">${not empty hospital.centerType ? hospital.centerType : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Year Established</span>
                        <span class="detail-value ${empty hospital.yearEstablished ? 'empty' : ''}">${not empty hospital.yearEstablished ? hospital.yearEstablished : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Contact Person</span>
                        <span class="detail-value ${empty hospital.contactPersonName ? 'empty' : ''}">${not empty hospital.contactPersonName ? hospital.contactPersonName : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Contact Phone</span>
                        <span class="detail-value ${empty hospital.contactPersonPhone ? 'empty' : ''}">${not empty hospital.contactPersonPhone ? hospital.contactPersonPhone : 'Not specified'}</span>
                    </div>
                </div>
                
                <!-- Location Details -->
                <div class="detail-card">
                    <h3><i class="fas fa-map-marker-alt"></i> Location Details</h3>
                    
                    <div class="detail-item">
                        <span class="detail-label">Street Address</span>
                        <span class="detail-value ${empty hospital.streetAddress ? 'empty' : ''}">${not empty hospital.streetAddress ? hospital.streetAddress : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">City</span>
                        <span class="detail-value ${empty hospital.city ? 'empty' : ''}">${not empty hospital.city ? hospital.city : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">State</span>
                        <span class="detail-value ${empty hospital.state ? 'empty' : ''}">${not empty hospital.state ? hospital.state : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">PIN Code</span>
                        <span class="detail-value ${empty hospital.pinCode ? 'empty' : ''}">${not empty hospital.pinCode ? hospital.pinCode : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Country</span>
                        <span class="detail-value ${empty hospital.country ? 'empty' : ''}">${not empty hospital.country ? hospital.country : 'India'}</span>
                    </div>
                </div>
                
                <!-- Contact Details -->
                <div class="detail-card">
                    <h3><i class="fas fa-address-book"></i> Contact Details</h3>
                    
                    <div class="detail-item">
                        <span class="detail-label">Email</span>
                        <span class="detail-value">${hospital.email}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Public Email</span>
                        <span class="detail-value ${empty hospital.publicEmail ? 'empty' : ''}">${not empty hospital.publicEmail ? hospital.publicEmail : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Reception Phone</span>
                        <span class="detail-value ${empty hospital.receptionPhone ? 'empty' : ''}">${not empty hospital.receptionPhone ? hospital.receptionPhone : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Emergency Phone</span>
                        <span class="detail-value ${empty hospital.emergencyPhone ? 'empty' : ''}">${not empty hospital.emergencyPhone ? hospital.emergencyPhone : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Website</span>
                        <span class="detail-value ${empty hospital.website ? 'empty' : ''}">${not empty hospital.website ? hospital.website : 'Not specified'}</span>
                    </div>
                </div>
                
                <!-- Medical Credentials -->
                <div class="detail-card">
                    <h3><i class="fas fa-certificate"></i> Medical Credentials</h3>
                    
                    <div class="detail-item">
                        <span class="detail-label">License Number</span>
                        <span class="detail-value ${empty hospital.medicalLicenseNumber ? 'empty' : ''}">${not empty hospital.medicalLicenseNumber ? hospital.medicalLicenseNumber : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Doctors Count</span>
                        <span class="detail-value ${empty hospital.doctorsCount ? 'empty' : ''}">${not empty hospital.doctorsCount ? hospital.doctorsCount : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Therapists Count</span>
                        <span class="detail-value ${empty hospital.therapistsCount ? 'empty' : ''}">${not empty hospital.therapistsCount ? hospital.therapistsCount : 'Not specified'}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Beds Capacity</span>
                        <span class="detail-value ${empty hospital.bedsCapacity ? 'empty' : ''}">${not empty hospital.bedsCapacity ? hospital.bedsCapacity : 'Not specified'}</span>
                    </div>
                    
                    <div class="certifications-list">
                        <span class="cert-badge ${hospital.ayushCertified ? 'active' : 'inactive'}">
                            <i class="fas fa-${hospital.ayushCertified ? 'check' : 'times'}"></i> AYUSH Certified
                        </span>
                        <span class="cert-badge ${hospital.nabhCertified ? 'active' : 'inactive'}">
                            <i class="fas fa-${hospital.nabhCertified ? 'check' : 'times'}"></i> NABH Certified
                        </span>
                        <span class="cert-badge ${hospital.isoCertified ? 'active' : 'inactive'}">
                            <i class="fas fa-${hospital.isoCertified ? 'check' : 'times'}"></i> ISO Certified
                        </span>
                        <span class="cert-badge ${hospital.stateGovtApproved ? 'active' : 'inactive'}">
                            <i class="fas fa-${hospital.stateGovtApproved ? 'check' : 'times'}"></i> State Govt Approved
                        </span>
                    </div>
                </div>
                
                <!-- Description -->
                <div class="detail-card full-width">
                    <h3><i class="fas fa-align-left"></i> Description</h3>
                    <c:choose>
                        <c:when test="${not empty hospital.description}">
                            <p class="description-text">${hospital.description}</p>
                        </c:when>
                        <c:otherwise>
                            <p class="description-text" style="color: #9ca3af; font-style: italic;">No description provided.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Timestamps -->
                <div class="detail-card full-width">
                    <h3><i class="fas fa-clock"></i> Activity Timeline</h3>
                    
                    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px;">
                        <div class="detail-item" style="flex-direction: column; align-items: flex-start;">
                            <span class="detail-label">Registered On</span>
                            <span class="detail-value" style="text-align: left;">
                                <fmt:parseDate value="${hospital.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt" type="both"/>
                                <fmt:formatDate value="${createdAt}" pattern="dd MMMM yyyy, hh:mm a"/>
                            </span>
                        </div>
                        <div class="detail-item" style="flex-direction: column; align-items: flex-start;">
                            <span class="detail-label">Last Updated</span>
                            <span class="detail-value" style="text-align: left;">
                                <c:if test="${not empty hospital.updatedAt}">
                                    <fmt:parseDate value="${hospital.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="updatedAt" type="both"/>
                                    <fmt:formatDate value="${updatedAt}" pattern="dd MMMM yyyy, hh:mm a"/>
                                </c:if>
                                <c:if test="${empty hospital.updatedAt}">-</c:if>
                            </span>
                        </div>
                        <div class="detail-item" style="flex-direction: column; align-items: flex-start;">
                            <span class="detail-label">Last Login</span>
                            <span class="detail-value ${empty hospital.lastLoginAt ? 'empty' : ''}" style="text-align: left;">
                                <c:if test="${not empty hospital.lastLoginAt}">
                                    <fmt:parseDate value="${hospital.lastLoginAt}" pattern="yyyy-MM-dd'T'HH:mm" var="lastLoginAt" type="both"/>
                                    <fmt:formatDate value="${lastLoginAt}" pattern="dd MMMM yyyy, hh:mm a"/>
                                </c:if>
                                <c:if test="${empty hospital.lastLoginAt}">Never logged in</c:if>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        // Sidebar toggle for mobile
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
            });
        }
        
        // Auto-dismiss alerts
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                alert.style.opacity = '0';
                alert.style.transition = 'opacity 0.5s ease';
                setTimeout(function() {
                    alert.remove();
                }, 500);
            });
        }, 5000);
    </script>
</body>
</html>

