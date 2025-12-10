<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - AyurVeda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #2d5a27; --primary-dark: #1e3d1a; --accent: #8b4513; --gold: #d4a84b; --cream: #faf8f5; }
        body { font-family: 'Poppins', sans-serif; background: var(--cream); }
        h1, h2, h3, h4, h5 { font-family: 'Playfair Display', serif; }
        
        .navbar { background: white; box-shadow: 0 2px 20px rgba(0,0,0,0.08); padding: 15px 0; }
        .navbar-brand { font-family: 'Playfair Display', serif; font-weight: 700; font-size: 1.5rem; color: var(--primary) !important; }
        .navbar-nav .nav-link { color: #333; font-weight: 500; padding: 8px 15px; transition: all 0.3s; }
        .navbar-nav .nav-link:hover { color: var(--primary); }
        .navbar-nav .nav-link.active { color: var(--primary); font-weight: 600; }
        .navbar-toggler { border: none; padding: 4px 8px; }
        .navbar-toggler:focus { box-shadow: none; }
        
        .page-header { background: linear-gradient(135deg, var(--primary), var(--primary-dark)); color: white; padding: 40px 0; text-align: center; }
        
        .cart-card { background: white; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        
        .cart-item { display: flex; align-items: center; padding: 20px; border-bottom: 1px solid #eee; }
        .cart-item:last-child { border-bottom: none; }
        
        .cart-item-image { width: 100px; height: 100px; border-radius: 10px; overflow: hidden; margin-right: 20px; }
        .cart-item-image img { width: 100%; height: 100%; object-fit: cover; }
        
        .cart-item-info { flex: 1; }
        .cart-item-name { font-weight: 600; margin-bottom: 5px; color: #333; }
        .cart-item-name a { color: inherit; text-decoration: none; }
        .cart-item-vendor { font-size: 0.85rem; color: #888; margin-bottom: 5px; }
        .cart-item-price { font-size: 1.1rem; color: var(--primary); font-weight: 600; }
        .cart-item-original { text-decoration: line-through; color: #999; font-size: 0.9rem; margin-left: 8px; }
        
        .quantity-input { display: flex; align-items: center; border: 2px solid #ddd; border-radius: 8px; width: fit-content; }
        .quantity-input button { width: 35px; height: 35px; border: none; background: white; cursor: pointer; }
        .quantity-input button:hover { background: var(--cream); }
        .quantity-input input { width: 50px; height: 35px; border: none; text-align: center; font-weight: 600; }
        
        .cart-item-total { font-size: 1.2rem; font-weight: 700; color: var(--primary); min-width: 100px; text-align: right; }
        
        .btn-remove { color: #dc3545; background: none; border: none; cursor: pointer; font-size: 1.2rem; }
        .btn-remove:hover { color: #a71d2a; }
        
        .summary-card { background: white; border-radius: 15px; padding: 25px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); position: sticky; top: 100px; }
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 15px; }
        .summary-total { font-size: 1.3rem; font-weight: 700; color: var(--primary); border-top: 2px solid #eee; padding-top: 15px; margin-top: 15px; }
        
        .btn-checkout { background: var(--primary); color: white; padding: 15px 30px; border: none; border-radius: 30px; width: 100%; font-weight: 600; font-size: 1rem; }
        .btn-checkout:hover { background: var(--primary-dark); color: white; }
        
        .btn-continue { background: white; color: var(--primary); border: 2px solid var(--primary); padding: 12px 30px; border-radius: 30px; width: 100%; margin-top: 10px; }
        .btn-continue:hover { background: var(--cream); }
        
        .empty-cart { text-align: center; padding: 60px 20px; }
        .empty-cart i { font-size: 5rem; color: #ddd; margin-bottom: 20px; }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="fas fa-leaf me-2"></i>AyurVeda</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/products">
                            <i class="fas fa-shopping-bag me-1"></i>Products
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/user/dashboard/wishlist">
                            <i class="fas fa-heart me-1"></i>Wishlist
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/user/dashboard/cart">
                            <i class="fas fa-shopping-cart me-1"></i>Cart
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/user/dashboard">
                            <i class="fas fa-user me-1"></i>Dashboard
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-shopping-cart me-3"></i>Shopping Cart</h1>
        </div>
    </div>

    <!-- Cart Content -->
    <section class="py-5">
        <div class="container">
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>

            <c:choose>
                <c:when test="${not empty cartItems}">
                    <div class="row">
                        <!-- Cart Items -->
                        <div class="col-lg-8 mb-4">
                            <div class="cart-card">
                                <div class="p-3 border-bottom d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0">${cartItems.size()} item(s) in your cart</h5>
                                    <a href="${pageContext.request.contextPath}/user/dashboard/cart/clear" class="text-danger text-decoration-none" onclick="return confirm('Clear all items?')">
                                        <i class="fas fa-trash me-1"></i>Clear Cart
                                    </a>
                                </div>
                                
                                <c:forEach items="${cartItems}" var="item">
                                    <div class="cart-item">
                                        <div class="cart-item-image">
                                            <a href="${pageContext.request.contextPath}/products/${item.product.slug}">
                                                <img src="${not empty item.product.imageUrl ? (item.product.imageUrl.startsWith('http') ? item.product.imageUrl : pageContext.request.contextPath.concat(item.product.imageUrl)) : pageContext.request.contextPath.concat('/images/no-product.png')}" alt="${item.product.productName}">
                                            </a>
                                        </div>
                                        <div class="cart-item-info">
                                            <h6 class="cart-item-name">
                                                <a href="${pageContext.request.contextPath}/products/${item.product.slug}">${item.product.productName}</a>
                                            </h6>
                                            <p class="cart-item-vendor">Sold by: ${item.product.vendor.storeDisplayName}</p>
                                            <span class="cart-item-price">₹<fmt:formatNumber value="${item.unitPrice}"/></span>
                                            <c:if test="${item.product.mrp != null && item.product.mrp > item.unitPrice}">
                                                <span class="cart-item-original">₹<fmt:formatNumber value="${item.product.mrp}"/></span>
                                            </c:if>
                                        </div>
                                        <div class="me-4">
                                            <form action="${pageContext.request.contextPath}/user/dashboard/cart/update/${item.product.id}" method="post" class="d-flex align-items-center">
                                                <div class="quantity-input">
                                                    <button type="button" onclick="updateQty(this, -1)">-</button>
                                                    <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.stockQuantity}" onchange="this.form.submit()">
                                                    <button type="button" onclick="updateQty(this, 1)">+</button>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="cart-item-total">
                                            ₹<fmt:formatNumber value="${item.totalPrice}"/>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/user/dashboard/cart/remove/${item.product.id}" class="btn-remove ms-3" title="Remove" onclick="return confirm('Remove this item from cart?')">
                                            <i class="fas fa-times"></i>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Order Summary -->
                        <div class="col-lg-4">
                            <div class="summary-card">
                                <h5 class="mb-4">Order Summary</h5>
                                
                                <div class="summary-row">
                                    <span>Subtotal</span>
                                    <span>₹<fmt:formatNumber value="${subtotal}"/></span>
                                </div>
                                <div class="summary-row">
                                    <span>Shipping</span>
                                    <span class="text-success">Calculated at checkout</span>
                                </div>
                                
                                <div class="summary-row summary-total">
                                    <span>Total</span>
                                    <span>₹<fmt:formatNumber value="${subtotal}"/></span>
                                </div>

                                <a href="${pageContext.request.contextPath}/user/dashboard/checkout" class="btn btn-checkout mt-3">
                                    <i class="fas fa-lock me-2"></i>Proceed to Checkout
                                </a>
                                <a href="${pageContext.request.contextPath}/products" class="btn btn-continue">
                                    <i class="fas fa-arrow-left me-2"></i>Continue Shopping
                                </a>

                                <div class="mt-4 text-center">
                                    <small class="text-muted">
                                        <i class="fas fa-shield-alt me-1"></i>Secure checkout
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="cart-card">
                        <div class="empty-cart">
                            <i class="fas fa-shopping-cart"></i>
                            <h4>Your cart is empty</h4>
                            <p class="text-muted mb-4">Looks like you haven't added any products yet</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-checkout" style="width: auto; display: inline-block;">
                                <i class="fas fa-shopping-bag me-2"></i>Start Shopping
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateQty(btn, change) {
            var form = btn.closest('form');
            var input = form.querySelector('input[name="quantity"]');
            var currentVal = parseInt(input.value) || 1;
            var min = parseInt(input.min) || 1;
            var max = parseInt(input.max) || 999;
            var newVal = currentVal + change;
            
            if (newVal >= min && newVal <= max) {
                input.value = newVal;
                form.submit();
            } else if (newVal < min) {
                alert('Minimum quantity is ' + min);
            } else if (newVal > max) {
                alert('Maximum available quantity is ' + max);
            }
        }
        
        // Prevent form double submission
        document.querySelectorAll('form').forEach(function(form) {
            form.addEventListener('submit', function(e) {
                var submitBtn = form.querySelector('button[type="submit"], input[type="submit"]');
                if (submitBtn) {
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
                }
            });
        });
    </script>
</body>
</html>

