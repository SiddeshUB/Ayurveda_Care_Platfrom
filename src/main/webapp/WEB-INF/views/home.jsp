<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ayurveda Wellness | Ancient Healing for Modern Life</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Poppins:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- GSAP for animations -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
    <style>
    /* === UNIQUE MODERN DESIGN SYSTEM === */
    
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
    
    .glass-dark {
        background: rgba(15, 22, 15, 0.7);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border: 1px solid rgba(230, 181, 92, 0.1);
    }
    
    /* Hexagonal Pattern */
    .hex-pattern {
        position: absolute;
        width: 100%;
        height: 100%;
        background-image: 
            url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><polygon points="50,5 90,25 90,75 50,95 10,75 10,25" fill="none" stroke="%23e6b55c" stroke-width="0.5" opacity="0.1"/></svg>');
        background-size: 100px 100px;
        opacity: 0.4;
        pointer-events: none;
    }
    
    /* Asymmetric Grid Layout */
    .asymmetric-grid {
        display: grid;
        grid-template-columns: repeat(12, 1fr);
        gap: 20px;
        position: relative;
    }
    
    .grid-item-1 { grid-column: 1 / 7; grid-row: 1 / 3; }
    .grid-item-2 { grid-column: 7 / 13; grid-row: 1 / 2; }
    .grid-item-3 { grid-column: 7 / 13; grid-row: 2 / 3; }
    
    /* Diagonal Split Design */
    .diagonal-split {
        position: relative;
        overflow: hidden;
    }
    
    .diagonal-split::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, transparent 0%, transparent 45%, rgba(230,181,92,0.05) 50%, transparent 55%, transparent 100%);
        transform: skewY(-5deg);
        transform-origin: top left;
    }
    
    /* Modern Card with Cut Corner */
    .cut-corner-card {
        position: relative;
        background: #fff;
        clip-path: polygon(0 0, calc(100% - 30px) 0, 100% 30px, 100% 100%, 0 100%);
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    }
    
    .cut-corner-card::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 30px;
        height: 30px;
        background: linear-gradient(135deg, #e6b55c, #d4a347);
        clip-path: polygon(0 0, 100% 0, 100% 100%);
    }
    
    .cut-corner-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 60px rgba(230,181,92,0.3);
    }
    
    /* Layered Card Design */
    .layered-card {
        position: relative;
        transform-style: preserve-3d;
    }
    
    .layered-card::before,
    .layered-card::after {
        content: '';
        position: absolute;
        background: inherit;
        border-radius: inherit;
        transition: transform 0.4s ease;
    }
    
    .layered-card::before {
        top: -5px;
        left: -5px;
        right: 5px;
        bottom: 5px;
        z-index: -1;
        opacity: 0.5;
    }
    
    .layered-card::after {
        top: -10px;
        left: -10px;
        right: 10px;
        bottom: 10px;
        z-index: -2;
        opacity: 0.3;
    }
    
    .layered-card:hover::before {
        transform: translate(5px, 5px);
    }
    
    .layered-card:hover::after {
        transform: translate(10px, 10px);
    }
    
    /* Floating Elements */
    .float-element {
        animation: floatUpDown 6s ease-in-out infinite;
    }
    
    @keyframes floatUpDown {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-20px); }
    }
    
    /* Gradient Mesh Background */
    .gradient-mesh {
        position: absolute;
        width: 100%;
        height: 100%;
        background: 
            radial-gradient(at 20% 30%, rgba(230,181,92,0.15) 0%, transparent 50%),
            radial-gradient(at 80% 70%, rgba(138,109,59,0.1) 0%, transparent 50%),
            radial-gradient(at 50% 50%, rgba(230,181,92,0.08) 0%, transparent 50%);
        filter: blur(60px);
        z-index: 0;
    }
    
    /* Modern Typography with Gradient */
    .gradient-text {
        background: linear-gradient(135deg, #e6b55c 0%, #d4a347 50%, #8a6d3b 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        background-size: 200% 200%;
        animation: gradientShift 5s ease infinite;
    }
    
    @keyframes gradientShift {
        0%, 100% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
    }
    
    /* Split Screen Design */
    .split-screen {
        display: grid;
        grid-template-columns: 1fr 1fr;
        min-height: 100vh;
        position: relative;
    }
    
    .split-left {
        background: linear-gradient(135deg, #fdfaf4 0%, #f8f3e9 100%);
        display: flex;
        align-items: center;
        padding: 80px;
    }
    
    .split-right {
        background: linear-gradient(135deg, #1f2a1f 0%, #0f160f 100%);
        display: flex;
        align-items: center;
        padding: 80px;
        color: #fff;
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
    
    /* Animated Border */
    .animated-border {
        position: relative;
        border: 2px solid transparent;
        background: linear-gradient(#fff, #fff) padding-box,
                    linear-gradient(135deg, #e6b55c, #d4a347, #8a6d3b, #e6b55c) border-box;
        background-size: 200% 200%;
        animation: borderFlow 3s linear infinite;
    }
    
    @keyframes borderFlow {
        0% { background-position: 0% 50%; }
        100% { background-position: 200% 50%; }
    }
    
    /* 3D Card Effect */
    .card-3d {
        transform-style: preserve-3d;
        transition: transform 0.6s;
    }
    
    .card-3d:hover {
        transform: rotateY(5deg) rotateX(5deg);
    }
    
    /* Zigzag Divider */
    .zigzag-divider {
        position: relative;
        height: 60px;
        overflow: hidden;
    }
    
    .zigzag-divider::before {
        content: '';
        position: absolute;
        width: 100%;
        height: 100%;
        background: 
            linear-gradient(45deg, transparent 30%, #fdfaf4 30%, #fdfaf4 35%, transparent 35%),
            linear-gradient(-45deg, transparent 30%, #fdfaf4 30%, #fdfaf4 35%, transparent 35%);
        background-size: 40px 40px;
    }
    
    /* Modern Section with Overlay */
    .overlay-section {
        position: relative;
        overflow: hidden;
    }
    
    .overlay-section::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(230,181,92,0.1) 0%, transparent 70%);
        animation: rotate 20s linear infinite;
    }
    
    @keyframes rotate {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    
    /* Geometric Shapes */
    .geometric-shape {
        position: absolute;
        background: linear-gradient(135deg, rgba(230,181,92,0.1), rgba(138,109,59,0.05));
        clip-path: polygon(50% 0%, 100% 50%, 50% 100%, 0% 50%);
        animation: spin 20s linear infinite;
    }
    
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    
    /* Modern Navbar with Glass Effect */
    .glass-navbar {
        background: rgba(31, 42, 31, 0.85);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border-bottom: 1px solid rgba(230, 181, 92, 0.1);
    }
    
    /* Creative Typography Layout */
    .creative-title {
        font-size: clamp(3rem, 8vw, 6rem);
        font-weight: 700;
        line-height: 1.1;
        letter-spacing: -0.02em;
        position: relative;
    }
    
    .creative-title::after {
        content: '';
        position: absolute;
        bottom: -10px;
        left: 0;
        width: 100px;
        height: 6px;
        background: linear-gradient(90deg, #e6b55c, transparent);
    }
    
    /* Staggered Grid */
    .staggered-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 30px;
    }
    
    .staggered-item:nth-child(odd) {
        margin-top: 40px;
    }
    
    .staggered-item:nth-child(even) {
        margin-bottom: 40px;
    }
    
    /* Modern Image Overlay */
    .image-overlay-modern {
        position: relative;
        overflow: hidden;
    }
    
    .image-overlay-modern::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(135deg, rgba(230,181,92,0.2) 0%, transparent 100%);
        opacity: 0;
        transition: opacity 0.4s ease;
    }
    
    .image-overlay-modern:hover::after {
        opacity: 1;
    }
    
    /* Neon Glow Effect */
    .neon-glow {
        text-shadow: 
            0 0 10px rgba(230,181,92,0.5),
            0 0 20px rgba(230,181,92,0.3),
            0 0 30px rgba(230,181,92,0.2);
    }
    /* === ANIMATION IMAGES SECTION === */
    .animation-section {
        padding: 100px 0;
        background: linear-gradient(135deg, #fdfaf4 0%, #f8f3e9 100%);
        position: relative;
        overflow: hidden;
    }

    .animation-container {
            display: flex;
        justify-content: space-between;
            align-items: center;
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    .animation-left {
        flex: 0 0 40%;
        animation: floatLeft 6s ease-in-out infinite;
    }

    .animation-right {
        flex: 0 0 40%;
        animation: floatRight 6s ease-in-out infinite;
    }

    .animation-center {
        flex: 0 0 20%;
            text-align: center;
        padding: 0 40px;
    }

    .animation-image {
            width: 100%;
        height: auto;
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        transition: transform 0.3s ease;
    }

    .animation-image:hover {
        transform: scale(1.05);
    }

    .animation-center h3 {
        font-family: 'Playfair Display', serif;
        font-size: 32px;
        color: #1f2a1f;
        margin-bottom: 20px;
    }

    .animation-center p {
        color: #666;
        font-size: 16px;
        line-height: 1.6;
        margin-bottom: 25px;
    }

    @keyframes floatLeft {
        0%, 100% {
            transform: translateY(0) rotate(-2deg);
        }
        50% {
            transform: translateY(-20px) rotate(0deg);
        }
    }

    @keyframes floatRight {
        0%, 100% {
            transform: translateY(0) rotate(2deg);
        }
        50% {
            transform: translateY(-20px) rotate(0deg);
        }
    }

    /* Responsive for animation section */
    @media (max-width: 992px) {
        .animation-container {
            flex-direction: column;
            gap: 50px;
        }

        .animation-left,
        .animation-right,
        .animation-center {
            flex: 0 0 100%;
            max-width: 500px;
            margin: 0 auto;
        }

        .animation-center {
            order: 1;
            padding: 0;
        }

        .animation-left {
            order: 2;
        }

        .animation-right {
            order: 3;
        }

        @keyframes floatLeft {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-15px);
            }
        }

        @keyframes floatRight {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-15px);
            }
        }
    }

    /* === ORIGINAL STYLES === */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Inter', 'Poppins', sans-serif;
        background: #fdfaf4;
        color: #1f2a1f;
        line-height: 1.7;
        overflow-x: hidden;
        position: relative;
    }
    
    body::before {
        content: '';
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: 
            radial-gradient(circle at 10% 20%, rgba(230,181,92,0.03) 0%, transparent 50%),
            radial-gradient(circle at 90% 80%, rgba(138,109,59,0.02) 0%, transparent 50%);
        pointer-events: none;
        z-index: 0;
    }
    
    body > * {
        position: relative;
        z-index: 1;
    }

        /* NAVBAR - Glassmorphism Design */
        .navbar {
            background: rgba(31, 42, 31, 0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 20px 0;
            transition: all 0.4s ease;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            border-bottom: 1px solid rgba(230, 181, 92, 0.1);
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
        
        /* Dashboard Link - Professional Styling */
        .navbar-nav .nav-link.nav-dashboard {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 18px !important;
            background: rgba(230, 181, 92, 0.15) !important;
            border-radius: 20px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .navbar-nav .nav-link.nav-dashboard i {
            font-size: 16px;
            color: #e6b55c;
        }
        
        .navbar-nav .nav-link.nav-dashboard:hover {
            background: rgba(230, 181, 92, 0.25) !important;
            color: #e6b55c !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(230, 181, 92, 0.3);
        }
        
        .navbar-nav .nav-link.nav-dashboard:hover i {
            transform: scale(1.1);
        }
        
        .navbar-nav .nav-link.nav-dashboard.active {
            background: rgba(230, 181, 92, 0.3) !important;
            color: #e6b55c !important;
        }
        
        .navbar-nav .nav-link.nav-dashboard.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 50%;
            transform: translateX(-50%);
            width: 60%;
            height: 2px;
            background: #e6b55c;
            border-radius: 2px;
        }
        
        /* User Dropdown Toggle - Improved Hover */
        .user-dropdown .dropdown-toggle {
            border: 1px solid transparent;
            transition: all 0.3s ease;
        }
        
        .user-dropdown .dropdown-toggle:hover {
            border-color: rgba(230, 181, 92, 0.3);
            transform: translateY(-1px);
        }
        
        /* Welcome Toast Notification - Golden Animated */
        .welcome-toast-home {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 10000;
            min-width: 380px;
            max-width: 450px;
            opacity: 0;
            transform: translateX(500px) scale(0.8);
            animation: slideInGoldenToast 0.8s cubic-bezier(0.68, -0.55, 0.265, 1.55) 0.3s forwards;
        }
        
        @keyframes slideInGoldenToast {
            0% {
                opacity: 0;
                transform: translateX(500px) scale(0.8) rotate(-5deg);
            }
            60% {
                transform: translateX(-10px) scale(1.05) rotate(2deg);
            }
            100% {
                opacity: 1;
                transform: translateX(0) scale(1) rotate(0deg);
            }
        }
        
        .welcome-toast-home.hide {
            animation: slideOutGoldenToast 0.5s ease-in forwards;
        }
        
        @keyframes slideOutGoldenToast {
            to {
                opacity: 0;
                transform: translateX(500px) scale(0.8) rotate(5deg);
            }
        }
        
        .toast-content-wrapper {
            position: relative;
            background: linear-gradient(135deg, #e6b55c 0%, #d4a347 50%, #c9a227 100%);
            padding: 3px;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(230, 181, 92, 0.5),
                        0 0 30px rgba(230, 181, 92, 0.3),
                        inset 0 1px 0 rgba(255, 255, 255, 0.3);
            overflow: hidden;
        }
        
        .toast-golden-bg {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, #f5e6b8 0%, #e6b55c 50%, #d4a347 100%);
            opacity: 0.95;
            animation: shimmer 3s infinite;
        }
        
        @keyframes shimmer {
            0%, 100% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
        }
        
        .toast-content-inner {
            position: relative;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(255, 248, 235, 0.98) 100%);
            padding: 25px 30px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            gap: 18px;
            box-shadow: inset 0 2px 10px rgba(230, 181, 92, 0.2);
        }
        
        .toast-icon-golden {
            width: 55px;
            height: 55px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: #fff;
            flex-shrink: 0;
            box-shadow: 0 5px 20px rgba(230, 181, 92, 0.4),
                        inset 0 2px 5px rgba(255, 255, 255, 0.3);
            animation: pulseIcon 2s infinite;
        }
        
        @keyframes pulseIcon {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 5px 20px rgba(230, 181, 92, 0.4),
                           inset 0 2px 5px rgba(255, 255, 255, 0.3);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 8px 30px rgba(230, 181, 92, 0.6),
                           inset 0 2px 5px rgba(255, 255, 255, 0.3);
            }
        }
        
        .toast-message-golden {
            flex: 1;
        }
        
        .toast-message-golden strong {
            display: block;
            font-size: 18px;
            font-weight: 700;
            color: #1a2e1a;
            margin-bottom: 6px;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1a2e1a, #2d4a2d);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .toast-message-golden p {
            margin: 0;
            font-size: 14px;
            color: #555;
            line-height: 1.5;
        }
        
        .toast-close-golden {
            background: rgba(230, 181, 92, 0.2);
            border: 2px solid rgba(230, 181, 92, 0.3);
            color: #1a2e1a;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            flex-shrink: 0;
            font-size: 14px;
        }
        
        .toast-close-golden:hover {
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            border-color: #e6b55c;
            color: #fff;
            transform: rotate(90deg) scale(1.1);
            box-shadow: 0 4px 15px rgba(230, 181, 92, 0.4);
        }
        
        .toast-shine {
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, 
                transparent 30%, 
                rgba(255, 255, 255, 0.3) 50%, 
                transparent 70%);
            animation: shine 3s infinite;
            pointer-events: none;
        }
        
        @keyframes shine {
            0% {
                transform: translateX(-100%) translateY(-100%) rotate(45deg);
            }
            100% {
                transform: translateX(100%) translateY(100%) rotate(45deg);
            }
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .welcome-toast-home {
                right: 10px;
                left: 10px;
                min-width: auto;
                max-width: none;
            }
            
            .toast-content-inner {
                padding: 20px;
                gap: 15px;
            }
            
            .toast-icon-golden {
                width: 45px;
                height: 45px;
                font-size: 20px;
            }
            
            .toast-message-golden strong {
                font-size: 16px;
            }
            
            .toast-message-golden p {
                font-size: 13px;
            }
        }
        
        /* Navbar Toggler Button - White */
        .navbar-toggler {
            background: #ffffff !important;
            border: 1px solid rgba(255, 255, 255, 0.3) !important;
            border-radius: 8px !important;
            padding: 8px 12px !important;
        }
        
        .navbar-toggler:focus {
            box-shadow: 0 0 0 0.2rem rgba(255, 255, 255, 0.25) !important;
        }
        
        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(26, 46, 26, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e") !important;
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
        
        /* Login Dropdown Styling */
        .nav-item.dropdown .dropdown-toggle {
            cursor: pointer;
        }
        
        .nav-item.dropdown .dropdown-menu {
            background: #fff;
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            padding: 10px 0;
            margin-top: 10px;
            min-width: 200px;
        }
        
        .nav-item.dropdown .dropdown-item {
            padding: 12px 20px;
            color: #333;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }
        
        .nav-item.dropdown .dropdown-item:hover {
            background: rgba(230, 181, 92, 0.1);
            color: #e6b55c;
        }
        
        .nav-item.dropdown .dropdown-item i {
            width: 20px;
            margin-right: 10px;
            color: #e6b55c;
        }
        
    /* HERO - Modern Split Design */
        .hero {
            min-height: 100vh;
            position: relative;
            overflow: hidden;
            color: #fff;
            display: flex;
            align-items: center;
            text-align: center;
            padding-top: 80px;
        }
        
        .hero::before {
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
        
        .hero .geometric-bg {
            z-index: 1;
        }
        
        .hero .gradient-mesh {
            z-index: 1;
        }
        
        .hero-slide {
            position: absolute;
            inset: 0;
            background-size: cover;
            background-position: center;
        background-repeat: no-repeat;
            opacity: 0;
        transition: opacity 1.2s ease-in-out;
        }
        
        .hero-slide.active {
            opacity: 1;
        }
        
        .hero-overlay {
            position: absolute;
            inset: 0;
        background: linear-gradient(rgba(0,0,0,.55), rgba(0,0,0,.75));
            z-index: 1;
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
    }

    .hero-content h1 {
        font-family: 'Playfair Display', serif;
        font-size: clamp(3rem, 8vw, 5.5rem);
        font-weight: 700;
        margin-bottom: 25px;
        color: #fff;
        text-shadow: 2px 2px 20px rgba(0,0,0,0.3);
        letter-spacing: -0.02em;
        line-height: 1.2;
        position: relative;
        z-index: 2;
    }
    
    .hero-content h1 .gradient-text {
        background: linear-gradient(135deg, #fff 0%, #e6b55c 50%, #fff 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .hero-content p {
        font-size: 18px;
        margin-bottom: 30px;
            max-width: 700px;
        margin-left: auto;
        margin-right: auto;
        }
        
        .hero-buttons {
        margin-top: 30px;
    }

    /* Pagination dots */
        .hero-dots {
            position: absolute;
        bottom: 40px;
        width: 100%;
            display: flex;
        justify-content: center;
        gap: 12px;
        z-index: 3;
        }
        
        .hero-dots span {
            width: 12px;
            height: 12px;
        background: rgba(230,181,92,0.4);
            border-radius: 50%;
            cursor: pointer;
        transition: background 0.3s ease, transform 0.3s ease;
        }
        
        .hero-dots span.active {
        background: #e6b55c;
        transform: scale(1.2);
    }

    /* BUTTON - Modern Glow Design */
    .btn-gold {
        background: linear-gradient(135deg, #e6b55c, #d4a347);
        color: #1f2a1f;
        border: none;
        border-radius: 8px;
        padding: 14px 36px;
        font-weight: 600;
        font-size: 16px;
        cursor: pointer;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        text-decoration: none;
        display: inline-block;
        position: relative;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(230,181,92,0.3);
    }
    
    .btn-gold::before {
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
    
    .btn-gold:hover::before {
        width: 400px;
        height: 400px;
    }

    .btn-gold:hover {
        background: linear-gradient(135deg, #d4a347, #e6b55c);
        transform: translateY(-4px);
        box-shadow: 0 8px 30px rgba(230,181,92,0.6), 0 0 40px rgba(230,181,92,0.3);
        color: #1f2a1f;
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

    /* STATS - Modern Design */
    .stats {
        background: linear-gradient(135deg, #0f160f 0%, #1a241a 100%);
        color: #c5d2a4;
        padding: 100px 0;
        position: relative;
        overflow: hidden;
    }
    
    .stats::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: 
            repeating-linear-gradient(45deg, transparent, transparent 50px, rgba(230,181,92,0.03) 50px, rgba(230,181,92,0.03) 100px);
        pointer-events: none;
    }
    
    .stats .geometric-shape {
        width: 200px;
        height: 200px;
        top: 10%;
        right: 10%;
        opacity: 0.1;
    }

    .stats-container {
            display: flex;
        justify-content: space-around;
        text-align: center;
        flex-wrap: wrap;
        }
        
        .stat-item {
        padding: 20px;
        flex: 1;
        min-width: 200px;
        }
        
        .stat-number {
            font-size: 56px;
            font-weight: 700;
            color: #e6b55c;
            margin-bottom: 12px;
            font-family: 'Playfair Display', serif;
            text-shadow: 0 0 20px rgba(230,181,92,0.3);
            position: relative;
        }
        
        .stat-item {
            position: relative;
            z-index: 1;
            transition: transform 0.3s ease;
        }
        
        .stat-item:hover {
            transform: scale(1.1);
        }
        
    .stat-text {
        font-size: 18px;
        font-weight: 400;
        letter-spacing: 0.5px;
    }

    /* SECTION TITLES - Creative Design */
    .section-title {
        font-family: 'Playfair Display', serif;
        font-size: clamp(2.5rem, 6vw, 4.5rem);
        text-align: center;
        margin-bottom: 60px;
        color: #1f2a1f;
        font-weight: 700;
        letter-spacing: -0.02em;
        position: relative;
        line-height: 1.2;
    }
    
    .section-title::after {
        content: '';
        position: absolute;
        bottom: -20px;
        left: 50%;
        transform: translateX(-50%);
        width: 100px;
        height: 6px;
        background: linear-gradient(90deg, transparent, #e6b55c, #d4a347, transparent);
        clip-path: polygon(0 0, calc(100% - 10px) 0, 100% 100%, 10px 100%);
    }
        
    .section-title.light {
        color: #fff;
    }
    
    .section-title.light::after {
        background: linear-gradient(90deg, transparent, #e6b55c, #d4a347, transparent);
    }
        
    /* SECTIONS - Modern Layout */
    section {
        padding: 120px 0;
        position: relative;
    }
    
    section.overlay-section {
        overflow: hidden;
    }
    
    section .geometric-bg {
        z-index: 0;
    }
    
    section > .container {
        position: relative;
        z-index: 1;
    }

    .section-header {
        text-align: center;
        margin-bottom: 50px;
    }

    .section-subtitle {
        color: #e6b55c;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 4px;
        margin-bottom: 15px;
        font-weight: 600;
        display: inline-block;
        position: relative;
        padding-left: 20px;
    }
    
    .section-subtitle::before {
        content: '';
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 12px;
        height: 2px;
        background: #e6b55c;
    }

    /* DARK SECTION */
    .dark {
        background: #0f0f0f;
        color: #fff;
    }

    /* SERVICES */
    .services-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 30px;
        }
        
        .service-card {
            background: #fff;
            border-radius: 0;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            clip-path: polygon(0 0, calc(100% - 30px) 0, 100% 30px, 100% 100%, 0 100%);
        }
        
        .service-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 30px;
            height: 30px;
            background: linear-gradient(135deg, #e6b55c, #d4a347);
            clip-path: polygon(0 0, 100% 0, 100% 100%);
            z-index: 1;
        }
        
        .service-card::after {
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
        
        .service-card:hover::after {
            opacity: 1;
        }
        
        .service-card:hover {
            transform: translateY(-15px) rotateY(2deg);
            box-shadow: 0 20px 60px rgba(230,181,92,0.25);
        }
        
        .service-img {
            height: 250px;
            background-size: cover;
            background-position: center;
            position: relative;
            overflow: hidden;
            transition: transform 0.6s ease;
        }
        
        .service-img::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(230,181,92,0.2) 0%, transparent 100%);
            opacity: 0;
            transition: opacity 0.5s ease;
            z-index: 1;
        }
        
        .service-card:hover .service-img {
            transform: scale(1.1);
        }
        
        .service-card:hover .service-img::before {
            opacity: 1;
        }
        
        .service-content {
            padding: 30px;
            position: relative;
            z-index: 1;
        }
        
        .service-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 15px;
            color: #1f2a1f;
            font-family: 'Playfair Display', serif;
            position: relative;
            padding-left: 15px;
        }
        
        .service-title::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: linear-gradient(180deg, #e6b55c, #d4a347);
        }
        
        .service-desc {
            color: #666;
            margin-bottom: 25px;
            line-height: 1.8;
            font-size: 15px;
        }

    /* TESTIMONIAL */
    .testimonials-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 30px;
    }

    .testimonial {
        background: rgba(20, 34, 24, 0.8);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        color: #fff;
        border-radius: 0;
        padding: 40px;
        position: relative;
        border: 1px solid rgba(230, 181, 92, 0.2);
        clip-path: polygon(0 0, calc(100% - 20px) 0, 100% 20px, 100% 100%, 20px 100%, 0 calc(100% - 20px));
        transition: all 0.5s ease;
    }
    
    .testimonial::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 20px;
        height: 20px;
        background: linear-gradient(135deg, #e6b55c, #d4a347);
        clip-path: polygon(0 0, 100% 0, 100% 100%);
    }
    
    .testimonial::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 20px;
        height: 20px;
        background: linear-gradient(135deg, #e6b55c, #d4a347);
        clip-path: polygon(0 0, 100% 100%, 0 100%);
    }
    
    .testimonial:hover {
        transform: translateY(-10px) rotateX(2deg);
        box-shadow: 0 20px 50px rgba(0,0,0,0.4);
        border-color: rgba(230, 181, 92, 0.4);
    }

    .testimonial:before {
        content: """;
        font-family: serif;
        font-size: 100px;
        color: #e6b55c;
            position: absolute;
        top: -20px;
        left: 10px;
        opacity: 0.3;
        }
        
        .testimonial-text {
        margin-bottom: 20px;
            font-style: italic;
        }
        
        .testimonial-author {
            display: flex;
            align-items: center;
        }
        
        .author-img {
        width: 50px;
        height: 50px;
            border-radius: 50%;
        background-color: #e6b55c;
        margin-right: 15px;
            overflow: hidden;
    }

    .author-info h4 {
        margin-bottom: 5px;
    }

    .author-info p {
        color: #c5d2a4;
            font-size: 14px;
        }
        
    /* APPOINTMENT */
    .appointment {
        background: linear-gradient(rgba(31,42,31,0.9), rgba(31,42,31,0.9)),
                    url("${pageContext.request.contextPath}/images/treatment3.jpg") center/cover;
        color: #fff;
        text-align: center;
        }
        
        .appointment-form {
        max-width: 600px;
        margin: 0 auto;
        background: rgba(255,255,255,0.12);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        padding: 50px;
        border-radius: 0;
        border: 1px solid rgba(230, 181, 92, 0.2);
        clip-path: polygon(0 0, calc(100% - 30px) 0, 100% 30px, 100% 100%, 30px 100%, 0 calc(100% - 30px));
        box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        position: relative;
        transition: all 0.5s ease;
    }
    
    .appointment-form::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 30px;
        height: 30px;
        background: linear-gradient(135deg, #e6b55c, #d4a347);
        clip-path: polygon(0 0, 100% 0, 100% 100%);
    }
    
    .appointment-form::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 30px;
        height: 30px;
        background: linear-gradient(135deg, #e6b55c, #d4a347);
        clip-path: polygon(0 0, 100% 100%, 0 100%);
    }
    
    .appointment-form:hover {
        background: rgba(255,255,255,0.15);
        border-color: rgba(230, 181, 92, 0.4);
        box-shadow: 0 25px 70px rgba(0,0,0,0.4);
    }

    .form-group {
            margin-bottom: 20px;
        text-align: left;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
    }

    .form-control {
        width: 100%;
        padding: 14px 18px;
        border-radius: 0;
        border: 1px solid rgba(255,255,255,0.2);
        background: rgba(255,255,255,0.1);
        color: #fff;
        font-size: 16px;
        transition: all 0.3s ease;
        clip-path: polygon(0 0, calc(100% - 10px) 0, 100% 10px, 100% 100%, 10px 100%, 0 calc(100% - 10px));
    }
    
    .form-control::placeholder {
        color: rgba(255,255,255,0.6);
    }
        
    .form-control:focus {
        outline: none;
        border-color: #e6b55c;
        background: rgba(255,255,255,0.15);
        box-shadow: 0 0 0 3px rgba(230, 181, 92, 0.2);
        transform: translateY(-2px);
    }

    /* FOOTER - Modern Design */
    footer {
        background: linear-gradient(135deg, #1f2a1f 0%, #0f160f 100%);
        color: #cdd6b6;
        padding: 100px 0 30px;
        position: relative;
        overflow: hidden;
    }
    
    footer::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 2px;
        background: linear-gradient(90deg, transparent, #e6b55c, transparent);
    }
    
    footer .geometric-bg {
        opacity: 0.05;
    }

    .footer-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 40px;
        margin-bottom: 40px;
    }

    .footer-col h3 {
        color: #e6b55c;
        margin-bottom: 30px;
        font-size: 22px;
        font-weight: 700;
        font-family: 'Playfair Display', serif;
        position: relative;
        padding-left: 20px;
    }
    
    .footer-col h3::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        bottom: 0;
        width: 4px;
        background: linear-gradient(180deg, #e6b55c, #d4a347);
    }
        
        .footer-links {
            list-style: none;
        }
        
        .footer-links li {
            margin-bottom: 12px;
        }
        
        .footer-links a {
        color: #cdd6b6;
            text-decoration: none;
        transition: color 0.3s ease;
        }
        
        .footer-links a:hover {
        color: #e6b55c;
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
        width: 45px;
        height: 45px;
        border-radius: 0;
        background: rgba(255,255,255,0.08);
        color: #cdd6b6;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        border: 1px solid rgba(230, 181, 92, 0.2);
        clip-path: polygon(0 0, calc(100% - 8px) 0, 100% 8px, 100% 100%, 8px 100%, 0 calc(100% - 8px));
        position: relative;
    }
    
    .social-links a::before {
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

    .social-links a:hover {
        background: linear-gradient(135deg, #e6b55c, #d4a347);
        color: #1f2a1f;
        transform: translateY(-5px) scale(1.1);
        box-shadow: 0 8px 25px rgba(230,181,92,0.4);
        border-color: transparent;
    }
    
    .social-links a:hover::before {
        opacity: 1;
    }

    .newsletter input {
            border-radius: 30px;
            border: none;
        padding: 12px 15px;
        width: 100%;
        margin-bottom: 15px;
    }

    .copyright {
            text-align: center;
        padding-top: 30px;
        border-top: 1px solid rgba(255,255,255,0.1);
        font-size: 14px;
    }

    /* RESPONSIVE */
    @media (max-width: 992px) {
        .hero-content h1 {
            font-size: 46px;
            }
            
            .section-title {
                font-size: 36px;
            }
    }

    @media (max-width: 768px) {
        .hero-content h1 {
                font-size: 36px;
            }
            
            .section-title {
            font-size: 32px;
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
    <!-- Welcome Toast Notification - Golden Animated -->
    <c:if test="${showWelcome == true && not empty currentUser}">
        <div class="welcome-toast-home" id="welcomeToastHome">
            <div class="toast-content-wrapper">
                <div class="toast-golden-bg"></div>
                <div class="toast-content-inner">
                    <div class="toast-icon-golden">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="toast-message-golden">
                        <strong>Welcome back, ${currentUser.fullName}! 👋</strong>
                        <p>You're successfully logged in. Start exploring our Ayurvedic wellness services!</p>
                    </div>
                    <button class="toast-close-golden" onclick="closeWelcomeToast()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="toast-shine"></div>
            </div>
        </div>
    </c:if>
    
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/services">Services</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contact</a>
                    </li>
                    <c:choose>
                        <c:when test="${not empty currentUser}">
                            <li class="nav-item">
                                <a class="nav-link nav-dashboard" href="${pageContext.request.contextPath}/user/dashboard">
                                    <i class="fas fa-th-large"></i> Dashboard
                                </a>
                            </li>
                            <li class="nav-item dropdown user-dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" title="Your account menu">
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
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" id="loginDropdown">
                                    <i class="fas fa-sign-in-alt me-2"></i>Login
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/login">
                                        <i class="fas fa-user me-2"></i>User Login
                                    </a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/hospital/login">
                                        <i class="fas fa-hospital me-2"></i>Hospital Login
                                    </a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/doctor/login">
                                        <i class="fas fa-user-md me-2"></i>Doctor Login
                                    </a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/vendor/login">
                                        <i class="fas fa-store me-2"></i>Vendor Login
                                    </a></li>
                                </ul>
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
    <section class="hero overlay-section">
        <!-- Geometric Background -->
        <div class="geometric-bg"></div>
        <div class="gradient-mesh"></div>
        <div class="geometric-shape" style="width: 300px; height: 300px; top: 20%; right: 10%;"></div>
        
        <!-- Slides -->
        <div class="hero-slide active" style="background-image:url('${pageContext.request.contextPath}/images/hero7.jpg')"></div>
        <div class="hero-slide" style="background-image:url('${pageContext.request.contextPath}/images/hero5.jpg')"></div>
        <div class="hero-slide" style="background-image:url('${pageContext.request.contextPath}/images/hero2.jpg')"></div>
        <div class="hero-slide" style="background-image:url('${pageContext.request.contextPath}/images/hero9.jpg')"></div>

        <!-- Dark overlay -->
        <div class="hero-overlay"></div>
        
        <!-- Content -->
        <div class="container hero-content">
            <h1 id="heroTitle"></h1>
            <p id="heroDesc"></p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/user/register" class="btn-gold" id="heroBtn1"></a>
                <a href="${pageContext.request.contextPath}/services" class="btn-gold btn-outline" id="heroBtn2" style="margin-left: 15px;"></a>
            </div>
        </div>
        
        <!-- Pagination -->
        <div class="hero-dots">
            <span class="active"></span>
            <span></span>
            <span></span>
            <span></span>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats overlay-section">
        <div class="geometric-bg"></div>
        <div class="geometric-shape"></div>
        <div class="container stats-container">
                    <div class="stat-item">
                <div class="stat-number">25+</div>
                <div class="stat-text">Years of Experience</div>
                    </div>
                    <div class="stat-item">
                <div class="stat-number">10,000+</div>
                <div class="stat-text">Patients Treated</div>
                    </div>
                    <div class="stat-item">
                <div class="stat-number">98%</div>
                <div class="stat-text">Satisfaction Rate</div>
                    </div>
                    <div class="stat-item">
                <div class="stat-number">50+</div>
                <div class="stat-text">Ayurvedic Experts</div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="overlay-section">
        <div class="geometric-bg"></div>
        <div class="gradient-mesh"></div>
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">Our Philosophy</p>
                <h2 class="section-title">The Ayurvedic Approach</h2>
            </div>
            <div class="about-content">
                <p style="text-align: center; max-width: 800px; margin: 0 auto 30px; font-size: 18px;">
                    Ayurveda, the ancient Indian system of medicine, views health as a perfect balance between body, mind, and consciousness. 
                    Our center specializes in personalized treatments that address the root cause of imbalance rather than just symptoms.
                </p>
                <div style="text-align: center;">
                    <a href="${pageContext.request.contextPath}/services" class="btn-gold">Discover Our Methods</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Animation Images Section -->
   <section class="balance-section">
    <div class="balance-container">
        <div class="balance-left">
            <img src="https://images.unsplash.com/photo-1599901860904-17e6ed7083a0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" 
                 alt="Yoga Meditation" class="balance-image">
        </div>
        
        <div class="balance-center">
            <h3>Holistic Balance</h3>
            <p>Ayurveda teaches us that true wellness comes from harmony between body, mind, and spirit. Our ancient practices bring modern healing.</p>
            <a href="${pageContext.request.contextPath}/services" class="btn-gold">Explore Balance</a>
        </div>
        
        <div class="balance-right">
            <img src="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" 
                 alt="Ayurvedic Treatment" class="balance-image">
        </div>
    </div>
</section>

<style>
    .balance-section {
        padding: 80px 20px;
        background-color: #f9f7f2;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    .balance-container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        justify-content: center;
        gap: 40px;
    }
    
    .balance-left, .balance-right {
        flex: 1;
        min-width: 300px;
        max-width: 400px;
    }
    
    .balance-center {
        flex: 1.2;
        min-width: 300px;
        max-width: 500px;
        padding: 0 20px;
        text-align: center;
    }
    
    .balance-image {
        width: 100%;
        height: 400px;
        object-fit: cover;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease;
    }
    
    .balance-left .balance-image {
        border-top-right-radius: 40px;
        border-bottom-left-radius: 40px;
    }
    
    .balance-right .balance-image {
        border-top-left-radius: 40px;
        border-bottom-right-radius: 40px;
    }
    
    .balance-image:hover {
        transform: scale(1.02);
    }
    
    .balance-center h3 {
        color: #8a6d3b;
        font-size: 2.2rem;
        margin-bottom: 20px;
        position: relative;
        display: inline-block;
    }
    
    .balance-center h3:after {
        content: '';
        position: absolute;
        width: 60%;
        height: 3px;
        background: linear-gradient(90deg, transparent, #8a6d3b, transparent);
        bottom: -10px;
        left: 20%;
    }
    
    .balance-center p {
        color: #555;
        font-size: 1.1rem;
        line-height: 1.7;
        margin-bottom: 30px;
        padding: 0 10px;
    }
    
    .btn-gold {
        display: inline-block;
        background: linear-gradient(to right, #c9a959, #8a6d3b);
        color: white;
        padding: 14px 32px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 600;
        font-size: 1rem;
        letter-spacing: 1px;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        box-shadow: 0 5px 15px rgba(138, 109, 59, 0.2);
    }
    
    .btn-gold:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(138, 109, 59, 0.3);
        background: linear-gradient(to right, #8a6d3b, #c9a959);
    }
    
    /* Responsive Design */
    @media (max-width: 992px) {
        .balance-container {
            flex-direction: column;
        }
        
        .balance-left, .balance-center, .balance-right {
            max-width: 100%;
        }
        
        .balance-center {
            order: 1;
        }
        
        .balance-left {
            order: 2;
        }
        
        .balance-right {
            order: 3;
        }
    }
    
    @media (max-width: 768px) {
        .balance-section {
            padding: 60px 15px;
        }
        
        .balance-image {
            height: 300px;
        }
        
        .balance-center h3 {
            font-size: 1.8rem;
        }
        
        .balance-center p {
            font-size: 1rem;
        }
    }
</style>

    <!-- Services Section -->
    <section id="services" class="dark overlay-section">
        <div class="geometric-bg"></div>
        <div class="hex-pattern"></div>
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">What We Offer</p>
                <h2 class="section-title light">Our Ayurvedic Services</h2>
            </div>
            <div class="services-container">
                    <div class="service-card">
                    <div class="service-img" style="background-image: url('${pageContext.request.contextPath}/images/treatment1.jpg');"></div>
                        <div class="service-content">
                            <h3 class="service-title">Panchakarma Therapy</h3>
                            <p class="service-desc">A comprehensive detoxification and rejuvenation program that eliminates toxins and restores constitutional balance.</p>
                        <a href="${pageContext.request.contextPath}/services" class="btn-gold">Learn More</a>
                        </div>
                    </div>
                    <div class="service-card">
                    <div class="service-img" style="background-image: url('${pageContext.request.contextPath}/images/treatment2.jpg');"></div>
                        <div class="service-content">
                            <h3 class="service-title">Herbal Consultations</h3>
                            <p class="service-desc">Personalized herbal formulations based on your unique constitution and health concerns.</p>
                        <a href="${pageContext.request.contextPath}/services" class="btn-gold">Learn More</a>
                        </div>
                    </div>
                    <div class="service-card">
                    <div class="service-img" style="background-image: url('${pageContext.request.contextPath}/images/treatment3.jpg');"></div>
                        <div class="service-content">
                        <h3 class="service-title">Diet & Lifestyle Guidance</h3>
                            <p class="service-desc">Customized nutritional plans and daily routines aligned with your dosha for optimal wellbeing.</p>
                        <a href="${pageContext.request.contextPath}/services" class="btn-gold">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section id="testimonials" class="dark overlay-section">
        <div class="geometric-bg"></div>
        <div class="gradient-mesh"></div>
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">Patient Stories</p>
                <h2 class="section-title light">What Our Patients Say</h2>
            </div>
            
            <div class="testimonials-container">
                <div class="testimonial">
                    <p class="testimonial-text">After years of struggling with digestive issues, Ayurveda Wellness provided a comprehensive treatment plan that transformed my health. I've never felt better!</p>
                        <div class="testimonial-author">
                            <div class="author-img">
                            <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" 
                                 alt="Sarah Johnson" 
                                 style="width:100%; height:100%; object-fit:cover; border-radius:50%;">
                            </div>
                        <div class="author-info">
                            <h4>Sarah Johnson</h4>
                            <p>Chronic Digestive Issues</p>
                            </div>
                        </div>
                    </div>
                <div class="testimonial">
                    <p class="testimonial-text">The Panchakarma therapy was life-changing. Not only did it alleviate my joint pain, but it also brought a sense of mental clarity I haven't experienced in years.</p>
                        <div class="testimonial-author">
                            <div class="author-img">
                            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80" 
                                 alt="Michael Chen" 
                                 style="width:100%; height:100%; object-fit:cover; border-radius:50%;">
                            </div>
                        <div class="author-info">
                            <h4>Michael Chen</h4>
                            <p>Arthritis & Stress</p>
                            </div>
                        </div>
                    </div>
                <div class="testimonial">
                    <p class="testimonial-text">The personalized diet and lifestyle recommendations have helped me manage my stress levels and improve my sleep quality significantly. Thank you!</p>
                        <div class="testimonial-author">
                            <div class="author-img">
                            <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80" 
                                 alt="Priya Sharma" 
                                 style="width:100%; height:100%; object-fit:cover; border-radius:50%;">
                            </div>
                        <div class="author-info">
                            <h4>Priya Sharma</h4>
                            <p>Insomnia & Anxiety</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Appointment Section -->
    <section class="appointment overlay-section">
        <div class="geometric-bg"></div>
        <div class="container">
            <div class="section-header">
                <p class="section-subtitle">Begin Your Journey</p>
                <h2 class="section-title light">Book a Consultation</h2>
            </div>
            <div class="appointment-form">
                <form>
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" class="form-control" placeholder="Enter your name">
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" class="form-control" placeholder="Enter your email">
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" class="form-control" placeholder="Enter your phone">
                    </div>
                    <div class="form-group">
                        <label for="service">Service Interested In</label>
                        <select id="service" class="form-control">
                            <option value="">Select a service</option>
                            <option value="consultation">Initial Consultation</option>
                            <option value="panchakarma">Panchakarma Therapy</option>
                            <option value="herbal">Herbal Consultation</option>
                            <option value="diet">Diet & Lifestyle Guidance</option>
                    </select>
                    </div>
                    <button type="submit" class="btn-gold" style="width: 100%;">Request Appointment</button>
                </form>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer id="contact" class="overlay-section">
        <div class="geometric-bg"></div>
        <div class="container">
            <div class="footer-container">
                <div class="footer-col">
                    <h3>Ayurveda Wellness</h3>
                    <p>Providing authentic Ayurvedic treatments and consultations for over 25 years. Our mission is to help you achieve optimal health through natural, time-tested methods.</p>
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
                        <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/terms-and-conditions">Terms & Conditions</a></li>
                        <li><a href="${pageContext.request.contextPath}/privacy-policy">Privacy Policy</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h3>Our Services</h3>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/services">Panchakarma Therapy</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Herbal Medicine</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Yoga & Meditation</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Diet & Nutrition</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Detox Programs</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h3>Newsletter</h3>
                    <p>Subscribe to our newsletter for health tips and special offers.</p>
                    <div class="newsletter">
                        <input type="email" placeholder="Your email address">
                        <button class="btn-gold" style="width: 100%;">Subscribe</button>
                    </div>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2025 Ayurveda Wellness Center. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Register GSAP plugins
        gsap.registerPlugin(ScrollTrigger);
        
        // Navbar scroll effect
        window.addEventListener('scroll', () => {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
        
        // Animate service cards with modern effect
        gsap.utils.toArray('.service-card').forEach((card, index) => {
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
        
        // Animate testimonials
        gsap.utils.toArray('.testimonial').forEach((testimonial, index) => {
            gsap.from(testimonial, {
                scrollTrigger: {
                    trigger: testimonial,
                    start: 'top 85%',
                    toggleActions: 'play none none none'
                },
                opacity: 0,
                scale: 0.8,
                rotation: index % 2 === 0 ? -5 : 5,
                duration: 0.8,
                delay: index * 0.15,
                ease: 'back.out(1.7)'
            });
        });
        
        // Animate stats
        gsap.utils.toArray('.stat-item').forEach((stat, index) => {
            gsap.from(stat, {
                scrollTrigger: {
                    trigger: stat,
                    start: 'top 85%',
                    toggleActions: 'play none none none'
                },
                opacity: 0,
                scale: 0.5,
                duration: 0.6,
                delay: index * 0.1,
                ease: 'elastic.out(1, 0.5)'
            });
        });
        
        // Animate section titles
        gsap.utils.toArray('.section-title').forEach((title) => {
            gsap.from(title, {
                scrollTrigger: {
                    trigger: title,
                    start: 'top 90%',
                    toggleActions: 'play none none none'
                },
                opacity: 0,
                y: 40,
                duration: 1,
                ease: 'power3.out'
            });
        });
        
        // Parallax for geometric shapes
        gsap.utils.toArray('.geometric-shape').forEach((shape) => {
            gsap.to(shape, {
                scrollTrigger: {
                    trigger: shape,
                    start: 'top bottom',
                    end: 'bottom top',
                    scrub: 1
                },
                rotation: 360,
                ease: 'none'
            });
        });
        
        // Animate hero content
        gsap.from('.hero-content h1', {
            opacity: 0,
            y: 50,
            duration: 1,
            ease: 'power3.out',
            delay: 0.3
        });
        
        gsap.from('.hero-content p', {
            opacity: 0,
            y: 30,
            duration: 1,
            ease: 'power3.out',
            delay: 0.5
        });
        
        gsap.from('.hero-buttons', {
            opacity: 0,
            y: 20,
            duration: 1,
            ease: 'power3.out',
            delay: 0.7
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

        // Hero slider functionality
        const slides = document.querySelectorAll('.hero-slide');
        const dots = document.querySelectorAll('.hero-dots span');
        
        const slideContent = [
            {
                title: "Ancient Healing for Modern Life",
                desc: "Discover the transformative power of Ayurveda with personalized treatments, herbal remedies, and lifestyle guidance.",
                btn1: "Begin Your Journey",
                btn2: "Learn More"
            },
            {
                title: "Personalized Panchakarma Therapy",
                desc: "Deep detox and rejuvenation programs designed according to your body constitution and health goals.",
                btn1: "Explore Panchakarma",
                btn2: "Our Programs"
            },
            {
                title: "Herbal Medicine & Natural Healing",
                desc: "Custom herbal formulations prepared by experienced Ayurvedic doctors for long-lasting wellness.",
                btn1: "Consult Now",
                btn2: "Herbal Care"
            },
            {
                title: "Yoga & Meditation for Inner Balance",
                desc: "Mind-body wellness practices combining yoga, meditation, and pranayama for holistic healing.",
                btn1: "Start Practice",
                btn2: "View Schedule"
            }
        ];

        let current = 0;

        const heroTitle = document.getElementById("heroTitle");
        const heroDesc  = document.getElementById("heroDesc");
        const heroBtn1  = document.getElementById("heroBtn1");
        const heroBtn2  = document.getElementById("heroBtn2");
        
        function showSlide(index) {
            // Animate out
            gsap.to([heroTitle, heroDesc, heroBtn1, heroBtn2], {
                opacity: 0,
                y: -20,
                duration: 0.3,
                ease: 'power2.in',
                onComplete: () => {
                    // Update content
                    slides.forEach((slide, i) => {
                        slide.classList.toggle('active', i === index);
                        if (dots[i]) dots[i].classList.toggle('active', i === index);
                    });

                    heroTitle.textContent = slideContent[index].title;
                    heroDesc.textContent  = slideContent[index].desc;
                    heroBtn1.textContent  = slideContent[index].btn1;
                    heroBtn2.textContent  = slideContent[index].btn2;
                    
                    // Animate in
                    gsap.fromTo([heroTitle, heroDesc, heroBtn1, heroBtn2], 
                        { opacity: 0, y: 20 },
                        { 
                            opacity: 1, 
                            y: 0, 
                            duration: 0.6, 
                            ease: 'power3.out',
                            stagger: 0.1
                        }
                    );
                }
            });

            current = index;
        }

        showSlide(0);

        setInterval(() => {
            showSlide((current + 1) % slides.length);
        }, 5000);

        dots.forEach((dot, i) => {
            dot.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                showSlide(i);
            });
        });
        
        // Welcome Toast Notification - Golden Animated
        function closeWelcomeToast() {
            const toast = document.getElementById('welcomeToastHome');
            if (toast) {
                toast.classList.add('hide');
                setTimeout(() => {
                    toast.style.display = 'none';
                }, 500);
            }
        }
        
        // Auto-dismiss toast after 6 seconds
        window.addEventListener('DOMContentLoaded', () => {
            const toast = document.getElementById('welcomeToastHome');
            if (toast) {
                // Use GSAP for smooth animation
                gsap.fromTo(toast, 
                    {
                        opacity: 0,
                        x: 500,
                        scale: 0.8,
                        rotation: -5
                    },
                    {
                        opacity: 1,
                        x: 0,
                        scale: 1,
                        rotation: 0,
                        duration: 0.8,
                        ease: "back.out(1.7)",
                        delay: 0.3
                    }
                );
                
                // Auto-dismiss after 6 seconds
                setTimeout(() => {
                    gsap.to(toast, {
                        opacity: 0,
                        x: 500,
                        scale: 0.8,
                        rotation: 5,
                        duration: 0.5,
                        ease: "power2.in",
                        onComplete: () => {
                            toast.style.display = 'none';
                        }
                    });
                }, 6000);
            }
        });
    </script>
</body>
</html>
