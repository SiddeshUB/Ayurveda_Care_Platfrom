<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - AyurVedaCare</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            background: #0a0f0a;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            background: radial-gradient(ellipse at 20% 20%, rgba(45, 74, 45, 0.4) 0%, transparent 50%),
                        radial-gradient(ellipse at 80% 80%, rgba(201, 162, 39, 0.3) 0%, transparent 50%);
        }
        .container {
            position: relative;
            z-index: 1;
            max-width: 500px;
            width: 100%;
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.5);
        }
        .logo {
            text-align: center;
            margin-bottom: 30px;
        }
        .logo-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #c9a227, #e6b55c);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: #1a2e1a;
            margin: 0 auto 15px;
        }
        .logo-text {
            font-family: 'Cormorant Garamond', serif;
            font-size: 28px;
            font-weight: 700;
            color: #fff;
        }
        .logo-text span { color: #c9a227; }
        h2 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 28px;
            color: #fff;
            text-align: center;
            margin-bottom: 10px;
        }
        p {
            color: rgba(255, 255, 255, 0.7);
            text-align: center;
            margin-bottom: 30px;
            font-size: 14px;
        }
        .alert {
            padding: 12px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 13px;
        }
        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            color: #ff6b6b;
            border: 1px solid rgba(239, 68, 68, 0.2);
        }
        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            color: #51cf66;
            border: 1px solid rgba(16, 185, 129, 0.2);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-label {
            display: block;
            color: #fff;
            margin-bottom: 8px;
            font-size: 14px;
        }
        .input-wrapper {
            position: relative;
        }
        .form-control {
            width: 100%;
            padding: 14px 14px 14px 45px;
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.05);
            color: #fff;
            font-size: 14px;
        }
        .form-control:focus {
            outline: none;
            border-color: #c9a227;
            background: rgba(255, 255, 255, 0.1);
        }
        .input-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.5);
        }
        .password-toggle {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: rgba(255, 255, 255, 0.5);
            cursor: pointer;
        }
        .btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #2d4a2d, #1a2e1a);
            color: #fff;
            border: none;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(45, 74, 45, 0.4);
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        .back-link a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            font-size: 14px;
        }
        .back-link a:hover {
            color: #c9a227;
        }
    </style>
</head>
<body>
    <div class="bg-animation"></div>
    <div class="container">
        <div class="logo">
            <div class="logo-icon">
                <i class="fas fa-leaf"></i>
            </div>
            <div class="logo-text">AyurVeda<span>Care</span></div>
        </div>
        
        <h2>Reset Password</h2>
        <p>Enter your new password below</p>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty token}">
            <form action="${pageContext.request.contextPath}/vendor/reset-password" method="post">
                <input type="hidden" name="token" value="${token}">
                
                <div class="form-group">
                    <label class="form-label">New Password</label>
                    <div class="input-wrapper">
                        <input type="password" name="newPassword" id="newPassword" class="form-control" placeholder="Enter new password" required>
                        <i class="fas fa-lock input-icon"></i>
                        <button type="button" class="password-toggle" onclick="togglePassword('newPassword')">
                            <i class="fas fa-eye" id="eye-newPassword"></i>
                        </button>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Confirm Password</label>
                    <div class="input-wrapper">
                        <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" placeholder="Confirm new password" required>
                        <i class="fas fa-lock input-icon"></i>
                        <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                            <i class="fas fa-eye" id="eye-confirmPassword"></i>
                        </button>
                    </div>
                </div>
                
                <button type="submit" class="btn">
                    <i class="fas fa-key"></i> Reset Password
                </button>
            </form>
        </c:if>
        
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/vendor/login">
                <i class="fas fa-arrow-left"></i> Back to Login
            </a>
        </div>
    </div>
    
    <script>
        function togglePassword(id) {
            const input = document.getElementById(id);
            const eye = document.getElementById('eye-' + id);
            if (input.type === 'password') {
                input.type = 'text';
                eye.classList.remove('fa-eye');
                eye.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                eye.classList.remove('fa-eye-slash');
                eye.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>

