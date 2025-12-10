<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terms & Conditions | AyurVedaCare</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Nunito Sans', sans-serif;
            background: linear-gradient(135deg, #f8f9f5 0%, #e8f4e8 100%);
            color: #2c3e2c;
            line-height: 1.8;
            overflow-x: hidden;
        }
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
        .header {
            background: linear-gradient(135deg, rgba(44, 62, 44, 0.98), rgba(60, 80, 60, 0.95));
            color: white;
            padding: 40px 0 100px;
            text-align: center;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }
        .header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3.5rem;
            margin-bottom: 20px;
        }
        .content {
            padding: 100px 0;
        }
        .content-card {
            background: white;
            border-radius: 20px;
            padding: 60px;
            box-shadow: 0 20px 60px rgba(44, 62, 44, 0.1);
            margin-top: -80px;
        }
        .content-section {
            margin-bottom: 40px;
        }
        .content-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: #2c3e2c;
            margin-bottom: 20px;
        }
        .back-link {
            text-align: center;
            margin-top: 40px;
        }
        .back-link a {
            display: inline-block;
            padding: 15px 30px;
            background: linear-gradient(135deg, #C7A369, #d4b378);
            color: #1f2a1f;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="bg-pattern"></div>
    <header class="header">
        <div class="container">
            <h1>Terms & Conditions</h1>
            <p>Please read these terms carefully before using our services</p>
        </div>
    </header>
    <main class="content">
        <div class="container">
            <div class="content-card">
                <div class="content-section">
                    <h2>Acceptance of Terms</h2>
                    <p>By accessing and using AyurVedaCare, you accept and agree to be bound by the terms and provision of this agreement.</p>
                </div>
                <div class="content-section">
                    <h2>Use License</h2>
                    <p>Permission is granted to temporarily use AyurVedaCare for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title.</p>
                </div>
                <div class="content-section">
                    <h2>Service Availability</h2>
                    <p>We strive to ensure our platform is available 24/7, but we do not guarantee uninterrupted access. We reserve the right to modify or discontinue services at any time.</p>
                </div>
                <div class="content-section">
                    <h2>User Responsibilities</h2>
                    <p>Users are responsible for maintaining the confidentiality of their account information and for all activities that occur under their account.</p>
                </div>
                <div class="back-link">
                    <a href="${pageContext.request.contextPath}/">Back to Home</a>
                </div>
            </div>
        </div>
    </main>
</body>
</html>

