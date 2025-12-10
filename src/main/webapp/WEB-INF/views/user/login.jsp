<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - AyurVedaCare</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            overflow-x: hidden;
            background: #0a0f0a;
        }
        
        /* Animated Background */
        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            overflow: hidden;
        }
        
        .bg-animation::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(ellipse at 20% 20%, rgba(45, 74, 45, 0.4) 0%, transparent 50%),
                radial-gradient(ellipse at 80% 80%, rgba(201, 162, 39, 0.3) 0%, transparent 50%),
                radial-gradient(ellipse at 40% 60%, rgba(45, 74, 45, 0.2) 0%, transparent 40%);
            animation: bgPulse 10s ease-in-out infinite;
        }
        
        @keyframes bgPulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.8; transform: scale(1.1); }
        }
        
        /* Floating Particles */
        .particles {
            position: absolute;
            width: 100%;
            height: 100%;
        }
        
        .particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: rgba(201, 162, 39, 0.6);
            border-radius: 50%;
            animation: float 15s infinite ease-in-out;
        }
        
        .particle:nth-child(1) { left: 10%; top: 20%; animation-delay: 0s; animation-duration: 20s; }
        .particle:nth-child(2) { left: 20%; top: 80%; animation-delay: 2s; animation-duration: 18s; }
        .particle:nth-child(3) { left: 30%; top: 40%; animation-delay: 4s; animation-duration: 22s; }
        .particle:nth-child(4) { left: 50%; top: 60%; animation-delay: 1s; animation-duration: 16s; }
        .particle:nth-child(5) { left: 70%; top: 30%; animation-delay: 3s; animation-duration: 19s; }
        .particle:nth-child(6) { left: 80%; top: 70%; animation-delay: 5s; animation-duration: 21s; }
        .particle:nth-child(7) { left: 90%; top: 10%; animation-delay: 2.5s; animation-duration: 17s; }
        .particle:nth-child(8) { left: 15%; top: 50%; animation-delay: 3.5s; animation-duration: 23s; }
        
        @keyframes float {
            0%, 100% { transform: translateY(0) translateX(0) scale(1); opacity: 0.6; }
            25% { transform: translateY(-30px) translateX(10px) scale(1.2); opacity: 1; }
            50% { transform: translateY(-20px) translateX(-15px) scale(0.8); opacity: 0.4; }
            75% { transform: translateY(-40px) translateX(5px) scale(1.1); opacity: 0.8; }
        }
        
        /* Decorative Leaves */
        .leaf {
            position: absolute;
            font-size: 40px;
            color: rgba(45, 74, 45, 0.15);
            animation: leafFloat 20s infinite ease-in-out;
        }
        
        .leaf:nth-child(1) { left: 5%; top: 15%; animation-delay: 0s; font-size: 50px; }
        .leaf:nth-child(2) { right: 8%; top: 25%; animation-delay: 3s; font-size: 35px; }
        .leaf:nth-child(3) { left: 12%; bottom: 20%; animation-delay: 6s; font-size: 45px; }
        .leaf:nth-child(4) { right: 15%; bottom: 30%; animation-delay: 9s; font-size: 55px; }
        
        @keyframes leafFloat {
            0%, 100% { transform: rotate(0deg) translateY(0); }
            25% { transform: rotate(15deg) translateY(-20px); }
            50% { transform: rotate(-10deg) translateY(-10px); }
            75% { transform: rotate(5deg) translateY(-30px); }
        }
        
        /* Main Container */
        .login-wrapper {
            position: relative;
            z-index: 1;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .login-container {
            width: 100%;
            max-width: 900px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 
                0 25px 80px rgba(0, 0, 0, 0.5),
                inset 0 0 0 1px rgba(255, 255, 255, 0.1);
            animation: containerAppear 1s ease-out;
        }
        
        @keyframes containerAppear {
            from { opacity: 0; transform: translateY(30px) scale(0.95); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }
        
        /* Left Side - Branding */
        .login-brand {
            padding: 40px 35px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, rgba(45, 74, 45, 0.9), rgba(26, 46, 26, 0.95));
        }
        
        .login-brand::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(201, 162, 39, 0.2) 0%, transparent 70%);
            animation: brandGlow 8s ease-in-out infinite;
        }
        
        @keyframes brandGlow {
            0%, 100% { transform: translate(0, 0); }
            50% { transform: translate(-20%, 20%); }
        }
        
        .brand-content {
            position: relative;
            z-index: 1;
        }
        
        .brand-logo {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 30px;
        }
        
        .logo-icon {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #c9a227, #e6b55c);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            color: #1a2e1a;
            box-shadow: 0 10px 30px rgba(201, 162, 39, 0.3);
        }
        
        .logo-text {
            font-family: 'Cormorant Garamond', serif;
            font-size: 26px;
            font-weight: 700;
            color: #fff;
        }
        
        .logo-text span {
            color: #c9a227;
        }
        
        .brand-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 36px;
            font-weight: 600;
            color: #fff;
            line-height: 1.2;
            margin-bottom: 12px;
        }
        
        .brand-subtitle {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.7);
            line-height: 1.7;
            margin-bottom: 30px;
        }
        
        .brand-features {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        
        .brand-feature {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.08);
            transition: all 0.3s ease;
        }
        
        .brand-feature:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateX(10px);
        }
        
        .feature-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, rgba(201, 162, 39, 0.2), rgba(201, 162, 39, 0.1));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #c9a227;
            font-size: 18px;
            flex-shrink: 0;
        }
        
        .feature-text h4 {
            color: #fff;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 2px;
        }
        
        .feature-text p {
            color: rgba(255, 255, 255, 0.5);
            font-size: 12px;
        }
        
        /* Right Side - Form */
        .login-form-section {
            padding: 35px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: #fff;
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 25px;
        }
        
        .form-header h2 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 30px;
            font-weight: 600;
            color: #1a2e1a;
            margin-bottom: 6px;
        }
        
        .form-header p {
            color: #888;
            font-size: 14px;
        }
        
        /* Alerts */
        .alert {
            padding: 12px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 13px;
            animation: alertSlide 0.5s ease-out;
        }
        
        @keyframes alertSlide {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .alert-danger {
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(239, 68, 68, 0.05));
            color: #dc2626;
            border: 1px solid rgba(239, 68, 68, 0.2);
        }
        
        .alert-success {
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(16, 185, 129, 0.05));
            color: #059669;
            border: 1px solid rgba(16, 185, 129, 0.2);
        }
        
        /* Form Groups */
        .form-group {
            margin-bottom: 18px;
            position: relative;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: #1a2e1a;
            font-weight: 500;
            font-size: 13px;
        }
        
        .input-wrapper {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            font-size: 16px;
            transition: all 0.3s ease;
            z-index: 1;
        }
        
        .form-control {
            width: 100%;
            padding: 14px 14px 14px 45px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #2d4a2d;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(45, 74, 45, 0.1);
        }
        
        .form-control:focus + .input-icon,
        .form-control:not(:placeholder-shown) + .input-icon {
            color: #2d4a2d;
        }
        
        .form-control::placeholder {
            color: #bbb;
        }
        
        /* Password Toggle */
        .password-toggle {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #aaa;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s ease;
            z-index: 1;
        }
        
        .password-toggle:hover {
            color: #2d4a2d;
        }
        
        /* Remember & Forgot */
        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }
        
        .remember-me input {
            width: 16px;
            height: 16px;
            accent-color: #2d4a2d;
            cursor: pointer;
        }
        
        .remember-me span {
            color: #666;
            font-size: 13px;
        }
        
        .forgot-link {
            color: #c9a227;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .forgot-link:hover {
            color: #2d4a2d;
        }
        
        /* Submit Button */
        .btn-submit {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #2d4a2d, #1a2e1a);
            color: #fff;
            border: none;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            transition: all 0.4s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
        }
        
        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s ease;
        }
        
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(45, 74, 45, 0.4);
        }
        
        .btn-submit:hover::before {
            left: 100%;
        }
        
        .btn-submit:active {
            transform: translateY(-1px);
        }
        
        /* Divider */
        .divider {
            display: flex;
            align-items: center;
            margin: 20px 0;
            gap: 12px;
        }
        
        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: linear-gradient(90deg, transparent, #e0e0e0, transparent);
        }
        
        .divider span {
            color: #aaa;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        /* Social Buttons */
        .social-buttons {
            display: flex;
            gap: 12px;
        }
        
        .btn-social {
            flex: 1;
            padding: 12px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            background: #fff;
            color: #333;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-social:hover {
            border-color: #2d4a2d;
            background: #f8f6f1;
        }
        
        .btn-social.google:hover { color: #ea4335; }
        .btn-social.facebook:hover { color: #1877f2; }
        
        /* Footer Links */
        .form-footer {
            text-align: center;
            margin-top: 20px;
        }
        
        .form-footer p {
            color: #888;
            font-size: 13px;
            margin-bottom: 8px;
        }
        
        .form-footer a {
            color: #2d4a2d;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .form-footer a:hover {
            color: #c9a227;
        }
        
        .back-home {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #888;
            font-size: 13px;
            text-decoration: none;
            margin-top: 10px;
            transition: all 0.3s ease;
        }
        
        .back-home:hover {
            color: #c9a227;
        }
        
        /* Responsive */
        @media (max-width: 992px) {
            .login-container {
                grid-template-columns: 1fr;
                max-width: 420px;
            }
            
            .login-brand {
                display: none;
            }
            
            .login-form-section {
                padding: 35px 30px;
            }
        }
        
        @media (max-width: 576px) {
            .login-wrapper {
                padding: 15px 12px;
            }
            
            .login-form-section {
                padding: 30px 20px;
            }
            
            .form-header h2 {
                font-size: 24px;
            }
            
            .form-options {
                flex-direction: column;
                gap: 12px;
                align-items: flex-start;
            }
            
            .social-buttons {
                flex-direction: row;
            }
        }
        
        /* Mobile Brand Header */
        .mobile-brand {
            display: none;
            text-align: center;
            margin-bottom: 20px;
        }
        
        .mobile-brand .logo-icon {
            width: 40px;
            height: 40px;
            margin: 0 auto 10px;
            font-size: 20px;
        }
        
        .mobile-brand .logo-text {
            font-size: 22px;
            color: #1a2e1a;
        }
        
        @media (max-width: 992px) {
            .mobile-brand {
                display: block;
            }
        }
    </style>
</head>
<body>
    <!-- Animated Background -->
    <div class="bg-animation">
        <div class="particles">
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
        </div>
        <i class="fas fa-leaf leaf"></i>
        <i class="fas fa-leaf leaf"></i>
        <i class="fas fa-leaf leaf"></i>
        <i class="fas fa-leaf leaf"></i>
    </div>
    
    <div class="login-wrapper">
        <div class="login-container">
            <!-- Left Side - Branding -->
            <div class="login-brand">
                <div class="brand-content">
                    <div class="brand-logo">
                        <div class="logo-icon">
                            <i class="fas fa-leaf"></i>
                        </div>
                        <div class="logo-text">AyurVeda<span>Care</span></div>
                    </div>
                    
                    <h1 class="brand-title">Begin Your<br>Wellness Journey</h1>
                    <p class="brand-subtitle">
                        Experience the ancient wisdom of Ayurveda combined with modern healthcare. 
                        Your path to holistic well-being starts here.
                    </p>
                    
                    <div class="brand-features">
                        <div class="brand-feature">
                            <div class="feature-icon">
                                <i class="fas fa-hospital"></i>
                            </div>
                            <div class="feature-text">
                                <h4>Verified Centers</h4>
                                <p>Access 500+ authentic Ayurvedic hospitals</p>
                            </div>
                        </div>
                        
                        <div class="brand-feature">
                            <div class="feature-icon">
                                <i class="fas fa-user-md"></i>
                            </div>
                            <div class="feature-text">
                                <h4>Expert Doctors</h4>
                                <p>Consult with certified practitioners</p>
                            </div>
                        </div>
                        
                        <div class="brand-feature">
                            <div class="feature-icon">
                                <i class="fas fa-calendar-check"></i>
                            </div>
                            <div class="feature-text">
                                <h4>Easy Booking</h4>
                                <p>Schedule treatments with one click</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Right Side - Form -->
            <div class="login-form-section">
                <!-- Mobile Brand (shows on mobile) -->
                <div class="mobile-brand">
                    <div class="logo-icon">
                        <i class="fas fa-leaf"></i>
                    </div>
                    <div class="logo-text">AyurVeda<span>Care</span></div>
                </div>
                
                <div class="form-header">
                    <h2>Welcome Back</h2>
                    <p>Sign in to continue your wellness journey</p>
                </div>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>
                
                <c:if test="${not empty message}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> ${message}
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/user/login" method="post">
                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <div class="input-wrapper">
                            <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                            <i class="fas fa-envelope input-icon"></i>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <div class="input-wrapper">
                            <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" required>
                            <i class="fas fa-lock input-icon"></i>
                            <button type="button" class="password-toggle" onclick="togglePassword()">
                                <i class="fas fa-eye" id="toggleIcon"></i>
                            </button>
                        </div>
                    </div>
                    
                    <div class="form-options">
                        <label class="remember-me">
                            <input type="checkbox" name="remember">
                            <span>Remember me</span>
                        </label>
                        <a href="${pageContext.request.contextPath}/user/forgot-password" class="forgot-link">Forgot Password?</a>
                    </div>
                    
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-sign-in-alt"></i> Sign In
                    </button>
                </form>
                
                <div class="divider">
                    <span>or continue with</span>
                </div>
                
                <div class="social-buttons">
                    <button type="button" class="btn-social google">
                        <i class="fab fa-google"></i>
                    </button>
                    <button type="button" class="btn-social facebook">
                        <i class="fab fa-facebook-f"></i>
                    </button>
                </div>
                
                <div class="form-footer">
                    <p>Don't have an account? <a href="${pageContext.request.contextPath}/user/register">Create Account</a></p>
                    <a href="${pageContext.request.contextPath}/" class="back-home">
                        <i class="fas fa-arrow-left"></i> Back to Home
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function togglePassword() {
            const password = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            
            if (password.type === 'password') {
                password.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                password.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
        
        // Add floating animation on load
        document.addEventListener('DOMContentLoaded', function() {
            const container = document.querySelector('.login-container');
            container.style.animation = 'containerAppear 1s ease-out forwards';
        });
    </script>
</body>
</html>
