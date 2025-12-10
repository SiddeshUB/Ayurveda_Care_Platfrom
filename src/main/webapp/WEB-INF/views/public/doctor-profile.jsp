<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dr. ${doctor.name} - AyurVedaCare</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* User Menu Dropdown - Amazon Style */
        .user-menu-container {
            position: relative;
            display: inline-block;
        }
        
        .user-name-link {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 15px;
            border-radius: 20px;
            background: rgba(230, 181, 92, 0.1);
            transition: all 0.3s ease;
        }
        
        .user-name-link:hover {
            background: rgba(230, 181, 92, 0.2);
        }
        
        .user-name-link i.fa-user-circle {
            font-size: 20px;
            color: #e6b55c;
        }
        
        .user-name-link span {
            font-weight: 500;
            color: #fff;
        }
        
        .user-name-link .fa-chevron-down {
            font-size: 12px;
            color: #e6b55c;
            transition: transform 0.3s ease;
        }
        
        .user-menu-container:hover .fa-chevron-down {
            transform: rotate(180deg);
        }
        
        .user-dropdown {
            position: absolute;
            top: 100%;
            right: 0;
            margin-top: 10px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
            min-width: 220px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.3s ease;
            z-index: 1000;
            padding: 8px 0;
        }
        
        .user-menu-container:hover .user-dropdown {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }
        
        .user-dropdown a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 20px;
            color: #333 !important;
            text-decoration: none;
            transition: background 0.2s ease;
            font-size: 14px;
        }
        
        .user-dropdown a:hover {
            background: #f5f5f5;
            color: #e6b55c !important;
        }
        
        .user-dropdown a i {
            width: 18px;
            color: #666;
        }
        
        .user-dropdown a:hover i {
            color: #e6b55c;
        }
        
        .dropdown-divider {
            height: 1px;
            background: #e0e0e0;
            margin: 8px 0;
        }
        
        .doctor-profile-page {
            padding-top: 70px;
            min-height: 100vh;
            background: var(--neutral-sand);
        }
        
        .profile-hero {
            position: relative;
            background: linear-gradient(135deg, var(--primary-forest), var(--primary-sage));
            padding: var(--spacing-3xl) var(--spacing-xl) var(--spacing-2xl);
            color: white;
        }
        
        .hero-container {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: var(--spacing-2xl);
            align-items: center;
        }
        
        .doctor-photo-large {
            width: 300px;
            height: 300px;
            border-radius: var(--radius-xl);
            overflow: hidden;
            background: rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--shadow-lg);
        }
        
        .doctor-photo-large img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .doctor-photo-large i {
            font-size: 8rem;
            color: white;
            opacity: 0.3;
        }
        
        .hero-info h1 {
            color: white;
            font-size: 2.5rem;
            margin: 0 0 var(--spacing-md);
        }
        
        .hero-qualifications {
            font-size: 1.1rem;
            color: var(--accent-gold);
            font-weight: 600;
            margin-bottom: var(--spacing-sm);
        }
        
        .hero-specializations {
            font-size: 1rem;
            opacity: 0.9;
            margin-bottom: var(--spacing-lg);
        }
        
        .hero-meta {
            display: flex;
            flex-wrap: wrap;
            gap: var(--spacing-lg);
            font-size: 0.95rem;
        }
        
        .hero-meta-item {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
        }
        
        .hero-meta-item i {
            color: var(--accent-gold);
        }
        
        .profile-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: var(--spacing-2xl) var(--spacing-xl);
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: var(--spacing-xl);
        }
        
        .content-card {
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-xl);
            box-shadow: var(--shadow-sm);
            margin-bottom: var(--spacing-xl);
        }
        
        .content-card h2 {
            color: var(--primary-forest);
            margin-bottom: var(--spacing-lg);
            padding-bottom: var(--spacing-md);
            border-bottom: 2px solid var(--neutral-stone);
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: var(--spacing-lg);
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
            gap: var(--spacing-xs);
        }
        
        .info-item label {
            font-size: 0.85rem;
            color: var(--text-muted);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .info-item span {
            font-size: 1rem;
            color: var(--text-dark);
        }
        
        .sidebar-card {
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-lg);
            box-shadow: var(--shadow-sm);
            margin-bottom: var(--spacing-lg);
        }
        
        .sidebar-card h3 {
            color: var(--primary-forest);
            margin-bottom: var(--spacing-md);
            font-size: 1.1rem;
        }
        
        .contact-item {
            display: flex;
            align-items: flex-start;
            gap: var(--spacing-md);
            padding: var(--spacing-md) 0;
            border-bottom: 1px solid var(--neutral-stone);
        }
        
        .contact-item:last-child {
            border-bottom: none;
        }
        
        .contact-item i {
            color: var(--primary-sage);
            font-size: 1.2rem;
            margin-top: 2px;
        }
        
        .contact-item .info {
            flex: 1;
        }
        
        .contact-item label {
            display: block;
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-bottom: var(--spacing-xs);
        }
        
        .contact-item span, .contact-item a {
            display: block;
            color: var(--text-dark);
            font-weight: 500;
        }
        
        .btn-gold {
            width: 100%;
            margin-top: var(--spacing-md);
        }
        
        @media (max-width: 1024px) {
            .hero-container {
                grid-template-columns: 1fr;
                text-align: center;
            }
            
            .profile-content {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/" class="nav-logo">
                <i class="fas fa-leaf"></i>
                <span>AyurVeda<span class="highlight">Care</span></span>
            </a>
            
            <div class="nav-menu" id="navMenu">
                <a href="${pageContext.request.contextPath}/" class="nav-link">Home</a>
                <a href="${pageContext.request.contextPath}/hospitals" class="nav-link">Find Centers</a>
                <a href="${pageContext.request.contextPath}/doctors" class="nav-link active">Find Doctors</a>
                <a href="${pageContext.request.contextPath}/about" class="nav-link">About</a>
                <a href="${pageContext.request.contextPath}/services" class="nav-link">Services</a>
                <a href="${pageContext.request.contextPath}/contact" class="nav-link">Contact</a>
                <c:choose>
                    <c:when test="${not empty currentUser}">
                        <div class="user-menu-container">
                            <a href="#" class="nav-link user-name-link" id="userMenuToggle">
                                <i class="fas fa-user-circle"></i>
                                <span>${currentUser.fullName}</span>
                                <i class="fas fa-chevron-down"></i>
                            </a>
                            <div class="user-dropdown" id="userDropdown">
                                <a href="${pageContext.request.contextPath}/user/dashboard">
                                    <i class="fas fa-th-large"></i> Dashboard
                                </a>
                                <a href="${pageContext.request.contextPath}/user/profile">
                                    <i class="fas fa-user"></i> Your Profile
                                </a>
                                <a href="${pageContext.request.contextPath}/user/enquiries">
                                    <i class="fas fa-envelope"></i> My Enquiries
                                </a>
                                <a href="${pageContext.request.contextPath}/user/saved-centers">
                                    <i class="fas fa-heart"></i> Saved Centers
                                </a>
                                <div class="dropdown-divider"></div>
                                <a href="${pageContext.request.contextPath}/user/logout">
                                    <i class="fas fa-sign-out-alt"></i> Sign Out
                                </a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/user/login" class="nav-link">Login</a>
                        <a href="${pageContext.request.contextPath}/user/register" class="nav-link nav-cta">Sign Up</a>
                        <a href="${pageContext.request.contextPath}/hospital/register" class="nav-link nav-cta">For Centers</a>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <button class="nav-toggle" id="navToggle">
                <i class="fas fa-bars"></i>
            </button>
        </div>
    </nav>

    <div class="doctor-profile-page">
        <!-- Hero Section -->
        <div class="profile-hero">
            <div class="hero-container">
                <div class="doctor-photo-large">
                    <c:choose>
                        <c:when test="${not empty doctor.photoUrl}">
                            <img src="${pageContext.request.contextPath}${doctor.photoUrl}" alt="${doctor.name}">
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-user-md"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="hero-info">
                    <h1>Dr. ${doctor.name}</h1>
                    <div class="hero-qualifications">${doctor.qualifications}</div>
                    <c:if test="${not empty doctor.specializations}">
                        <div class="hero-specializations">${doctor.specializations}</div>
                    </c:if>
                    
                    <div class="hero-meta">
                        <c:if test="${doctor.experienceYears != null}">
                            <div class="hero-meta-item">
                                <i class="fas fa-calendar-alt"></i>
                                <span>${doctor.experienceYears}+ Years Experience</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty doctor.availableLocations}">
                            <div class="hero-meta-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>${doctor.availableLocations}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty doctor.hospital}">
                            <div class="hero-meta-item">
                                <i class="fas fa-hospital"></i>
                                <span>${doctor.hospital.centerName}</span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Profile Content -->
        <div class="profile-content">
            <div class="profile-main">
                <!-- About Section -->
                <div class="content-card">
                    <h2><i class="fas fa-user-md"></i> About</h2>
                    <c:choose>
                        <c:when test="${not empty doctor.biography}">
                            <p style="line-height: 1.8; color: var(--text-medium);">${doctor.biography}</p>
                        </c:when>
                        <c:otherwise>
                            <p style="color: var(--text-muted);">Biography information coming soon.</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Qualifications & Education -->
                <div class="content-card">
                    <h2><i class="fas fa-graduation-cap"></i> Qualifications & Education</h2>
                    <div class="info-grid">
                        <div class="info-item">
                            <label>Qualifications</label>
                            <span>${doctor.qualifications != null ? doctor.qualifications : 'Not specified'}</span>
                        </div>
                        <c:if test="${not empty doctor.degreeUniversity}">
                            <div class="info-item">
                                <label>University</label>
                                <span>${doctor.degreeUniversity}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty doctor.registrationNumber}">
                            <div class="info-item">
                                <label>Registration Number</label>
                                <span>${doctor.registrationNumber}</span>
                            </div>
                        </c:if>
                        <c:if test="${doctor.experienceYears != null}">
                            <div class="info-item">
                                <label>Experience</label>
                                <span>${doctor.experienceYears} Years</span>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Specializations -->
                <c:if test="${not empty doctor.specializations}">
                    <div class="content-card">
                        <h2><i class="fas fa-stethoscope"></i> Specializations</h2>
                        <p style="line-height: 1.8; color: var(--text-medium);">${doctor.specializations}</p>
                    </div>
                </c:if>

                <!-- Consultation Details -->
                <div class="content-card">
                    <h2><i class="fas fa-calendar-check"></i> Consultation Details</h2>
                    <div class="info-grid">
                        <c:if test="${not empty doctor.consultationDays}">
                            <div class="info-item">
                                <label>Available Days</label>
                                <span>${doctor.consultationDays}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty doctor.consultationTimings}">
                            <div class="info-item">
                                <label>Consultation Timings</label>
                                <span>${doctor.consultationTimings}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty doctor.availableLocations}">
                            <div class="info-item">
                                <label>Available Locations</label>
                                <span>${doctor.availableLocations}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty doctor.languagesSpoken}">
                            <div class="info-item">
                                <label>Languages Spoken</label>
                                <span>${doctor.languagesSpoken}</span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Sidebar -->
            <aside class="profile-sidebar">
                <!-- Contact Information -->
                <div class="sidebar-card">
                    <h3>Contact Information</h3>
                    
                    <c:if test="${not empty doctor.phone}">
                        <div class="contact-item">
                            <i class="fas fa-phone"></i>
                            <div class="info">
                                <label>Phone</label>
                                <span>${doctor.phone}</span>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty doctor.email}">
                        <div class="contact-item">
                            <i class="fas fa-envelope"></i>
                            <div class="info">
                                <label>Email</label>
                                <span>${doctor.email}</span>
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Hospital Information -->
                <c:if test="${not empty doctor.hospital}">
                    <div class="sidebar-card">
                        <h3>Associated Hospital</h3>
                        <div style="margin-bottom: var(--spacing-md);">
                            <h4 style="margin: 0 0 var(--spacing-xs); color: var(--primary-forest);">${doctor.hospital.centerName}</h4>
                            <c:if test="${not empty doctor.hospital.city}">
                                <p style="margin: 0; color: var(--text-medium); font-size: 0.9rem;">
                                    <i class="fas fa-map-marker-alt"></i> ${doctor.hospital.city}, ${doctor.hospital.state}
                                </p>
                            </c:if>
                        </div>
                        <a href="${pageContext.request.contextPath}/hospital/profile/${doctor.hospital.id}" class="btn btn-gold">
                            <i class="fas fa-hospital"></i> View Hospital Profile
                        </a>
                    </div>
                </c:if>

                <!-- Book Consultation -->
                <div class="sidebar-card">
                    <a href="${pageContext.request.contextPath}/consultation/book/${doctor.id}" class="btn btn-gold">
                        <i class="fas fa-calendar-check"></i> Book Consultation
                    </a>
                </div>
            </aside>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-container">
            <div class="footer-bottom">
                <p>&copy; 2024 AyurVedaCare. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>

