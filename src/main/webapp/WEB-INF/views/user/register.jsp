<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - AyurVedaCare</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: var(--spacing-xl) 0;
        }
        
        .register-container {
            max-width: 900px;
            margin: 0 auto;
            padding: var(--spacing-3xl);
        }
        
        .register-header {
            text-align: center;
            margin-bottom: var(--spacing-3xl);
        }
        
        .register-header .logo {
            display: inline-flex;
            align-items: center;
            gap: var(--spacing-sm);
            font-family: var(--font-display);
            font-size: 1.8rem;
            color: var(--primary-forest);
            margin-bottom: var(--spacing-lg);
        }
        
        .register-header h1 {
            color: var(--primary-forest);
            font-family: var(--font-display);
            font-size: 2.5rem;
            margin-bottom: var(--spacing-md);
        }
        
        .register-header p {
            color: var(--text-medium);
            font-size: 1.1rem;
        }
        
        .register-card {
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-3xl);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: var(--spacing-lg);
        }
        
        .form-group {
            margin-bottom: var(--spacing-lg);
        }
        
        .form-label {
            display: block;
            margin-bottom: var(--spacing-sm);
            color: var(--text-dark);
            font-weight: 500;
        }
        
        .form-control {
            width: 100%;
            padding: var(--spacing-md);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-md);
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-forest);
            box-shadow: 0 0 0 3px rgba(45, 90, 61, 0.1);
        }
        
        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }
        
        .btn-primary {
            width: 100%;
            padding: var(--spacing-md);
            background: var(--primary-forest);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: var(--primary-forest-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(45, 90, 61, 0.3);
        }
        
        .alert {
            padding: var(--spacing-md);
            border-radius: var(--radius-md);
            margin-bottom: var(--spacing-lg);
        }
        
        .alert-danger {
            background: #fee;
            color: #c33;
            border: 1px solid #fcc;
        }
        
        .register-footer {
            text-align: center;
            margin-top: var(--spacing-xl);
            padding-top: var(--spacing-xl);
            border-top: 1px solid var(--border-color);
        }
        
        .register-footer a {
            color: var(--primary-forest);
            text-decoration: none;
            font-weight: 600;
        }
        
        .register-footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <div class="logo">
                <i class="fas fa-leaf"></i>
                <span>AyurVeda<span style="color: var(--accent-gold);">Care</span></span>
            </div>
            <h1><i class="fas fa-user-plus"></i> Create Account</h1>
            <p>Join thousands of people on their wellness journey</p>
        </div>
        
        <div class="register-card">
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
            
            <form action="${pageContext.request.contextPath}/user/register" method="post">
                <h3 style="margin-bottom: var(--spacing-lg); color: var(--primary-forest);">
                    <i class="fas fa-user"></i> Personal Information
                </h3>
                
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Full Name *</label>
                        <input type="text" name="fullName" class="form-control" placeholder="Enter your full name" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Email Address *</label>
                        <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Password *</label>
                        <input type="password" name="password" class="form-control" placeholder="Create a password" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" name="phone" class="form-control" placeholder="Enter your phone">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Country *</label>
                        <input type="text" name="country" class="form-control" placeholder="Enter your country" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Purpose of Visit</label>
                        <select name="purpose" class="form-control">
                            <option value="">Select purpose</option>
                            <option value="Detox">Detox</option>
                            <option value="Panchakarma">Panchakarma</option>
                            <option value="Yoga">Yoga</option>
                            <option value="Healing">Healing</option>
                            <option value="Wellness">Wellness</option>
                            <option value="Rejuvenation">Rejuvenation</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Purpose Details (Optional)</label>
                    <textarea name="purpose" class="form-control" placeholder="Tell us more about what you're looking for..."></textarea>
                </div>
                
                <button type="submit" class="btn-primary">
                    <i class="fas fa-user-plus"></i> Create Account
                </button>
            </form>
            
            <div class="register-footer">
                <p>Already have an account? <a href="${pageContext.request.contextPath}/user/login">Sign in here</a></p>
                <p><a href="${pageContext.request.contextPath}/">Back to Home</a></p>
            </div>
        </div>
    </div>
</body>
</html>

