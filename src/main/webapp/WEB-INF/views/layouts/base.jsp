<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Ayurveda Hospital'} - Healing Naturally</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    <c:if test="${not empty extraCss}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/${extraCss}">
    </c:if>
</head>
<body class="${bodyClass}">
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
                <a href="${pageContext.request.contextPath}/products" class="nav-link"><i class="fas fa-shopping-bag"></i> Products</a>
                <a href="${pageContext.request.contextPath}/about" class="nav-link">About</a>
                <a href="${pageContext.request.contextPath}/services" class="nav-link">Services</a>
                <a href="${pageContext.request.contextPath}/contact" class="nav-link">Contact</a>
                
                <c:choose>
                    <c:when test="${pageContext.request.userPrincipal != null}">
                        <a href="${pageContext.request.contextPath}/dashboard" class="nav-link nav-cta">Dashboard</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/hospital/login" class="nav-link">Login</a>
                        <a href="${pageContext.request.contextPath}/hospital/register" class="nav-link nav-cta">Register Center</a>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <button class="nav-toggle" id="navToggle">
                <i class="fas fa-bars"></i>
            </button>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <jsp:include page="${contentPage}" />
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-container">
            <div class="footer-grid">
                <div class="footer-section">
                    <h3><i class="fas fa-leaf"></i> AyurVedaCare</h3>
                    <p>Connecting you with authentic Ayurvedic healing centers across India. Experience the ancient wisdom of natural healing.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
                
                <div class="footer-section">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/hospitals">Find Centers</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                        <li><a href="${pageContext.request.contextPath}/hospital/register">List Your Center</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h4>Popular Therapies</h4>
                    <ul>
                        <li><a href="#">Panchakarma</a></li>
                        <li><a href="#">Detox Programs</a></li>
                        <li><a href="#">Yoga & Meditation</a></li>
                        <li><a href="#">Weight Management</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h4>Contact Us</h4>
                    <ul class="contact-info">
                        <li><i class="fas fa-envelope"></i> info@ayurvedacare.com</li>
                        <li><i class="fas fa-phone"></i> +91 98765 43210</li>
                        <li><i class="fas fa-map-marker-alt"></i> Kerala, India</li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2024 AyurVedaCare. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <c:if test="${not empty extraJs}">
        <script src="${pageContext.request.contextPath}/js/${extraJs}"></script>
    </c:if>
</body>
</html>

