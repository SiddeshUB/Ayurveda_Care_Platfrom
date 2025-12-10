<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - AyurVedaCare</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            min-height: 100vh;
            display: flex;
            background: linear-gradient(135deg, #0f0f23 0%, #1a1a3e 50%, #0d1f2d 100%);
            font-family: 'Nunito Sans', sans-serif;
        }
        
        .admin-login-container {
            display: flex;
            width: 100%;
            min-height: 100vh;
        }
        
        .admin-branding {
            flex: 1;
            background: linear-gradient(135deg, rgba(15, 15, 35, 0.95), rgba(26, 26, 62, 0.9)),
                        url('https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=1200') center/cover;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px;
            color: white;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .admin-branding::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(199, 163, 105, 0.1) 0%, transparent 50%);
            animation: pulse 4s ease-in-out infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.5; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }
        
        .admin-branding h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }
        
        .admin-branding h1 i {
            color: #C7A369;
            margin-right: 15px;
        }
        
        .admin-branding p {
            font-size: 1.2rem;
            max-width: 500px;
            opacity: 0.9;
            line-height: 1.8;
            position: relative;
            z-index: 1;
        }
        
        .admin-features {
            margin-top: 50px;
            display: flex;
            gap: 40px;
            position: relative;
            z-index: 1;
        }
        
        .admin-feature {
            text-align: center;
            padding: 20px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            border: 1px solid rgba(199, 163, 105, 0.2);
            transition: transform 0.3s ease;
        }
        
        .admin-feature:hover {
            transform: translateY(-5px);
        }
        
        .admin-feature i {
            font-size: 2.5rem;
            color: #C7A369;
            margin-bottom: 15px;
            display: block;
        }
        
        .admin-feature h4 {
            font-size: 1rem;
            font-weight: 600;
        }
        
        .admin-form-section {
            flex: 0 0 520px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 60px;
            background: #ffffff;
        }
        
        .admin-header {
            margin-bottom: 40px;
        }
        
        .admin-header .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: #1a1a3e;
            margin-bottom: 40px;
            text-decoration: none;
        }
        
        .admin-header .logo i {
            color: #C7A369;
        }
        
        .admin-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: linear-gradient(135deg, #1a1a3e, #2d2d5e);
            color: white;
            padding: 8px 16px;
            border-radius: 30px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 20px;
        }
        
        .admin-badge i {
            color: #C7A369;
        }
        
        .admin-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: #1a1a3e;
            margin-bottom: 10px;
        }
        
        .admin-header p {
            color: #666;
            font-size: 1rem;
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 0.95rem;
        }
        
        .alert-error {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }
        
        .alert-success {
            background: #f0fdf4;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }
        
        .form-group {
            margin-bottom: 24px;
        }
        
        .form-label {
            display: block;
            font-weight: 600;
            color: #1a1a3e;
            margin-bottom: 10px;
            font-size: 0.95rem;
        }
        
        .input-wrapper {
            position: relative;
        }
        
        .input-wrapper i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            transition: color 0.3s ease;
        }
        
        .form-input {
            width: 100%;
            padding: 16px 18px 16px 50px;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f9fafb;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #C7A369;
            background: white;
            box-shadow: 0 0 0 4px rgba(199, 163, 105, 0.1);
        }
        
        .form-input:focus + i,
        .input-wrapper:focus-within i {
            color: #C7A369;
        }
        
        .remember-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            color: #666;
            font-size: 0.95rem;
        }
        
        .checkbox-label input {
            width: 18px;
            height: 18px;
            accent-color: #C7A369;
        }
        
        .forgot-link {
            color: #C7A369;
            font-weight: 600;
            text-decoration: none;
            font-size: 0.95rem;
        }
        
        .forgot-link:hover {
            text-decoration: underline;
        }
        
        .btn-admin-login {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #1a1a3e, #2d2d5e);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            transition: all 0.3s ease;
        }
        
        .btn-admin-login:hover {
            background: linear-gradient(135deg, #2d2d5e, #3d3d7e);
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(26, 26, 62, 0.3);
        }
        
        .divider {
            display: flex;
            align-items: center;
            margin: 35px 0;
            color: #9ca3af;
        }
        
        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #e5e7eb;
        }
        
        .divider span {
            padding: 0 20px;
            font-size: 0.9rem;
        }
        
        .register-link {
            text-align: center;
        }
        
        .register-link p {
            color: #666;
            font-size: 1rem;
        }
        
        .register-link a {
            color: #C7A369;
            font-weight: 700;
            text-decoration: none;
        }
        
        .register-link a:hover {
            text-decoration: underline;
        }
        
        .back-to-home {
            position: absolute;
            top: 30px;
            left: 30px;
            display: flex;
            align-items: center;
            gap: 8px;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            font-size: 0.95rem;
            transition: color 0.3s ease;
            z-index: 10;
        }
        
        .back-to-home:hover {
            color: white;
        }
        
        @media (max-width: 992px) {
            .admin-branding {
                display: none;
            }
            
            .admin-form-section {
                flex: 1;
                max-width: 100%;
            }
        }
        
        @media (max-width: 480px) {
            .admin-form-section {
                padding: 40px 25px;
            }
        }
    </style>
</head>
<body>
    <div class="admin-login-container">
        <div class="admin-branding">
            <a href="${pageContext.request.contextPath}/" class="back-to-home">
                <i class="fas fa-arrow-left"></i> Back to Home
            </a>
            
            <h1><i class="fas fa-shield-alt"></i>Admin Portal</h1>
            <p>Manage and oversee all Ayurvedic centers, verify hospital registrations, and ensure quality healthcare services.</p>
            
            <div class="admin-features">
                <div class="admin-feature">
                    <i class="fas fa-hospital-user"></i>
                    <h4>Verify Hospitals</h4>
                </div>
                <div class="admin-feature">
                    <i class="fas fa-chart-pie"></i>
                    <h4>Analytics</h4>
                </div>
                <div class="admin-feature">
                    <i class="fas fa-cogs"></i>
                    <h4>Manage System</h4>
                </div>
            </div>
        </div>
        
        <div class="admin-form-section">
            <div class="admin-header">
                <a href="${pageContext.request.contextPath}/" class="logo">
                    <i class="fas fa-leaf"></i>
                    <span>AyurVedaCare</span>
                </a>
                
                <span class="admin-badge">
                    <i class="fas fa-user-shield"></i> Administrator Access
                </span>
                
                <h2>Welcome Back</h2>
                <p>Sign in to access the admin dashboard</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    ${message}
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    ${success}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/admin/login" method="post">
                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <div class="input-wrapper">
                        <input type="email" name="email" class="form-input" placeholder="admin@ayurvedacare.com" required>
                        <i class="fas fa-envelope"></i>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <div class="input-wrapper">
                        <input type="password" name="password" class="form-input" placeholder="Enter your password" required>
                        <i class="fas fa-lock"></i>
                    </div>
                </div>
                
                <div class="remember-row">
                    <label class="checkbox-label">
                        <input type="checkbox" name="remember"> Remember me
                    </label>
                    <a href="#" class="forgot-link">Forgot password?</a>
                </div>
                
                <button type="submit" class="btn-admin-login">
                    <i class="fas fa-sign-in-alt"></i> Sign In to Dashboard
                </button>
            </form>
            
            <div class="divider">
                <span>New Administrator?</span>
            </div>
            
            <div class="register-link">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/admin/register">Create Admin Account</a></p>
            </div>
        </div>
    </div>
</body>
</html>

