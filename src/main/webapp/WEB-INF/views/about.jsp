<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>About Us | Ayurveda Wellness</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Fonts & Icons -->
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
*{margin:0;padding:0;box-sizing:border-box}
body{
    font-family:'Poppins',sans-serif;
    background:#fdfaf4;
    color:#333;
    line-height:1.6;
    padding-top: 80px;
}

/* NAVBAR - Bootstrap compatible */
.navbar{
    background: rgba(31, 42, 31, 0.98);
    padding: 20px 0;
    position:fixed;
    width:100%;
    top:0;
    z-index:1000;
            transition: all 0.4s ease;
    box-shadow: 0 5px 30px rgba(0,0,0,0.3);
            backdrop-filter: blur(10px);
        }
.navbar.scrolled{
    padding: 12px 0;
            box-shadow: 0 5px 30px rgba(0,0,0,0.3);
    backdrop-filter: blur(10px);
        }
        
        .navbar-brand {
    font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 700;
    color: #e6b55c !important;
            letter-spacing: 1px;
        }

.navbar-nav {
    display: flex;
    flex-direction: row;
    align-items: center;
    flex-wrap: nowrap;
}

.navbar-nav .nav-item {
    display: flex;
    align-items: center;
    white-space: nowrap;
}
        
        .navbar-nav .nav-link {
            color: #fff !important;
            font-weight: 500;
            padding: 8px 18px !important;
            transition: all 0.3s ease;
    white-space: nowrap;
}

.navbar-nav .nav-link:hover {
    color: #e6b55c !important;
        }
        
        .btn-nav {
    background: linear-gradient(135deg, #e6b55c 0%, #d4a347 100%);
    color: #1f2a1f !important;
            padding: 10px 25px !important;
            border-radius: 30px;
            font-weight: 600;
    margin-left: 8px;
            transition: all 0.4s ease;
        }
        
        .btn-nav:hover {
            transform: translateY(-3px);
    box-shadow: 0 10px 30px rgba(230, 181, 92, 0.4);
    color: #1f2a1f !important;
}

.user-dropdown .dropdown-toggle {
    background: rgba(230, 181, 92, 0.15);
    border-radius: 30px;
    padding: 8px 20px !important;
        }
        
        .user-dropdown .dropdown-menu {
            background: #fff;
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            padding: 10px 0;
            margin-top: 10px;
        }
        
        .user-dropdown .dropdown-item {
            padding: 12px 20px;
            color: #333;
            transition: all 0.3s ease;
        }
        
        .user-dropdown .dropdown-item:hover {
    background: rgba(230, 181, 92, 0.1);
    color: #e6b55c;
        }
        
        .user-dropdown .dropdown-item i {
            width: 20px;
            margin-right: 10px;
    color: #e6b55c;
}

.container{
    width:90%;
    max-width:1200px;
    margin:auto;
}

.about-hero{
    margin-top:80px;
    min-height:calc(100vh - 80px);
    background:
    linear-gradient(rgba(0,0,0,.6),rgba(0,0,0,.8)),
    url("${pageContext.request.contextPath}/images/about.jpg") center/cover no-repeat;
    display:flex;
    align-items:center;
    text-align:center;
    color:#fff;
}
.about-hero h1{
    font-family:'Playfair Display';
    font-size:56px;
    color:#e6b55c;
    margin-bottom:20px;
}
.about-hero p{
    max-width:800px;
    margin:auto;
    font-size:18px;
}
section{padding:90px 0}
.about-text{
    max-width:900px;
    margin:auto;
    text-align:center;
}
.about-text h2{
    font-family:'Playfair Display';
    font-size:42px;
    color:#1f2a1f;
            margin-bottom: 25px;
        }
.about-text p{
    font-size:18px;
    line-height:1.8;
    color:#555;
}
.dark{
    background:#0f0f0f;
    color:#f1dfbf;
    text-align:center;
}
.dark h2{color:#e6b55c}
.values{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:40px;
    margin-top:60px;
}
.value{
    background:#fff;
    padding:40px;
    border-radius:15px;
    box-shadow:0 15px 40px rgba(0,0,0,.1);
            text-align: center;
    transition: all 0.3s ease;
}
.value:hover {
    transform: translateY(-10px);
    box-shadow: 0 20px 50px rgba(0,0,0,.15);
}
.value i{
    font-size:40px;
    color:#e6b55c;
    margin-bottom:15px;
}
.value h3 {
    font-family: 'Playfair Display', serif;
            font-size: 24px;
    color: #1f2a1f;
            margin-bottom: 15px;
        }
.value p {
            color: #666;
            font-size: 16px;
}
footer{
    background:#1f2a1f;
    color:#dfe7cf;
    padding:80px 0 30px;
}
.footer-container{
    display:grid;
    grid-template-columns:repeat(auto-fit, minmax(250px, 1fr));
    gap:60px;
    max-width:1200px;
    margin:auto;
}
.footer-col h3{
    color:#e6b55c;
    font-family:'Playfair Display';
    font-size:22px;
    margin-bottom:22px;
}
.footer-col p{font-size:16px; line-height: 1.7;}
.footer-links{list-style:none; padding: 0;}
.footer-links li{margin-bottom:12px}
.footer-links a{
    color:#e0e7cc;
    text-decoration:none;
    transition: color 0.3s ease;
}
.footer-links a:hover{color:#e6b55c}
.social-links{
    display:flex;
    gap:12px;
    margin-top:25px;
}
.social-links a{
    width:42px;
    height:42px;
    border-radius:50%;
    background:rgba(255,255,255,.08);
    display:flex;
    align-items:center;
    justify-content:center;
    color:#dfe7cf;
    transition: all 0.3s ease;
}
.social-links a:hover{
    background:#e6b55c;
    color:#1f2a1f;
}
.newsletter input{
    width:100%;
    padding:14px 18px;
    border-radius:30px;
    border:none;
    margin-bottom:16px;
    background: rgba(255,255,255,0.1);
            color: #fff;
}
.newsletter input::placeholder {
    color: rgba(255,255,255,0.6);
}
.newsletter button{
    background:#e6b55c;
    color:#1f2a1f;
    border:none;
    width:100%;
    padding:14px;
    border-radius:30px;
    font-size:16px;
            font-weight: 600;
    cursor: pointer;
            transition: all 0.3s ease;
        }
.newsletter button:hover {
    background: #d4a347;
}
.copyright{
    margin-top:60px;
    padding-top:25px;
    text-align:center;
    border-top:1px solid rgba(255,255,255,.15);
    font-size: 14px;
}
/* Ensure navbar items stay in single row on desktop */
@media (min-width: 992px) {
    .navbar-nav {
        flex-wrap: nowrap !important;
    }
    
    .navbar-nav .nav-item {
        flex-shrink: 0;
    }
}

@media(max-width:768px){
    .about-hero h1 {
        font-size: 42px;
    }
    
    .about-text h2 {
        font-size: 36px;
    }
    
    .values {
        grid-template-columns: 1fr;
        gap: 30px;
    }
    
    .footer-container {
        grid-template-columns: 1fr;
        gap: 40px;
    }
}
</style>
</head>

<body>

<!-- NAVBAR - KEEPING CURRENT NAVBAR -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-leaf me-2"></i>Ayurveda Wellness
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/hospitals">Find Centers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/doctors">Find Doctors</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products"><i class="fas fa-shopping-bag me-1"></i>Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/about">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/services">Services</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                    </li>
                    <c:choose>
                        <c:when test="${not empty currentUser}">
                            <li class="nav-item dropdown user-dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle me-2"></i>${currentUser.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/dashboard"><i class="fas fa-th-large"></i>Dashboard</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile"><i class="fas fa-user"></i>Profile</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/enquiries"><i class="fas fa-envelope"></i>Enquiries</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout"><i class="fas fa-sign-out-alt"></i>Sign Out</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/login">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link btn-nav" href="${pageContext.request.contextPath}/user/register">Sign Up</a>
                            </li>
                        <li class="nav-item">
                            <a class="nav-link btn-nav" href="${pageContext.request.contextPath}/hospital/register">For Centers</a>
                        </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

<section class="about-hero">
    <div class="container">
        <h1>Ancient Wisdom, Global Healing</h1>
        <p>Connecting the world with India's authentic Ayurveda and natural healing traditions.</p>
    </div>
</section>

<section>
    <div class="about-text container">
        <h2>Our Mission</h2>
        <p>
        Our mission is to make authentic Ayurveda and natural healing accessible,
        transparent, and trustworthy for people worldwide.
        We focus on preventive care, root-cause treatment,
        and long-term holistic wellness.
        </p>
    </div>
</section>

<section class="dark">
    <div class="about-text container">
        <h2>Our Philosophy</h2>
        <p>
        True healing happens when body, mind, and lifestyle are in harmony.
        Ayurveda treats the individual, not just the illness,
        encouraging balance with nature for lasting wellness.
        </p>
    </div>
</section>

<section>
    <div class="about-text container">
        <h2>Who We Are</h2>
        <p>
        We are a global Ayurveda and wellness discovery platform.
        We connect users with verified Ayurvedic hospitals,
        wellness centres, ashrams, and natural healing experts across India.
        </p>
    </div>
</section>

<section>
        <div class="container">
        <div class="about-text"><h2>Our Core Values</h2></div>
        <div class="values">
            <div class="value">
                        <i class="fas fa-leaf"></i>
                <h3>Authenticity</h3>
                <p>Preserving traditional Ayurvedic wisdom.</p>
                    </div>
            <div class="value">
                            <i class="fas fa-user-check"></i>
                <h3>Personal Care</h3>
                <p>Respecting each individual healing journey.</p>
                        </div>
            <div class="value">
                            <i class="fas fa-heart"></i>
                <h3>Compassion</h3>
                <p>Healing with empathy and responsibility.</p>
                        </div>
            <div class="value">
                <i class="fas fa-award"></i>
                <h3>Excellence</h3>
                <p>Maintaining trusted wellness standards.</p>
                </div>
            </div>
        </div>
    </section>

<footer>
<div class="footer-container">
    <div class="footer-col">
        <h3>Ayurveda Wellness</h3>
        <p>Connecting people globally with authentic Ayurvedic healing.</p>
        <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
    <div class="footer-col">
        <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/terms-and-conditions">Terms & Conditions</a></li>
                        <li><a href="${pageContext.request.contextPath}/privacy-policy">Privacy Policy</a></li>
                        <li><a href="${pageContext.request.contextPath}/private and policy">Services</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                    </ul>
                </div>
    <div class="footer-col">
        <h3>Our Services</h3>
                    <ul class="footer-links">
            <li>Panchakarma</li>
            <li>Yoga Therapy</li>
            <li>Detox Programs</li>
            <li>Herbal Medicine</li>
            <li>Diet & Nutrition</li>
                    </ul>
                </div>
    <div class="footer-col newsletter">
        <h3>Newsletter</h3>
        <p style="margin-bottom: 15px; font-size: 15px;">Subscribe for health tips and special offers.</p>
        <input type="email" placeholder="Your email">
        <button>Subscribe</button>
                </div>
            </div>
<div class="copyright">
© 2025 Ayurveda Wellness. All rights reserved.
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
// Navbar scroll effect
        window.addEventListener('scroll', () => {
            const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
        
// Smooth scrolling for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        
        const targetId = this.getAttribute('href');
        if (targetId === '#') return;
        
        const targetElement = document.querySelector(targetId);
        if (targetElement) {
            window.scrollTo({
                top: targetElement.offsetTop - 80,
                behavior: 'smooth'
            });
        }
    });
        });
    </script>

</body>
</html>
