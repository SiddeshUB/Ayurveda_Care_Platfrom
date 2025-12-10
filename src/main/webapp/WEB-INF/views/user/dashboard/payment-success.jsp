<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful - AyurVeda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #2d5a27; --cream: #faf8f5; }
        body { font-family: 'Poppins', sans-serif; background: var(--cream); min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        h1, h2, h3, h4, h5 { font-family: 'Playfair Display', serif; }
        
        .success-card { background: white; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,0,0,0.1); padding: 50px 40px; max-width: 500px; width: 100%; text-align: center; }
        
        .success-icon { width: 100px; height: 100px; background: linear-gradient(135deg, #28a745, #20c997); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 30px; animation: scaleIn 0.5s ease-out; }
        .success-icon i { font-size: 3rem; color: white; }
        
        @keyframes scaleIn {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }
        
        .order-info { background: var(--cream); border-radius: 10px; padding: 20px; margin: 25px 0; text-align: left; }
        .order-info .row { margin-bottom: 10px; }
        .order-info label { color: #888; font-size: 0.85rem; }
        .order-info p { font-weight: 600; margin: 0; }
        
        .btn-view { background: var(--primary); color: white; padding: 12px 30px; border: none; border-radius: 25px; }
        .btn-view:hover { background: #1e3d1a; color: white; }
        
        .confetti { position: fixed; top: 0; left: 0; right: 0; bottom: 0; pointer-events: none; overflow: hidden; }
        .confetti-piece { position: absolute; width: 10px; height: 10px; background: #ffc107; animation: fall 3s ease-out forwards; }
        
        @keyframes fall {
            0% { transform: translateY(-100px) rotate(0deg); opacity: 1; }
            100% { transform: translateY(100vh) rotate(720deg); opacity: 0; }
        }
    </style>
</head>
<body>
    <div class="confetti" id="confetti"></div>

    <div class="success-card">
        <div class="success-icon">
            <i class="fas fa-check"></i>
        </div>
        
        <h3>Payment Successful!</h3>
        <p class="text-muted mb-4">Thank you for your order. Your payment has been processed successfully.</p>
        
        <div class="order-info">
            <div class="row">
                <div class="col-6">
                    <label>Order Number</label>
                    <p>${order.orderNumber}</p>
                </div>
                <div class="col-6">
                    <label>Amount Paid</label>
                    <p class="text-primary">₹<fmt:formatNumber value="${order.totalAmount}"/></p>
                </div>
            </div>
            <div class="row">
                <div class="col-6">
                    <label>Payment ID</label>
                    <p style="font-size: 0.8rem;">${order.razorpayPaymentId}</p>
                </div>
                <div class="col-6">
                    <label>Status</label>
                    <p class="text-success"><i class="fas fa-check-circle me-1"></i>Paid</p>
                </div>
            </div>
        </div>

        <p class="small text-muted mb-4">A confirmation email has been sent to your registered email address.</p>

        <div class="d-flex gap-3 justify-content-center">
            <a href="${pageContext.request.contextPath}/user/dashboard/orders/${order.id}" class="btn btn-view">
                <i class="fas fa-eye me-2"></i>View Order
            </a>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary">
                Continue Shopping
            </a>
        </div>
    </div>

    <script>
        // Create confetti
        const confettiContainer = document.getElementById('confetti');
        const colors = ['#ffc107', '#28a745', '#17a2b8', '#dc3545', '#6f42c1', '#2d5a27'];
        
        for (let i = 0; i < 50; i++) {
            const piece = document.createElement('div');
            piece.className = 'confetti-piece';
            piece.style.left = Math.random() * 100 + '%';
            piece.style.background = colors[Math.floor(Math.random() * colors.length)];
            piece.style.animationDelay = Math.random() * 2 + 's';
            piece.style.borderRadius = Math.random() > 0.5 ? '50%' : '0';
            confettiContainer.appendChild(piece);
        }
    </script>
</body>
</html>

