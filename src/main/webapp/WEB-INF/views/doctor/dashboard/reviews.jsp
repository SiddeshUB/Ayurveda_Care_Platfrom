<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reviews & Ratings - Doctor Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
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
                <i class="fas fa-user-md"></i>
                <span>Doctor<span class="highlight">Portal</span></span>
            </a>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-item">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/reviews" class="nav-item active">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
        </nav>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
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
</body>
</html>

