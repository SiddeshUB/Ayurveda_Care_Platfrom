<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Ayurvedic Doctors - Ayurveda Wellness</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-dark: #1a2e1a;
            --primary-green: #2d4a2d;
            --accent-gold: #c9a227;
            --accent-gold-light: #e6b55c;
            --text-light: #f5f0e8;
            --text-cream: #e8dcc8;
            --bg-cream: #fdfaf4;
            --bg-dark: #0a0f0a;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        html {
            scroll-behavior: smooth;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--bg-cream);
            color: #333;
            line-height: 1.7;
            overflow-x: hidden;
        }
        
        h1, h2, h3, h4, h5 {
            font-family: 'Cormorant Garamond', serif;
            font-weight: 600;
        }
        
        /* ========== NAVBAR ========== */
        .navbar {
            background: rgba(26, 46, 26, 0.98);
            padding: 15px 0;
            transition: all 0.4s ease;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            backdrop-filter: blur(10px);
        }
        
        .navbar.scrolled {
            padding: 10px 0;
            box-shadow: 0 5px 30px rgba(0,0,0,0.3);
        }
        
        .navbar-brand {
            font-family: 'Cormorant Garamond', serif;
            font-size: 28px;
            font-weight: 700;
            color: var(--accent-gold) !important;
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
            margin: 0 2px;
            transition: all 0.3s ease;
            position: relative;
            white-space: nowrap;
        }
        
        .navbar-nav .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background: var(--accent-gold);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }
        
        .navbar-nav .nav-link:hover::after,
        .navbar-nav .nav-link.active::after {
            width: 70%;
        }
        
        .navbar-nav .nav-link:hover,
        .navbar-nav .nav-link.active {
            color: var(--accent-gold) !important;
        }
        
        .btn-nav {
            background: linear-gradient(135deg, var(--accent-gold) 0%, var(--accent-gold-light) 100%);
            color: var(--primary-dark) !important;
            padding: 10px 25px !important;
            border-radius: 30px;
            font-weight: 600;
            margin-left: 10px;
            transition: all 0.4s ease;
            border: none;
        }
        
        .btn-nav:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(201, 162, 39, 0.4);
            color: var(--primary-dark) !important;
        }
        
        .btn-nav::after {
            display: none;
        }
        
        .navbar-toggler {
            border: none;
            padding: 0;
        }
        
        .navbar-toggler:focus {
            box-shadow: none;
        }
        
        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(201, 162, 39, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }
        
        /* User Dropdown */
        .user-dropdown .dropdown-toggle {
            background: rgba(201, 162, 39, 0.15);
            border-radius: 30px;
            padding: 8px 20px !important;
        }
        
        .user-dropdown .dropdown-toggle::after {
            display: none;
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
            background: rgba(201, 162, 39, 0.1);
            color: var(--accent-gold);
        }
        
        .user-dropdown .dropdown-item i {
            width: 20px;
            margin-right: 10px;
            color: var(--accent-gold);
        }
        
        /* ========== PAGE HERO ========== */
        .page-hero {
            background: linear-gradient(135deg, rgba(10, 15, 10, 0.9) 0%, rgba(26, 46, 26, 0.85) 100%),
                      url('https://images.unsplash.com/photo-1600508774634-4e11d34730e2?auto=format&fit=crop&w=1920&q=85')

 center/cover;

 center/cover;
            padding: 180px 0 100px;
            text-align: center;
            position: relative;
        }
        
       .page-hero::before {
    background: linear-gradient(to top, var(--bg-cream), transparent);
}
/* FIX: Dark fade instead of white */
.page-hero::before {
    background: linear-gradient(
        to top,
        #0a0f0a 0%,
        rgba(10, 15, 10, 0.95) 30%,
        rgba(10, 15, 10, 0.6) 60%,
        transparent 100%
    );
}

        
        .page-hero-badge {
            display: inline-block;
            background: rgba(201, 162, 39, 0.2);
            border: 1px solid rgba(201, 162, 39, 0.4);
            padding: 8px 25px;
            border-radius: 30px;
            color: var(--accent-gold);
            font-size: 14px;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 20px;
        }
        
        .page-hero h1 {
            font-size: 56px;
            color: #fff;
            margin-bottom: 20px;
        }
        
        .page-hero p {
            color: rgba(255,255,255,0.8);
            font-size: 18px;
            max-width: 600px;
            margin: 0 auto 40px;
        }
        
        /* Search Box */
        .search-box {
            max-width: 700px;
            margin: 0 auto;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(201, 162, 39, 0.3);
            border-radius: 60px;
            padding: 8px;
            display: flex;
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        }
        
        .search-box input {
            flex: 1;
            border: none;
            background: transparent;
            padding: 15px 25px;
            font-size: 16px;
            color: #fff;
            outline: none;
        }
        
        .search-box input::placeholder {
            color: rgba(255,255,255,0.6);
        }
        
        .search-box button {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            border: none;
            padding: 15px 35px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.4s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .search-box button:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 30px rgba(201, 162, 39, 0.4);
        }
        
        /* ========== SPECIALIZATIONS SECTION ========== */
        .specializations-section {
            background: #fff;
            padding: 30px 0;
            border-bottom: 1px solid rgba(201, 162, 39, 0.1);
        }
        
        .spec-scroll {
            display: flex;
            gap: 15px;
            overflow-x: auto;
            padding: 10px 0;
            scrollbar-width: none;
        }
        
        .spec-scroll::-webkit-scrollbar {
            display: none;
        }
        
        .spec-chip {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 24px;
            border-radius: 50px;
            background: rgba(201, 162, 39, 0.08);
            border: 2px solid transparent;
            white-space: nowrap;
            transition: all 0.3s ease;
            cursor: pointer;
            font-weight: 500;
            color: var(--primary-dark);
        }
        
        .spec-chip:hover,
        .spec-chip.active {
            background: var(--accent-gold);
            color: var(--primary-dark);
            border-color: var(--accent-gold);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(201, 162, 39, 0.3);
        }
        
        .spec-chip i {
            font-size: 18px;
            color: var(--accent-gold);
        }
        
        .spec-chip:hover i,
        .spec-chip.active i {
            color: var(--primary-dark);
        }
        
        /* ========== DOCTORS SECTION ========== */
        .doctors-section {
            padding: 60px 0 100px;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .section-header h2 {
            font-size: 36px;
            color: var(--primary-dark);
            margin: 0;
        }
        
        .results-info {
            color: #888;
            font-size: 15px;
        }
        
        .results-info strong {
            color: var(--accent-gold);
            font-weight: 600;
        }
        
        /* ========== DOCTOR CARD ========== */
        .doctor-card {
            background: #fff;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(201, 162, 39, 0.1);
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        
        .doctor-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 30px 60px rgba(0,0,0,0.15);
            border-color: rgba(201, 162, 39, 0.3);
        }
        
        .doctor-photo {
            position: relative;
            height: 280px;
            overflow: hidden;
            background: linear-gradient(135deg, var(--primary-green) 0%, var(--primary-dark) 100%);
        }
        
        .doctor-photo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s ease;
        }
        
        .doctor-card:hover .doctor-photo img {
            transform: scale(1.1);
        }
        
        .doctor-photo .placeholder-icon {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 80px;
            color: rgba(255,255,255,0.2);
        }
        
        .doctor-photo::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(to bottom, transparent 40%, rgba(0,0,0,0.8));
            z-index: 1;
            opacity: 0;
            transition: opacity 0.4s ease;
        }
        
        .doctor-card:hover .doctor-photo::before {
            opacity: 1;
        }
        
        /* Badges on Photo */
        .doctor-badges {
            position: absolute;
            top: 15px;
            left: 15px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            z-index: 2;
        }
        
        .badge-verified {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            color: #fff;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .badge-experience {
            background: rgba(0,0,0,0.6);
            backdrop-filter: blur(10px);
            color: #fff;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        
        /* Rating Badge */
        .doctor-rating {
            position: absolute;
            bottom: 15px;
            right: 15px;
            background: #fff;
            padding: 8px 15px;
            border-radius: 30px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
            z-index: 2;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .doctor-rating i {
            color: var(--accent-gold);
        }
        
        .doctor-rating span {
            color: var(--primary-dark);
        }
        
        /* Doctor Body */
        .doctor-body {
            padding: 25px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        .doctor-name {
            font-size: 24px;
            color: var(--primary-dark);
            margin-bottom: 5px;
            transition: color 0.3s ease;
        }
        
        .doctor-card:hover .doctor-name {
            color: var(--accent-gold);
        }
        
        .doctor-qualifications {
            color: var(--primary-green);
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .doctor-qualifications i {
            color: var(--accent-gold);
        }
        
        .doctor-specializations {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 15px;
            flex: 1;
        }
        
        .doctor-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
            padding: 15px 0;
            border-top: 1px solid rgba(201, 162, 39, 0.15);
            border-bottom: 1px solid rgba(201, 162, 39, 0.15);
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            color: #666;
        }
        
        .meta-item i {
            color: var(--accent-gold);
            font-size: 14px;
        }
        
        .doctor-hospital {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 15px;
            background: rgba(201, 162, 39, 0.08);
            border-radius: 12px;
            margin-bottom: 20px;
        }
        
        .doctor-hospital i {
            color: var(--accent-gold);
            font-size: 18px;
        }
        
        .doctor-hospital span {
            font-size: 13px;
            color: var(--primary-dark);
            font-weight: 500;
        }
        
        /* Action Buttons */
        .doctor-actions {
            display: flex;
            gap: 10px;
            margin-top: auto;
        }
        
        .btn-profile {
            flex: 1;
            padding: 14px 20px;
            border-radius: 12px;
            border: 2px solid rgba(201, 162, 39, 0.3);
            background: transparent;
            color: var(--primary-dark);
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s ease;
        }
        
        .btn-profile:hover {
            background: rgba(201, 162, 39, 0.1);
            border-color: var(--accent-gold);
            color: var(--accent-gold);
        }
        
        .btn-book {
            flex: 1;
            padding: 14px 20px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            transition: all 0.4s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn-book:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(201, 162, 39, 0.4);
            color: var(--primary-dark);
        }
        
        /* ========== EMPTY STATE ========== */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: #fff;
            border-radius: 24px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
        }
        
        .empty-state-icon {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: rgba(201, 162, 39, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
        }
        
        .empty-state-icon i {
            font-size: 50px;
            color: var(--accent-gold);
        }
        
        .empty-state h3 {
            font-size: 28px;
            color: var(--primary-dark);
            margin-bottom: 15px;
        }
        
        .empty-state p {
            color: #888;
            margin-bottom: 30px;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }
        
        /* ========== CTA SECTION ========== */
        .cta-section {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--bg-dark) 100%);
            padding: 80px 0;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .cta-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23c9a227' fill-opacity='0.05'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
        }
        
        .cta-content {
            position: relative;
            z-index: 1;
        }
        
        .cta-section h2 {
            font-size: 42px;
            color: #fff;
            margin-bottom: 20px;
        }
        
        .cta-section p {
            color: rgba(255,255,255,0.7);
            font-size: 18px;
            max-width: 600px;
            margin: 0 auto 30px;
        }
        
        .btn-cta {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            padding: 16px 40px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.4s ease;
        }
        
        .btn-cta:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(201, 162, 39, 0.4);
            color: var(--primary-dark);
        }
        
        /* ========== FOOTER ========== */
        .footer {
            background: linear-gradient(180deg, var(--primary-dark) 0%, #0d170d 100%);
            padding: 80px 0 30px;
            color: var(--text-cream);
        }
        
        .footer-brand {
            font-family: 'Cormorant Garamond', serif;
            font-size: 32px;
            color: var(--accent-gold);
            margin-bottom: 20px;
        }
        
        .footer-desc {
            color: rgba(255,255,255,0.7);
            line-height: 1.8;
            margin-bottom: 25px;
        }
        
        .footer h5 {
            color: var(--accent-gold);
            font-size: 20px;
            margin-bottom: 25px;
            font-family: 'Cormorant Garamond', serif;
        }
        
        .footer-links {
            list-style: none;
            padding: 0;
        }
        
        .footer-links li {
            margin-bottom: 12px;
        }
        
        .footer-links a {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .footer-links a:hover {
            color: var(--accent-gold);
            padding-left: 10px;
        }
        
        .social-icons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }
        
        .social-icons a {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: rgba(201, 162, 39, 0.1);
            border: 1px solid rgba(201, 162, 39, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-gold);
            transition: all 0.4s ease;
        }
        
        .social-icons a:hover {
            background: var(--accent-gold);
            color: var(--primary-dark);
            transform: translateY(-5px);
        }
        
        .footer-bottom {
            border-top: 1px solid rgba(201, 162, 39, 0.1);
            padding-top: 30px;
            margin-top: 50px;
            text-align: center;
            color: rgba(255,255,255,0.5);
        }
        
        /* ========== BACK TO TOP ========== */
        .back-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            border: none;
            border-radius: 50%;
            cursor: pointer;
            opacity: 0;
            visibility: hidden;
            transform: translateY(20px);
            transition: all 0.4s ease;
            z-index: 999;
            box-shadow: 0 5px 25px rgba(201, 162, 39, 0.4);
        }
        
        .back-to-top.visible {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }
        
        .back-to-top:hover {
            transform: translateY(-5px);
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
        
        /* ========== RESPONSIVE ========== */
        @media (max-width: 991px) {
            .page-hero h1 {
                font-size: 40px;
            }
            
            .navbar-collapse {
                background: rgba(26, 46, 26, 0.98);
                padding: 20px;
                border-radius: 15px;
                margin-top: 15px;
            }
            
            .section-header {
                flex-direction: column;
                text-align: center;
            }
        }
        
        @media (max-width: 767px) {
            .page-hero {
                padding: 140px 0 80px;
            }
            
            .page-hero h1 {
                font-size: 32px;
            }
            
            .search-box {
                flex-direction: column;
                border-radius: 20px;
                padding: 15px;
            }
            
            .search-box input {
                text-align: center;
                margin-bottom: 10px;
            }
            
            .search-box button {
                width: 100%;
                justify-content: center;
            }
            
            .doctor-actions {
                flex-direction: column;
            }
            
            .cta-section h2 {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-leaf me-2"></i>Ayurveda Wellness
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-lg-center">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/hospitals">Find Centers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/doctors">Find Doctors</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products"></i>Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/about">About Us</a>
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
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/saved-centers"><i class="fas fa-heart"></i>Saved Centers</a></li>
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

    <!-- Page Hero -->
    <section class="page-hero">
        <div class="container">
            <span class="page-hero-badge" data-aos="fade-down">Expert Practitioners</span>
            <h1 data-aos="fade-up" data-aos-delay="100">Find Ayurvedic Doctors</h1>
            <p data-aos="fade-up" data-aos-delay="200">Connect with experienced and verified Ayurvedic practitioners for personalized holistic healthcare</p>
            
            <form action="${pageContext.request.contextPath}/doctors" method="get" class="search-box" data-aos="fade-up" data-aos-delay="300">
                <input type="text" name="search" value="${search}" placeholder="Search by name, specialization, or location..." autocomplete="off">
                <button type="submit">
                    <i class="fas fa-search"></i>
                    <span>Search</span>
                </button>
            </form>
        </div>
    </section>

    <!-- Specializations Filter -->
    <section class="specializations-section">
        <div class="container">
            <div class="spec-scroll">
                <div class="spec-chip active">
                    <i class="fas fa-th-large"></i>
                    <span>All Doctors</span>
                </div>
                <div class="spec-chip">
                    <i class="fas fa-spa"></i>
                    <span>Panchakarma</span>
                </div>
                <div class="spec-chip">
                    <i class="fas fa-leaf"></i>
                    <span>Herbal Medicine</span>
                </div>
                <div class="spec-chip">
                    <i class="fas fa-heart"></i>
                    <span>Cardiology</span>
                </div>
                <div class="spec-chip">
                    <i class="fas fa-brain"></i>
                    <span>Neurology</span>
                </div>
                <div class="spec-chip">
                    <i class="fas fa-bone"></i>
                    <span>Orthopedics</span>
                </div>
                <div class="spec-chip">
                    <i class="fas fa-female"></i>
                    <span>Women's Health</span>
                </div>
                <div class="spec-chip">
                    <i class="fas fa-child"></i>
                    <span>Pediatrics</span>
                </div>
                <div class="spec-chip">
                    <i class="fas fa-smile"></i>
                    <span>Skin Care</span>
                </div>
            </div>
        </div>
    </section>

    <!-- Doctors Section -->
    <section class="doctors-section">
        <div class="container">
            <div class="section-header" data-aos="fade-up">
                <h2>Available Doctors</h2>
                <div class="results-info">
                    <c:choose>
                        <c:when test="${not empty doctors}">
                            <strong>${fn:length(doctors)}</strong> doctor<c:if test="${fn:length(doctors) != 1}">s</c:if> found
                            <c:if test="${not empty search}"> for "<strong>${search}</strong>"</c:if>
                        </c:when>
                        <c:otherwise>
                            No doctors found
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty doctors}">
                    <div class="row g-4">
                        <c:forEach var="doctor" items="${doctors}" varStatus="status">
                            <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="${status.index % 3 * 100}">
                                <div class="doctor-card">
                                    <div class="doctor-photo">
                                        <c:choose>
                                            <c:when test="${not empty doctor.photoUrl}">
                                                <img src="${pageContext.request.contextPath}${doctor.photoUrl}" alt="${doctor.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-user-md placeholder-icon"></i>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <div class="doctor-badges">
                                            <span class="badge-verified">
                                                <i class="fas fa-check-circle"></i> Verified
                                            </span>
                                            <c:if test="${doctor.experienceYears != null && doctor.experienceYears > 0}">
                                                <span class="badge-experience">
                                                    <i class="fas fa-award"></i> ${doctor.experienceYears}+ Years Exp
                                                </span>
                                            </c:if>
                                        </div>
                                        
                                        <div class="doctor-rating">
                                            <i class="fas fa-star"></i>
                                            <span>4.8</span>
                                        </div>
                                    </div>
                                    
                                    <div class="doctor-body">
                                        <h3 class="doctor-name">${doctor.name}</h3>
                                        
                                        <div class="doctor-qualifications">
                                            <i class="fas fa-graduation-cap"></i>
                                            ${doctor.qualifications}
                                        </div>
                                        
                                        <c:if test="${not empty doctor.specializations}">
                                            <div class="doctor-specializations">
                                                ${fn:substring(doctor.specializations, 0, 100)}${fn:length(doctor.specializations) > 100 ? '...' : ''}
                                            </div>
                                        </c:if>
                                        
                                        <div class="doctor-meta">
                                            <c:if test="${not empty doctor.availableLocations}">
                                                <div class="meta-item">
                                                    <i class="fas fa-map-marker-alt"></i>
                                                    <span>${fn:substring(doctor.availableLocations, 0, 25)}${fn:length(doctor.availableLocations) > 25 ? '...' : ''}</span>
                                                </div>
                                            </c:if>
                                            <div class="meta-item">
                                                <i class="fas fa-clock"></i>
                                                <span>Mon - Sat</span>
                                            </div>
                                            <div class="meta-item">
                                                <i class="fas fa-video"></i>
                                                <span>Video Consult</span>
                                            </div>
                                        </div>
                                        
                                        <c:if test="${not empty doctor.hospital}">
                                            <div class="doctor-hospital">
                                                <i class="fas fa-hospital"></i>
                                                <span>${doctor.hospital.centerName}</span>
                                            </div>
                                        </c:if>
                                        
                                        <div class="doctor-actions">
                                            <a href="${pageContext.request.contextPath}/doctor/profile/${doctor.id}" class="btn-profile">
                                                View Profile
                                            </a>
                                            <a href="${pageContext.request.contextPath}/consultation/book/${doctor.id}" class="btn-book">
                                                <i class="fas fa-calendar-check"></i> Book Now
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" data-aos="fade-up">
                        <div class="empty-state-icon">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <h3>No Doctors Found</h3>
                        <p>
                            <c:choose>
                                <c:when test="${not empty search}">
                                    No doctors match your search criteria. Try different keywords or browse all doctors.
                                </c:when>
                                <c:otherwise>
                                    There are no doctors available at the moment. Please check back later.
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/doctors" class="btn-book" style="display: inline-flex;">
                            <i class="fas fa-th-large"></i> View All Doctors
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container">
            <div class="cta-content" data-aos="fade-up">
                <h2>Are You an Ayurvedic Doctor?</h2>
                <p>Join our network of trusted practitioners and connect with patients seeking authentic Ayurvedic care</p>
                <a href="${pageContext.request.contextPath}/doctor/register" class="btn-cta">
                    <i class="fas fa-user-plus"></i> Register as Doctor
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-5">
                <div class="col-lg-4" data-aos="fade-up">
                    <div class="footer-brand"><i class="fas fa-leaf me-2"></i>Ayurveda Wellness</div>
                    <p class="footer-desc">Providing authentic Ayurvedic treatments and consultations for over 25 years. Our mission is to help you achieve optimal health through natural, time-tested methods.</p>
                    <div class="social-icons">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="col-6 col-lg-2" data-aos="fade-up" data-aos-delay="100">
                    <h5>Quick Links</h5>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/hospitals">Find Centers</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctors">Find Doctors</a></li>
                    </ul>
                </div>
                <div class="col-6 col-lg-2" data-aos="fade-up" data-aos-delay="200">
                    <h5>Services</h5>
                    <ul class="footer-links">
                        <li><a href="#">Panchakarma</a></li>
                        <li><a href="#">Herbal Medicine</a></li>
                        <li><a href="#">Yoga & Meditation</a></li>
                        <li><a href="#">Diet & Nutrition</a></li>
                        <li><a href="#">Online Consultation</a></li>
                    </ul>
                </div>
                <div class="col-lg-4" data-aos="fade-up" data-aos-delay="300">
                    <h5>Contact Us</h5>
                    <ul class="footer-links">
                        <li><i class="fas fa-map-marker-alt me-2 text-warning"></i>123 Wellness Street, Mumbai</li>
                        <li><i class="fas fa-phone me-2 text-warning"></i>+91 98765 43210</li>
                        <li><i class="fas fa-envelope me-2 text-warning"></i>info@ayurvedawellness.com</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 Ayurveda Wellness Center. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Back to Top -->
    <button class="back-to-top" id="backToTop">
        <i class="fas fa-chevron-up"></i>
    </button>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- AOS JS -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    <script>
        // Initialize AOS
        AOS.init({
            duration: 800,
            easing: 'ease-out-cubic',
            once: true,
            offset: 50
        });
        
        // Navbar Scroll Effect
        window.addEventListener('scroll', () => {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 100) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
        
        // Back to Top
        const backToTop = document.getElementById('backToTop');
        
        window.addEventListener('scroll', () => {
            if (window.scrollY > 500) {
                backToTop.classList.add('visible');
            } else {
                backToTop.classList.remove('visible');
            }
        });
        
        backToTop.addEventListener('click', () => {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
        
        // Specialization Chips
        document.querySelectorAll('.spec-chip').forEach(chip => {
            chip.addEventListener('click', function() {
                document.querySelectorAll('.spec-chip').forEach(c => c.classList.remove('active'));
                this.classList.add('active');
            });
        });
    </script>
</body>
</html>
