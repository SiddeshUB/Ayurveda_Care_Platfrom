<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Ayurveda Wellness</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #2d5a3d 0%, #1a3a26 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .error-container {
            background: white;
            border-radius: 20px;
            padding: 60px 40px;
            text-align: center;
            max-width: 600px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        .error-icon {
            font-size: 80px;
            color: #dc3545;
            margin-bottom: 20px;
        }
        h1 {
            color: #2d5a3d;
            font-size: 36px;
            margin-bottom: 15px;
        }
        p {
            color: #666;
            font-size: 18px;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .btn {
            display: inline-block;
            padding: 12px 30px;
            background: #2d5a3d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #1a3a26;
        }
        .error-details {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #eee;
            text-align: left;
        }
        .error-details h3 {
            color: #2d5a3d;
            margin-bottom: 10px;
        }
        .error-details pre {
            background: #f5f5f5;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
            font-size: 12px;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <h1>Oops! Something went wrong</h1>
        <p>We're sorry, but something unexpected happened. Please try again later.</p>
        <a href="${pageContext.request.contextPath}/" class="btn">
            <i class="fas fa-home"></i> Go to Home
        </a>
        
        <c:if test="${not empty error}">
            <div class="error-details">
                <h3>Error Details:</h3>
                <pre>${error}</pre>
            </div>
        </c:if>
        
        <c:if test="${not empty message}">
            <div class="error-details">
                <h3>Message:</h3>
                <pre>${message}</pre>
            </div>
        </c:if>
    </div>
</body>
</html>

