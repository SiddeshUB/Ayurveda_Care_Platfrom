<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reviews - Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        .rating-overview {
            display: grid;
            grid-template-columns: 200px 1fr;
            gap: var(--spacing-2xl);
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-xl);
            margin-bottom: var(--spacing-xl);
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
        }
        
        .rating-bars {
            display: flex;
            flex-direction: column;
            justify-content: center;
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
            font-weight: 500;
        }
        
        .rating-bar .bar {
            flex: 1;
            height: 10px;
            background: var(--neutral-stone);
            border-radius: var(--radius-full);
            overflow: hidden;
        }
        
        .rating-bar .fill {
            height: 100%;
            background: var(--accent-gold);
            border-radius: var(--radius-full);
        }
        
        .rating-bar .count {
            width: 40px;
            font-size: 0.9rem;
            color: var(--text-muted);
        }
        
        .review-card {
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-xl);
            margin-bottom: var(--spacing-lg);
        }
        
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
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
            font-size: 1.25rem;
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
            margin-bottom: var(--spacing-md);
        }
        
        .review-response {
            background: var(--neutral-sand);
            border-left: 3px solid var(--primary-forest);
            padding: var(--spacing-md);
            margin-top: var(--spacing-md);
            border-radius: 0 var(--radius-md) var(--radius-md) 0;
        }
        
        .review-response h5 {
            margin: 0 0 var(--spacing-sm);
            color: var(--primary-forest);
        }
        
        @media (max-width: 768px) {
            .rating-overview {
                grid-template-columns: 1fr;
            }
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
            <a href="${pageContext.request.contextPath}/dashboard/doctors" class="nav-item">
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
            <a href="${pageContext.request.contextPath}/dashboard/reviews" class="nav-item active">
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
                <h1>Reviews & Ratings</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success" data-auto-dismiss="5000">
                    <i class="fas fa-check-circle"></i>
                    ${success}
                </div>
            </c:if>

            <!-- Rating Overview -->
            <div class="rating-overview">
                <div class="rating-big">
                    <c:set var="avgRating" value="${ratingBreakdown.averageRating != null ? ratingBreakdown.averageRating : 0}"/>
                    <div class="number">
                        <fmt:formatNumber value="${avgRating}" maxFractionDigits="1" minFractionDigits="1"/>
                    </div>
                    <div class="stars">
                        <c:forEach begin="1" end="5">
                            <i class="fas fa-star"></i>
                        </c:forEach>
                    </div>
                    <div style="color: var(--text-muted);">${ratingBreakdown.totalReviews != null ? ratingBreakdown.totalReviews : 0} reviews</div>
                </div>
                <div class="rating-bars">
                    <div class="rating-bar">
                        <span class="label">5</span>
                        <i class="fas fa-star" style="color: var(--accent-gold); font-size: 0.8rem;"></i>
                        <div class="bar">
                            <c:set var="r5" value="${ratingBreakdown.rating5 != null ? ratingBreakdown.rating5 : 0}"/>
                            <c:set var="total" value="${ratingBreakdown.totalReviews != null && ratingBreakdown.totalReviews > 0 ? ratingBreakdown.totalReviews : 1}"/>
                            <div class="fill" style="width: ${(r5 / total) * 100}%"></div>
                        </div>
                        <span class="count">${r5}</span>
                    </div>
                    <div class="rating-bar">
                        <span class="label">4</span>
                        <i class="fas fa-star" style="color: var(--accent-gold); font-size: 0.8rem;"></i>
                        <div class="bar">
                            <c:set var="r4" value="${ratingBreakdown.rating4 != null ? ratingBreakdown.rating4 : 0}"/>
                            <div class="fill" style="width: ${(r4 / total) * 100}%"></div>
                        </div>
                        <span class="count">${r4}</span>
                    </div>
                    <div class="rating-bar">
                        <span class="label">3</span>
                        <i class="fas fa-star" style="color: var(--accent-gold); font-size: 0.8rem;"></i>
                        <div class="bar">
                            <c:set var="r3" value="${ratingBreakdown.rating3 != null ? ratingBreakdown.rating3 : 0}"/>
                            <div class="fill" style="width: ${(r3 / total) * 100}%"></div>
                        </div>
                        <span class="count">${r3}</span>
                    </div>
                    <div class="rating-bar">
                        <span class="label">2</span>
                        <i class="fas fa-star" style="color: var(--accent-gold); font-size: 0.8rem;"></i>
                        <div class="bar">
                            <c:set var="r2" value="${ratingBreakdown.rating2 != null ? ratingBreakdown.rating2 : 0}"/>
                            <div class="fill" style="width: ${(r2 / total) * 100}%"></div>
                        </div>
                        <span class="count">${r2}</span>
                    </div>
                    <div class="rating-bar">
                        <span class="label">1</span>
                        <i class="fas fa-star" style="color: var(--accent-gold); font-size: 0.8rem;"></i>
                        <div class="bar">
                            <c:set var="r1" value="${ratingBreakdown.rating1 != null ? ratingBreakdown.rating1 : 0}"/>
                            <div class="fill" style="width: ${(r1 / total) * 100}%"></div>
                        </div>
                        <span class="count">${r1}</span>
                    </div>
                </div>
            </div>

            <!-- Reviews List -->
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
                                            ${review.patientCountry} • ${review.createdAt}
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
                            
                            <c:if test="${not empty review.hospitalResponse}">
                                <div class="review-response">
                                    <h5><i class="fas fa-reply"></i> Your Response</h5>
                                    <p style="margin: 0; color: var(--text-medium);">${review.hospitalResponse}</p>
                                </div>
                            </c:if>
                            
                            <c:if test="${empty review.hospitalResponse}">
                                <form action="${pageContext.request.contextPath}/dashboard/reviews/${review.id}/respond" method="post" style="margin-top: var(--spacing-md);">
                                    <div class="form-group" style="margin-bottom: var(--spacing-sm);">
                                        <textarea name="response" class="form-textarea" rows="2" placeholder="Write a response to this review..." required></textarea>
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
                        <p>When patients leave reviews, they'll appear here</p>
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
