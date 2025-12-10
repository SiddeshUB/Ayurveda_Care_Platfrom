<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${hospital.centerName} - AyurVedaCare</title>
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
        
        /* Hero Section */
        .profile-hero {
            position: relative;
            height: 450px;
            background: linear-gradient(135deg, rgba(45, 90, 61, 0.85), rgba(107, 142, 107, 0.9)),
                        url('${not empty hospital.coverPhotoUrl ? "/uploads/".concat(hospital.coverPhotoUrl) : "https://images.unsplash.com/photo-1545205597-3d9d02c29597?w=1920"}') center/cover;
            display: flex;
            align-items: flex-end;
            padding-top: 70px;
        }
        
        .hero-content {
            width: 100%;
            padding: var(--spacing-3xl) 0 var(--spacing-xl);
            background: linear-gradient(to top, rgba(0,0,0,0.6), transparent);
        }
        
        .hero-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 var(--spacing-xl);
            color: white;
        }
        
        .hero-badges {
            display: flex;
            gap: var(--spacing-sm);
            margin-bottom: var(--spacing-md);
        }
        
        .hero-badges .badge {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .hero-title {
            display: flex;
            align-items: center;
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-md);
        }
        
        .hero-title h1 {
            color: white;
            font-size: 2.5rem;
            margin: 0;
        }
        
        .verified-badge {
            background: var(--accent-gold);
            color: white;
            padding: var(--spacing-xs) var(--spacing-md);
            border-radius: var(--radius-xl);
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
        }
        
        .hero-meta {
            display: flex;
            align-items: center;
            gap: var(--spacing-xl);
            font-size: 1rem;
            opacity: 0.95;
        }
        
        .hero-meta i {
            margin-right: var(--spacing-xs);
            color: var(--accent-gold);
        }
        
        .hero-rating {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .hero-rating i {
            color: var(--accent-gold);
        }
        
        /* Profile Layout */
        .profile-layout {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 var(--spacing-xl);
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: var(--spacing-xl);
            margin-top: calc(-1 * var(--spacing-xl));
            position: relative;
            z-index: 10;
        }
        
        /* Tab Navigation */
        .profile-tabs {
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-md);
            box-shadow: var(--shadow-lg);
            display: flex;
            gap: var(--spacing-sm);
            margin-bottom: var(--spacing-xl);
            overflow-x: auto;
        }
        
        .profile-tabs a {
            padding: var(--spacing-md) var(--spacing-lg);
            border-radius: var(--radius-md);
            font-weight: 600;
            color: var(--text-medium);
            white-space: nowrap;
            transition: all var(--transition-fast);
        }
        
        .profile-tabs a:hover {
            background: var(--neutral-sand);
            color: var(--primary-forest);
        }
        
        .profile-tabs a.active {
            background: var(--primary-forest);
            color: white;
        }
        
        /* Content Card */
        .content-card {
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-xl);
            box-shadow: var(--shadow-sm);
            margin-bottom: var(--spacing-xl);
        }
        
        .content-card h2 {
            font-size: 1.5rem;
            margin-bottom: var(--spacing-lg);
            padding-bottom: var(--spacing-md);
            border-bottom: 2px solid var(--neutral-sand);
        }
        
        /* Sidebar */
        .profile-sidebar {
            position: sticky;
            top: 90px;
            height: fit-content;
        }
        
        .sidebar-card {
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-xl);
            box-shadow: var(--shadow-md);
            margin-bottom: var(--spacing-lg);
        }
        
        .sidebar-card h3 {
            font-size: 1.1rem;
            margin-bottom: var(--spacing-lg);
        }
        
        .contact-item {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            padding: var(--spacing-md) 0;
            border-bottom: 1px solid var(--neutral-stone);
        }
        
        .contact-item:last-child {
            border-bottom: none;
        }
        
        .contact-item i {
            width: 40px;
            height: 40px;
            background: var(--neutral-sand);
            border-radius: var(--radius-full);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-forest);
        }
        
        .contact-item .info {
            flex: 1;
        }
        
        .contact-item .info label {
            font-size: 0.8rem;
            color: var(--text-muted);
            display: block;
        }
        
        .contact-item .info span {
            font-weight: 500;
        }
        
        .book-now-btn {
            width: 100%;
            padding: var(--spacing-lg);
            font-size: 1.1rem;
            margin-top: var(--spacing-lg);
        }
        
        /* Quick Packages */
        .quick-package {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: var(--spacing-md);
            background: var(--neutral-sand);
            border-radius: var(--radius-md);
            margin-bottom: var(--spacing-sm);
        }
        
        .quick-package h4 {
            font-size: 0.95rem;
            margin: 0;
        }
        
        .quick-package .price {
            color: var(--primary-forest);
            font-weight: 700;
        }
        
        /* Certification Badges */
        .cert-badges {
            display: flex;
            flex-wrap: wrap;
            gap: var(--spacing-sm);
        }
        
        .cert-badge {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
            padding: var(--spacing-sm) var(--spacing-md);
            background: var(--neutral-sand);
            border-radius: var(--radius-md);
            font-size: 0.85rem;
            font-weight: 500;
        }
        
        .cert-badge i {
            color: var(--accent-gold);
        }
        
        /* Gallery Grid */
        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: var(--spacing-md);
        }
        
        .gallery-item {
            aspect-ratio: 1;
            border-radius: var(--radius-md);
            overflow: hidden;
            cursor: pointer;
        }
        
        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform var(--transition-base);
        }
        
        .gallery-item:hover img {
            transform: scale(1.1);
        }
        
        /* Highlights */
        .highlights-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-xl);
        }
        
        .highlight-item {
            text-align: center;
            padding: var(--spacing-lg);
            background: var(--neutral-sand);
            border-radius: var(--radius-md);
        }
        
        .highlight-item i {
            font-size: 2rem;
            color: var(--primary-forest);
            margin-bottom: var(--spacing-sm);
        }
        
        .highlight-item h4 {
            font-size: 0.95rem;
            margin: 0;
        }
        
        /* Tags */
        .tags-list {
            display: flex;
            flex-wrap: wrap;
            gap: var(--spacing-sm);
        }
        
        /* Package Cards */
        .package-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: var(--spacing-lg);
        }
        
        .package-card {
            background: var(--neutral-sand);
            border-radius: var(--radius-lg);
            padding: var(--spacing-lg);
            transition: all var(--transition-base);
        }
        
        .package-card:hover {
            box-shadow: var(--shadow-md);
            transform: translateY(-3px);
        }
        
        .package-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: var(--spacing-md);
        }
        
        .package-header h3 {
            margin: 0;
            font-size: 1.2rem;
        }
        
        .package-duration {
            background: var(--primary-forest);
            color: white;
            padding: var(--spacing-xs) var(--spacing-sm);
            border-radius: var(--radius-sm);
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .package-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-forest);
            margin: var(--spacing-md) 0;
        }
        
        .package-price span {
            font-size: 0.9rem;
            font-weight: 400;
            color: var(--text-muted);
        }
        
        /* Doctor Cards */
        .doctor-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: var(--spacing-lg);
        }
        
        .doctor-card {
            text-align: center;
            padding: var(--spacing-xl);
            background: var(--neutral-sand);
            border-radius: var(--radius-lg);
        }
        
        .doctor-photo {
            width: 120px;
            height: 120px;
            border-radius: var(--radius-full);
            margin: 0 auto var(--spacing-md);
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
            font-size: 3rem;
            color: white;
        }
        
        .doctor-card h4 {
            margin: 0 0 var(--spacing-xs);
        }
        
        .doctor-card .qualifications {
            color: var(--primary-forest);
            font-weight: 500;
            font-size: 0.9rem;
        }
        
        .doctor-card .specialization {
            color: var(--text-muted);
            font-size: 0.85rem;
            margin-top: var(--spacing-sm);
        }
        
        /* Reviews */
        .review-summary {
            display: flex;
            gap: var(--spacing-2xl);
            margin-bottom: var(--spacing-xl);
            padding: var(--spacing-xl);
            background: var(--neutral-sand);
            border-radius: var(--radius-lg);
        }
        
        .rating-big {
            text-align: center;
        }
        
        .rating-big .number {
            font-size: 4rem;
            font-weight: 700;
            color: var(--primary-forest);
            line-height: 1;
        }
        
        .rating-big .stars {
            margin: var(--spacing-sm) 0;
        }
        
        .rating-big .stars i {
            color: var(--accent-gold);
            font-size: 1.25rem;
        }
        
        .rating-big .count {
            color: var(--text-muted);
        }
        
        .rating-bars {
            flex: 1;
        }
        
        .rating-bar {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-sm);
        }
        
        .rating-bar .label {
            width: 20px;
            text-align: right;
        }
        
        .rating-bar .bar {
            flex: 1;
            height: 8px;
            background: var(--neutral-stone);
            border-radius: var(--radius-full);
            overflow: hidden;
        }
        
        .rating-bar .fill {
            height: 100%;
            background: var(--accent-gold);
            border-radius: var(--radius-full);
        }
        
        .review-card {
            padding: var(--spacing-lg);
            border-bottom: 1px solid var(--neutral-stone);
        }
        
        .review-card:last-child {
            border-bottom: none;
        }
        
        .review-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: var(--spacing-md);
        }
        
        .reviewer-info {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
        }
        
        .reviewer-avatar {
            width: 50px;
            height: 50px;
            background: var(--primary-sage);
            border-radius: var(--radius-full);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }
        
        .reviewer-name {
            font-weight: 600;
        }
        
        .reviewer-meta {
            font-size: 0.85rem;
            color: var(--text-muted);
        }
        
        .review-rating i {
            color: var(--accent-gold);
        }
        
        .review-text {
            color: var(--text-medium);
            line-height: 1.7;
        }
        
        @media (max-width: 1200px) {
            .package-grid { grid-template-columns: 1fr; }
            .doctor-grid { grid-template-columns: repeat(2, 1fr); }
            .highlights-grid { grid-template-columns: repeat(2, 1fr); }
        }
        
        @media (max-width: 992px) {
            .profile-layout {
                grid-template-columns: 1fr;
            }
            
            .profile-sidebar {
                position: static;
            }
            
            .gallery-grid { grid-template-columns: repeat(3, 1fr); }
        }
        
        @media (max-width: 768px) {
            .profile-hero { height: 350px; }
            .hero-title h1 { font-size: 1.75rem; }
            .hero-meta { flex-wrap: wrap; gap: var(--spacing-md); }
            .gallery-grid { grid-template-columns: repeat(2, 1fr); }
            .doctor-grid { grid-template-columns: 1fr; }
            .highlights-grid { grid-template-columns: 1fr; }
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
                <a href="${pageContext.request.contextPath}/doctors" class="nav-link">Find Doctors</a>
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

    <!-- Hero Section -->
    <section class="profile-hero">
        <div class="hero-content">
            <div class="hero-container">
                <div class="hero-badges">
                    <c:if test="${hospital.ayushCertified}">
                        <span class="badge badge-gold">AYUSH Certified</span>
                    </c:if>
                    <c:if test="${hospital.nabhCertified}">
                        <span class="badge badge-primary">NABH Accredited</span>
                    </c:if>
                    <span class="badge">${hospital.centerType}</span>
                </div>
                
                <div class="hero-title">
                    <h1>${hospital.centerName}</h1>
                    <c:if test="${hospital.isVerified}">
                        <span class="verified-badge">
                            <i class="fas fa-check-circle"></i> Verified
                        </span>
                    </c:if>
                </div>
                
                <div class="hero-meta">
                    <span>
                        <i class="fas fa-map-marker-alt"></i>
                        ${hospital.city}, ${hospital.state}
                    </span>
                    <div class="hero-rating">
                        <c:forEach begin="1" end="5" var="star">
                            <i class="fas fa-star ${star <= hospital.averageRating ? '' : 'empty'}" style="${star > hospital.averageRating ? 'opacity: 0.4' : ''}"></i>
                        </c:forEach>
                        <span>${hospital.averageRating != null ? String.format("%.1f", hospital.averageRating) : '0.0'}</span>
                        <span>(${hospital.totalReviews} reviews)</span>
                    </div>
                    <c:if test="${hospital.bedsCapacity != null}">
                        <span><i class="fas fa-bed"></i> ${hospital.bedsCapacity} Beds</span>
                    </c:if>
                </div>
            </div>
        </div>
    </section>

    <!-- Profile Content -->
    <div class="profile-layout py-4">
        <div class="profile-main">
            <!-- Tab Navigation -->
            <div class="profile-tabs">
                <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}?tab=overview" class="${activeTab == 'overview' ? 'active' : ''}">Overview</a>
                <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}?tab=packages" class="${activeTab == 'packages' ? 'active' : ''}">Packages</a>
                <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}?tab=rooms" class="${activeTab == 'rooms' ? 'active' : ''}">Rooms</a>
                <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}?tab=products" class="${activeTab == 'products' ? 'active' : ''}">Products</a>
                <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}?tab=doctors" class="${activeTab == 'doctors' ? 'active' : ''}">Doctors</a>
                <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}?tab=gallery" class="${activeTab == 'gallery' ? 'active' : ''}">Gallery</a>
                <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}?tab=reviews" class="${activeTab == 'reviews' ? 'active' : ''}">Reviews</a>
                <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}?tab=location" class="${activeTab == 'location' ? 'active' : ''}">Location</a>
            </div>

            <!-- Overview Tab -->
            <c:if test="${activeTab == 'overview'}">
                <!-- Highlights -->
                <div class="highlights-grid">
                    <c:if test="${hospital.ayushCertified}">
                        <div class="highlight-item">
                            <i class="fas fa-certificate"></i>
                            <h4>AYUSH Certified</h4>
                        </div>
                    </c:if>
                    <c:if test="${hospital.bedsCapacity != null}">
                        <div class="highlight-item">
                            <i class="fas fa-bed"></i>
                            <h4>${hospital.bedsCapacity}+ Beds</h4>
                        </div>
                    </c:if>
                    <c:if test="${hospital.doctorsCount != null}">
                        <div class="highlight-item">
                            <i class="fas fa-user-md"></i>
                            <h4>${hospital.doctorsCount} Doctors</h4>
                        </div>
                    </c:if>
                    <c:if test="${hospital.yearEstablished != null}">
                        <div class="highlight-item">
                            <i class="fas fa-history"></i>
                            <h4>Est. ${hospital.yearEstablished}</h4>
                        </div>
                    </c:if>
                </div>

                <!-- About -->
                <div class="content-card">
                    <h2>About ${hospital.centerName}</h2>
                    <p style="line-height: 1.8; color: var(--text-medium);">
                        ${not empty hospital.description ? hospital.description : 'Welcome to our Ayurvedic healing center. We offer authentic traditional treatments in a serene environment.'}
                    </p>
                </div>

                <!-- Therapies -->
                <c:if test="${not empty hospital.therapiesOffered}">
                    <div class="content-card">
                        <h2>Therapies Offered</h2>
                        <div class="tags-list">
                            <c:forTokens items="${hospital.therapiesOffered}" delims="," var="therapy">
                                <span class="tag"><i class="fas fa-spa"></i> ${fn:trim(therapy)}</span>
                            </c:forTokens>
                        </div>
                    </div>
                </c:if>

                <!-- Facilities -->
                <c:if test="${not empty hospital.facilitiesAvailable}">
                    <div class="content-card">
                        <h2>Facilities</h2>
                        <div class="tags-list">
                            <c:forTokens items="${hospital.facilitiesAvailable}" delims="," var="facility">
                                <span class="tag"><i class="fas fa-check"></i> ${fn:trim(facility)}</span>
                            </c:forTokens>
                        </div>
                    </div>
                </c:if>

                <!-- Gallery Preview -->
                <c:if test="${not empty photos}">
                    <div class="content-card">
                        <h2>Photo Gallery</h2>
                        <div class="gallery-grid">
                            <c:forEach var="photo" items="${photos}" end="7">
                                <div class="gallery-item">
                                    <img src="${pageContext.request.contextPath}${photo.photoUrl}" alt="${photo.title}">
                                </div>
                            </c:forEach>
                        </div>
                        <c:if test="${fn:length(photos) > 8}">
                            <div class="text-center mt-2">
                                <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}?tab=gallery" class="btn btn-outline">
                                    View All Photos
                                </a>
                            </div>
                        </c:if>
                    </div>
                </c:if>
            </c:if>

            <!-- Packages Tab -->
            <c:if test="${activeTab == 'packages'}">
                <div class="content-card">
                    <h2>Treatment Packages</h2>
                    <c:choose>
                        <c:when test="${not empty packages}">
                            <div class="package-grid">
                                <c:forEach var="pkg" items="${packages}">
                                    <div class="package-card">
                                        <div class="package-header">
                                            <h3>${pkg.packageName}</h3>
                                            <span class="package-duration">${pkg.durationDays} Days</span>
                                        </div>
                                        <p style="color: var(--text-medium); font-size: 0.95rem;">
                                            ${not empty pkg.shortDescription ? pkg.shortDescription : pkg.description}
                                        </p>
                                        <div class="package-price">
                                            ₹<fmt:formatNumber value="${pkg.budgetRoomPrice != null ? pkg.budgetRoomPrice : 0}" maxFractionDigits="0"/>
                                            <span>onwards</span>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/booking/enquiry/${hospital.id}?packageId=${pkg.id}" class="btn btn-primary btn-sm">
                                            Book Now
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">No packages available at the moment.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <!-- Doctors Tab -->
            <c:if test="${activeTab == 'doctors'}">
                <div class="content-card">
                    <h2>Our Doctors</h2>
                    <c:choose>
                        <c:when test="${not empty doctors}">
                            <div class="doctor-grid">
                                <c:forEach var="doctor" items="${doctors}">
                                    <a href="${pageContext.request.contextPath}/doctor/profile/${doctor.id}" class="doctor-card" style="text-decoration: none; color: inherit;">
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
                                        <h4>${doctor.name}</h4>
                                        <div class="qualifications">${doctor.qualifications}</div>
                                        <div class="specialization">${doctor.specializations}</div>
                                        <c:if test="${doctor.experienceYears != null}">
                                            <p style="margin-top: var(--spacing-sm); font-size: 0.85rem; color: var(--text-muted);">
                                                ${doctor.experienceYears}+ Years Experience
                                            </p>
                                        </c:if>
                                        <div style="margin-top: var(--spacing-md); padding-top: var(--spacing-md); border-top: 1px solid var(--neutral-stone);">
                                            <span style="font-size: 0.9rem; color: var(--primary-forest); font-weight: 600;">
                                                View Profile →
                                            </span>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">Doctor information coming soon.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <!-- Rooms Tab -->
            <c:if test="${activeTab == 'rooms'}">
                <div class="content-card">
                    <h2>Accommodation Rooms</h2>
                    <c:choose>
                        <c:when test="${not empty rooms}">
                            <div class="room-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: var(--spacing-xl); margin-top: var(--spacing-lg);">
                                <c:forEach var="room" items="${rooms}">
                                    <div class="room-card" style="background: white; border-radius: var(--radius-lg); overflow: hidden; box-shadow: var(--shadow-sm); transition: transform var(--transition-fast);">
                                        <div class="room-image" style="position: relative; height: 220px; overflow: hidden;">
                                            <c:choose>
                                                <c:when test="${not empty room.imageUrls}">
                                                    <c:set var="imageArray" value="${fn:split(room.imageUrls, ',')}" />
                                                    <img src="${pageContext.request.contextPath}${imageArray[0]}" alt="${room.roomName}" style="width: 100%; height: 100%; object-fit: cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; background: var(--neutral-sand);">
                                                        <i class="fas fa-bed" style="font-size: 3rem; color: var(--text-muted);"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div style="position: absolute; top: var(--spacing-sm); right: var(--spacing-sm);">
                                                <span class="badge" style="background: rgba(255,255,255,0.9); color: var(--primary-forest); padding: var(--spacing-xs) var(--spacing-sm); border-radius: var(--radius-md); font-weight: 600;">
                                                    ${room.roomType}
                                                </span>
                                            </div>
                                        </div>
                                        <div class="room-body" style="padding: var(--spacing-lg);">
                                            <h3 style="margin: 0 0 var(--spacing-sm) 0; color: var(--primary-forest); font-size: 1.25rem;">${room.roomName}</h3>
                                            <p style="color: var(--text-medium); font-size: 0.9rem; margin-bottom: var(--spacing-md); line-height: 1.6;">
                                                ${fn:substring(room.description != null ? room.description : 'Comfortable accommodation with modern amenities.', 0, 100)}${fn:length(room.description != null ? room.description : '') > 100 ? '...' : ''}
                                            </p>
                                            <div style="display: flex; flex-wrap: wrap; gap: var(--spacing-sm); margin-bottom: var(--spacing-md);">
                                                <c:if test="${room.maxOccupancy != null}">
                                                    <span style="display: flex; align-items: center; gap: var(--spacing-xs); color: var(--text-medium); font-size: 0.85rem;">
                                                        <i class="fas fa-users"></i> ${room.maxOccupancy} Guests
                                                    </span>
                                                </c:if>
                                                <c:if test="${room.roomSize != null}">
                                                    <span style="display: flex; align-items: center; gap: var(--spacing-xs); color: var(--text-medium); font-size: 0.85rem;">
                                                        <i class="fas fa-ruler-combined"></i> ${room.roomSize} sq ft
                                                    </span>
                                                </c:if>
                                                <c:if test="${room.bedType != null}">
                                                    <span style="display: flex; align-items: center; gap: var(--spacing-xs); color: var(--text-medium); font-size: 0.85rem;">
                                                        <i class="fas fa-bed"></i> ${room.bedType}
                                                    </span>
                                                </c:if>
                                            </div>
                                            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: var(--spacing-md); padding-top: var(--spacing-md); border-top: 1px solid var(--neutral-sand);">
                                                <div>
                                                    <span style="font-size: 1.5rem; font-weight: 700; color: var(--primary-forest);">
                                                        ₹<fmt:formatNumber value="${room.pricePerNight != null ? room.pricePerNight : 0}" maxFractionDigits="0"/>
                                                    </span>
                                                    <span style="color: var(--text-muted); font-size: 0.9rem;">/night</span>
                                                </div>
                                                <a href="${pageContext.request.contextPath}/room/booking/${room.id}" class="btn" style="padding: var(--spacing-sm) var(--spacing-lg);">
                                                    Book Now
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">No rooms available at this time.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <!-- Gallery Tab -->
            <c:if test="${activeTab == 'gallery'}">
                <div class="content-card">
                    <h2>Photo Gallery</h2>
                    <c:choose>
                        <c:when test="${not empty photos}">
                            <div class="gallery-grid">
                                <c:forEach var="photo" items="${photos}">
                                    <div class="gallery-item">
                                        <img src="${pageContext.request.contextPath}${photo.photoUrl}" alt="${photo.title}">
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">No photos available.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <!-- Reviews Tab -->
            <c:if test="${activeTab == 'reviews'}">
                <div class="content-card">
                    <h2>Patient Reviews</h2>
                    
                    <c:if test="${not empty ratingBreakdown}">
                        <div class="review-summary">
                            <div class="rating-big">
                                <div class="number">${String.format("%.1f", ratingBreakdown.averageRating)}</div>
                                <div class="stars">
                                    <c:forEach begin="1" end="5" var="star">
                                        <i class="fas fa-star"></i>
                                    </c:forEach>
                                </div>
                                <div class="count">${ratingBreakdown.totalReviews} reviews</div>
                            </div>
                            <div class="rating-bars">
                                <c:forEach begin="1" end="5" var="i">
                                    <c:set var="ratingKey" value="rating${6-i}Percent"/>
                                    <div class="rating-bar">
                                        <span class="label">${6-i}</span>
                                        <i class="fas fa-star" style="color: var(--accent-gold); font-size: 0.8rem;"></i>
                                        <div class="bar">
                                            <div class="fill" style="width: ${ratingBreakdown[ratingKey]}%"></div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:choose>
                        <c:when test="${not empty reviews}">
                            <c:forEach var="review" items="${reviews}">
                                <div class="review-card">
                                    <div class="review-header">
                                        <div class="reviewer-info">
                                            <div class="reviewer-avatar">
                                                ${fn:substring(review.patientName, 0, 1)}
                                            </div>
                                            <div>
                                                <div class="reviewer-name">${review.patientName}</div>
                                                <div class="reviewer-meta">
                                                    ${review.patientCountry} • <fmt:formatDate value="${review.createdAt}" pattern="MMM yyyy"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="review-rating">
                                            <c:forEach begin="1" end="${review.rating}">
                                                <i class="fas fa-star"></i>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <p class="review-text">${review.reviewText}</p>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">No reviews yet. Be the first to review!</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <!-- Location Tab -->
            <c:if test="${activeTab == 'location'}">
                <div class="content-card">
                    <h2>Location & Contact</h2>
                    
                    <div style="margin-bottom: var(--spacing-xl);">
                        <h4 style="margin-bottom: var(--spacing-md);">Address</h4>
                        <p style="color: var(--text-medium);">
                            ${hospital.streetAddress}<br>
                            ${hospital.city}, ${hospital.state} ${hospital.pinCode}<br>
                            ${hospital.country}
                        </p>
                    </div>
                    
                    <c:if test="${not empty hospital.googleMapsUrl}">
                        <div style="margin-bottom: var(--spacing-xl);">
                            <iframe 
                                src="${hospital.googleMapsUrl}"
                                width="100%" 
                                height="400" 
                                style="border:0; border-radius: var(--radius-md);" 
                                allowfullscreen="" 
                                loading="lazy">
                            </iframe>
                        </div>
                    </c:if>
                </div>
            </c:if>
        </div>

        <!-- Sidebar -->
        <aside class="profile-sidebar">
            <!-- Quick Contact -->
            <div class="sidebar-card">
                <h3>Quick Contact</h3>
                
                <c:if test="${not empty hospital.bookingPhone}">
                    <div class="contact-item">
                        <i class="fas fa-phone"></i>
                        <div class="info">
                            <label>Booking</label>
                            <span>${hospital.bookingPhone}</span>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${not empty hospital.publicEmail}">
                    <div class="contact-item">
                        <i class="fas fa-envelope"></i>
                        <div class="info">
                            <label>Email</label>
                            <span>${hospital.publicEmail}</span>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${not empty hospital.website}">
                    <div class="contact-item">
                        <i class="fas fa-globe"></i>
                        <div class="info">
                            <label>Website</label>
                            <a href="${hospital.website}" target="_blank">${hospital.website}</a>
                        </div>
                    </div>
                </c:if>
                
                <a href="${pageContext.request.contextPath}/booking/enquiry/${hospital.id}" class="btn btn-gold book-now-btn">
                    <i class="fas fa-calendar-check"></i> Book Now
                </a>
            </div>

            <!-- Popular Packages -->
            <c:if test="${not empty popularPackages}">
                <div class="sidebar-card">
                    <h3>Popular Packages</h3>
                    <c:forEach var="pkg" items="${popularPackages}">
                        <div class="quick-package">
                            <div>
                                <h4>${pkg.packageName}</h4>
                                <span style="font-size: 0.85rem; color: var(--text-muted);">${pkg.durationDays} Days</span>
                            </div>
                            <span class="price">₹<fmt:formatNumber value="${pkg.budgetRoomPrice}" maxFractionDigits="0"/></span>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <!-- Certifications -->
            <div class="sidebar-card">
                <h3>Certifications</h3>
                <div class="cert-badges">
                    <c:if test="${hospital.ayushCertified}">
                        <span class="cert-badge"><i class="fas fa-check-circle"></i> AYUSH</span>
                    </c:if>
                    <c:if test="${hospital.nabhCertified}">
                        <span class="cert-badge"><i class="fas fa-check-circle"></i> NABH</span>
                    </c:if>
                    <c:if test="${hospital.isoCertified}">
                        <span class="cert-badge"><i class="fas fa-check-circle"></i> ISO</span>
                    </c:if>
                    <c:if test="${hospital.stateGovtApproved}">
                        <span class="cert-badge"><i class="fas fa-check-circle"></i> Govt. Approved</span>
                    </c:if>
                </div>
            </div>
        </aside>
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

