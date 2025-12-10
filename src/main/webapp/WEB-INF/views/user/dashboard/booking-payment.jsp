<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Payment - AyurVeda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #2d5a27; --primary-dark: #1e3d1a; --cream: #faf8f5; }
        body { font-family: 'Poppins', sans-serif; background: var(--cream); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        h1, h2, h3, h4, h5 { font-family: 'Playfair Display', serif; }
        
        .payment-card { background: white; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,0,0,0.1); padding: 40px; max-width: 500px; width: 100%; text-align: center; }
        .payment-icon { width: 80px; height: 80px; background: linear-gradient(135deg, var(--primary), var(--primary-dark)); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 25px; }
        .payment-icon i { font-size: 2rem; color: white; }
        
        .booking-summary { background: var(--cream); border-radius: 10px; padding: 20px; margin: 25px 0; text-align: left; }
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 10px; }
        .summary-row.total { font-size: 1.2rem; font-weight: 700; color: var(--primary); border-top: 2px solid #ddd; padding-top: 10px; margin-top: 10px; }
        
        .btn-pay { background: #528FF0; color: white; padding: 15px 50px; border: none; border-radius: 30px; font-size: 1.1rem; font-weight: 600; width: 100%; }
        .btn-pay:hover { background: #4178D3; color: white; }
        
        .secure-text { color: #888; font-size: 0.85rem; margin-top: 15px; }
        .secure-text i { color: #28a745; }
        
        .loading-overlay { position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(255,255,255,0.9); display: none; align-items: center; justify-content: center; z-index: 9999; flex-direction: column; }
        .spinner { width: 50px; height: 50px; border: 4px solid #ddd; border-top-color: var(--primary); border-radius: 50%; animation: spin 1s linear infinite; }
        @keyframes spin { to { transform: rotate(360deg); } }
    </style>
</head>
<body>
    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="spinner mb-3"></div>
        <p>Processing payment...</p>
    </div>

    <div class="payment-card">
        <div class="payment-icon">
            <i class="fas fa-credit-card"></i>
        </div>
        
        <h4>Complete Your Payment</h4>
        <p class="text-muted">Booking #${booking.bookingNumber}</p>
        
        <div class="booking-summary">
            <div class="summary-row">
                <span>Hospital</span>
                <span>${booking.hospital.centerName}</span>
            </div>
            <c:if test="${booking.treatmentPackage != null}">
                <div class="summary-row">
                    <span>Package</span>
                    <span>${booking.treatmentPackage.packageName}</span>
                </div>
            </c:if>
            <c:if test="${booking.basePrice != null && booking.basePrice > 0}">
                <div class="summary-row">
                    <span>Base Price</span>
                    <span>₹<fmt:formatNumber value="${booking.basePrice}" maxFractionDigits="0"/></span>
                </div>
            </c:if>
            <c:if test="${booking.gstAmount != null && booking.gstAmount > 0}">
                <div class="summary-row">
                    <span>GST</span>
                    <span>₹<fmt:formatNumber value="${booking.gstAmount}" maxFractionDigits="0"/></span>
                </div>
            </c:if>
            <c:if test="${booking.cgstAmount != null && booking.cgstAmount > 0}">
                <div class="summary-row">
                    <span>CGST</span>
                    <span>₹<fmt:formatNumber value="${booking.cgstAmount}" maxFractionDigits="0"/></span>
                </div>
            </c:if>
            <div class="summary-row total">
                <span>Amount to Pay</span>
                <span>₹<fmt:formatNumber value="${booking.totalAmount}" maxFractionDigits="0"/></span>
            </div>
        </div>

        <button type="button" class="btn btn-pay" id="payButton" onclick="initiatePayment()">
            <i class="fas fa-lock me-2"></i>Pay ₹<fmt:formatNumber value="${booking.totalAmount}" maxFractionDigits="0"/>
        </button>

        <p class="secure-text">
            <i class="fas fa-shield-alt me-1"></i>Secured by Razorpay
        </p>
        
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/booking/confirmation/${booking.bookingNumber}" class="text-muted text-decoration-none">
                <i class="fas fa-arrow-left me-1"></i>Cancel and go back
            </a>
        </div>
    </div>

    <!-- Razorpay Script -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script>
        function initiatePayment() {
            var options = {
                "key": "${razorpayKey}",
                "amount": ${booking.totalAmount.multiply(100).intValue()},
                "currency": "INR",
                "name": "AyurVedaCare",
                "description": "Booking #${booking.bookingNumber}",
                "image": "${pageContext.request.contextPath}/images/logo.jpg",
                "order_id": "${razorpayOrderId}",
                "handler": function (response) {
                    // Show loading
                    document.getElementById('loadingOverlay').style.display = 'flex';
                    
                    // Verify payment
                    fetch('${pageContext.request.contextPath}/payment/booking/verify', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'razorpay_order_id=' + response.razorpay_order_id + 
                              '&razorpay_payment_id=' + response.razorpay_payment_id + 
                              '&razorpay_signature=' + response.razorpay_signature
                    })
                    .then(res => res.json())
                    .then(data => {
                        if (data.success) {
                            window.location.href = '${pageContext.request.contextPath}/payment/booking/success';
                        } else {
                            alert('Payment verification failed: ' + data.message);
                            window.location.href = '${pageContext.request.contextPath}/booking/confirmation/${booking.bookingNumber}';
                        }
                    })
                    .catch(err => {
                        console.error('Error:', err);
                        alert('An error occurred during payment verification');
                        window.location.href = '${pageContext.request.contextPath}/booking/confirmation/${booking.bookingNumber}';
                    });
                },
                "prefill": {
                    "name": "${user.fullName}",
                    "email": "${user.email}",
                    "contact": "${booking.patientPhone != null ? booking.patientPhone : user.phone}"
                },
                "notes": {
                    "booking_number": "${booking.bookingNumber}",
                    "hospital": "${booking.hospital.centerName}"
                },
                "theme": {
                    "color": "#2d5a27"
                },
                "modal": {
                    "ondismiss": function() {
                        // User closed the popup
                    }
                }
            };
            
            var rzp = new Razorpay(options);
            rzp.on('payment.failed', function (response) {
                alert('Payment failed: ' + response.error.description);
                window.location.href = '${pageContext.request.contextPath}/booking/confirmation/${booking.bookingNumber}';
            });
            rzp.open();
        }
    </script>
</body>
</html>

