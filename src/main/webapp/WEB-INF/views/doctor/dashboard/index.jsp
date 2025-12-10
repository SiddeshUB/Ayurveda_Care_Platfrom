<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Dashboard - AyurVedaCare</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        /* ============================================
           AYURVEDIC DOCTOR DASHBOARD - WOW DESIGN
           ============================================ */
        
        /* Base Reset & Variables - Ayurvedic Color Palette */
        :root {
            /* Ayurvedic Green Theme */
            --ayur-dark-green: #0a3d2c;      /* Deep forest green */
            --ayur-medium-green: #1a5c40;    /* Sage green */
            --ayur-light-green: #2e7d5a;     /* Healing green */
            --ayur-accent-gold: #d4af37;     /* Ayurvedic gold */
            --ayur-warm-brown: #8b7355;      /* Earthy brown */
            --ayur-cream: #f5f1e6;          /* Cream background */
            --ayur-teal: #2a9d8f;           /* Healing teal */
            --ayur-olive: #6a994e;          /* Olive green */
            --ayur-moss: #386641;           /* Moss green */
            --ayur-spice: #bc6c25;          /* Spice orange */
            
            /* Dashboard Layout */
            --sidebar-width: 280px;
            --sidebar-collapsed: 80px;
            --header-height: 80px;
            --border-radius: 16px;
            --card-shadow: 0 10px 40px rgba(10, 61, 44, 0.1);
            --hover-shadow: 0 15px 50px rgba(10, 61, 44, 0.15);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        /* Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Nunito Sans', sans-serif;
            background: linear-gradient(135deg, #f0f7f4 0%, #e8f1ed 100%);
            color: #2c3e50;
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        .dashboard-body {
            display: flex;
            min-height: 100vh;
        }
        
        /* ============ SIDEBAR STYLES - AYURVEDIC DESIGN ============ */
        .sidebar {
            width: var(--sidebar-width);
            background: linear-gradient(180deg, var(--ayur-dark-green) 0%, var(--ayur-medium-green) 100%);
            color: white;
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100vh;
            z-index: 1000;
            transition: var(--transition);
            box-shadow: 5px 0 25px rgba(10, 61, 44, 0.2);
            border-right: 3px solid var(--ayur-accent-gold);
        }
        
        .sidebar-header {
            padding: 30px 25px;
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            text-align: center;
            background: rgba(10, 61, 44, 0.9);
            position: relative;
            overflow: hidden;
        }
        
        .sidebar-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, 
                transparent, 
                var(--ayur-accent-gold), 
                transparent
            );
        }
        
        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 15px;
            color: white;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: 700;
            justify-content: center;
            z-index: 1;
            position: relative;
        }
        
        .sidebar-logo i {
            font-size: 2.2rem;
            color: var(--ayur-accent-gold);
            text-shadow: 0 2px 10px rgba(212, 175, 55, 0.3);
        }
        
        .sidebar-logo .highlight {
            color: var(--ayur-accent-gold);
            font-weight: 800;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
        
        .sidebar-nav {
            flex: 1;
            padding: 25px 0;
            overflow-y: auto;
        }
        
        .nav-item {
            display: flex;
            align-items: center;
            gap: 18px;
            padding: 18px 30px;
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            transition: var(--transition);
            border-left: 4px solid transparent;
            margin: 8px 15px;
            position: relative;
            overflow: hidden;
            border-radius: 12px;
        }
        
        .nav-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, 
                transparent, 
                rgba(212, 175, 55, 0.1), 
                transparent
            );
            transition: left 0.6s ease;
        }
        
        .nav-item:hover::before {
            left: 100%;
        }
        
        .nav-item:hover {
            background: linear-gradient(90deg, 
                rgba(212, 175, 55, 0.15), 
                rgba(46, 125, 90, 0.2)
            );
            color: white;
            padding-left: 35px;
            transform: translateX(5px);
            border-left-color: var(--ayur-accent-gold);
        }
        
        .nav-item.active {
            background: linear-gradient(135deg, 
                rgba(46, 125, 90, 0.3), 
                rgba(212, 175, 55, 0.2)
            );
            border-left-color: var(--ayur-accent-gold);
            color: white;
            font-weight: 600;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .nav-item i {
            width: 24px;
            font-size: 1.2rem;
            text-align: center;
            color: var(--ayur-accent-gold);
        }
        
        .nav-item span {
            flex: 1;
            white-space: nowrap;
            font-size: 0.95rem;
        }
        
        .sidebar-footer {
            padding: 25px;
            border-top: 1px solid rgba(212, 175, 55, 0.2);
            display: flex;
            flex-direction: column;
            gap: 15px;
            background: rgba(10, 61, 44, 0.8);
        }
        
        .btn-outline {
            background: transparent;
            border: 2px solid var(--ayur-accent-gold);
            color: var(--ayur-accent-gold);
            padding: 12px 20px;
            border-radius: 10px;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 600;
            transition: var(--transition);
            font-size: 0.9rem;
        }
        
        .btn-outline:hover {
            background: var(--ayur-accent-gold);
            color: var(--ayur-dark-green);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
        }
        
        .logout-link {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            border-radius: 10px;
            transition: var(--transition);
            font-size: 0.9rem;
        }
        
        .logout-link:hover {
            background: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            transform: translateX(5px);
        }
        
        /* ============ MAIN CONTENT ============ */
        .dashboard-main {
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: var(--transition);
            background: linear-gradient(135deg, #f5f9f7 0%, #edf5f1 100%);
            min-height: 100vh;
        }
        
        /* Header Styles */
        .dashboard-header {
            background: white;
            height: var(--header-height);
            padding: 0 35px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 6px 20px rgba(10, 61, 44, 0.08);
            position: sticky;
            top: 0;
            z-index: 999;
            border-bottom: 2px solid var(--ayur-accent-gold);
        }
        
        .header-left {
            display: flex;
            align-items: center;
            gap: 25px;
        }
        
        .sidebar-toggle {
            background: var(--ayur-light-green);
            border: none;
            width: 45px;
            height: 45px;
            border-radius: 12px;
            font-size: 1.3rem;
            color: white;
            cursor: pointer;
            display: none;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(46, 125, 90, 0.2);
        }
        
        .sidebar-toggle:hover {
            background: var(--ayur-teal);
            transform: rotate(90deg);
        }
        
        .header-left h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--ayur-dark-green);
            font-weight: 700;
            background: linear-gradient(135deg, var(--ayur-dark-green), var(--ayur-teal));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .header-right {
            display: flex;
            align-items: center;
            gap: 30px;
        }
        
        .header-profile {
            display: flex;
            align-items: center;
            gap: 20px;
            background: linear-gradient(135deg, #f0f7f4, #e8f1ed);
            padding: 12px 25px;
            border-radius: 50px;
            transition: var(--transition);
            border: 2px solid rgba(46, 125, 90, 0.1);
            box-shadow: 0 4px 15px rgba(46, 125, 90, 0.1);
        }
        
        .header-profile:hover {
            background: white;
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(46, 125, 90, 0.15);
            border-color: rgba(212, 175, 55, 0.3);
        }
        
        .profile-info {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }
        
        .profile-name {
            font-weight: 700;
            color: var(--ayur-dark-green);
            font-size: 1.1rem;
        }
        
        .doctor-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: linear-gradient(135deg, var(--ayur-accent-gold), #e6c158);
            color: var(--ayur-dark-green);
            padding: 6px 16px;
            border-radius: 25px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            box-shadow: 0 3px 10px rgba(212, 175, 55, 0.2);
        }
        
        .profile-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--ayur-light-green), var(--ayur-teal));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.3rem;
            overflow: hidden;
            border: 3px solid var(--ayur-accent-gold);
            box-shadow: 0 4px 15px rgba(46, 125, 90, 0.3);
        }
        
        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        /* Dashboard Content */
        .dashboard-content {
            padding: 35px;
            max-width: 1500px;
            margin: 0 auto;
            width: 100%;
        }
        
        /* Welcome Banner */
        .welcome-banner {
            background: linear-gradient(135deg, 
                var(--ayur-dark-green), 
                var(--ayur-medium-green),
                var(--ayur-light-green)
            );
            border-radius: var(--border-radius);
            padding: 40px 45px;
            margin-bottom: 35px;
            color: white;
            position: relative;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            border: 2px solid rgba(212, 175, 55, 0.2);
        }
        
        .welcome-banner::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(212, 175, 55, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(42, 157, 143, 0.1) 0%, transparent 50%);
        }
        
        .welcome-banner::after {
            content: 'ॐ';
            position: absolute;
            right: 40px;
            bottom: 30px;
            font-size: 6rem;
            opacity: 0.08;
            font-family: 'Playfair Display', serif;
            transform: rotate(-15deg);
        }
        
        .welcome-text h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            margin-bottom: 15px;
            font-weight: 700;
            position: relative;
            display: inline-block;
        }
        
        .welcome-text h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 80px;
            height: 3px;
            background: var(--ayur-accent-gold);
            border-radius: 2px;
        }
        
        .welcome-text p {
            font-size: 1.2rem;
            opacity: 0.9;
            max-width: 700px;
            line-height: 1.6;
            margin-top: 25px;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 30px;
            display: flex;
            align-items: center;
            gap: 25px;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            border: 2px solid rgba(46, 125, 90, 0.1);
        }
        
        .stat-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: var(--hover-shadow);
            border-color: var(--ayur-accent-gold);
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 8px;
            height: 100%;
            background: linear-gradient(to bottom, var(--ayur-accent-gold), var(--ayur-light-green));
        }
        
        .stat-icon {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.2rem;
            color: white;
            flex-shrink: 0;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .stat-icon.bookings {
            background: linear-gradient(135deg, var(--ayur-dark-green), var(--ayur-medium-green));
        }
        
        .stat-icon.pending {
            background: linear-gradient(135deg, var(--ayur-spice), #d08c2c);
        }
        
        .stat-icon.views {
            background: linear-gradient(135deg, var(--ayur-teal), #38b2ac);
        }
        
        .stat-icon.revenue {
            background: linear-gradient(135deg, var(--ayur-accent-gold), #e6c158);
        }
        
        .stat-info h3 {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--ayur-dark-green);
            line-height: 1;
            margin-bottom: 8px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .stat-info p {
            color: var(--ayur-medium-green);
            font-size: 1.05rem;
            font-weight: 600;
            opacity: 0.9;
        }
        
        /* Dashboard Cards */
        .dashboard-card {
            background: white;
            border-radius: var(--border-radius);
            margin-bottom: 35px;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            overflow: hidden;
            border: 2px solid rgba(46, 125, 90, 0.1);
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
            border-color: rgba(212, 175, 55, 0.3);
        }
        
        .card-header {
            padding: 30px 35px;
            border-bottom: 2px solid #f0f7f4;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: linear-gradient(to right, #f9fbf8, white);
        }
        
        .card-header h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.6rem;
            color: var(--ayur-dark-green);
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .card-header h3 i {
            color: var(--ayur-accent-gold);
            font-size: 1.8rem;
            text-shadow: 0 2px 5px rgba(212, 175, 55, 0.2);
        }
        
        .view-all {
            color: var(--ayur-medium-green);
            text-decoration: none;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
            padding: 10px 20px;
            border-radius: 10px;
            background: rgba(46, 125, 90, 0.1);
            font-size: 0.95rem;
        }
        
        .view-all:hover {
            background: var(--ayur-light-green);
            color: white;
            transform: translateX(8px);
            box-shadow: 0 5px 15px rgba(46, 125, 90, 0.2);
        }
        
        .card-body {
            padding: 35px;
        }
        
        /* Booking List */
        .booking-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .booking-item {
            display: flex;
            align-items: center;
            gap: 25px;
            padding: 25px;
            background: linear-gradient(to right, #f9fbf8, #f5f9f7);
            border-radius: 15px;
            transition: var(--transition);
            border-left: 5px solid transparent;
            border: 2px solid rgba(46, 125, 90, 0.1);
        }
        
        .booking-item:hover {
            transform: translateX(8px);
            background: white;
            border-left-color: var(--ayur-accent-gold);
            box-shadow: 0 8px 25px rgba(46, 125, 90, 0.1);
            border-color: rgba(212, 175, 55, 0.3);
        }
        
        .booking-avatar {
            width: 70px;
            height: 70px;
            border-radius: 18px;
            background: linear-gradient(135deg, var(--ayur-light-green), var(--ayur-teal));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.8rem;
            flex-shrink: 0;
            box-shadow: 0 5px 20px rgba(46, 125, 90, 0.2);
        }
        
        .booking-avatar[style*="background: var(--primary-sage);"] {
            background: linear-gradient(135deg, var(--ayur-olive), var(--ayur-moss)) !important;
        }
        
        .booking-info {
            flex: 1;
        }
        
        .booking-info h4 {
            font-size: 1.2rem;
            color: var(--ayur-dark-green);
            margin-bottom: 8px;
            font-weight: 700;
        }
        
        .booking-meta {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 15px;
            min-width: 150px;
        }
        
        /* Badges */
        .badge {
            padding: 8px 18px;
            border-radius: 25px;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }
        
        .badge-success {
            background: linear-gradient(135deg, var(--ayur-olive), var(--ayur-moss));
            color: white;
        }
        
        .badge-warning {
            background: linear-gradient(135deg, var(--ayur-spice), #d08c2c);
            color: white;
        }
        
        .badge-error {
            background: linear-gradient(135deg, #e74c3c, #ec7063);
            color: white;
        }
        
        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            padding: 12px 25px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 700;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            font-size: 0.95rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-sm {
            padding: 10px 20px;
            font-size: 0.9rem;
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, var(--ayur-medium-green), var(--ayur-light-green));
            color: white;
        }
        
        .btn-secondary:hover {
            background: linear-gradient(135deg, var(--ayur-light-green), var(--ayur-teal));
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 25px rgba(46, 125, 90, 0.3);
        }
        
        /* Completion Card */
        .completion-card {
            background: linear-gradient(135deg, #fffbf0, #fff);
            border: 3px dashed var(--ayur-accent-gold);
            border-radius: var(--border-radius);
            padding: 40px;
            margin-bottom: 35px;
            position: relative;
            overflow: hidden;
        }
        
        .completion-card::before {
            content: '✿';
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 3rem;
            color: rgba(212, 175, 55, 0.1);
        }
        
        .completion-header {
            margin-bottom: 30px;
            text-align: center;
        }
        
        .completion-header h3 {
            color: var(--ayur-dark-green);
            font-size: 1.8rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        
        .completion-header p {
            color: var(--ayur-medium-green);
            max-width: 700px;
            margin: 0 auto;
            font-size: 1.1rem;
            line-height: 1.6;
        }
        
        .completion-items {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            max-width: 900px;
            margin: 0 auto;
        }
        
        .completion-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 20px;
            background: white;
            border-radius: 12px;
            transition: var(--transition);
            border: 2px solid rgba(46, 125, 90, 0.1);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .completion-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(46, 125, 90, 0.15);
            border-color: var(--ayur-accent-gold);
        }
        
        .completion-item.completed {
            background: linear-gradient(135deg, #f0f9f5, #fff);
            border-left: 5px solid var(--ayur-olive);
        }
        
        .completion-item i {
            font-size: 1.5rem;
            color: #bbb;
        }
        
        .completion-item.completed i {
            color: var(--ayur-olive);
            text-shadow: 0 2px 5px rgba(106, 153, 78, 0.2);
        }
        
        /* Star Ratings */
        .fa-star {
            color: var(--ayur-accent-gold);
            text-shadow: 0 1px 3px rgba(212, 175, 55, 0.3);
        }
        
        .far.fa-star {
            color: #d1d9c7;
        }
        
        /* ============ RESPONSIVE DESIGN ============ */
        @media (max-width: 1200px) {
            .sidebar {
                transform: translateX(-100%);
                box-shadow: 10px 0 40px rgba(10, 61, 44, 0.3);
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .dashboard-main {
                margin-left: 0;
            }
            
            .sidebar-toggle {
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .dashboard-content {
                padding: 25px;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .welcome-banner {
                padding: 30px;
            }
            
            .welcome-text h2 {
                font-size: 2rem;
            }
            
            .card-body {
                padding: 25px;
            }
            
            .booking-item {
                flex-direction: column;
                text-align: center;
                gap: 20px;
            }
            
            .booking-meta {
                align-items: center;
                width: 100%;
            }
            
            .header-left h1 {
                font-size: 1.6rem;
            }
            
            .header-profile {
                padding: 10px 20px;
            }
            
            .profile-info {
                display: none;
            }
            
            .completion-items {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 480px) {
            .dashboard-header {
                padding: 0 20px;
            }
            
            .welcome-banner {
                padding: 25px;
            }
            
            .welcome-text h2 {
                font-size: 1.8rem;
            }
            
            .stat-card {
                padding: 25px;
            }
            
            .stat-icon {
                width: 65px;
                height: 65px;
                font-size: 1.8rem;
            }
            
            .stat-info h3 {
                font-size: 2.2rem;
            }
            
            .card-header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .view-all {
                align-self: center;
            }
        }
        
        /* ============ ANIMATIONS ============ */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .welcome-banner {
            animation: fadeInUp 0.8s ease-out;
        }
        
        .stat-card {
            animation: fadeInUp 0.6s ease-out;
        }
        
        .dashboard-card {
            animation: fadeInUp 0.7s ease-out;
        }
        
        .booking-item:nth-child(1) { animation: fadeInUp 0.6s ease-out 0.1s both; }
        .booking-item:nth-child(2) { animation: fadeInUp 0.6s ease-out 0.2s both; }
        .booking-item:nth-child(3) { animation: fadeInUp 0.6s ease-out 0.3s both; }
        .booking-item:nth-child(4) { animation: fadeInUp 0.6s ease-out 0.4s both; }
        .booking-item:nth-child(5) { animation: fadeInUp 0.6s ease-out 0.5s both; }
        
        .doctor-badge {
            animation: pulse 2s infinite;
        }
        
        /* Scrollbar Styling - Ayurvedic Theme */
        ::-webkit-scrollbar {
            width: 10px;
            height: 10px;
        }
        
        ::-webkit-scrollbar-track {
            background: #f0f7f4;
            border-radius: 10px;
        }
        
        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, var(--ayur-light-green), var(--ayur-teal));
            border-radius: 10px;
            border: 2px solid #f0f7f4;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, var(--ayur-teal), var(--ayur-accent-gold));
        }
        
        /* Ayurvedic Pattern Overlay */
        .ayur-pattern {
            background-image: 
                radial-gradient(circle at 25% 25%, rgba(46, 125, 90, 0.03) 2px, transparent 2px),
                radial-gradient(circle at 75% 75%, rgba(212, 175, 55, 0.03) 2px, transparent 2px);
            background-size: 40px 40px;
        }
        
        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 25px;
            height: 25px;
            border: 3px solid rgba(46, 125, 90, 0.2);
            border-radius: 50%;
            border-top-color: var(--ayur-accent-gold);
            animation: spin 1s ease-in-out infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        /* Decorative Elements */
        .leaf-decoration {
            position: absolute;
            width: 80px;
            height: 80px;
            opacity: 0.1;
            pointer-events: none;
        }
        
        .leaf-decoration:nth-child(1) {
            top: 10%;
            left: 5%;
            transform: rotate(45deg);
        }
        
        .leaf-decoration:nth-child(2) {
            bottom: 10%;
            right: 5%;
            transform: rotate(-45deg);
        }
        
        
    </style>
</head>
<body class="dashboard-body">
    <!-- Decorative Leaves -->
    <div class="leaf-decoration">🍃</div>
    <div class="leaf-decoration">🌿</div>
    
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-leaf"></i>
                <span>Ayur<span class="highlight">Doctor</span></span>
            </a>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-item active">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/profile" class="nav-item">
                <i class="fas fa-user-circle"></i>
                <span>Profile</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Appointments</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/prescriptions" class="nav-item">
                <i class="fas fa-prescription"></i>
                <span>Prescriptions</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/health-records" class="nav-item">
                <i class="fas fa-file-medical"></i>
                <span>Health Records</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/reviews" class="nav-item">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availability" class="nav-item">
                <i class="fas fa-clock"></i>
                <span>Availability</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/packages" class="nav-item">
                <i class="fas fa-box"></i>
                <span>My Packages</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/bookings" class="nav-item">
                <i class="fas fa-book-medical"></i>
                <span>Package Bookings</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline btn-sm" target="_blank">
                <i class="fas fa-external-link-alt"></i> View AyurVedaCare
            </a>
            <a href="${pageContext.request.contextPath}/doctor/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="dashboard-main">
        <!-- Top Bar -->
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Ayurvedic Doctor Dashboard</h1>
            </div>
            
            <div class="header-right">
                <div class="header-profile">
                    <div class="profile-info">
                        <span class="profile-name">Dr. ${doctor.name}</span>
                        <span class="doctor-badge">
                            <i class="fas fa-leaf"></i> Ayurvedic Doctor
                        </span>
                    </div>
                    <div class="profile-avatar">
                        <c:choose>
                            <c:when test="${not empty doctor.photoUrl}">
                                <img src="${pageContext.request.contextPath}${doctor.photoUrl}" alt="Dr. ${doctor.name}">
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-user-md"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </header>

        <!-- Dashboard Content -->
        <div class="dashboard-content">
            

            <!-- Welcome Banner -->
            <div class="welcome-banner">
                <div class="welcome-text">
                    <h2>Welcome, Dr. ${doctor.name}!</h2>
                    <p>Balance, harmony, and healing. Manage your holistic practice and bring wellness to your patients today.</p>
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon bookings">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${todayAppointments != null ? todayAppointments.size() : 0}</h3>
                        <p>Today's Consultations</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon pending">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${pendingConsultations != null ? pendingConsultations.size() : 0}</h3>
                        <p>Pending Follow-ups</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon views">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${upcomingConsultations != null ? upcomingConsultations.size() : 0}</h3>
                        <p>Upcoming Sessions</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon revenue">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${averageRating != null ? String.format("%.1f", averageRating) : '0.0'}</h3>
                        <p>Patient Rating</p>
                    </div>
                </div>
            </div>

            <!-- My Packages Section -->
            <c:if test="${not empty packages}">
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3><i class="fas fa-spa"></i> My Ayurvedic Packages</h3>
                        <a href="${pageContext.request.contextPath}/doctor/packages" class="view-all">
                            View All <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="booking-list">
                            <c:forEach var="pkg" items="${packages}" end="4">
                                <div class="booking-item">
                                    <div class="booking-avatar" style="background: linear-gradient(135deg, var(--ayur-olive), var(--ayur-moss));">
                                        <i class="fas fa-spa"></i>
                                    </div>
                                    <div class="booking-info" style="flex: 1;">
                                        <h4>${pkg.packageName}</h4>
                                        <p style="color: var(--ayur-medium-green); margin-top: 5px; font-weight: 600;">
                                            <c:choose>
                                                <c:when test="${pkg.packageType == 'OTHERS'}">
                                                    ${pkg.customType != null ? pkg.customType : 'Custom Ayurvedic Package'}
                                                </c:when>
                                                <c:otherwise>
                                                    ${fn:replace(pkg.packageType, '_', ' ')}
                                                </c:otherwise>
                                            </c:choose>
                                            <c:if test="${pkg.durationDays != null}">
                                                • ${pkg.durationDays} Days
                                            </c:if>
                                        </p>
                                        <p style="color: #777; font-size: 0.9rem; margin-top: 8px; display: flex; align-items: center; gap: 8px;">
                                            <i class="fas fa-hospital-alt" style="color: var(--ayur-teal);"></i> 
                                            <span>${pkg.hospital.centerName}</span>
                                        </p>
                                    </div>
                                    <div class="booking-meta">
                                        <span class="badge ${pkg.isActive ? 'badge-success' : 'badge-error'}">
                                            ${pkg.isActive ? 'Active' : 'Inactive'}
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Package Bookings Section -->
            <c:if test="${not empty packageBookings}">
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3><i class="fas fa-book-medical"></i> Package Bookings</h3>
                        <a href="${pageContext.request.contextPath}/doctor/bookings" class="view-all">
                            View All <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="booking-list">
                            <c:forEach var="booking" items="${packageBookings}" end="4">
                                <div class="booking-item">
                                    <div class="booking-avatar">
                                        <i class="fas fa-user-injured"></i>
                                    </div>
                                    <div class="booking-info" style="flex: 1;">
                                        <h4>${booking.patientName}</h4>
                                        <p style="color: var(--ayur-medium-green); margin-top: 5px; font-weight: 600;">
                                            <i class="fas fa-spa"></i> ${booking.treatmentPackage.packageName}
                                            <c:if test="${booking.roomType != null}">
                                                • ${fn:replace(booking.roomType, '_', ' ')} Room
                                            </c:if>
                                        </p>
                                        <p style="color: #777; font-size: 0.9rem; margin-top: 8px; display: flex; align-items: center; gap: 8px;">
                                            <i class="fas fa-calendar" style="color: var(--ayur-teal);"></i> 
                                            <c:choose>
                                                <c:when test="${booking.checkInDate != null && booking.checkOutDate != null}">
                                                    <fmt:parseDate value="${booking.checkInDate}" pattern="yyyy-MM-dd" var="parsedCheckInDate" type="date"/>
                                                    <fmt:formatDate value="${parsedCheckInDate}" pattern="dd MMM yyyy"/> - 
                                                    <fmt:parseDate value="${booking.checkOutDate}" pattern="yyyy-MM-dd" var="parsedCheckOutDate" type="date"/>
                                                    <fmt:formatDate value="${parsedCheckOutDate}" pattern="dd MMM yyyy"/>
                                                </c:when>
                                                <c:when test="${booking.checkInDate != null}">
                                                    <fmt:parseDate value="${booking.checkInDate}" pattern="yyyy-MM-dd" var="parsedCheckInDateOnly" type="date"/>
                                                    <fmt:formatDate value="${parsedCheckInDateOnly}" pattern="dd MMM yyyy"/>
                                                </c:when>
                                            </c:choose>
                                            <c:if test="${booking.totalAmount != null}">
                                                • <i class="fas fa-rupee-sign" style="color: var(--ayur-spice);"></i> <fmt:formatNumber value="${booking.totalAmount}" maxFractionDigits="0"/>
                                            </c:if>
                                        </p>
                                    </div>
                                    <div class="booking-meta">
                                        <span class="badge ${booking.status == 'CONFIRMED' ? 'badge-success' : (booking.status == 'PENDING' ? 'badge-warning' : 'badge-error')}">
                                            ${booking.status}
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Today's Appointments -->
            <c:if test="${not empty todayAppointments}">
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3><i class="fas fa-calendar-day"></i> Today's Appointments</h3>
                        <a href="${pageContext.request.contextPath}/doctor/appointments" class="view-all">
                            View All <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="booking-list">
                            <c:forEach var="appointment" items="${todayAppointments}">
                                <div class="booking-item">
                                    <div class="booking-avatar">
                                        <i class="fas fa-user-injured"></i>
                                    </div>
                                    <div class="booking-info">
                                        <h4>${appointment.patientName}</h4>
                                        <p style="color: var(--ayur-medium-green); font-weight: 600;">
                                            <i class="fas fa-clock"></i> 
                                            <c:if test="${appointment.consultationTime != null}">
                                                ${appointment.consultationTime}
                                            </c:if>
                                            <c:if test="${appointment.consultationType != null}">
                                                • ${appointment.consultationType}
                                            </c:if>
                                        </p>
                                    </div>
                                    <div class="booking-meta">
                                        <span class="badge ${appointment.status == 'PENDING' ? 'badge-warning' : (appointment.status == 'CONFIRMED' ? 'badge-success' : 'badge-error')}">
                                            ${appointment.status}
                                        </span>
                                        <a href="${pageContext.request.contextPath}/doctor/appointments/${appointment.id}" class="btn btn-sm btn-secondary" style="margin-top: 8px;">
                                            View Details <i class="fas fa-external-link-alt"></i>
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Reviews Summary -->
            <c:if test="${not empty recentReviews}">
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3><i class="fas fa-star"></i> Patient Reviews</h3>
                        <a href="${pageContext.request.contextPath}/doctor/reviews" class="view-all">
                            View All <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="booking-list">
                            <c:forEach var="review" items="${recentReviews}">
                                <div class="booking-item">
                                    <div class="booking-avatar">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div class="booking-info" style="flex: 1;">
                                        <h4>${review.isAnonymous ? 'Anonymous Patient' : review.reviewerName}</h4>
                                        <div style="display: flex; align-items: center; gap: 12px; margin-top: 8px;">
                                            <div style="color: var(--ayur-accent-gold);">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <i class="fas fa-star ${i <= review.rating ? '' : 'far'}" style="font-size: 1rem;"></i>
                                                </c:forEach>
                                            </div>
                                            <span style="color: #777; font-size: 0.85rem;">
                                                <fmt:parseDate value="${review.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                                <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                            </span>
                                        </div>
                                        <c:if test="${not empty review.reviewText}">
                                            <p style="color: var(--ayur-dark-green); margin-top: 12px; font-size: 0.95rem; line-height: 1.6; font-style: italic; background: rgba(240, 247, 244, 0.5); padding: 12px; border-radius: 8px; border-left: 3px solid var(--ayur-accent-gold);">
                                                "${review.reviewText.length() > 120 ? review.reviewText.substring(0, 120).concat('...') : review.reviewText}"
                                            </p>
                                        </c:if>
                                    </div>
                                    <div class="booking-meta">
                                        <span class="badge ${review.status == 'APPROVED' ? 'badge-success' : (review.status == 'PENDING' ? 'badge-warning' : 'badge-error')}">
                                            ${review.status}
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Upcoming Consultations -->
            <c:if test="${not empty upcomingConsultations}">
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3><i class="fas fa-calendar-week"></i> Upcoming Consultations</h3>
                        <a href="${pageContext.request.contextPath}/doctor/appointments" class="view-all">
                            View All <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="booking-list">
                            <c:forEach var="consultation" items="${upcomingConsultations}" end="4">
                                <div class="booking-item">
                                    <div class="booking-avatar">
                                        <i class="fas fa-user-injured"></i>
                                    </div>
                                    <div class="booking-info">
                                        <h4>${consultation.patientName}</h4>
                                        <p style="color: var(--ayur-medium-green); font-weight: 600;">
                                            <fmt:parseDate value="${consultation.consultationDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                                            <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                            <c:if test="${consultation.consultationTime != null}">
                                                at ${consultation.consultationTime}
                                            </c:if>
                                        </p>
                                    </div>
                                    <div class="booking-meta">
                                        <span class="badge ${consultation.status == 'PENDING' ? 'badge-warning' : (consultation.status == 'CONFIRMED' ? 'badge-success' : 'badge-error')}">
                                            ${consultation.status}
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Profile Completion Notice -->
            <c:if test="${!doctor.profileComplete}">
                <div class="completion-card">
                    <div class="completion-header">
                        <h3><i class="fas fa-tasks"></i> Complete Your Ayurvedic Profile</h3>
                        <p>Enhance your practice visibility. Complete your profile to attract more patients seeking holistic healing.</p>
                    </div>
                    <div class="completion-items">
                        <div class="completion-item ${not empty doctor.qualifications ? 'completed' : ''}">
                            <i class="fas ${not empty doctor.qualifications ? 'fa-check-circle' : 'fa-circle'}"></i>
                            <span>Ayurvedic Qualifications</span>
                        </div>
                        <div class="completion-item ${not empty doctor.specializations ? 'completed' : ''}">
                            <i class="fas ${not empty doctor.specializations ? 'fa-check-circle' : 'fa-circle'}"></i>
                            <span>Specializations (Panchakarma, etc.)</span>
                        </div>
                        <div class="completion-item ${not empty doctor.biography ? 'completed' : ''}">
                            <i class="fas ${not empty doctor.biography ? 'fa-check-circle' : 'fa-circle'}"></i>
                            <span>Healing Philosophy</span>
                        </div>
                        <div class="completion-item ${not empty doctor.photoUrl ? 'completed' : ''}">
                            <i class="fas ${not empty doctor.photoUrl ? 'fa-check-circle' : 'fa-circle'}"></i>
                            <span>Professional Photo</span>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Quick Info -->
            <div class="dashboard-card">
                <div class="card-header">
                    <h3><i class="fas fa-info-circle"></i> Ayurvedic Practitioner Profile</h3>
                </div>
                <div class="card-body">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 25px;">
                        <div style="background: linear-gradient(135deg, #f0f9f5, white); padding: 20px; border-radius: 12px; border-left: 5px solid var(--ayur-light-green);">
                            <strong style="color: var(--ayur-dark-green); font-size: 0.95rem;">Email Address:</strong>
                            <div style="color: var(--ayur-medium-green); margin-top: 5px; font-weight: 600;">${doctor.email}</div>
                        </div>
                        <div style="background: linear-gradient(135deg, #f0f9f5, white); padding: 20px; border-radius: 12px; border-left: 5px solid var(--ayur-light-green);">
                            <strong style="color: var(--ayur-dark-green); font-size: 0.95rem;">Phone Number:</strong>
                            <div style="color: var(--ayur-medium-green); margin-top: 5px; font-weight: 600;">${not empty doctor.phone ? doctor.phone : 'Not provided'}</div>
                        </div>
                        <div style="background: linear-gradient(135deg, #f0f9f5, white); padding: 20px; border-radius: 12px; border-left: 5px solid var(--ayur-light-green);">
                            <strong style="color: var(--ayur-dark-green); font-size: 0.95rem;">Qualifications:</strong>
                            <div style="color: var(--ayur-medium-green); margin-top: 5px; font-weight: 600;">${not empty doctor.qualifications ? doctor.qualifications : 'Not provided'}</div>
                        </div>
                        <div style="background: linear-gradient(135deg, #f0f9f5, white); padding: 20px; border-radius: 12px; border-left: 5px solid var(--ayur-light-green);">
                            <strong style="color: var(--ayur-dark-green); font-size: 0.95rem;">Experience:</strong>
                            <div style="color: var(--ayur-medium-green); margin-top: 5px; font-weight: 600;">
                                ${doctor.experienceYears != null ? doctor.experienceYears : 0} Years
                                <span style="color: var(--ayur-accent-gold); font-size: 0.9rem; margin-left: 10px;">🌿 Ayurvedic Practice</span>
                            </div>
                        </div>
                        <div style="background: linear-gradient(135deg, #f0f9f5, white); padding: 20px; border-radius: 12px; border-left: 5px solid var(--ayur-light-green);">
                            <strong style="color: var(--ayur-dark-green); font-size: 0.95rem;">Account Status:</strong>
                            <div style="color: ${doctor.isActive ? 'var(--ayur-olive)' : 'var(--ayur-spice)'}; margin-top: 5px; font-weight: 700; display: flex; align-items: center; gap: 8px;">
                                <i class="fas fa-circle" style="font-size: 0.7rem;"></i>
                                ${doctor.isActive ? 'Active' : 'Inactive'}
                            </div>
                        </div>
                        <div style="background: linear-gradient(135deg, #f0f9f5, white); padding: 20px; border-radius: 12px; border-left: 5px solid var(--ayur-light-green);">
                            <strong style="color: var(--ayur-dark-green); font-size: 0.95rem;">Verification Status:</strong>
                            <div style="color: ${doctor.isVerified ? 'var(--ayur-olive)' : 'var(--ayur-spice)'}; margin-top: 5px; font-weight: 700; display: flex; align-items: center; gap: 8px;">
                                <i class="fas ${doctor.isVerified ? 'fa-check-circle' : 'fa-clock'}" style="color: ${doctor.isVerified ? 'var(--ayur-olive)' : 'var(--ayur-spice)'};"></i>
                                ${doctor.isVerified ? 'Verified Ayurvedic Doctor' : 'Verification Pending'}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script>
        // Sidebar toggle for mobile with Ayurvedic animation
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
                this.style.transform = sidebar.classList.contains('active') ? 'rotate(90deg)' : 'rotate(0)';
            });
        }
        
        // Add hover effects to cards with Ayurvedic feel
        document.querySelectorAll('.dashboard-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-8px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
        
        // Add pulsing effect to stat cards
        document.querySelectorAll('.stat-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                const icon = this.querySelector('.stat-icon');
                icon.style.transform = 'scale(1.1) rotate(5deg)';
            });
            
            card.addEventListener('mouseleave', function() {
                const icon = this.querySelector('.stat-icon');
                icon.style.transform = 'scale(1) rotate(0)';
            });
        });
        
        // Update current time with Ayurvedic greeting
        function updateTime() {
            const now = new Date();
            const hours = now.getHours();
            const timeString = now.toLocaleTimeString('en-US', { 
                hour: '2-digit', 
                minute: '2-digit',
                hour12: true 
            });
            
            let greeting = '';
            if (hours < 12) greeting = '🌅 Good Morning';
            else if (hours < 17) greeting = '☀️ Good Afternoon';
            else greeting = '🌙 Good Evening';
            
            // Update greeting if you add an element for it
            const greetingElement = document.querySelector('.greeting');
            if (greetingElement) {
                greetingElement.textContent = greeting;
            }
        }
        
        // Update time every minute
        setInterval(updateTime, 60000);
        updateTime();
        
        // Add loading states to buttons with Ayurvedic theme
        document.querySelectorAll('.btn').forEach(button => {
            button.addEventListener('click', function(e) {
                if (this.href) {
                    const originalText = this.innerHTML;
                    this.innerHTML = '<span class="loading"></span> Processing...';
                    this.style.pointerEvents = 'none';
                    
                    setTimeout(() => {
                        this.innerHTML = originalText;
                        this.style.pointerEvents = 'auto';
                    }, 2000);
                }
            });
        });
        
        // Add subtle floating animation to welcome banner
        const welcomeBanner = document.querySelector('.welcome-banner');
        if (welcomeBanner) {
            setInterval(() => {
                welcomeBanner.style.transform = 'translateY(-2px)';
                setTimeout(() => {
                    welcomeBanner.style.transform = 'translateY(0)';
                }, 500);
            }, 3000);
        }
    </script>
</body>
</html>