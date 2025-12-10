<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Services | Ayurveda Wellness</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: #fdfaf4;
            color: #333;
            line-height: 1.6;
            padding-top: 80px;
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

        /* HERO SECTION */
        .services-hero {
            height: 100vh;
            background:
                linear-gradient(rgba(15, 22, 15, 0.85), rgba(31, 42, 31, 0.95)),
                url("${pageContext.request.contextPath}/images/treatment3.jpg") 
                center center / cover no-repeat;
            display: flex;
            align-items: center;
            text-align: center;
            color: #fff;
            padding-top: 80px;
            position: relative;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            width: 100%;
        }

        .services-hero h1 {
            font-family: 'Playfair Display';
            font-size: 62px;
            color: #e6b55c;
            margin-bottom: 20px;
            text-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }
        
        .services-hero p {
            max-width: 900px;
            margin: 20px auto 40px;
            font-size: 22px;
            color: #f5e4c3;
            line-height: 1.8;
        }

        /* BUTTON */
        .btn-gold {
            background: #e6b55c;
            color: #1f2a1f;
            border: none;
            border-radius: 50px;
            padding: 16px 42px;
            font-weight: 600;
            font-size: 17px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            letter-spacing: 0.5px;
            box-shadow: 0 5px 20px rgba(230, 181, 92, 0.3);
        }
        
        .btn-gold:hover {
            background: #d4a347;
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(230, 181, 92, 0.4);
        }
        
        .btn-outline {
            background: transparent;
            border: 2px solid #e6b55c;
            color: #e6b55c;
        }
        
        .btn-outline:hover {
            background: #e6b55c;
            color: #1f2a1f;
        }

        /* MAIN SECTIONS */
        section {
            padding: 120px 0;
        }

        .section-header {
            text-align: center;
            margin-bottom: 80px;
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 52px;
            margin-bottom: 20px;
            color: #1f2a1f;
            position: relative;
            display: inline-block;
        }

        .section-title:after {
            content: '';
            position: absolute;
            width: 100px;
            height: 4px;
            background: #e6b55c;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }
        
        .section-subtitle {
            color: #e6b55c;
            font-size: 20px;
            text-transform: uppercase;
            letter-spacing: 4px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .section-desc {
            color: #666;
            font-size: 20px;
            max-width: 900px;
            margin: 30px auto 0;
            line-height: 1.9;
        }

        .section-title.light {
            color: #fff;
        }

        .section-title.light:after {
            background: #e6b55c;
        }

        /* WHY CHOOSE US SECTION - WITH BACKGROUND IMAGE */
        .why-choose-us {
            position: relative;
            background: linear-gradient(rgba(253, 250, 244, 0.95), rgba(253, 250, 244, 0.98)),
                        url('https://images.unsplash.com/photo-1540555700478-4be289fbecef?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .why-choose-us::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(230, 181, 92, 0.05) 0%, rgba(31, 42, 31, 0.05) 100%);
            z-index: 1;
        }

        .why-choose-us .container {
            position: relative;
            z-index: 2;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 50px;
            margin-top: 60px;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.92);
            border-radius: 20px;
            padding: 50px 40px;
            text-align: center;
            box-shadow: 0 15px 40px rgba(31, 42, 31, 0.1);
            transition: all 0.4s ease;
            border: 1px solid rgba(230, 181, 92, 0.2);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .feature-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 25px 60px rgba(31, 42, 31, 0.15);
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, #e6b55c, #d4a347);
        }

        .feature-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 35px;
            font-size: 42px;
            color: #1f2a1f;
            box-shadow: 0 10px 25px rgba(230, 181, 92, 0.3);
        }

        .feature-title {
            font-size: 26px;
            color: #1f2a1f;
            margin-bottom: 20px;
            font-weight: 700;
            font-family: 'Playfair Display', serif;
        }

        .feature-desc {
            color: #555;
            font-size: 18px;
            line-height: 1.8;
        }

        /* IMAGE GALLERY SECTION */
        .image-gallery {
            padding: 80px 0;
            background: #1f2a1f;
        }

        .gallery-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            margin-top: 40px;
        }
        
        @media (max-width: 992px) {
            .gallery-container {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .gallery-container {
                grid-template-columns: 1fr;
            }
        }

        .gallery-item {
            border-radius: 15px;
            overflow: hidden;
            position: relative;
            height: 350px;
            cursor: pointer;
            transition: all 0.4s ease;
        }

        .gallery-item:hover {
            transform: scale(1.03);
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        }

        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
            display: block;
        }

        .gallery-item:hover img {
            transform: scale(1.1);
        }

        .gallery-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(transparent, rgba(31, 42, 31, 0.9));
            color: white;
            padding: 30px 25px;
            transform: translateY(100%);
            transition: transform 0.3s ease;
        }

        .gallery-item:hover .gallery-overlay {
            transform: translateY(0);
        }

        .gallery-title {
            font-size: 20px;
            color: #e6b55c;
            margin-bottom: 10px;
            font-weight: 600;
        }

        /* WHAT WE OFFER SECTION */
        .what-we-offer {
            background: linear-gradient(rgba(15, 22, 15, 0.95), rgba(31, 42, 31, 0.95)),
                        url('https://images.unsplash.com/photo-1599901860904-17e6ed7083a0?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: #fff;
        }

        .offerings-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 40px;
            margin-top: 60px;
        }

        .offering-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            transition: all 0.4s ease;
            border: 1px solid rgba(230, 181, 92, 0.2);
            backdrop-filter: blur(10px);
        }

        .offering-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 25px 60px rgba(0,0,0,0.3);
            background: rgba(255, 255, 255, 0.15);
        }

        .offering-header {
            background: linear-gradient(135deg, rgba(230, 181, 92, 0.9), rgba(212, 163, 71, 0.9));
            color: #1f2a1f;
            padding: 35px;
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .offering-icon {
            font-size: 48px;
            color: #1f2a1f;
        }

        .offering-title {
            font-size: 26px;
            color: #1f2a1f;
            font-weight: 700;
            font-family: 'Playfair Display', serif;
        }

        .offering-content {
            padding: 40px;
        }

        .offering-list {
            list-style: none;
        }

        .offering-list li {
            padding: 16px 0;
            padding-left: 40px;
            position: relative;
            color: #f5e4c3;
            font-size: 18px;
            border-bottom: 1px solid rgba(230, 181, 92, 0.2);
            line-height: 1.6;
        }

        .offering-list li:last-child {
            border-bottom: none;
        }

        .offering-list li:before {
            content: "✓";
            position: absolute;
            left: 0;
            top: 16px;
            color: #e6b55c;
            font-weight: bold;
            font-size: 20px;
            width: 28px;
            height: 28px;
            background: rgba(230, 181, 92, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* HEALING CATEGORIES */
        .categories-section {
            background: linear-gradient(rgba(253, 250, 244, 0.95), rgba(253, 250, 244, 0.98)),
                        url('https://images.unsplash.com/photo-1591348278863-a2a664f4d1f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 35px;
            margin-top: 60px;
        }

        .category-item {
            background: rgba(255, 255, 255, 0.92);
            border-radius: 20px;
            padding: 40px 35px;
            text-align: center;
            box-shadow: 0 15px 40px rgba(31, 42, 31, 0.1);
            transition: all 0.4s ease;
            border: 1px solid rgba(230, 181, 92, 0.2);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }

        .category-item:hover {
            background: linear-gradient(135deg, #1f2a1f, #0f160f);
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 25px 60px rgba(31, 42, 31, 0.2);
        }

        .category-item:hover .category-title {
            color: #e6b55c;
        }

        .category-item:hover .category-desc {
            color: #cdd6b6;
        }

        .category-icon {
            font-size: 56px;
            color: #e6b55c;
            margin-bottom: 25px;
            transition: all 0.3s ease;
        }

        .category-item:hover .category-icon {
            transform: scale(1.2);
            color: #f5e4c3;
        }

        .category-title {
            font-size: 22px;
            color: #1f2a1f;
            margin-bottom: 15px;
            font-weight: 700;
            transition: all 0.3s ease;
            font-family: 'Playfair Display', serif;
        }

        .category-desc {
            color: #666;
            font-size: 16px;
            line-height: 1.6;
            transition: all 0.3s ease;
        }

        /* TESTIMONIALS SECTION */
        .testimonials-section {
            background: linear-gradient(rgba(15, 22, 15, 0.95), rgba(31, 42, 31, 0.95)),
                        url('https://images.unsplash.com/photo-1518609878373-06d740f60d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: #fff;
        }

        .testimonials-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 40px;
            margin-top: 60px;
        }

        .testimonial-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 50px 40px;
            position: relative;
            border: 1px solid rgba(230, 181, 92, 0.2);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .testimonial-card:hover {
            transform: translateY(-10px);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        }

        .testimonial-quote {
            font-size: 60px;
            color: #e6b55c;
            position: absolute;
            top: 20px;
            left: 30px;
            opacity: 0.3;
            font-family: serif;
        }

        .testimonial-text {
            font-size: 18px;
            line-height: 1.8;
            color: #f5e4c3;
            margin-bottom: 30px;
            font-style: italic;
        }

        .testimonial-author {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .author-avatar {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            overflow: hidden;
            border: 3px solid #e6b55c;
        }

        .author-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .author-info h4 {
            font-size: 20px;
            color: #e6b55c;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .author-info p {
            color: #cdd6b6;
            font-size: 16px;
        }

        /* CTA SECTION */
        .cta-section {
            position: relative;
            padding: 150px 0;
            text-align: center;
            color: #f5e4c3;
            background: 
                linear-gradient(rgba(15, 22, 15, 0.95), rgba(31, 42, 31, 0.95)),
                url('https://images.unsplash.com/photo-1540555700478-4be289fbecef?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .cta-section::before {
            content: "";
            position: absolute;
            inset: 0;
            background: radial-gradient(
                circle at center,
                rgba(230, 181, 92, 0.15),
                transparent 70%
            );
            z-index: 1;
        }

        .cta-content {
            position: relative;
            z-index: 2;
        }

        .cta-title {
            font-family: 'Playfair Display', serif;
            font-size: 56px;
            color: #f5e4c3;
            margin-bottom: 30px;
            text-shadow: 0 2px 10px rgba(0,0,0,0.3);
        }

        .cta-desc {
            color: #f6e7c3;
            font-size: 22px;
            line-height: 1.8;
            margin-bottom: 50px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }

        /* FOOTER */
        footer {
            background: linear-gradient(135deg, #0f160f 0%, #1f2a1f 100%);
            color: #cdd6b6;
            padding: 80px 0 40px;
            position: relative;
        }

        footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #e6b55c, #d4a347);
        }
        
        .footer-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 50px;
            margin-bottom: 60px;
        }
        
        .footer-col h3 {
            color: #e6b55c;
            margin-bottom: 30px;
            font-size: 24px;
            font-family: 'Playfair Display', serif;
            position: relative;
            padding-bottom: 15px;
        }

        .footer-col h3::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background: #e6b55c;
            border-radius: 2px;
        }
        
        .footer-links {
            list-style: none;
        }
        
        .footer-links li {
            margin-bottom: 15px;
        }
        
        .footer-links a {
            color: #cdd6b6;
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .footer-links a:hover {
            color: #e6b55c;
            transform: translateX(5px);
        }

        .footer-links a i {
            font-size: 12px;
            color: #e6b55c;
        }
        
        .social-links {
            display: flex;
            gap: 20px;
            margin-top: 30px;
        }
        
        .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            color: #cdd6b6;
            transition: all 0.3s ease;
            font-size: 20px;
        }
        
        .social-links a:hover {
            background: #e6b55c;
            color: #1f2a1f;
            transform: translateY(-5px);
        }
        
        .newsletter input {
            width: 100%;
            padding: 16px 25px;
            border-radius: 50px;
            border: 1px solid rgba(230, 181, 92, 0.3);
            background: rgba(255,255,255,0.1);
            color: #fff;
            font-size: 16px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .newsletter input:focus {
            outline: none;
            border-color: #e6b55c;
            background: rgba(255,255,255,0.15);
        }
        
        .copyright {
            text-align: center;
            padding-top: 40px;
            border-top: 1px solid rgba(255,255,255,0.1);
            font-size: 16px;
            color: #a8b894;
        }

        /* RESPONSIVE */
        @media (max-width: 1200px) {
            .services-hero h1 {
                font-size: 52px;
            }
            
            .section-title {
                font-size: 46px;
            }
        }

        @media (max-width: 992px) {
            .services-hero h1 {
                font-size: 46px;
            }
            
            .section-title {
                font-size: 40px;
            }
            
            .features-grid,
            .offerings-container,
            .categories-grid,
            .testimonials-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }
            
            .feature-card,
            .offering-card,
            .category-item,
            .testimonial-card {
                padding: 40px 30px;
            }
            
            .cta-title {
                font-size: 46px;
            }
        }
        
        @media (max-width: 768px) {
            .services-hero h1 {
                font-size: 38px;
            }
            
            .services-hero p {
                font-size: 18px;
            }
            
            .section-title {
                font-size: 36px;
            }
            
            section {
                padding: 80px 0;
            }
            
            .gallery-item {
                height: 300px;
            }
            
            .cta-title {
                font-size: 36px;
            }
            
            .cta-desc {
                font-size: 18px;
            }
        }

        @media (max-width: 576px) {
            .services-hero h1 {
                font-size: 32px;
            }
            
            .services-hero p {
                font-size: 16px;
            }
            
            .section-title {
                font-size: 32px;
            }
            
            .section-desc {
                font-size: 18px;
            }
            
            .btn-gold {
                padding: 14px 30px;
                font-size: 16px;
            }
            
            .feature-card,
            .offering-card,
            .category-item,
            .testimonial-card {
                padding: 30px 25px;
            }
            
            .cta-title {
                font-size: 32px;
            }
            
            .cta-desc {
                font-size: 16px;
            }
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
    </style>
</head>
<body>
    <!-- Navbar - KEEPING CURRENT NAVBAR -->
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/services">Services</a>
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

    <!-- Hero Section -->
    <section class="services-hero">
        <div class="container hero-content">
            <h1>YOUR GATEWAY TO NATURAL HEALING</h1>
            <p>
                Discover India's finest Ayurvedic hospitals, ashrams, wellness retreats and therapy centres 
                in one trusted digital ecosystem designed for your holistic wellness journey.
            </p>
            <div style="margin-top: 50px;">
                <a href="${pageContext.request.contextPath}/hospitals" class="btn-gold">Explore Centres</a>
                <a href="${pageContext.request.contextPath}/user/register" class="btn-gold btn-outline" style="margin-left: 25px;">Book Consultation</a>
            </div>
        </div>
    </section>

    <!-- Why Choose Our Platform -->
    <section id="why-choose" class="why-choose-us">
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">Trust & Excellence</p>
                <h2 class="section-title">Why Choose Our Platform</h2>
                <p class="section-desc">
                    We bring together India's top Ayurvedic hospitals, clinics, ashrams, wellness retreats 
                    and therapy centres — all in one trusted digital ecosystem designed for your healing journey.
                </p>
            </div>
            
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h3 class="feature-title">Verified Centres</h3>
                    <p class="feature-desc">Only verified Ayurvedic hospitals, ashrams & traditional healing institutions listed on our platform. Each centre undergoes strict verification for authenticity and quality standards.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-rupee-sign"></i>
                    </div>
                    <h3 class="feature-title">Transparent Pricing</h3>
                    <p class="feature-desc">Clear treatment packages, pricing, inclusions and accommodation details for informed decisions. No hidden costs, complete transparency in every aspect of your healing journey.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <h3 class="feature-title">Expert Doctors</h3>
                    <p class="feature-desc">Consult with experienced Ayurvedic doctors, naturopaths, therapists & wellness experts. All practitioners are certified with years of experience in traditional healing practices.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-globe-asia"></i>
                    </div>
                    <h3 class="feature-title">Global Support</h3>
                    <p class="feature-desc">Safe for international users with multilingual support, travel guidance & assistance. We provide complete support for international wellness seekers visiting India.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <h3 class="feature-title">Easy Booking</h3>
                    <p class="feature-desc">Book consultations, therapy plans & long-stay healing programs with just a few clicks. Simplified booking process for both Indian and international users.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3 class="feature-title">Safe & Secure</h3>
                    <p class="feature-desc">Secure platform with quality assurance, verified reviews, and complete data protection for all your healing journey needs and personal information.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Ayurvedic Image Gallery -->
    <section class="image-gallery">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title light">Experience Authentic Ayurveda</h2>
                <p class="section-desc" style="color: #cdd6b6;">
                    Witness the beauty and serenity of traditional Ayurvedic healing practices across India's finest wellness centres.
                </p>
            </div>
            
            <div class="gallery-container">
                <div class="gallery-item">
                    <img src="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Ayurvedic Treatment">
                    <div class="gallery-overlay">
                        <h4 class="gallery-title">Traditional Panchakarma</h4>
                        <p style="color: #f5e4c3;">Ancient detoxification and rejuvenation therapy</p>
                    </div>
                </div>
                
                <div class="gallery-item">
                    <img src="https://images.unsplash.com/photo-1599901860904-17e6ed7083a0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Yoga Practice">
                    <div class="gallery-overlay">
                        <h4 class="gallery-title">Yoga & Meditation</h4>
                        <p style="color: #f5e4c3">Mind-body balance and spiritual wellness</p>
                    </div>
                </div>
                
                <div class="gallery-item">
                    <img src="https://images.unsplash.com/photo-1540555700478-4be289fbecef?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Wellness Retreat">
                    <div class="gallery-overlay">
                        <h4 class="gallery-title">Herbal Medicine</h4>
                        <p style="color: #f5e4c3">Traditional herbal preparations and remedies</p>
                    </div>
                </div>
                
                <div class="gallery-item">
                    <img src="https://images.unsplash.com/photo-1518609878373-06d740f60d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Ayurvedic Massage">
                    <div class="gallery-overlay">
                        <h4 class="gallery-title">Therapeutic Massage</h4>
                        <p style="color: #f5e4c3">Traditional Abhyanga and body treatments</p>
                    </div>
                </div>
                
                <div class="gallery-item">
                    <img src="https://images.unsplash.com/photo-1540555700478-4be289fbecef?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Wellness Retreat">
                    <div class="gallery-overlay">
                        <h4 class="gallery-title">Wellness Retreats</h4>
                        <p style="color: #f5e4c3">Serene environments for holistic healing</p>
                    </div>
                </div>
                
                <div class="gallery-item">
                    <img src="https://images.unsplash.com/photo-1544161515-4ab6ce6db874?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Ayurvedic Consultation">
                    <div class="gallery-overlay">
                        <h4 class="gallery-title">Doctor Consultation</h4>
                        <p style="color: #f5e4c3">Personalized Ayurvedic diagnosis and treatment</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- What We Offer -->
    <section class="what-we-offer">
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">Comprehensive Services</p>
                <h2 class="section-title light">What We Offer</h2>
                <p class="section-desc" style="color: #f5e4c3;">
                    A complete ecosystem for discovering, comparing and booking authentic Ayurvedic healing experiences across India.
                </p>
            </div>
            
            <div class="offerings-container">
                <div class="offering-card">
                    <div class="offering-header">
                        <div class="offering-icon">
                            <i class="fas fa-hospital"></i>
                        </div>
                        <h3 class="offering-title">Ayurvedic Hospitals</h3>
                    </div>
                    <div class="offering-content">
                        <ul class="offering-list">
                            <li>NABH/NABL certified Ayurvedic hospitals</li>
                            <li>Expert physicians & advanced treatment plans</li>
                            <li>Panchakarma units & specialized therapy rooms</li>
                            <li>Complete inpatient & outpatient facilities</li>
                            <li>Post-treatment follow-up care programs</li>
                        </ul>
                    </div>
                </div>
                
                <div class="offering-card">
                    <div class="offering-header">
                        <div class="offering-icon">
                            <i class="fas fa-spa"></i>
                        </div>
                        <h3 class="offering-title">Wellness Retreats</h3>
                    </div>
                    <div class="offering-content">
                        <ul class="offering-list">
                            <li>Peaceful healing spaces across India</li>
                            <li>Yoga, meditation & naturopathy programs</li>
                            <li>Traditional Ayurvedic wellness retreats</li>
                            <li>Detox & rejuvenation programs</li>
                            <li>Spiritual guidance & lifestyle healing</li>
                        </ul>
                    </div>
                </div>
                
                <div class="offering-card">
                    <div class="offering-header">
                        <div class="offering-icon">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <h3 class="offering-title">Doctor Consultations</h3>
                    </div>
                    <div class="offering-content">
                        <ul class="offering-list">
                            <li>Certified Ayurveda physicians & specialists</li>
                            <li>Naturopaths & physiotherapists</li>
                            <li>Yogacharyas & meditation experts</li>
                            <li>Online consultations available worldwide</li>
                            <li>Second opinions & treatment reviews</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Healing Categories -->
    <section id="healing-categories" class="categories-section">
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">Specialized Healing</p>
                <h2 class="section-title">Top Healing Categories</h2>
                <p class="section-desc">
                    Find the perfect Ayurvedic treatment for your specific health needs and wellness goals.
                </p>
            </div>
            
            <div class="categories-grid">
                <div class="category-item">
                    <div class="category-icon">
                        <i class="fas fa-spa"></i>
                    </div>
                    <h4 class="category-title">Panchakarma Detox</h4>
                    <p class="category-desc">Complete body purification and rejuvenation programs</p>
                </div>
                
                <div class="category-item">
                    <div class="category-icon">
                        <i class="fas fa-brain"></i>
                    </div>
                    <h4 class="category-title">Stress Management</h4>
                    <p class="category-desc">Holistic approaches for mental peace and emotional balance</p>
                </div>
                
                <div class="category-item">
                    <div class="category-icon">
                        <i class="fas fa-weight"></i>
                    </div>
                    <h4 class="category-title">Weight Management</h4>
                    <p class="category-desc">Natural weight loss and metabolic correction</p>
                </div>
                
                <div class="category-item">
                    <div class="category-icon">
                        <i class="fas fa-bone"></i>
                    </div>
                    <h4 class="category-title">Joint Pain Care</h4>
                    <p class="category-desc">Traditional treatments for arthritis and joint health</p>
                </div>
                
                <div class="category-item">
                    <div class="category-icon">
                        <i class="fas fa-spine"></i>
                    </div>
                    <h4 class="category-title">Spine Treatment</h4>
                    <p class="category-desc">Comprehensive care for spinal health and posture</p>
                </div>
                
                <div class="category-item">
                    <div class="category-icon">
                        <i class="fas fa-hormone"></i>
                    </div>
                    <h4 class="category-title">Hormonal Balance</h4>
                    <p class="category-desc">Natural solutions for PCOS, Thyroid and hormonal issues</p>
                </div>
                
                <div class="category-item">
                    <div class="category-icon">
                        <i class="fas fa-heartbeat"></i>
                    </div>
                    <h4 class="category-title">Cardiac Care</h4>
                    <p class="category-desc">Ayurvedic management for heart health</p>
                </div>
                
                <div class="category-item">
                    <div class="category-icon">
                        <i class="fas fa-shield-virus"></i>
                    </div>
                    <h4 class="category-title">Immunity Boost</h4>
                    <p class="category-desc">Strengthen your natural defenses with Ayurveda</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials -->
    <section class="testimonials-section">
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">Success Stories</p>
                <h2 class="section-title light">What Our Patients Say</h2>
                <p class="section-desc" style="color: #f5e4c3;">
                    Real experiences from people who transformed their health through authentic Ayurvedic healing.
                </p>
            </div>
            
            <div class="testimonials-grid">
                <div class="testimonial-card">
                    <div class="testimonial-quote">"</div>
                    <p class="testimonial-text">
                        "After years of struggling with digestive issues, I found the perfect Ayurvedic centre through this platform. 
                        The 21-day Panchakarma program transformed my health completely."
                    </p>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Sarah Johnson">
                        </div>
                        <div class="author-info">
                            <h4>Sarah Johnson</h4>
                            <p>London, UK</p>
                        </div>
                    </div>
                </div>
                
                <div class="testimonial-card">
                    <div class="testimonial-quote">"</div>
                    <p class="testimonial-text">
                        "The transparent pricing and detailed information helped me choose the right wellness retreat. 
                        My stress levels reduced significantly after the 2-week yoga and meditation program."
                    </p>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Michael Chen">
                        </div>
                        <div class="author-info">
                            <h4>Michael Chen</h4>
                            <p>Singapore</p>
                        </div>
                    </div>
                </div>
                
                <div class="testimonial-card">
                    <div class="testimonial-quote">"</div>
                    <p class="testimonial-text">
                        "As an international patient, I was worried about finding authentic Ayurvedic treatment. 
                        This platform made everything so easy - from consultation to accommodation arrangements."
                    </p>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Priya Sharma">
                        </div>
                        <div class="author-info">
                            <h4>Priya Sharma</h4>
                            <p>Dubai, UAE</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container">
            <div class="cta-content">
                <h2 class="cta-title">Begin Your Healing Journey Today</h2>
                <p class="cta-desc">
                    Experience the transformative power of authentic Ayurveda. Whether you're in India or anywhere in the world, 
                    find the perfect healing centre and start your wellness journey with complete confidence.
                </p>
                <div style="margin-top: 50px;">
                    <a href="${pageContext.request.contextPath}/hospitals" 
                       class="btn-gold" 
                       style="font-size: 18px; padding: 18px 50px;">
                        Explore Healing Centres
                    </a>
                    <a href="${pageContext.request.contextPath}/user/register" 
                       class="btn-gold btn-outline" 
                       style="margin-left: 25px; font-size: 18px; padding: 18px 50px;">
                        Book Free Consultation
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer id="contact">
        <div class="container">
            <div class="footer-container">
                <div class="footer-col">
                    <h3>Ayurveda Wellness</h3>
                    <p style="margin-bottom: 20px; font-size: 17px; line-height: 1.8;">
                        Your trusted global gateway to authentic Ayurvedic healing. Connecting seekers with India's finest 
                        hospitals, ashrams, wellness centres and expert doctors for holistic wellness.
                    </p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="footer-col">
                    <h3>Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-chevron-right"></i> Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/about"><i class="fas fa-chevron-right"></i> About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/services"><i class="fas fa-chevron-right"></i> Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/terms and condition">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/private and policy">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact"><i class="fas fa-chevron-right"></i> Contact</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h3>For Centres</h3>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/hospital/register"><i class="fas fa-chevron-right"></i> Register Centre</a></li>
                        <li><a href="${pageContext.request.contextPath}/hospital/register"><i class="fas fa-chevron-right"></i> Partner With Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/hospital/login"><i class="fas fa-chevron-right"></i> Admin Login</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact"><i class="fas fa-chevron-right"></i> Support Centre</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h3>Contact Info</h3>
                    <ul class="footer-links">
                        <li><a href="tel:+911234567890"><i class="fas fa-phone"></i> +91 123 456 7890</a></li>
                        <li><a href="mailto:info@ayurvedawellness.com"><i class="fas fa-envelope"></i> info@ayurvedawellness.com</a></li>
                        <li><i class="fas fa-map-marker-alt"></i> Ayurveda Wellness, Kerala, India</li>
                        <li><i class="fas fa-clock"></i> Mon-Sun: 8:00 AM - 8:00 PM</li>
                    </ul>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2025 Ayurveda Wellness Platform. All rights reserved. | 
                   <a href="${pageContext.request.contextPath}/contact" style="color: #e6b55c; text-decoration: none;">Terms</a> • 
                   <a href="${pageContext.request.contextPath}/contact" style="color: #e6b55c; text-decoration: none;">Privacy</a> • 
                   <a href="${pageContext.request.contextPath}/contact" style="color: #e6b55c; text-decoration: none;">Support</a>
                </p>
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

        // Add animation on scroll
        const observerOptions = {
            threshold: 0.1
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animated');
                }
            });
        }, observerOptions);

        // Observe elements for animation
        document.querySelectorAll('.feature-card, .offering-card, .category-item, .testimonial-card').forEach(el => {
            observer.observe(el);
        });
    </script>
</body>
</html>
