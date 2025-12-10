<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - AyurVeda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #2d5a27; --primary-dark: #1e3d1a; --accent: #8b4513; --gold: #d4a84b; --cream: #faf8f5; }
        body { font-family: 'Poppins', sans-serif; background: var(--cream); }
        h1, h2, h3, h4, h5 { font-family: 'Playfair Display', serif; }
        
        .navbar { background: white; box-shadow: 0 2px 20px rgba(0,0,0,0.08); padding: 15px 0; }
        .navbar-brand { font-family: 'Playfair Display', serif; font-weight: 700; font-size: 1.5rem; color: var(--primary) !important; }
        
        .page-header { background: linear-gradient(135deg, var(--primary), var(--primary-dark)); color: white; padding: 40px 0; text-align: center; }
        
        .checkout-card { background: white; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); padding: 25px; margin-bottom: 20px; }
        .checkout-card h5 { color: var(--primary); margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid var(--cream); }
        
        .form-label { font-weight: 500; color: #333; }
        .form-control, .form-select { border-radius: 10px; border: 2px solid #e0e0e0; padding: 12px 15px; }
        .form-control:focus, .form-select:focus { border-color: var(--primary); box-shadow: 0 0 0 0.2rem rgba(45, 90, 39, 0.15); }
        
        .order-item { display: flex; align-items: center; padding: 15px 0; border-bottom: 1px solid #eee; }
        .order-item:last-child { border-bottom: none; }
        .order-item img { width: 60px; height: 60px; border-radius: 8px; object-fit: cover; margin-right: 15px; }
        .order-item-info { flex: 1; }
        .order-item-name { font-weight: 500; margin-bottom: 2px; }
        .order-item-qty { color: #888; font-size: 0.9rem; }
        .order-item-price { font-weight: 600; color: var(--primary); }
        
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 12px; }
        .summary-total { font-size: 1.25rem; font-weight: 700; color: var(--primary); border-top: 2px solid #eee; padding-top: 15px; margin-top: 15px; }
        
        .payment-option { border: 2px solid #e0e0e0; border-radius: 10px; padding: 15px 20px; cursor: pointer; transition: all 0.3s ease; margin-bottom: 10px; }
        .payment-option:hover { border-color: var(--primary); }
        .payment-option.selected { border-color: var(--primary); background: #f8fff8; }
        .payment-option input { display: none; }
        .payment-option .payment-icon { font-size: 1.5rem; margin-right: 15px; color: var(--primary); }
        
        .coupon-section { background: var(--cream); border-radius: 10px; padding: 15px; margin-bottom: 20px; }
        
        .btn-place-order { background: var(--primary); color: white; padding: 15px 30px; border: none; border-radius: 30px; width: 100%; font-weight: 600; font-size: 1.1rem; }
        .btn-place-order:hover { background: var(--primary-dark); color: white; }
        
        .secure-badge { display: flex; align-items: center; justify-content: center; margin-top: 15px; color: #888; font-size: 0.9rem; }
        .secure-badge i { color: #28a745; margin-right: 8px; }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="fas fa-leaf me-2"></i>AyurVeda</a>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-credit-card me-3"></i>Checkout</h1>
        </div>
    </div>

    <!-- Checkout Content -->
    <section class="py-5">
        <div class="container">
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>

            <form action="${pageContext.request.contextPath}/user/dashboard/checkout/place-order" method="post" id="checkoutForm">
                <div class="row">
                    <!-- Left Column - Shipping & Payment -->
                    <div class="col-lg-7 mb-4">
                        <!-- Shipping Address -->
                        <div class="checkout-card">
                            <h5><i class="fas fa-map-marker-alt me-2"></i>Shipping Address</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Full Name *</label>
                                    <input type="text" class="form-control" name="shippingName" value="${user.fullName}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Phone Number *</label>
                                    <input type="tel" class="form-control" name="shippingPhone" value="${user.phone}" required pattern="[0-9]{10}">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Address Line 1 *</label>
                                <input type="text" class="form-control" name="shippingAddressLine1" required placeholder="House No, Building Name, Street">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Address Line 2</label>
                                <input type="text" class="form-control" name="shippingAddressLine2" placeholder="Area, Landmark">
                            </div>
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">City *</label>
                                    <input type="text" class="form-control" name="shippingCity" required>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">State *</label>
                                    <select class="form-select" name="shippingState" required>
                                        <option value="">Select State</option>
                                        <option value="Andhra Pradesh">Andhra Pradesh</option>
                                        <option value="Karnataka">Karnataka</option>
                                        <option value="Kerala">Kerala</option>
                                        <option value="Maharashtra">Maharashtra</option>
                                        <option value="Tamil Nadu">Tamil Nadu</option>
                                        <option value="Telangana">Telangana</option>
                                        <option value="Gujarat">Gujarat</option>
                                        <option value="Rajasthan">Rajasthan</option>
                                        <option value="Delhi">Delhi</option>
                                        <option value="Uttar Pradesh">Uttar Pradesh</option>
                                        <option value="West Bengal">West Bengal</option>
                                        <!-- Add more states as needed -->
                                    </select>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">PIN Code *</label>
                                    <input type="text" class="form-control" name="shippingPinCode" required pattern="[0-9]{6}">
                                </div>
                            </div>
                        </div>

                        <!-- Payment Method -->
                        <div class="checkout-card">
                            <h5><i class="fas fa-wallet me-2"></i>Payment Method</h5>
                            
                            <label class="payment-option selected">
                                <input type="radio" name="paymentMethod" value="COD" checked>
                                <div class="d-flex align-items-center">
                                    <span class="payment-icon"><i class="fas fa-money-bill-wave"></i></span>
                                    <div>
                                        <strong>Cash on Delivery</strong>
                                        <br><small class="text-muted">Pay when you receive</small>
                                    </div>
                                </div>
                            </label>
                            
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="RAZORPAY">
                                <div class="d-flex align-items-center">
                                    <span class="payment-icon"><i class="fas fa-credit-card"></i></span>
                                    <div>
                                        <strong>Pay Online</strong>
                                        <br><small class="text-muted">Credit/Debit Card, UPI, Net Banking</small>
                                    </div>
                                </div>
                            </label>
                        </div>
                    </div>

                    <!-- Right Column - Order Summary -->
                    <div class="col-lg-5">
                        <div class="checkout-card" style="position: sticky; top: 100px;">
                            <h5><i class="fas fa-shopping-bag me-2"></i>Order Summary</h5>
                            
                            <!-- Cart Items -->
                            <div class="mb-3">
                                <c:forEach items="${cartItems}" var="item">
                                    <div class="order-item">
                                        <img src="${not empty item.product.imageUrl ? (item.product.imageUrl.startsWith('http') ? item.product.imageUrl : pageContext.request.contextPath.concat(item.product.imageUrl)) : pageContext.request.contextPath.concat('/images/no-product.png')}" alt="${item.product.productName}">
                                        <div class="order-item-info">
                                            <div class="order-item-name">${item.product.productName}</div>
                                            <div class="order-item-qty">Qty: ${item.quantity}</div>
                                        </div>
                                        <div class="order-item-price">₹<fmt:formatNumber value="${item.totalPrice}"/></div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Coupon Code -->
                            <div class="coupon-section">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="couponCode" placeholder="Enter coupon code">
                                    <button type="button" class="btn btn-outline-primary" onclick="applyCoupon()">Apply</button>
                                </div>
                                <input type="hidden" name="couponId" id="couponId">
                                <div id="couponMessage" class="small mt-2"></div>
                            </div>

                            <!-- Price Summary -->
                            <div class="summary-row">
                                <span>Subtotal</span>
                                <span>₹<fmt:formatNumber value="${subtotal}"/></span>
                            </div>
                            <div class="summary-row" id="discountRow" style="display: none;">
                                <span class="text-success">Discount</span>
                                <span class="text-success" id="discountAmount">-₹0</span>
                            </div>
                            <div class="summary-row">
                                <span>Shipping</span>
                                <span>₹<fmt:formatNumber value="${shipping}"/></span>
                            </div>
                            <div class="summary-row summary-total">
                                <span>Total</span>
                                <span id="totalAmount">₹<fmt:formatNumber value="${total}"/></span>
                            </div>

                            <button type="submit" class="btn btn-place-order">
                                <i class="fas fa-lock me-2"></i>Place Order
                            </button>

                            <div class="secure-badge">
                                <i class="fas fa-shield-alt"></i>
                                100% Secure Payment
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Payment option selection
        document.querySelectorAll('.payment-option').forEach(option => {
            option.addEventListener('click', function() {
                document.querySelectorAll('.payment-option').forEach(o => o.classList.remove('selected'));
                this.classList.add('selected');
                this.querySelector('input').checked = true;
            });
        });

        // Apply coupon
        function applyCoupon() {
            var code = document.getElementById('couponCode').value;
            if (!code) return;
            
            fetch('${pageContext.request.contextPath}/user/dashboard/checkout/apply-coupon', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'code=' + encodeURIComponent(code) + '&subtotal=${subtotal}'
            })
            .then(response => response.json())
            .then(data => {
                var msg = document.getElementById('couponMessage');
                if (data.success) {
                    document.getElementById('couponId').value = data.couponId;
                    document.getElementById('discountRow').style.display = 'flex';
                    document.getElementById('discountAmount').textContent = '-₹' + data.discount;
                    var currentTotal = parseFloat('${total}') || 0;
                    var discount = parseFloat(data.discount) || 0;
                    var newTotal = currentTotal - discount;
                    document.getElementById('totalAmount').textContent = '₹' + newTotal.toFixed(2);
                    msg.className = 'small mt-2 text-success';
                    msg.textContent = 'Coupon applied successfully!';
                } else {
                    msg.className = 'small mt-2 text-danger';
                    msg.textContent = data.error;
                }
            });
        }
    </script>
</body>
</html>
