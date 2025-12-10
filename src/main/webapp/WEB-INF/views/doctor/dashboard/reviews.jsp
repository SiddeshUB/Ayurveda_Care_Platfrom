<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reviews & Ratings - Doctor Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        :root {
            --ayur-dark-green: #0a3d2c;
            --ayur-medium-green: #1a5c40;
            --ayur-light-green: #2e7d5a;
            --ayur-accent-gold: #d4af37;
            --ayur-teal: #2a9d8f;
            --primary-forest: #0a3d2c;
            --primary-sage: #1a5c40;
            --sidebar-width: 280px;
            --header-height: 80px;
            --border-radius: 16px;
            --card-shadow: 0 10px 40px rgba(10, 61, 44, 0.1);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Nunito Sans', sans-serif;
            background: linear-gradient(135deg, #f0f7f4 0%, #e8f1ed 100%);
            color: #2c3e50;
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        .dashboard-body { display: flex; min-height: 100vh; }
        
        .sidebar {
            width: var(--sidebar-width);
            background: linear-gradient(180deg, var(--ayur-dark-green) 0%, var(--ayur-medium-green) 100%);
            color: white;
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100vh;
            z-index: 1000;
            transition: var(--transition);
            box-shadow: 5px 0 25px rgba(10, 61, 44, 0.2);
            border-right: 3px solid var(--ayur-accent-gold);
        }
        
        .sidebar-header {
            padding: 30px 25px;
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            text-align: center;
            background: rgba(10, 61, 44, 0.9);
            position: relative;
            overflow: hidden;
        }
        
        .sidebar-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, transparent, var(--ayur-accent-gold), transparent);
        }
        
        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 15px;
            color: white;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: 700;
            justify-content: center;
            z-index: 1;
            position: relative;
        }
        
        .sidebar-logo i {
            font-size: 2.2rem;
            color: var(--ayur-accent-gold);
            text-shadow: 0 2px 10px rgba(212, 175, 55, 0.3);
        }
        
        .sidebar-logo .highlight {
            color: var(--ayur-accent-gold);
            font-weight: 800;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
        
        .sidebar-nav {
            flex: 1;
            padding: 25px 0;
            overflow-y: auto;
        }
        
        .nav-item {
            display: flex;
            align-items: center;
            gap: 18px;
            padding: 18px 30px;
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            transition: var(--transition);
            border-left: 4px solid transparent;
            margin: 8px 15px;
            position: relative;
            overflow: hidden;
            border-radius: 12px;
        }
        
        .nav-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(212, 175, 55, 0.1), transparent);
            transition: left 0.6s ease;
        }
        
        .nav-item:hover::before { left: 100%; }
        
        .nav-item:hover {
            background: linear-gradient(90deg, rgba(212, 175, 55, 0.15), rgba(46, 125, 90, 0.2));
            color: white;
            padding-left: 35px;
            transform: translateX(5px);
            border-left-color: var(--ayur-accent-gold);
        }
        
        .nav-item.active {
            background: linear-gradient(135deg, rgba(46, 125, 90, 0.3), rgba(212, 175, 55, 0.2));
            border-left-color: var(--ayur-accent-gold);
            color: white;
            font-weight: 600;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .nav-item i {
            width: 24px;
            font-size: 1.2rem;
            text-align: center;
            color: var(--ayur-accent-gold);
        }
        
        .nav-item span {
            flex: 1;
            white-space: nowrap;
            font-size: 0.95rem;
        }
        
        .sidebar-footer {
            padding: 25px;
            border-top: 1px solid rgba(212, 175, 55, 0.2);
            display: flex;
            flex-direction: column;
            gap: 15px;
            background: rgba(10, 61, 44, 0.8);
        }
        
        .btn-outline {
            background: transparent;
            border: 2px solid var(--ayur-accent-gold);
            color: var(--ayur-accent-gold);
            padding: 12px 20px;
            border-radius: 10px;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 600;
            transition: var(--transition);
            font-size: 0.9rem;
        }
        
        .btn-outline:hover {
            background: var(--ayur-accent-gold);
            color: var(--ayur-dark-green);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
        }
        
        .logout-link {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            border-radius: 10px;
            transition: var(--transition);
            font-size: 0.9rem;
        }
        
        .logout-link:hover {
            background: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            transform: translateX(5px);
        }
        
        .dashboard-main {
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: var(--transition);
            background: linear-gradient(135deg, #f5f9f7 0%, #edf5f1 100%);
            min-height: 100vh;
        }
        
        .dashboard-header {
            background: white;
            height: var(--header-height);
            padding: 0 35px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 6px 20px rgba(10, 61, 44, 0.08);
            position: sticky;
            top: 0;
            z-index: 999;
            border-bottom: 2px solid var(--ayur-accent-gold);
        }
        
        .header-left {
            display: flex;
            align-items: center;
            gap: 25px;
        }
        
        .sidebar-toggle {
            background: var(--ayur-light-green);
            border: none;
            width: 45px;
            height: 45px;
            border-radius: 12px;
            font-size: 1.3rem;
            color: white;
            cursor: pointer;
            display: none;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(46, 125, 90, 0.2);
        }
        
        .sidebar-toggle:hover {
            background: var(--ayur-teal);
            transform: rotate(90deg);
        }
        
        .header-left h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--ayur-dark-green);
            font-weight: 700;
            background: linear-gradient(135deg, var(--ayur-dark-green), var(--ayur-teal));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .dashboard-content {
            padding: 35px;
            max-width: 1500px;
            margin: 0 auto;
            width: 100%;
        }
        
        @media (max-width: 1200px) {
            .sidebar {
                transform: translateX(-100%);
                box-shadow: 10px 0 40px rgba(10, 61, 44, 0.3);
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .dashboard-main {
                margin-left: 0;
            }
            
            .sidebar-toggle {
                display: flex;
                align-items: center;
                justify-content: center;
            }
        }
        
        @media (max-width: 768px) {
            .dashboard-content {
                padding: 25px;
            }
            
            .header-left h1 {
                font-size: 1.6rem;
            }
        }
        
        .rating-summary {
            background: linear-gradient(135deg, var(--primary-forest) 0%, var(--primary-sage) 100%);
            color: white;
            padding: 30px;
            border-radius: 16px;
            margin-bottom: 30px;
        }
        
        .rating-display {
            text-align: center;
        }
        
        .rating-display .rating-number {
            font-size: 4rem;
            font-weight: bold;
            margin: 0;
        }
        
        .rating-display .rating-stars {
            font-size: 1.5rem;
            margin: 10px 0;
        }
        
        .rating-display .rating-count {
            opacity: 0.9;
        }
        
        .rating-breakdown {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        
        .rating-bar-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .rating-bar {
            flex: 1;
            height: 8px;
            background: rgba(255,255,255,0.3);
            border-radius: 4px;
            overflow: hidden;
        }
        
        .rating-bar-fill {
            height: 100%;
            background: white;
            transition: width 0.3s;
        }
        
        .review-item {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 15px;
        }
        
        .reviewer-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .reviewer-avatar {
            width: 50px;
            height: 50px;
            background: var(--primary-sage);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }
        
        .review-rating {
            display: flex;
            gap: 5px;
            color: #fbbf24;
        }
        
        .review-response {
            background: #f0fdf4;
            border-left: 4px solid var(--primary-sage);
            padding: 15px;
            margin-top: 15px;
            border-radius: 8px;
        }
    </style>
</head>
<body class="dashboard-body">
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-leaf"></i>
                <span>Ayur<span class="highlight">Doctor</span></span>
            </a>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-item">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/profile" class="nav-item">
                <i class="fas fa-user-circle"></i>
                <span>Profile</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Appointments</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/prescriptions" class="nav-item">
                <i class="fas fa-prescription"></i>
                <span>Prescriptions</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/reviews" class="nav-item active">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availability" class="nav-item">
                <i class="fas fa-clock"></i>
                <span>Availability</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline btn-sm" target="_blank">
                <i class="fas fa-external-link-alt"></i> View AyurVedaCare
            </a>
            <a href="${pageContext.request.contextPath}/doctor/logout" class="logout-link">
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
                <h1>Reviews & Ratings</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <!-- Rating Summary -->
            <div class="rating-summary">
                <div class="rating-display">
                    <c:set var="ratingValue" value="${averageRating != null ? averageRating : 0}"/>
                    <h2 class="rating-number"><fmt:formatNumber value="${ratingValue}" maxFractionDigits="1" minFractionDigits="1"/></h2>
                    <div class="rating-stars">
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${i <= ratingValue}">
                                    <i class="fas fa-star"></i>
                                </c:when>
                                <c:when test="${(i - 0.5) <= ratingValue}">
                                    <i class="fas fa-star-half-alt"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="far fa-star"></i>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <p class="rating-count">Based on ${reviewCount != null ? reviewCount : 0} review(s)</p>
                </div>
                
                <div class="rating-breakdown">
                    <c:forEach begin="5" end="1" step="-1" var="rating">
                        <div class="rating-bar-item">
                            <span>${rating} <i class="fas fa-star"></i></span>
                            <div class="rating-bar">
                                <c:set var="ratingCount" value="${rating == 5 ? rating5 : (rating == 4 ? rating4 : (rating == 3 ? rating3 : (rating == 2 ? rating2 : rating1)))}"/>
                                <c:set var="percentage" value="${reviewCount > 0 ? (ratingCount * 100 / reviewCount) : 0}"/>
                                <div class="rating-bar-fill" style="width: ${percentage}%"></div>
                            </div>
                            <span>${ratingCount != null ? ratingCount : 0}</span>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Reviews List -->
            <h3 style="margin-bottom: 20px;">All Reviews</h3>
            
            <c:choose>
                <c:when test="${not empty allReviews}">
                    <c:forEach var="review" items="${allReviews}">
                        <div class="review-item">
                            <div class="review-header">
                                <div class="reviewer-info">
                                    <div class="reviewer-avatar">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div>
                                        <strong>${review.isAnonymous ? 'Anonymous' : review.reviewerName}</strong>
                                        <c:if test="${review.isVerified}">
                                            <span class="badge badge-success" style="margin-left: 8px;">
                                                <i class="fas fa-check-circle"></i> Verified
                                            </span>
                                        </c:if>
                                        <div style="color: var(--text-muted); font-size: 0.9rem; margin-top: 3px;">
                                            <fmt:parseDate value="${review.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                            <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <div class="review-rating">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="fas fa-star ${i <= review.rating ? '' : 'far'}"></i>
                                        </c:forEach>
                                    </div>
                                    <span class="badge ${review.status == 'APPROVED' ? 'badge-success' : (review.status == 'PENDING' ? 'badge-warning' : 'badge-error')}" style="margin-top: 5px; display: inline-block;">
                                        ${review.status}
                                    </span>
                                </div>
                            </div>
                            
                            <c:if test="${not empty review.reviewText}">
                                <p style="color: var(--text-medium); margin: 15px 0; line-height: 1.6;">
                                    ${review.reviewText}
                                </p>
                            </c:if>
                            
                            <c:if test="${not empty review.doctorResponse}">
                                <div class="review-response">
                                    <strong><i class="fas fa-reply"></i> Doctor's Response:</strong>
                                    <p style="margin-top: 8px; color: var(--text-medium);">${review.doctorResponse}</p>
                                    <small style="color: var(--text-muted);">
                                        <fmt:parseDate value="${review.doctorResponseDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedResponse" type="both"/>
                                        <fmt:formatDate value="${parsedResponse}" pattern="dd MMM yyyy 'at' hh:mm a"/>
                                    </small>
                                </div>
                            </c:if>
                            
                            <c:if test="${empty review.doctorResponse && review.status == 'APPROVED'}">
                                <form action="${pageContext.request.contextPath}/doctor/reviews/${review.id}/respond" method="post" style="margin-top: 15px;">
                                    <div class="form-group" style="margin-bottom: 10px;">
                                        <textarea name="response" class="form-textarea" rows="3" placeholder="Respond to this review..." required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-sm btn-primary">
                                        <i class="fas fa-reply"></i> Respond
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" style="background: white; border-radius: var(--radius-lg); padding: var(--spacing-3xl);">
                        <i class="fas fa-star"></i>
                        <h3>No Reviews Yet</h3>
                        <p>You haven't received any reviews yet</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script>
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
                this.style.transform = sidebar.classList.contains('active') ? 'rotate(90deg)' : 'rotate(0)';
            });
        }
    </script>
</body>
</html>

