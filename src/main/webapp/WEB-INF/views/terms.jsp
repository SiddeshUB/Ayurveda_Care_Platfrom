<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy | AyurVedaCare</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Nunito Sans', sans-serif;
            background: linear-gradient(135deg, #f8f9f5 0%, #e8f4e8 100%);
            color: #2c3e2c;
            line-height: 1.8;
            overflow-x: hidden;
        }

        /* Background Pattern */
        .bg-pattern {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z' fill='%23c7a369' fill-opacity='0.05' fill-rule='evenodd'/%3E%3C/svg%3E");
            opacity: 0.5;
            z-index: -1;
        }

        /* Header */
        .header {
            background: linear-gradient(135deg, rgba(44, 62, 44, 0.98), rgba(60, 80, 60, 0.95)),
                        url('https://images.unsplash.com/photo-1542744173-8e7e53415bb0?w=1600&auto=format&fit=crop&q=80&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') center/cover;
            color: white;
            padding: 40px 0 100px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 30% 20%, rgba(199, 163, 105, 0.2) 0%, transparent 50%),
                        radial-gradient(circle at 70% 80%, rgba(44, 62, 44, 0.2) 0%, transparent 50%);
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

        .nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 60px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .logo:hover {
            transform: translateY(-2px);
        }

        .logo i {
            color: #C7A369;
            font-size: 2rem;
        }

        .nav-links {
            display: flex;
            gap: 30px;
            list-style: none;
        }

        .nav-links a {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 8px 0;
            position: relative;
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: #C7A369;
            transition: width 0.3s ease;
        }

        .nav-links a:hover {
            color: white;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        .header-content {
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 0;
        }

        .header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #fff 0%, #C7A369 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .header-subtitle {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 40px;
            line-height: 1.6;
        }

        .header-badge {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: rgba(199, 163, 105, 0.2);
            color: #C7A369;
            padding: 12px 25px;
            border-radius: 30px;
            font-size: 0.9rem;
            font-weight: 600;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(199, 163, 105, 0.3);
        }

        /* Main Content */
        .privacy-container {
            padding: 100px 0;
            position: relative;
        }

        .privacy-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(44, 62, 44, 0.1);
            overflow: hidden;
            position: relative;
            margin-top: -80px;
        }

        .privacy-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #C7A369, #2c3e2c, #C7A369);
            background-size: 200% 100%;
            animation: shimmer 3s linear infinite;
        }

        @keyframes shimmer {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }

        .privacy-header {
            padding: 60px 60px 40px;
            background: linear-gradient(135deg, #f9f7f2 0%, #f1ede4 100%);
            border-bottom: 1px solid rgba(199, 163, 105, 0.2);
        }

        .privacy-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            color: #2c3e2c;
            margin-bottom: 20px;
        }

        .last-updated {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: #2c3e2c;
            color: white;
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .last-updated i {
            color: #C7A369;
        }

        /* Table of Contents */
        .toc-container {
            padding: 40px 60px;
            background: linear-gradient(135deg, #f5f8f5 0%, #eaf2ea 100%);
            border-bottom: 1px solid rgba(199, 163, 105, 0.2);
        }

        .toc-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: #2c3e2c;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .toc-title i {
            color: #C7A369;
            background: rgba(199, 163, 105, 0.1);
            padding: 12px;
            border-radius: 50%;
        }

        .toc-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
        }

        .toc-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 20px;
            background: white;
            border-radius: 12px;
            text-decoration: none;
            color: #2c3e2c;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .toc-item:hover {
            transform: translateY(-3px);
            border-color: #C7A369;
            box-shadow: 0 10px 20px rgba(199, 163, 105, 0.15);
        }

        .toc-item i {
            color: #C7A369;
            font-size: 1.2rem;
            background: rgba(199, 163, 105, 0.1);
            padding: 10px;
            border-radius: 50%;
        }

        .toc-item span {
            font-weight: 600;
            font-size: 1rem;
        }

        /* Content Sections */
        .content-section {
            padding: 60px;
            border-bottom: 1px solid rgba(199, 163, 105, 0.1);
            transition: all 0.3s ease;
        }

        .content-section:hover {
            background: linear-gradient(135deg, #fcfcf9 0%, #f9f7f2 100%);
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid rgba(199, 163, 105, 0.2);
        }

        .section-number {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #C7A369, #d4b378);
            color: white;
            border-radius: 50%;
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 600;
            box-shadow: 0 5px 15px rgba(199, 163, 105, 0.3);
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: #2c3e2c;
        }

        .section-content {
            color: #555;
            font-size: 1.1rem;
            line-height: 1.8;
        }

        .highlight-box {
            background: linear-gradient(135deg, #f9f7f2 0%, #f5f1e8 100%);
            border-left: 4px solid #C7A369;
            padding: 25px;
            margin: 25px 0;
            border-radius: 0 12px 12px 0;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .data-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 25px 0;
        }

        .data-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            border: 2px solid rgba(199, 163, 105, 0.2);
            transition: all 0.3s ease;
            text-align: center;
        }

        .data-card:hover {
            transform: translateY(-5px);
            border-color: #C7A369;
            box-shadow: 0 10px 30px rgba(199, 163, 105, 0.15);
        }

        .data-card i {
            font-size: 2rem;
            color: #C7A369;
            margin-bottom: 15px;
        }

        .data-card h4 {
            color: #2c3e2c;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }

        .feature-list {
            list-style: none;
            margin: 20px 0;
        }

        .feature-list li {
            padding: 12px 0 12px 40px;
            position: relative;
            margin-bottom: 10px;
        }

        .feature-list li::before {
            content: '✓';
            position: absolute;
            left: 15px;
            color: #C7A369;
            font-weight: bold;
            font-size: 1.2rem;
        }

        /* Cookie Types */
        .cookie-types {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin: 30px 0;
        }

        .cookie-type {
            background: white;
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            border: 2px solid;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .cookie-type::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: currentColor;
            opacity: 0.3;
        }

        .cookie-type:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
        }

        .cookie-type i {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        .cookie-type h4 {
            font-size: 1.2rem;
            margin-bottom: 15px;
            color: #2c3e2c;
        }

        .cookie-type.essential {
            border-color: #4caf50;
            color: #4caf50;
        }

        .cookie-type.analytics {
            border-color: #2196f3;
            color: #2196f3;
        }

        .cookie-type.functional {
            border-color: #ff9800;
            color: #ff9800;
        }

        /* Contact Section */
        .contact-section {
            background: linear-gradient(135deg, #2c3e2c, #3a523a);
            color: white;
            padding: 60px;
            border-radius: 20px;
            margin: 60px 0;
            position: relative;
            overflow: hidden;
        }

        .contact-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z' fill='%23c7a369' fill-opacity='0.1' fill-rule='evenodd'/%3E%3C/svg%3E");
            opacity: 0.1;
        }

        .contact-section h3 {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            margin-bottom: 20px;
            color: white;
        }

        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .contact-item {
            background: rgba(255, 255, 255, 0.1);
            padding: 25px;
            border-radius: 12px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(199, 163, 105, 0.3);
        }

        .contact-item i {
            font-size: 2rem;
            color: #C7A369;
            margin-bottom: 15px;
        }

        /* Footer Navigation */
        .footer-nav {
            padding: 40px 60px;
            background: linear-gradient(135deg, #f5f8f5 0%, #eaf2ea 100%);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-button {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 18px 35px;
            background: linear-gradient(135deg, #2c3e2c, #3a523a);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .nav-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(44, 62, 44, 0.3);
        }

        .nav-button i {
            font-size: 1.2rem;
        }

        .nav-button.home {
            background: linear-gradient(135deg, #C7A369, #d4b378);
        }

        .nav-button.home:hover {
            box-shadow: 0 15px 30px rgba(199, 163, 105, 0.3);
        }

        /* Footer */
        .footer {
            background: linear-gradient(135deg, #2c3e2c, #1f2a1f);
            color: rgba(255, 255, 255, 0.9);
            padding: 60px 0 30px;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-bottom: 40px;
        }

        .footer-col h4 {
            color: #C7A369;
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            margin-bottom: 25px;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 12px;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .footer-links a:hover {
            color: #C7A369;
            padding-left: 5px;
        }

        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border-radius: 50%;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            background: #C7A369;
            transform: translateY(-3px);
        }

        .copyright {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .header h1 {
                font-size: 2.8rem;
            }
            
            .nav-links {
                display: none;
            }
            
            .content-section, .privacy-header, .toc-container {
                padding: 40px;
            }
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2.2rem;
            }
            
            .header-subtitle {
                font-size: 1.1rem;
            }
            
            .section-title {
                font-size: 1.5rem;
            }
            
            .footer-nav {
                flex-direction: column;
                gap: 20px;
            }
            
            .nav-button {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .content-section, .privacy-header, .toc-container {
                padding: 30px 20px;
            }
            
            .header {
                padding: 30px 0 80px;
            }
            
            .toc-grid {
                grid-template-columns: 1fr;
            }
            
            .data-grid, .cookie-types {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="bg-pattern"></div>
    
    <!-- Header -->
    <header class="header">
        <div class="container">
            <nav class="nav">
                <a href="${pageContext.request.contextPath}/" class="logo">
                    <i class="fas fa-leaf"></i>
                    <span>AyurVedaCare</span>
                </a>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                    <li><a href="${pageContext.request.contextPath}/user/login">Login</a></li>
                </ul>
            </nav>
            
            <div class="header-content">
                <h1>Privacy & Data Protection</h1>
                <p class="header-subtitle">
                    Your privacy is sacred to us. We're committed to protecting your personal information 
                    with the same care we approach Ayurvedic healing - with integrity, respect, and complete transparency.
                </p>
                <div class="header-badge">
                    <i class="fas fa-shield-alt"></i>
                    <span>Last Updated: January 2024</span>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="privacy-container">
        <div class="container">
            <div class="privacy-card">
                <!-- Header -->
                <div class="privacy-header">
                    <h2>Our Commitment to Your Privacy</h2>
                    <p class="section-content">
                        At AyurVedaCare, we believe that privacy is a fundamental right. This Privacy Policy explains how we collect, use, 
                        disclose, and safeguard your information when you use our Ayurvedic healthcare platform. Please read this policy 
                        carefully to understand our views and practices regarding your personal data.
                    </p>
                    <div class="last-updated">
                        <i class="fas fa-history"></i>
                        <span>Effective Date: January 1, 2024</span>
                    </div>
                </div>

                <!-- Table of Contents -->
                <div class="toc-container">
                    <h3 class="toc-title">
                        <i class="fas fa-list-alt"></i>
                        Table of Contents
                    </h3>
                    <div class="toc-grid">
                        <a href="#information-collected" class="toc-item">
                            <i class="fas fa-database"></i>
                            <span>Information We Collect</span>
                        </a>
                        <a href="#how-we-use" class="toc-item">
                            <i class="fas fa-cogs"></i>
                            <span>How We Use Information</span>
                        </a>
                        <a href="#data-sharing" class="toc-item">
                            <i class="fas fa-share-alt"></i>
                            <span>Data Sharing & Disclosure</span>
                        </a>
                        <a href="#data-security" class="toc-item">
                            <i class="fas fa-shield-alt"></i>
                            <span>Data Security</span>
                        </a>
                        <a href="#your-rights" class="toc-item">
                            <i class="fas fa-user-check"></i>
                            <span>Your Rights</span>
                        </a>
                        <a href="#cookies" class="toc-item">
                            <i class="fas fa-cookie-bite"></i>
                            <span>Cookies Policy</span>
                        </a>
                        <a href="#retention" class="toc-item">
                            <i class="fas fa-history"></i>
                            <span>Data Retention</span>
                        </a>
                        <a href="#contact" class="toc-item">
                            <i class="fas fa-headset"></i>
                            <span>Contact Us</span>
                        </a>
                    </div>
                </div>

                <!-- Section 1: Information Collected -->
                <div class="content-section" id="information-collected">
                    <div class="section-header">
                        <div class="section-number">1</div>
                        <h3 class="section-title">Information We Collect</h3>
                    </div>
                    <div class="section-content">
                        <p>We collect information to provide you with personalized Ayurvedic healthcare services:</p>
                        
                        <div class="highlight-box">
                            <h4><i class="fas fa-user-circle"></i> Personal Information You Provide</h4>
                            <p>When you register, book appointments, or use our services, we collect:</p>
                        </div>
                        
                        <div class="data-grid">
                            <div class="data-card">
                                <i class="fas fa-user"></i>
                                <h4>Basic Information</h4>
                                <p>Name, email, phone number, date of birth</p>
                            </div>
                            <div class="data-card">
                                <i class="fas fa-heartbeat"></i>
                                <h4>Health Information</h4>
                                <p>Medical history, dosha type, health concerns</p>
                            </div>
                            <div class="data-card">
                                <i class="fas fa-map-marker-alt"></i>
                                <h4>Location Data</h4>
                                <p>For finding nearby Ayurvedic centers</p>
                            </div>
                            <div class="data-card">
                                <i class="fas fa-credit-card"></i>
                                <h4>Payment Information</h4>
                                <p>Secure payment processing</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Section 2: How We Use Information -->
                <div class="content-section" id="how-we-use">
                    <div class="section-header">
                        <div class="section-number">2</div>
                        <h3 class="section-title">How We Use Your Information</h3>
                    </div>
                    <div class="section-content">
                        <p>Your information helps us provide and improve our Ayurvedic healthcare services:</p>
                        
                        <ul class="feature-list">
                            <li><strong>Personalized Recommendations:</strong> Match you with appropriate Ayurvedic practitioners based on your dosha and health needs</li>
                            <li><strong>Appointment Management:</strong> Schedule and manage your Ayurvedic consultations and treatments</li>
                            <li><strong>Service Improvement:</strong> Enhance platform features and user experience</li>
                            <li><strong>Communication:</strong> Send important updates, reminders, and health tips</li>
                            <li><strong>Security:</strong> Protect your account and prevent fraudulent activities</li>
                            <li><strong>Compliance:</strong> Meet legal and regulatory requirements</li>
                        </ul>
                        
                        <div class="highlight-box">
                            <p><i class="fas fa-exclamation-circle"></i> <strong>Important:</strong> We never sell your personal health information. Data sharing with healthcare providers only occurs with your explicit consent.</p>
                        </div>
                    </div>
                </div>

                <!-- Section 3: Data Security -->
                <div class="content-section" id="data-security">
                    <div class="section-header">
                        <div class="section-number">3</div>
                        <h3 class="section-title">Data Security Measures</h3>
                    </div>
                    <div class="section-content">
                        <p>We implement enterprise-grade security measures to protect your sensitive health data:</p>
                        
                        <div class="data-grid">
                            <div class="data-card">
                                <i class="fas fa-lock"></i>
                                <h4>End-to-End Encryption</h4>
                                <p>All health data encrypted in transit and at rest</p>
                            </div>
                            <div class="data-card">
                                <i class="fas fa-server"></i>
                                <h4>Secure Infrastructure</h4>
                                <p>ISO 27001 certified data centers</p>
                            </div>
                            <div class="data-card">
                                <i class="fas fa-user-shield"></i>
                                <h4>Access Controls</h4>
                                <p>Role-based access and authentication</p>
                            </div>
                            <div class="data-card">
                                <i class="fas fa-sync-alt"></i>
                                <h4>Regular Audits</h4>
                                <p>Continuous security monitoring</p>
                            </div>
                        </div>
                        
                        <div class="highlight-box">
                            <p><i class="fas fa-shield-alt"></i> <strong>Our Security Commitment:</strong> We treat your health data with the same confidentiality that Ayurvedic practitioners have maintained for centuries. Regular security audits ensure we maintain the highest standards of data protection.</p>
                        </div>
                    </div>
                </div>

                <!-- Section 4: Cookies Policy -->
                <div class="content-section" id="cookies">
                    <div class="section-header">
                        <div class="section-number">4</div>
                        <h3 class="section-title">Cookies & Tracking Technologies</h3>
                    </div>
                    <div class="section-content">
                        <p>We use cookies and similar technologies to enhance your browsing experience:</p>
                        
                        <div class="cookie-types">
                            <div class="cookie-type essential">
                                <i class="fas fa-check-circle"></i>
                                <h4>Essential Cookies</h4>
                                <p>Required for platform functionality, security, and account access</p>
                            </div>
                            <div class="cookie-type analytics">
                                <i class="fas fa-chart-line"></i>
                                <h4>Analytics Cookies</h4>
                                <p>Help us understand how users interact with our platform</p>
                            </div>
                            <div class="cookie-type functional">
                                <i class="fas fa-cog"></i>
                                <h4>Functional Cookies</h4>
                                <p>Remember your preferences and settings</p>
                            </div>
                        </div>
                        
                        <p>You can control cookie settings through your browser preferences. Disabling essential cookies may affect platform functionality.</p>
                    </div>
                </div>

                <!-- Contact Section -->
                <div class="contact-section" id="contact">
                    <h3>Contact Our Privacy Team</h3>
                    <p>For privacy-related inquiries, data requests, or concerns about how we handle your information:</p>
                    
                    <div class="contact-grid">
                        <div class="contact-item">
                            <i class="fas fa-user-shield"></i>
                            <h4>Data Protection Officer</h4>
                            <p>dpo@ayurvedacare.com</p>
                            <p>+91-XXX-XXX-XXXX</p>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-envelope"></i>
                            <h4>General Inquiries</h4>
                            <p>privacy@ayurvedacare.com</p>
                            <p>Response within 48 hours</p>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <h4>Office Address</h4>
                            <p>AyurVedaCare Privacy Office</p>
                            <p>Delhi, India</p>
                        </div>
                    </div>
                </div>

                <!-- Footer Navigation -->
                <div class="footer-nav">
                    <a href="${pageContext.request.contextPath}/" class="nav-button home">
                        <i class="fas fa-home"></i>
                        <span>Back to Home</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/terms-and-conditions" class="nav-button">
                        <i class="fas fa-file-contract"></i>
                        <span>View Terms & Conditions</span>
                    </a>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <h4>AyurVedaCare</h4>
                    <p>Connecting you with authentic Ayurvedic healthcare providers for holistic wellness and natural healing.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="footer-col">
                    <h4>Quick Links</h4>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Legal</h4>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/terms-and-conditions">Terms & Conditions</a></li>
                        <li><a href="${pageContext.request.contextPath}/privacy-policy" style="color: #C7A369;">Privacy Policy</a></li>
                        <li><a href="<%=request.getContextPath()%>/views/refund-policy.jsp">Refund Policy</a></li>
                        <li><a href="<%=request.getContextPath()%>/views/disclaimer.jsp">Disclaimer</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Contact Info</h4>
                    <ul class="footer-links">
                        <li><i class="fas fa-phone"></i> +91-123-456-7890</li>
                        <li><i class="fas fa-envelope"></i> info@ayurvedacare.com</li>
                        <li><i class="fas fa-map-marker-alt"></i> Delhi, India</li>
                    </ul>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2024 AyurVedaCare. All rights reserved. | <a href="${pageContext.request.contextPath}/privacy-policy" style="color: #C7A369;">Privacy Policy</a></p>
            </div>
        </div>
    </footer>

    <script>
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const targetId = this.getAttribute('href');
                if (targetId === '#') return;
                
                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop - 100,
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Add animation to sections when they come into view
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        });

        // Observe all content sections
        document.querySelectorAll('.content-section').forEach(section => {
            section.style.opacity = '0';
            section.style.transform = 'translateY(30px)';
            section.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(section);
        });

        // Interactive cookie cards
        document.querySelectorAll('.cookie-type').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-10px) scale(1.02)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(-5px) scale(1.02)';
            });
        });

        // Table of contents item hover effect
        document.querySelectorAll('.toc-item').forEach(item => {
            item.addEventListener('mouseenter', function() {
                const icon = this.querySelector('i');
                icon.style.transform = 'rotate(15deg) scale(1.2)';
            });
            
            item.addEventListener('mouseleave', function() {
                const icon = this.querySelector('i');
                icon.style.transform = 'rotate(0) scale(1)';
            });
        });

        // Update current year in footer
        document.addEventListener('DOMContentLoaded', function() {
            const yearSpan = document.querySelector('.copyright p');
            if (yearSpan) {
                yearSpan.innerHTML = yearSpan.innerHTML.replace('2024', new Date().getFullYear());
            }
        });
    </script>
</body>
</html>