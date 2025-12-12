<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us | Ayurveda Wellness</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        *{margin:0;padding:0;box-sizing:border-box;}
        body{
            font-family:'Poppins',sans-serif;
            background:#fdfaf4;
            color:#333;
            padding-top: 80px; /* FOR FIXED NAVBAR */
        }

        /* NAVBAR - Bootstrap compatible */
        .navbar {
            background: rgba(31, 42, 31, 0.98);
            padding: 20px 0;
            transition: all 0.4s ease;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 5px 30px rgba(0,0,0,0.3);
            backdrop-filter: blur(10px);
        }
        
        .navbar.scrolled {
            background: rgba(31, 42, 31, 0.98);
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

        /* HERO */
        .contact-hero{
            min-height:calc(100vh - 80px);
            background:
                linear-gradient(rgba(0,0,0,.6),rgba(0,0,0,.8)),
                url("${pageContext.request.contextPath}/images/hero1.jpg")
                center/cover no-repeat;
            display:flex;
            align-items:center;
            text-align:center;
            color:#fff;
        }
        .contact-hero-inner{
            width:90%;
            max-width:900px;
            margin:auto;
        }
        .contact-hero h1{
            font-family:'Playfair Display',serif;
            font-size:52px;
            color:#e6b55c;
            margin-bottom:20px;
        }

        section{padding:80px 0;}

        .section-title{
            font-family:'Playfair Display',serif;
            font-size:38px;
            text-align:center;
            color:#1f2a1f;
            margin-bottom:15px;
        }
        .section-subtitle{
            text-align:center;
            color:#777;
            margin-bottom:40px;
            font-size:16px;
        }

        /* CONTACT INFO CARDS */
        .contact-cards{
            display:grid;
            grid-template-columns:repeat(auto-fit,minmax(230px,1fr));
            gap:25px;
            margin-bottom:50px;
        }
        .contact-card{
            background:#fff;
            border-radius:16px;
            box-shadow:0 12px 30px rgba(0,0,0,.08);
            padding:25px 22px;
            text-align:left;
        }
        .contact-card i{
            font-size:26px;
            color:#e6b55c;
            margin-bottom:12px;
        }
        .contact-card h4{
            font-size:18px;
            margin-bottom:8px;
            font-weight:600;
        }
        .contact-card p{
            font-size:15px;
            color:#555;
            margin-bottom:5px;
        }

        /* FORM + MAP WRAPPER */
        .contact-main{
            display:grid;
            grid-template-columns: minmax(0, 1.1fr) minmax(0, 1.1fr);
            gap:35px;
        }
        @media(max-width:992px){
            .contact-main{
                grid-template-columns:1fr;
            }
        }

        /* FORM */
        .contact-form{
            background:#ffffff;
            border-radius:18px;
            padding:30px 25px;
            box-shadow:0 15px 40px rgba(0,0,0,.10);
        }
        .contact-form .form-label{
            font-weight:500;
            margin-bottom:6px;
        }
        .contact-form .form-control,
        .contact-form .form-select{
            border-radius:10px;
            border:1px solid #d5d5d5;
            padding:10px 12px;
            font-size:15px;
        }
        .contact-form .form-control:focus,
        .contact-form .form-select:focus{
            border-color:#e6b55c;
            box-shadow:0 0 0 0.1rem rgba(230,181,92,.35);
        }
        .btn-gold{
            background:#e6b55c;
            color:#1f2a1f;
            border:none;
            border-radius:999px;
            padding:10px 26px;
            font-weight:500;
            font-size:15px;
        }
        .btn-gold:hover{
            background:#d4a347;
            color:#1f2a1f;
        }

        /* MAP */
        .contact-map{
            border-radius:18px;
            overflow:hidden;
            box-shadow:0 15px 40px rgba(0,0,0,.10);
            background:#eee;
            min-height:320px;
        }
        .contact-map iframe{
            width:100%;
            height:100%;
            border:0;
        }

        /* FOOTER (same visual style as your other pages) */
        .site-footer{
            background:#1f2a1f;
            color:#cdd6b6;
            padding:70px 0 25px;
        }
        .footer-col h3{
            color:#e6b55c;
            margin-bottom:20px;
            font-size:20px;
        }
        .footer-col p{
            font-size:15px;
            line-height:1.7;
        }
        .footer-col ul{
            list-style:none;
            padding:0;
        }
        .footer-col ul li{
            margin-bottom:12px;
        }
        .footer-col ul li a{
            color:#cdd6b6;
            text-decoration:none;
        }
        .footer-col ul li a:hover{
            color:#e6b55c;
        }
        .footer-social{
            display:flex;
            gap:12px;
            margin-top:20px;
        }
        .footer-social a{
            width:40px;
            height:40px;
            background:rgba(255,255,255,0.08);
            border-radius:50%;
            display:flex;
            align-items:center;
            justify-content:center;
            color:#cdd6b6;
        }
        .footer-social a:hover{
            background:#e6b55c;
            color:#1f2a1f;
        }
        .newsletter-form input{
            width:100%;
            padding:12px;
            border-radius:25px;
            border:none;
            margin-bottom:15px;
        }
        .newsletter-form button{
            width:100%;
            padding:12px;
            border:none;
            border-radius:25px;
            background:#e6b55c;
            font-weight:600;
        }
        .footer-bottom{
            margin-top:50px;
            text-align:center;
            padding-top:20px;
            border-top:1px solid rgba(255,255,255,0.1);
            font-size:14px;
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
        
        /* RESPONSIVE */
        @media (max-width: 768px) {
            .contact-hero h1 {
                font-size: 36px;
            }
            
            .section-title {
                font-size: 32px;
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">About Us</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/services">Services</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/contact">Contact</a>
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

<!-- HERO -->
<section class="contact-hero">
    <div class="contact-hero-inner">
        <h1>Get in Touch With Us</h1>
        <p>
            Have a question about your health, our Ayurvedic therapies, or booking an appointment?
            Reach out and our wellness team will be happy to guide you.
        </p>
    </div>
</section>

<!-- CONTACT CONTENT -->
<section>
    <div class="container">

        <h2 class="section-title">We're Here to Help</h2>
        <p class="section-subtitle">
            Call, visit, or send us a message. We'll respond as soon as possible with caring, personalised support.
        </p>

        <!-- Top info cards -->
        <div class="contact-cards">
            <div class="contact-card">
                <i class="fas fa-location-dot"></i>
                <h4>Clinic Address</h4>
                <p>Ayurveda Wellness Center</p>
                <p>12, Harmony Street, Wellness Nagar</p>
                <p>Bengaluru, Karnataka – 560001</p>
            </div>

            <div class="contact-card">
                <i class="fas fa-phone-alt"></i>
                <h4>Call Us</h4>
                <p>+91 98765 43210</p>
                <p>+91 91234 56789</p>
                <p>Mon – Sat, 9:00 AM – 7:00 PM</p>
            </div>

            <div class="contact-card">
                <i class="fas fa-envelope-open-text"></i>
                <h4>Email</h4>
                <p>care@ayurvedawellness.com</p>
                <p>appointments@ayurvedawellness.com</p>
            </div>

            <div class="contact-card">
                <i class="fas fa-clock"></i>
                <h4>Clinic Hours</h4>
                <p>Mon – Sat : 9:00 AM – 7:00 PM</p>
                <p>Sun : By prior appointment only</p>
            </div>
        </div>

        <!-- Form + Map -->
        <div class="contact-main">
            <!-- FORM -->
            <div class="contact-form">
                <h4 class="mb-3" style="font-family:'Playfair Display',serif;">Send Us a Message</h4>
                <form>
                    <div class="mb-3">
                        <label class="form-label" for="name">Full Name</label>
                        <input type="text" class="form-control" id="name" placeholder="Enter your name">
                    </div>

                    <div class="mb-3">
                        <label class="form-label" for="email">Email Address</label>
                        <input type="email" class="form-control" id="email" placeholder="Enter your email">
                    </div>

                    <div class="mb-3">
                        <label class="form-label" for="phone">Phone Number</label>
                        <input type="tel" class="form-control" id="phone" placeholder="Enter your mobile number">
                    </div>

                    <div class="mb-3">
                        <label class="form-label" for="topic">Reason for Contact</label>
                        <select id="topic" class="form-select">
                            <option value="">Select an option</option>
                            <option>Book a consultation</option>
                            <option>Ask about a treatment</option>
                            <option>Follow-up on existing case</option>
                            <option>General enquiry</option>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label class="form-label" for="message">Your Message</label>
                        <textarea id="message" class="form-control" rows="4" placeholder="Share your concern or question"></textarea>
                    </div>

                    <button type="submit" class="btn-gold">Submit Enquiry</button>
                </form>
            </div>

            <!-- MAP -->
            <div class="contact-map">
                <!-- You can replace the src with your real Google Maps embed link -->
                <iframe
                    loading="lazy"
                    allowfullscreen
                    referrerpolicy="no-referrer-when-downgrade"
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3890.993330900884!2d77.5946!3d12.9716!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMTLCsDU4JzE3LjgiTiA3N8KwMzUnNDMuNiJF!5e0!3m2!1sen!2sin!4v1700000000000">
                </iframe>
            </div>
        </div>

    </div>
</section>

<!-- FOOTER (same visual style as your other pages) -->
<footer class="site-footer">
    <div class="container">
        <div class="row">

            <div class="col-lg-3 col-md-6 footer-col">
                <h3>Ayurveda Wellness</h3>
                <p>
                    Providing authentic Ayurvedic treatments and consultations for over 25 years.
                    Our mission is to help you achieve optimal health through natural, time-tested methods.
                </p>
                <div class="footer-social">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>

            <div class="col-lg-3 col-md-6 footer-col">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                   <li><a href="${pageContext.request.contextPath}/terms-and-conditions">Terms & Conditions</a></li>
                        <li><a href="${pageContext.request.contextPath}/privacy-policy">Privacy Policy</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-6 footer-col">
                <h3>Our Services</h3>
                <ul>
                    <li>Panchakarma Therapy</li>
                    <li>Herbal Medicine</li>
                    <li>Yoga &amp; Meditation</li>
                    <li>Diet &amp; Nutrition</li>
                    <li>Detox Programs</li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-6 footer-col">
                <h3>Newsletter</h3>
                <p>Subscribe to our newsletter for health tips and special offers.</p>
                <form class="newsletter-form">
                    <input type="email" placeholder="Your email address">
                    <button type="submit">Subscribe</button>
                </form>
            </div>

        </div>

        <div class="footer-bottom">
            © 2025 Ayurveda Wellness Center. All rights reserved.
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript -->
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
