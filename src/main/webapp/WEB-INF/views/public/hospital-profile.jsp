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
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- GSAP for animations -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
        
        /* === MODERN DESIGN SYSTEM === */
        
        /* Geometric Pattern Background */
        .geometric-bg {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            opacity: 0.03;
            background-image: 
                repeating-linear-gradient(45deg, transparent, transparent 35px, rgba(230,181,92,0.1) 35px, rgba(230,181,92,0.1) 70px),
                repeating-linear-gradient(-45deg, transparent, transparent 35px, rgba(138,109,59,0.08) 35px, rgba(138,109,59,0.08) 70px);
            pointer-events: none;
            z-index: 0;
        }
        
        /* Glassmorphism Effect */
        .glass-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
        }
        
        /* Gradient Mesh Background */
        .gradient-mesh {
            position: absolute;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(at 20% 30%, rgba(230,181,92,0.15) 0%, transparent 50%),
                radial-gradient(at 80% 70%, rgba(138,109,59,0.1) 0%, transparent 50%);
            filter: blur(60px);
            z-index: 0;
        }
        
        /* Modern Clip-Path Card */
        .modern-card {
            position: relative;
            background: #fff;
            clip-path: polygon(0 0, calc(100% - 30px) 0, 100% 30px, 100% 100%, 0 100%);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .modern-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 30px;
            height: 30px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .modern-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 60px rgba(230,181,92,0.3);
        }
        
        /* Modern Button with Glow */
        .glow-button {
            position: relative;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            border: none;
            padding: 14px 36px;
            border-radius: 8px;
            color: #1f2a1f;
            font-weight: 600;
            cursor: pointer;
            overflow: hidden;
            transition: all 0.4s ease;
        }
        
        .glow-button::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255,255,255,0.3);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }
        
        .glow-button:hover::before {
            width: 400px;
            height: 400px;
        }
        
        .glow-button:hover {
            box-shadow: 0 0 30px rgba(230,181,92,0.6), 0 0 60px rgba(230,181,92,0.4);
            transform: translateY(-3px);
        }
        
        /* ========== NAVBAR - Modern Glassmorphism ========== */
        .navbar {
            background: rgba(26, 46, 26, 0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 15px 0;
            transition: all 0.4s ease;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid rgba(230, 181, 92, 0.1);
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
        
        /* Hero Section - Modern Design */
        .profile-hero {
            position: relative;
            height: 500px;
            background: linear-gradient(135deg, rgba(45, 90, 61, 0.85), rgba(107, 142, 107, 0.9));
            display: flex;
            align-items: flex-end;
            padding-top: 70px;
            overflow: hidden;
        }
        
        .profile-hero::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 50%;
            height: 100%;
            background: linear-gradient(135deg, rgba(230,181,92,0.1) 0%, transparent 100%);
            clip-path: polygon(0 0, 100% 0, 100% 100%, 30% 100%);
            z-index: 1;
        }
        
        .profile-hero .geometric-bg {
            z-index: 1;
        }
        
        .profile-hero .gradient-mesh {
            z-index: 1;
        }
        
        .hero-content {
            width: 100%;
            padding: var(--spacing-3xl) 0 var(--spacing-xl);
            background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
            position: relative;
            z-index: 2;
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
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 0;
            padding: var(--spacing-xs) var(--spacing-md);
            font-weight: 600;
            font-size: 0.85rem;
            clip-path: polygon(0 0, calc(100% - 8px) 0, 100% 8px, 100% 100%, 0 100%);
            position: relative;
            transition: all 0.3s ease;
        }
        
        .hero-badges .badge::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 8px;
            height: 8px;
            background: rgba(255,255,255,0.5);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .hero-badges .badge:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-3px);
        }
        
        .hero-badges .badge-gold {
            background: rgba(230, 181, 92, 0.3);
            border-color: rgba(230, 181, 92, 0.5);
        }
        
        .hero-badges .badge-primary {
            background: rgba(45, 90, 61, 0.3);
            border-color: rgba(45, 90, 61, 0.5);
        }
        
        .hero-title {
            display: flex;
            align-items: center;
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-md);
        }
        
        .hero-title h1 {
            color: white;
            font-size: clamp(2rem, 5vw, 3.5rem);
            margin: 0;
            font-weight: 700;
            text-shadow: 2px 2px 20px rgba(0,0,0,0.5);
            letter-spacing: -0.02em;
            line-height: 1.2;
        }
        
        .verified-badge {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: white;
            padding: var(--spacing-xs) var(--spacing-md);
            border-radius: 0;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
            font-weight: 600;
            clip-path: polygon(0 0, calc(100% - 8px) 0, 100% 8px, 100% 100%, 0 100%);
            position: relative;
            box-shadow: 0 4px 15px rgba(230,181,92,0.4);
            transition: all 0.3s ease;
        }
        
        .verified-badge::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 8px;
            height: 8px;
            background: rgba(255,255,255,0.3);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .verified-badge:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(230,181,92,0.5);
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
        
        /* Tab Navigation - Modern Design */
        .profile-tabs {
            background: white;
            border-radius: 0;
            padding: var(--spacing-md);
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            display: flex;
            gap: var(--spacing-sm);
            margin-bottom: var(--spacing-xl);
            overflow-x: auto;
            clip-path: polygon(0 0, calc(100% - 20px) 0, 100% 20px, 100% 100%, 20px 100%, 0 calc(100% - 20px));
            position: relative;
        }
        
        .profile-tabs::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 20px;
            height: 20px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .profile-tabs::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 20px;
            height: 20px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 100%, 0 100%);
        }
        
        .profile-tabs a {
            padding: var(--spacing-md) var(--spacing-lg);
            border-radius: 0;
            font-weight: 600;
            color: var(--text-medium);
            white-space: nowrap;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            clip-path: polygon(0 0, calc(100% - 8px) 0, 100% 8px, 100% 100%, 8px 100%, 0 calc(100% - 8px));
        }
        
        .profile-tabs a::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 8px;
            height: 8px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .profile-tabs a:hover {
            background: rgba(230,181,92,0.1);
            color: var(--primary-forest);
        }
        
        .profile-tabs a:hover::before {
            opacity: 1;
        }
        
        .profile-tabs a.active {
            background: linear-gradient(135deg, var(--primary-forest), #2d4a2d);
            color: white;
        }
        
        .profile-tabs a.active::before {
            opacity: 1;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
        }
        
        /* Content Card - Modern Design */
        .content-card {
            background: white;
            border-radius: 0;
            padding: var(--spacing-xl);
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            margin-bottom: var(--spacing-xl);
            position: relative;
            clip-path: polygon(0 0, calc(100% - 30px) 0, 100% 30px, 100% 100%, 0 100%);
            transition: all 0.4s ease;
        }
        
        .content-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 30px;
            height: 30px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .content-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 60px rgba(230,181,92,0.2);
        }
        
        .content-card h2 {
            font-size: clamp(1.5rem, 3vw, 2rem);
            margin-bottom: var(--spacing-lg);
            padding-bottom: var(--spacing-md);
            border-bottom: 3px solid transparent;
            background: linear-gradient(white, white) padding-box,
                        linear-gradient(90deg, #e6b55c, #d4a347) border-box;
            border-bottom-width: 3px;
            font-weight: 700;
            position: relative;
            padding-left: 20px;
        }
        
        .content-card h2::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: linear-gradient(180deg, #e6b55c, #d4a347);
        }
        
        /* Sidebar - Modern Design */
        .profile-sidebar {
            position: sticky;
            top: 90px;
            height: fit-content;
        }
        
        .sidebar-card {
            background: white;
            border-radius: 0;
            padding: var(--spacing-xl);
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            margin-bottom: var(--spacing-lg);
            position: relative;
            clip-path: polygon(0 0, calc(100% - 25px) 0, 100% 25px, 100% 100%, 0 100%);
            transition: all 0.4s ease;
        }
        
        .sidebar-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 25px;
            height: 25px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .sidebar-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 60px rgba(230,181,92,0.25);
        }
        
        .sidebar-card h3 {
            font-size: 1.25rem;
            margin-bottom: var(--spacing-lg);
            font-weight: 700;
            color: var(--primary-forest);
            position: relative;
            padding-left: 20px;
        }
        
        .sidebar-card h3::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: linear-gradient(180deg, #e6b55c, #d4a347);
        }
        
        .contact-item {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            padding: var(--spacing-md) 0;
            border-bottom: 1px solid rgba(230,181,92,0.1);
            transition: all 0.3s ease;
        }
        
        .contact-item:last-child {
            border-bottom: none;
        }
        
        .contact-item:hover {
            padding-left: 10px;
        }
        
        .contact-item i {
            width: 45px;
            height: 45px;
            background: rgba(230,181,92,0.1);
            border-radius: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-gold);
            transition: all 0.3s ease;
            clip-path: polygon(0 0, calc(100% - 6px) 0, 100% 6px, 100% 100%, 0 100%);
            position: relative;
        }
        
        .contact-item i::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 6px;
            height: 6px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .contact-item:hover i {
            background: rgba(230,181,92,0.2);
            transform: scale(1.1);
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
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            border: none;
            border-radius: 0;
            color: #1f2a1f;
            font-weight: 600;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            clip-path: polygon(0 0, calc(100% - 10px) 0, 100% 10px, 100% 100%, 0 100%);
        }
        
        .book-now-btn::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 10px;
            height: 10px;
            background: rgba(255,255,255,0.3);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .book-now-btn::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255,255,255,0.3);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }
        
        .book-now-btn:hover::after {
            width: 400px;
            height: 400px;
        }
        
        .book-now-btn:hover {
            box-shadow: 0 0 30px rgba(230,181,92,0.6), 0 0 60px rgba(230,181,92,0.4);
            transform: translateY(-3px);
        }
        
        /* Quick Packages */
        .quick-package {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: var(--spacing-md);
            background: rgba(230,181,92,0.05);
            border-radius: 0;
            margin-bottom: var(--spacing-sm);
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }
        
        .quick-package:hover {
            background: rgba(230,181,92,0.1);
            border-left-color: #e6b55c;
            transform: translateX(5px);
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
            background: rgba(230,181,92,0.1);
            border-radius: 0;
            font-size: 0.85rem;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 1px solid rgba(230,181,92,0.2);
            clip-path: polygon(0 0, calc(100% - 8px) 0, 100% 8px, 100% 100%, 0 100%);
            position: relative;
        }
        
        .cert-badge::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 8px;
            height: 8px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .cert-badge:hover {
            background: rgba(230,181,92,0.2);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(230,181,92,0.3);
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
            border-radius: 0;
            overflow: hidden;
            cursor: pointer;
            position: relative;
            clip-path: polygon(0 0, calc(100% - 15px) 0, 100% 15px, 100% 100%, 0 100%);
            transition: all 0.4s ease;
        }
        
        .gallery-item::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 15px;
            height: 15px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
            z-index: 1;
        }
        
        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s ease;
        }
        
        .gallery-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }
        
        .gallery-item:hover img {
            transform: scale(1.15);
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
            background: white;
            border-radius: 0;
            transition: all 0.4s ease;
            position: relative;
            clip-path: polygon(0 0, calc(100% - 15px) 0, 100% 15px, 100% 100%, 0 100%);
            border: 1px solid rgba(230,181,92,0.1);
        }
        
        .highlight-item::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 15px;
            height: 15px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .highlight-item:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(230,181,92,0.25);
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
        
        /* Tags - Modern Design */
        .tags-list {
            display: flex;
            flex-wrap: wrap;
            gap: var(--spacing-sm);
        }
        
        .tag {
            display: inline-flex;
            align-items: center;
            gap: var(--spacing-xs);
            padding: var(--spacing-sm) var(--spacing-md);
            background: rgba(230,181,92,0.1);
            border: 1px solid rgba(230,181,92,0.2);
            border-radius: 0;
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--primary-forest);
            transition: all 0.3s ease;
            clip-path: polygon(0 0, calc(100% - 8px) 0, 100% 8px, 100% 100%, 0 100%);
            position: relative;
        }
        
        .tag::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 8px;
            height: 8px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .tag:hover {
            background: rgba(230,181,92,0.2);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(230,181,92,0.3);
        }
        
        .tag i {
            color: var(--accent-gold);
        }
        
        /* Package Cards */
        .package-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: var(--spacing-lg);
        }
        
        .package-card {
            background: white;
            border-radius: 0;
            padding: var(--spacing-lg);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            clip-path: polygon(0 0, calc(100% - 25px) 0, 100% 25px, 100% 100%, 0 100%);
            border: 1px solid rgba(230,181,92,0.1);
        }
        
        .package-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 25px;
            height: 25px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .package-card::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(230,181,92,0.05) 0%, transparent 100%);
            opacity: 0;
            transition: opacity 0.5s ease;
            z-index: 0;
        }
        
        .package-card:hover::after {
            opacity: 1;
        }
        
        .package-card:hover {
            box-shadow: 0 20px 60px rgba(230,181,92,0.3);
            transform: translateY(-10px) rotateY(2deg);
        }
        
        .package-card > * {
            position: relative;
            z-index: 1;
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
            background: white;
            border-radius: 0;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            clip-path: polygon(0 0, calc(100% - 20px) 0, 100% 20px, 100% 100%, 0 100%);
            border: 1px solid rgba(230,181,92,0.1);
        }
        
        .doctor-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 20px;
            height: 20px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .doctor-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 60px rgba(230,181,92,0.3);
        }
        
        .doctor-photo {
            width: 130px;
            height: 130px;
            border-radius: 0;
            margin: 0 auto var(--spacing-md);
            background: linear-gradient(135deg, var(--primary-forest), var(--accent-gold));
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            clip-path: polygon(0 0, calc(100% - 12px) 0, 100% 12px, 100% 100%, 0 100%);
            position: relative;
            transition: all 0.4s ease;
        }
        
        .doctor-photo::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 12px;
            height: 12px;
            background: rgba(255,255,255,0.3);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
            z-index: 1;
        }
        
        .doctor-card:hover .doctor-photo {
            transform: scale(1.1) rotate(5deg);
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
            background: rgba(230,181,92,0.05);
            border-radius: 0;
            border: 1px solid rgba(230,181,92,0.1);
            clip-path: polygon(0 0, calc(100% - 25px) 0, 100% 25px, 100% 100%, 0 100%);
            position: relative;
        }
        
        .review-summary::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 25px;
            height: 25px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
        }
        
        .rating-big {
            text-align: center;
        }
        
        .rating-big .number {
            font-size: clamp(3rem, 6vw, 4rem);
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary-forest), var(--accent-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
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
            border-bottom: 1px solid rgba(230,181,92,0.1);
            transition: all 0.3s ease;
            position: relative;
            padding-left: calc(var(--spacing-lg) + 15px);
        }
        
        .review-card::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 3px;
            background: linear-gradient(180deg, #e6b55c, #d4a347);
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .review-card:hover::before {
            opacity: 1;
        }
        
        .review-card:hover {
            background: rgba(230,181,92,0.03);
            padding-left: calc(var(--spacing-lg) + 20px);
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
            width: 55px;
            height: 55px;
            background: linear-gradient(135deg, var(--primary-forest), var(--accent-gold));
            border-radius: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            clip-path: polygon(0 0, calc(100% - 8px) 0, 100% 8px, 100% 100%, 0 100%);
            position: relative;
        }
        
        .reviewer-avatar::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 8px;
            height: 8px;
            background: rgba(255,255,255,0.3);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
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
        
        /* Responsive Design */
        @media (max-width: 1200px) {
            .package-grid { grid-template-columns: 1fr; }
            .doctor-grid { grid-template-columns: repeat(2, 1fr); }
            .highlights-grid { grid-template-columns: repeat(2, 1fr); }
            .profile-layout {
                grid-template-columns: 1fr 300px;
            }
        }
        
        @media (max-width: 992px) {
            .profile-layout {
                grid-template-columns: 1fr;
                gap: var(--spacing-lg);
            }
            
            .profile-sidebar {
                position: static;
                order: -1;
            }
            
            .gallery-grid { grid-template-columns: repeat(3, 1fr); }
            .profile-hero { height: 400px; }
        }
        
        @media (max-width: 768px) {
            .profile-hero { 
                height: 350px; 
                padding-top: 60px;
            }
            .hero-title h1 { font-size: 1.75rem; }
            .hero-meta { 
                flex-wrap: wrap; 
                gap: var(--spacing-md);
                font-size: 0.9rem;
            }
            .gallery-grid { grid-template-columns: repeat(2, 1fr); }
            .doctor-grid { grid-template-columns: 1fr; }
            .highlights-grid { grid-template-columns: 1fr; }
            .profile-tabs {
                padding: var(--spacing-sm);
                gap: var(--spacing-xs);
            }
            .profile-tabs a {
                padding: var(--spacing-sm) var(--spacing-md);
                font-size: 0.9rem;
            }
            .content-card, .sidebar-card {
                padding: var(--spacing-lg);
            }
        }
        
        @media (max-width: 576px) {
            .profile-hero { height: 300px; }
            .hero-title h1 { font-size: 1.5rem; }
            .gallery-grid { grid-template-columns: 1fr; }
            .package-grid { grid-template-columns: 1fr; }
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/hospitals">Find Centers</a>
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

    <!-- Hero Section -->
    <section class="profile-hero" <c:if test="${not empty hospital.coverPhotoUrl}">style="background-image: linear-gradient(135deg, rgba(45, 90, 61, 0.85), rgba(107, 142, 107, 0.9)), url('${pageContext.request.contextPath}/uploads/${hospital.coverPhotoUrl}'); background-size: cover; background-position: center;"</c:if>>
        <!-- Geometric Background -->
        <div class="geometric-bg"></div>
        <div class="gradient-mesh"></div>
        
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
                                <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}?tab=gallery" class="glow-button" style="display: inline-block;">
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
                                        <a href="${pageContext.request.contextPath}/booking/enquiry/${hospital.id}?packageId=${pkg.id}" class="btn glow-button" style="font-size: 0.9rem; padding: var(--spacing-sm) var(--spacing-lg);">
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
                                    <div class="room-card modern-card" style="overflow: hidden; background: white;">
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
                                            <div style="position: absolute; top: var(--spacing-sm); right: var(--spacing-sm); z-index: 2;">
                                                <span class="badge" style="background: rgba(255,255,255,0.95); backdrop-filter: blur(10px); color: var(--primary-forest); padding: var(--spacing-xs) var(--spacing-sm); border-radius: 0; font-weight: 600; clip-path: polygon(0 0, calc(100% - 6px) 0, 100% 6px, 100% 100%, 0 100%); position: relative;">
                                                    <span style="position: absolute; top: 0; right: 0; width: 6px; height: 6px; background: linear-gradient(135deg, #e6b55c, #d4a347); clip-path: polygon(0 0, 100% 0, 100% 100%);"></span>
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
                                                <a href="${pageContext.request.contextPath}/room/booking/${room.id}" class="btn glow-button" style="padding: var(--spacing-sm) var(--spacing-lg); font-size: 0.9rem;">
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
                
                <a href="${pageContext.request.contextPath}/booking/enquiry/${hospital.id}" class="book-now-btn">
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

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- AOS JS -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    
    <script>
        // Register GSAP plugins
        gsap.registerPlugin(ScrollTrigger);
        
        // Navbar Scroll Effect
        window.addEventListener('scroll', () => {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 100) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
        
        // Animate hero content on load
        gsap.from('.hero-title h1', {
            opacity: 0,
            y: 50,
            duration: 1,
            ease: 'power3.out',
            delay: 0.3
        });
        
        gsap.from('.hero-meta', {
            opacity: 0,
            y: 30,
            duration: 1,
            ease: 'power3.out',
            delay: 0.5
        });
        
        gsap.from('.hero-badges', {
            opacity: 0,
            x: -30,
            duration: 0.8,
            ease: 'power3.out',
            delay: 0.2
        });
        
        // Animate content cards
        gsap.utils.toArray('.content-card').forEach((card, index) => {
            gsap.from(card, {
                scrollTrigger: {
                    trigger: card,
                    start: 'top 85%',
                    toggleActions: 'play none none none'
                },
                opacity: 0,
                y: 60,
                rotationX: -15,
                duration: 0.8,
                delay: index * 0.1,
                ease: 'power3.out'
            });
        });
        
        // Animate sidebar cards
        gsap.utils.toArray('.sidebar-card').forEach((card, index) => {
            gsap.from(card, {
                scrollTrigger: {
                    trigger: card,
                    start: 'top 85%',
                    toggleActions: 'play none none none'
                },
                opacity: 0,
                x: 50,
                duration: 0.8,
                delay: index * 0.15,
                ease: 'power3.out'
            });
        });
        
        // Animate package cards
        gsap.utils.toArray('.package-card').forEach((card, index) => {
            gsap.from(card, {
                scrollTrigger: {
                    trigger: card,
                    start: 'top 85%',
                    toggleActions: 'play none none none'
                },
                opacity: 0,
                y: 50,
                scale: 0.9,
                duration: 0.8,
                delay: index * 0.1,
                ease: 'back.out(1.7)'
            });
        });
        
        // Animate doctor cards
        gsap.utils.toArray('.doctor-card').forEach((card, index) => {
            gsap.from(card, {
                scrollTrigger: {
                    trigger: card,
                    start: 'top 85%',
                    toggleActions: 'play none none none'
                },
                opacity: 0,
                scale: 0.8,
                rotation: -5,
                duration: 0.8,
                delay: index * 0.1,
                ease: 'back.out(1.7)'
            });
        });
        
        // Animate gallery items
        gsap.utils.toArray('.gallery-item').forEach((item, index) => {
            gsap.from(item, {
                scrollTrigger: {
                    trigger: item,
                    start: 'top 85%',
                    toggleActions: 'play none none none'
                },
                opacity: 0,
                scale: 0.8,
                duration: 0.6,
                delay: index * 0.05,
                ease: 'power3.out'
            });
        });
        
        // Animate highlight items
        gsap.utils.toArray('.highlight-item').forEach((item, index) => {
            gsap.from(item, {
                scrollTrigger: {
                    trigger: item,
                    start: 'top 85%',
                    toggleActions: 'play none none none'
                },
                opacity: 0,
                y: 30,
                duration: 0.6,
                delay: index * 0.1,
                ease: 'power3.out'
            });
        });
        
        // Animate review cards
        gsap.utils.toArray('.review-card').forEach((card, index) => {
            gsap.from(card, {
                scrollTrigger: {
                    trigger: card,
                    start: 'top 85%',
                    toggleActions: 'play none none none'
                },
                opacity: 0,
                x: -30,
                duration: 0.6,
                delay: index * 0.1,
                ease: 'power3.out'
            });
        });
        
        // Animate tabs
        gsap.from('.profile-tabs', {
            scrollTrigger: {
                trigger: '.profile-tabs',
                start: 'top 90%',
                toggleActions: 'play none none none'
            },
            opacity: 0,
            y: 30,
            duration: 0.8,
            ease: 'power3.out'
        });
    </script>
</body>
</html>

