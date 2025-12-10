<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    /* NAVBAR STYLES - From home.jsp */
    .navbar {
        background: #1f2a1f;
        padding: 15px 0;
        position: fixed;
        width: 100%;
        top: 0;
        z-index: 1000;
        transition: all 0.3s ease;
    }
    
    .navbar.scrolled {
        padding: 10px 0;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    
    .container {
        width: 90%;
        max-width: 1200px;
        margin: 0 auto;
    }
    
    .nav-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .navbar-brand {
        font-family: 'Playfair Display', serif;
        color: #e6b55c !important;
        font-size: 28px;
        text-decoration: none;
        font-weight: 700;
    }
    
    .nav-links {
        display: flex;
        list-style: none;
    }
    
    .nav-links li {
        margin-left: 30px;
    }
    
    .nav-links a {
        color: #fff !important;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s ease;
    }
    
    .nav-links a:hover {
        color: #e6b55c !important;
    }
    
    .nav-links a.nav-cta {
        background: #e6b55c;
        color: #1f2a1f !important;
        padding: 8px 20px;
        border-radius: 25px;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .nav-links a.nav-cta:hover {
        background: #d4a550;
        color: #1f2a1f !important;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(230, 181, 92, 0.3);
    }
    
    /* User Menu Dropdown - Amazon Style */
    .user-menu-container {
        position: relative;
    }
    
    .user-name-link {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 8px 15px;
        border-radius: 20px;
        background: rgba(230, 181, 92, 0.1);
        transition: all 0.3s ease;
    }
    
    .user-name-link:hover {
        background: rgba(230, 181, 92, 0.2);
    }
    
    .user-name-link i.fa-user-circle {
        font-size: 20px;
        color: #e6b55c;
    }
    
    .user-name-link span {
        font-weight: 500;
        color: #fff;
    }
    
    .user-name-link .fa-chevron-down {
        font-size: 12px;
        color: #e6b55c;
        transition: transform 0.3s ease;
    }
    
    .user-menu-container:hover .fa-chevron-down {
        transform: rotate(180deg);
    }
    
    .user-dropdown {
        position: absolute;
        top: 100%;
        right: 0;
        margin-top: 10px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        min-width: 220px;
        opacity: 0;
        visibility: hidden;
        transform: translateY(-10px);
        transition: all 0.3s ease;
        z-index: 1000;
        padding: 8px 0;
    }
    
    .user-menu-container:hover .user-dropdown {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }
    
    .user-dropdown a {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 20px;
        color: #333 !important;
        text-decoration: none;
        transition: background 0.2s ease;
        font-size: 14px;
    }
    
    .user-dropdown a:hover {
        background: #f5f5f5;
        color: #e6b55c !important;
    }
    
    .user-dropdown a i {
        width: 18px;
        color: #666;
    }
    
    .user-dropdown a:hover i {
        color: #e6b55c;
    }
    
    .dropdown-divider {
        height: 1px;
        background: #e0e0e0;
        margin: 8px 0;
    }
    
    .mobile-menu-btn {
        display: none;
        background: none;
        border: none;
        color: #fff;
        font-size: 24px;
        cursor: pointer;
    }

    /* FOOTER STYLES - From home.jsp */
    footer {
        background: #1f2a1f;
        color: #cdd6b6;
        padding: 60px 0 30px;
    }
    
    .footer-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 40px;
        margin-bottom: 40px;
    }
    
    .footer-col h3 {
        color: #e6b55c;
        margin-bottom: 25px;
        font-size: 20px;
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
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: rgba(255,255,255,0.1);
        color: #cdd6b6;
        transition: all 0.3s ease;
    }
    
    .social-links a:hover {
        background: #e6b55c;
        color: #1f2a1f;
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
    @media (max-width: 768px) {
        .mobile-menu-btn {
            display: block;
        }
        
        .nav-links {
            position: fixed;
            top: 70px;
            left: -100%;
            width: 100%;
            height: calc(100vh - 70px);
            background: #1f2a1f;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            padding-top: 50px;
            transition: left 0.3s ease;
        }
        
        .nav-links.active {
            left: 0;
        }
        
        .nav-links li {
            margin: 0 0 30px 0;
        }
    }
</style>

