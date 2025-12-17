<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName} - AyurVeda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Playfair+Display:wght@400;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <script>
        // Critical functions defined early to ensure they're available
        window.addToCart = function(productId) {
            console.log('addToCart called with productId:', productId);
            console.log('window.isUserLoggedIn:', window.isUserLoggedIn);
            if (!productId) {
                alert('Product ID is missing. Please refresh the page.');
                return;
            }
            // Check multiple ways if user is logged in
            var isLoggedIn = window.isUserLoggedIn || false;
            
            // Fallback: Check if user dropdown exists in navbar (means user is logged in)
            var userDropdown = document.querySelector('.dropdown-toggle[data-bs-toggle="dropdown"]');
            if (userDropdown) {
                var dropdownText = userDropdown.textContent.trim();
                // If dropdown has text and it's not empty, user is logged in
                if (dropdownText && dropdownText.length > 0 && !dropdownText.includes('Login')) {
                    console.log('User detected in navbar dropdown:', dropdownText);
                    isLoggedIn = true;
                }
            }
            
            // Another check: Look for user name in navbar
            var navLinks = document.querySelectorAll('.nav-link');
            var hasUserLink = false;
            navLinks.forEach(function(link) {
                var text = link.textContent.trim();
                // If we see a user name (not "Login" or empty), user is logged in
                if (text && text.length > 2 && !text.includes('Login') && !text.includes('Sign Up') && !text.includes('Home')) {
                    var parent = link.closest('.dropdown');
                    if (parent) {
                        hasUserLink = true;
                    }
                }
            });
            if (hasUserLink) {
                console.log('User link found in navbar');
                isLoggedIn = true;
            }
            
            var ctxPath = window.contextPath || '';
            console.log('Final isLoggedIn check:', isLoggedIn);
            if (isLoggedIn) {
                var qtyInput = document.getElementById('quantity');
                var qty = qtyInput ? qtyInput.value : 1;
                if (!qty || qty < 1) qty = 1;
                var url = ctxPath + '/user/dashboard/cart/add/' + productId + '?quantity=' + qty;
                console.log('Redirecting to:', url);
                window.location.href = url;
            } else {
                if (confirm('Please login to add items to cart. Redirect to login page?')) {
                    window.location.href = ctxPath + '/user/login?redirect=' + encodeURIComponent(window.location.pathname);
                }
            }
        };
        
        window.buyNow = function(productId) {
            console.log('buyNow called with productId:', productId);
            console.log('window.isUserLoggedIn:', window.isUserLoggedIn);
            if (!productId) {
                alert('Product ID is missing. Please refresh the page.');
                return;
            }
            // Check multiple ways if user is logged in
            var isLoggedIn = window.isUserLoggedIn || false;
            
            // Fallback: Check if user dropdown exists in navbar (means user is logged in)
            var userDropdown = document.querySelector('.dropdown-toggle[data-bs-toggle="dropdown"]');
            if (userDropdown) {
                var dropdownText = userDropdown.textContent.trim();
                // If dropdown has text and it's not empty, user is logged in
                if (dropdownText && dropdownText.length > 0 && !dropdownText.includes('Login')) {
                    console.log('User detected in navbar dropdown:', dropdownText);
                    isLoggedIn = true;
                }
            }
            
            // Another check: Look for user name in navbar
            var navLinks = document.querySelectorAll('.nav-link');
            var hasUserLink = false;
            navLinks.forEach(function(link) {
                var text = link.textContent.trim();
                // If we see a user name (not "Login" or empty), user is logged in
                if (text && text.length > 2 && !text.includes('Login') && !text.includes('Sign Up') && !text.includes('Home')) {
                    var parent = link.closest('.dropdown');
                    if (parent) {
                        hasUserLink = true;
                    }
                }
            });
            if (hasUserLink) {
                console.log('User link found in navbar');
                isLoggedIn = true;
            }
            
            var ctxPath = window.contextPath || '';
            console.log('Final isLoggedIn check for buyNow:', isLoggedIn);
            if (isLoggedIn) {
                var qtyInput = document.getElementById('quantity');
                var qty = qtyInput ? qtyInput.value : 1;
                if (!qty || qty < 1) qty = 1;
                var addToCartUrl = ctxPath + '/user/dashboard/cart/add/' + productId + '?quantity=' + qty + '&redirect=checkout';
                console.log('Redirecting to:', addToCartUrl);
                window.location.href = addToCartUrl;
            } else {
                if (confirm('Please login to buy now. Redirect to login page?')) {
                    window.location.href = ctxPath + '/user/login?redirect=' + encodeURIComponent(window.location.pathname);
                }
            }
        };
        
        window.toggleWishlist = function(productId) {
            var isLoggedIn = window.isUserLoggedIn || false;
            var ctxPath = window.contextPath || '';
            if (isLoggedIn) {
                window.location.href = ctxPath + '/user/dashboard/wishlist/toggle/' + productId;
            } else {
                if (confirm('Please login to add to wishlist. Redirect to login page?')) {
                    window.location.href = ctxPath + '/user/login?redirect=' + encodeURIComponent(window.location.pathname);
                }
            }
        };
        
        window.checkDelivery = function() {
            console.log('checkDelivery called');
            const pincodeInput = document.getElementById('pincodeInput');
            if (!pincodeInput) {
                alert('Pincode input field not found');
                return;
            }
            const pincode = pincodeInput.value;
            if (pincode.length !== 6 || !/^\d+$/.test(pincode)) {
                alert('Please enter a valid 6-digit pincode');
                return;
            }
            const today = new Date();
            const deliveryDays = window.productDeliveryDays || 3;
            today.setDate(today.getDate() + deliveryDays);
            const deliveryDate = today.toLocaleDateString('en-IN', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
            const deliveryDateEl = document.getElementById('deliveryDate');
            const deliveryInfoEl = document.getElementById('deliveryInfo');
            if (deliveryDateEl) {
                deliveryDateEl.textContent = deliveryDate;
            }
            if (deliveryInfoEl) {
                deliveryInfoEl.style.display = 'block';
            }
        };
        
        window.changeImage = function(url, element) {
            document.getElementById('mainImage').src = url;
            document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active'));
            element.classList.add('active');
        };
    </script>
    <style>
        :root {
            --primary: #2d5a27;
            --primary-dark: #1e3d1a;
            --accent: #8b4513;
            --gold: #d4a84b;
            --cream: #faf8f5;
        }
        
        body { font-family: 'Poppins', sans-serif; background: var(--cream); }
        h1, h2, h3, h4, h5 { font-family: 'Playfair Display', serif; }
        
        .navbar { background: white; box-shadow: 0 2px 20px rgba(0,0,0,0.08); padding: 15px 0; }
        .navbar-brand { font-family: 'Playfair Display', serif; font-weight: 700; font-size: 1.5rem; color: var(--primary) !important; }
        
        .navbar-nav {
            display: flex;
            flex-direction: row;
            align-items: center;
            flex-wrap: nowrap;
        }
        
        .navbar-nav .nav-item {
            display: flex;
            align-items: center;
            white-space: nowrap;
        }
        
        .nav-link { color: #333 !important; font-weight: 500; margin: 0 10px; white-space: nowrap; }
        .nav-link:hover { color: var(--primary) !important; }
        
        /* Ensure navbar items stay in single row on desktop */
        @media (min-width: 992px) {
            .navbar-nav {
                flex-wrap: nowrap !important;
            }
            
            .navbar-nav .nav-item {
                flex-shrink: 0;
            }
        }
        
        .breadcrumb { background: transparent; padding: 20px 0; }
        .breadcrumb-item a { color: var(--primary); text-decoration: none; }
        
        .product-gallery { background: white; border-radius: 15px; padding: 20px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        .main-image { height: 400px; display: flex; align-items: center; justify-content: center; margin-bottom: 15px; }
        .main-image img { max-width: 100%; max-height: 100%; object-fit: contain; border-radius: 10px; }
        .thumbnail-images { display: flex; gap: 10px; }
        .thumbnail { width: 80px; height: 80px; border: 2px solid #ddd; border-radius: 8px; cursor: pointer; overflow: hidden; transition: all 0.3s ease; }
        .thumbnail:hover, .thumbnail.active { border-color: var(--primary); }
        .thumbnail img { width: 100%; height: 100%; object-fit: cover; }
        
        .product-info-card { background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        .product-brand { font-size: 0.9rem; color: var(--accent); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px; }
        .product-title { font-size: 1.8rem; margin-bottom: 15px; color: #333; }
        
        .product-rating { display: flex; align-items: center; margin-bottom: 20px; }
        .stars { color: #ffc107; font-size: 1.1rem; }
        .rating-text { margin-left: 10px; color: #666; }
        
        .price-section { margin-bottom: 25px; padding: 20px; background: var(--cream); border-radius: 10px; }
        .current-price { font-size: 2rem; font-weight: 700; color: var(--primary); }
        .original-price { font-size: 1.2rem; color: #999; text-decoration: line-through; margin-left: 10px; }
        .discount-badge { background: #dc3545; color: white; padding: 5px 12px; border-radius: 20px; font-size: 0.85rem; margin-left: 10px; }
        
        .stock-status { display: flex; align-items: center; margin-bottom: 20px; }
        .in-stock { color: #28a745; font-weight: 500; }
        .out-of-stock { color: #dc3545; font-weight: 500; }
        
        .quantity-selector { display: flex; align-items: center; margin-bottom: 25px; }
        .quantity-selector label { margin-right: 15px; font-weight: 500; }
        .quantity-input { display: flex; align-items: center; border: 2px solid #ddd; border-radius: 8px; overflow: hidden; background: white; }
        .quantity-input button { width: 40px; height: 40px; border: none; background: white; cursor: pointer; font-size: 1.2rem; font-weight: 600; color: var(--primary); transition: all 0.3s ease; }
        .quantity-input button:hover { background: var(--cream); color: var(--primary-dark); }
        .quantity-input button:active { transform: scale(0.95); }
        .quantity-input input { width: 60px; height: 40px; border: none; text-align: center; font-weight: 600; font-size: 1rem; }
        .quantity-input input:focus { outline: none; }
        
        .action-buttons { display: flex; gap: 15px; margin-bottom: 25px; }
        .btn-add-cart { background: var(--primary); color: white; padding: 15px 40px; border: none; border-radius: 30px; font-weight: 600; flex: 1; }
        .btn-add-cart:hover { background: var(--primary-dark); color: white; }
        .btn-buy-now { background: var(--gold); color: white; padding: 15px 40px; border: none; border-radius: 30px; font-weight: 600; flex: 1; }
        .btn-buy-now:hover { background: #c99a3a; color: white; }
        .btn-wishlist { width: 55px; height: 55px; border: 2px solid #ddd; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; cursor: pointer; transition: all 0.3s ease; }
        .btn-wishlist:hover, .btn-wishlist.active { background: #dc3545; color: white; border-color: #dc3545; }
        
        .product-meta { border-top: 1px solid #eee; padding-top: 20px; }
        .meta-item { display: flex; margin-bottom: 10px; }
        .meta-label { width: 120px; color: #666; }
        .meta-value { font-weight: 500; }
        
        .share-section { margin-top: 20px; }
        .share-section a { width: 35px; height: 35px; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; margin-right: 8px; color: white; text-decoration: none; }
        
        .product-tabs { background: white; border-radius: 15px; padding: 30px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-top: 30px; }
        .nav-tabs { border-bottom: 2px solid #eee; }
        .nav-tabs .nav-link { border: none; color: #666; padding: 15px 25px; font-weight: 500; }
        .nav-tabs .nav-link.active { color: var(--primary); border-bottom: 3px solid var(--primary); }
        .tab-content { padding-top: 25px; }
        
        .review-card { border-bottom: 1px solid #eee; padding: 20px 0; }
        .review-card:last-child { border-bottom: none; }
        .reviewer { display: flex; align-items: center; margin-bottom: 10px; }
        .reviewer-avatar { width: 45px; height: 45px; border-radius: 50%; background: var(--cream); display: flex; align-items: center; justify-content: center; font-weight: 600; color: var(--primary); margin-right: 15px; }
        .verified-badge { background: #28a745; color: white; padding: 2px 8px; border-radius: 10px; font-size: 0.75rem; margin-left: 10px; }
        
        .rating-breakdown { display: flex; align-items: center; margin-bottom: 8px; }
        .rating-breakdown span { width: 30px; }
        .rating-bar { flex: 1; height: 8px; background: #eee; border-radius: 4px; margin: 0 10px; }
        .rating-bar-fill { height: 100%; background: #ffc107; border-radius: 4px; }
        
        .similar-products { margin-top: 40px; }
        .similar-product-card { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 3px 10px rgba(0,0,0,0.05); transition: all 0.3s ease; height: 100%; }
        .similar-product-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .similar-product-card img { width: 100%; height: 150px; object-fit: cover; }
        .similar-product-card .card-body { padding: 15px; display: flex; flex-direction: column; }
        .similar-product-card .title { font-size: 0.9rem; margin-bottom: 5px; }
        .similar-product-card .price { font-weight: 600; color: var(--primary); }
        .products-carousel { position: relative; }
        .products-carousel::-webkit-scrollbar { height: 6px; }
        .products-carousel::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
        .products-carousel::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        .products-carousel::-webkit-scrollbar-thumb:hover { background: var(--primary-dark); }
        .carousel-controls { display: flex; gap: 10px; }
        
        /* Mobile Optimizations */
        @media (max-width: 768px) {
            .product-gallery { margin-bottom: 20px; }
            .main-image { height: 300px; }
            .thumbnail-images { flex-wrap: wrap; }
            .product-info-card { padding: 20px; }
            .product-title { font-size: 1.4rem; }
            .action-buttons { flex-direction: column; }
            .btn-add-cart, .btn-buy-now { width: 100%; }
            .variant-options { flex-wrap: wrap; }
            .offers-section, .delivery-section, .emi-section, .warranty-section, .seller-section { padding: 12px; }
            .products-carousel { padding-bottom: 10px; }
            .similar-product-card { min-width: 180px !important; }
            .breadcrumb-wrapper { padding: 10px 0; }
            .breadcrumb { font-size: 0.85rem; }
        }
        
        @media (max-width: 576px) {
            .product-title { font-size: 1.2rem; }
            .current-price { font-size: 1.5rem; }
            .quantity-input { width: 100%; }
            .action-buttons { gap: 10px; }
            .btn-wishlist { width: 45px; height: 45px; }
        }
        
        /* Image Zoom */
        .main-image { position: relative; cursor: zoom-in; }
        .zoom-lens { position: absolute; border: 2px solid var(--primary); display: none; pointer-events: none; }
        .zoom-result { position: absolute; top: 0; right: -450px; width: 400px; height: 400px; border: 1px solid #ddd; display: none; background: white; z-index: 1000; }
        .zoom-result img { width: 100%; height: 100%; object-fit: contain; }
        
        /* Breadcrumb */
        .breadcrumb-wrapper { background: white; padding: 15px 0; margin-top: 80px; border-bottom: 1px solid #eee; }
        
        /* Product Variants */
        .variant-selector { margin-bottom: 20px; }
        .variant-group { margin-bottom: 15px; }
        .variant-label { font-weight: 600; margin-bottom: 8px; color: #333; }
        .variant-options { display: flex; flex-wrap: wrap; gap: 10px; }
        .variant-option { padding: 8px 16px; border: 2px solid #ddd; border-radius: 8px; cursor: pointer; transition: all 0.3s; background: white; }
        .variant-option:hover { border-color: var(--primary); }
        .variant-option.selected { border-color: var(--primary); background: rgba(45, 90, 39, 0.1); }
        .variant-option.color-option { width: 40px; height: 40px; border-radius: 50%; padding: 0; border-width: 3px; }
        
        /* Offers Section */
        .offers-section { background: #fff3cd; border: 1px solid #ffc107; border-radius: 8px; padding: 15px; margin: 20px 0; }
        .offer-item { display: flex; align-items: start; margin-bottom: 10px; padding: 8px; background: white; border-radius: 5px; }
        .offer-item:last-child { margin-bottom: 0; }
        .offer-icon { color: #ffc107; margin-right: 10px; margin-top: 3px; }
        .offer-text { flex: 1; font-size: 0.9rem; }
        .offer-link { color: var(--primary); text-decoration: none; font-weight: 600; }
        
        /* Delivery Calculator */
        .delivery-section { background: #f8f9fa; border-radius: 8px; padding: 15px; margin: 20px 0; }
        .pincode-input-group { display: flex; gap: 10px; margin-top: 10px; }
        .pincode-input { flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
        .check-pincode-btn { padding: 10px 20px; background: var(--primary); color: white; border: none; border-radius: 5px; cursor: pointer; }
        .delivery-info { margin-top: 10px; padding: 10px; background: white; border-radius: 5px; }
        
        /* Seller Information */
        .seller-section { background: #f8f9fa; border-radius: 8px; padding: 15px; margin: 20px 0; }
        .seller-name { font-weight: 600; color: var(--primary); }
        .seller-rating { display: flex; align-items: center; gap: 5px; margin-top: 5px; }
        .seller-policy { margin-top: 10px; padding-top: 10px; border-top: 1px solid #ddd; }
        
        /* Warranty Section */
        .warranty-section { background: #e7f3ff; border-left: 4px solid #0066cc; padding: 15px; margin: 20px 0; border-radius: 5px; }
        
        /* EMI Section */
        .emi-section { background: #f0f0f0; border-radius: 8px; padding: 15px; margin: 20px 0; }
        .emi-option { display: flex; justify-content: space-between; padding: 10px; background: white; border-radius: 5px; margin-bottom: 8px; }
        
        /* Q&A Section */
        .qa-section { margin-top: 30px; }
        .question-card { background: white; border: 1px solid #eee; border-radius: 8px; padding: 15px; margin-bottom: 15px; }
        .question-header { display: flex; justify-content: space-between; align-items: start; margin-bottom: 10px; }
        .question-text { font-weight: 600; color: #333; margin-bottom: 10px; }
        .question-meta { font-size: 0.85rem; color: #666; }
        .answer-card { background: #f8f9fa; border-left: 3px solid var(--primary); padding: 12px; margin-top: 10px; margin-left: 20px; border-radius: 5px; }
        .answer-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
        .vendor-badge { background: #28a745; color: white; padding: 2px 8px; border-radius: 10px; font-size: 0.75rem; }
        .ask-question-btn { margin-top: 20px; }
        
        /* Enhanced Reviews */
        .review-images { display: flex; gap: 10px; margin-top: 10px; flex-wrap: wrap; }
        .review-image { width: 80px; height: 80px; border-radius: 5px; object-fit: cover; cursor: pointer; border: 2px solid #ddd; }
        .helpful-buttons { display: flex; gap: 10px; margin-top: 10px; }
        .helpful-btn { padding: 5px 15px; border: 1px solid #ddd; background: white; border-radius: 20px; cursor: pointer; font-size: 0.85rem; }
        .helpful-btn:hover { background: #f0f0f0; }
        .helpful-btn.active { background: var(--primary); color: white; border-color: var(--primary); }
        .review-filters { display: flex; gap: 10px; margin-bottom: 20px; flex-wrap: wrap; }
        .filter-btn { padding: 8px 16px; border: 1px solid #ddd; background: white; border-radius: 20px; cursor: pointer; font-size: 0.9rem; }
        .filter-btn.active { background: var(--primary); color: white; border-color: var(--primary); }
        
        /* Highlights */
        .highlights-section { background: white; border-radius: 8px; padding: 20px; margin: 20px 0; }
        .highlight-item { display: flex; align-items: start; margin-bottom: 12px; }
        .highlight-icon { color: var(--primary); margin-right: 10px; margin-top: 3px; }
        
        /* Urgency Messages */
        .urgency-message { background: #fff3cd; border-left: 4px solid #ffc107; padding: 12px; margin: 15px 0; border-radius: 5px; font-weight: 600; color: #856404; }
        
        /* View More Offers */
        .view-more-offers { text-align: center; margin-top: 10px; }
        .view-more-link { color: var(--primary); text-decoration: none; font-weight: 600; cursor: pointer; }
    </style>
</head>
<body>
    <!-- Navbar - Same as Home Page -->
    <nav class="navbar navbar-expand-lg fixed-top" style="background: rgba(26, 46, 26, 0.98); box-shadow: 0 5px 30px rgba(0,0,0,0.3);">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/" style="font-family: 'Cormorant Garamond', serif; font-size: 28px; font-weight: 700; color: #c9a227 !important;">
                <i class="fas fa-leaf me-2"></i>Ayurveda Wellness
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-lg-center">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/" style="color: #fff !important;">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/hospitals" style="color: #fff !important;">Find Centers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/doctors" style="color: #fff !important;">Find Doctors</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/products" style="color: #c9a227 !important;"><i class="fas fa-shopping-bag me-1"></i>Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/about" style="color: #fff !important;">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/services" style="color: #fff !important;">Services</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/contact" style="color: #fff !important;">Contact</a>
                    </li>
                    <c:choose>
                        <c:when test="${not empty currentUser}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/dashboard/wishlist" style="color: #fff !important;">
                                    <i class="fas fa-heart"></i>
                                </a>
                            </li>
                            <li class="nav-item position-relative">
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/dashboard/cart" style="color: #fff !important;">
                                    <i class="fas fa-shopping-cart"></i>
                                    <c:if test="${cartCount > 0}">
                                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.7rem;">${cartCount}</span>
                                    </c:if>
                                </a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" style="background: rgba(201, 162, 39, 0.15); border-radius: 30px; padding: 8px 20px !important; color: #c9a227 !important;">
                                    <i class="fas fa-user-circle me-2"></i>${currentUser.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/dashboard"><i class="fas fa-th-large me-2" style="color: #c9a227;"></i>Dashboard</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/dashboard/orders"><i class="fas fa-box me-2" style="color: #c9a227;"></i>My Orders</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout"><i class="fas fa-sign-out-alt me-2" style="color: #c9a227;"></i>Sign Out</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/login" style="color: #fff !important;">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/register" style="background: linear-gradient(135deg, #c9a227 0%, #e6b55c 100%); color: #1a2e1a !important; padding: 10px 25px !important; border-radius: 30px; font-weight: 600; margin-left: 10px;">Sign Up</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Breadcrumb -->
    <div class="breadcrumb-wrapper">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <c:if test="${not empty product.category}">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products/category/${product.category.slug}">${product.category.displayName}</a></li>
                    </c:if>
                    <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
                </ol>
            </nav>
        </div>
    </div>

    <!-- Product Details -->
    <section class="py-4">
        <div class="container">
            <div class="row">
                <!-- Product Gallery -->
                <div class="col-lg-5 mb-4">
                    <div class="product-gallery">
                        <div class="main-image">
                            <c:choose>
                                <c:when test="${not empty product.imageUrl}">
                                    <c:set var="mainImageUrl" value="${product.imageUrl.startsWith('http') ? product.imageUrl : pageContext.request.contextPath.concat(product.imageUrl)}" />
                                    <img src="${mainImageUrl}" alt="${product.productName}" id="mainImage" onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                    <div style="display: none; width: 100%; height: 400px; background: #f0f0f0; align-items: center; justify-content: center; color: #999;">
                                        <i class="fas fa-image" style="font-size: 3rem;"></i>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div style="width: 100%; height: 400px; background: #f0f0f0; display: flex; align-items: center; justify-content: center; color: #999;" id="mainImage">
                                        <i class="fas fa-image" style="font-size: 3rem;"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <c:if test="${not empty productImages}">
                            <div class="thumbnail-images">
                                <c:if test="${not empty product.imageUrl}">
                                    <c:set var="mainThumbUrl" value="${product.imageUrl.startsWith('http') ? product.imageUrl : pageContext.request.contextPath.concat(product.imageUrl)}" />
                                    <div class="thumbnail active" onclick="changeImage('${mainThumbUrl}', this)">
                                        <img src="${mainThumbUrl}" alt="Main">
                                    </div>
                                </c:if>
                                <c:forEach items="${productImages}" var="img">
                                    <c:set var="thumbUrl" value="${img.imageUrl.startsWith('http') ? img.imageUrl : pageContext.request.contextPath.concat(img.imageUrl)}" />
                                    <div class="thumbnail" onclick="changeImage('${thumbUrl}', this)">
                                        <img src="${thumbUrl}" alt="Image">
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Product Info -->
                <div class="col-lg-7">
                    <div class="product-info-card">
                        <c:if test="${not empty product.brand}">
                            <span class="product-brand">${product.brand}</span>
                        </c:if>
                        <h1 class="product-title">${product.productName}</h1>

                        <div class="product-rating">
                            <div class="stars">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="${i <= product.averageRating ? 'fas' : (i - 0.5 <= product.averageRating ? 'fas fa-star-half-alt' : 'far')} fa-star"></i>
                                </c:forEach>
                            </div>
                            <span class="rating-text">${product.averageRating} (${product.totalReviews} reviews) | ${product.totalSales} sold</span>
                        </div>

                        <div class="price-section">
                            <span class="current-price">₹<fmt:formatNumber value="${product.price}" pattern="#,##0"/></span>
                            <c:if test="${product.mrp != null && product.mrp > product.price}">
                                <span class="original-price">₹<fmt:formatNumber value="${product.mrp}" pattern="#,##0"/></span>
                                <span class="discount-badge">${product.discountPercentage}% OFF</span>
                            </c:if>
                        </div>

                        <div class="stock-status">
                            <c:choose>
                                <c:when test="${product.stockQuantity > 0}">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span class="in-stock">In Stock (${product.stockQuantity} available)</span>
                                    <c:if test="${product.stockQuantity <= 10}">
                                        <span class="urgency-message" style="display: block; margin-top: 10px;">
                                            <i class="fas fa-exclamation-triangle me-2"></i>Hurry, Only ${product.stockQuantity} left!
                                        </span>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-times-circle text-danger me-2"></i>
                                    <span class="out-of-stock">Out of Stock</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <c:if test="${not empty product.shortDescription}">
                            <p class="mb-4">${product.shortDescription}</p>
                        </c:if>

                        <!-- Product Variants -->
                        <c:if test="${not empty variants}">
                            <div class="variant-selector">
                                <c:forEach var="variantEntry" items="${variants}">
                                    <div class="variant-group">
                                        <div class="variant-label">${variantEntry.key.displayName}:</div>
                                        <div class="variant-options">
                                            <c:forEach var="variant" items="${variantEntry.value}">
                                                <c:choose>
                                                    <c:when test="${variantEntry.key == 'COLOR' && not empty variant.colorCode}">
                                                        <div class="variant-option color-option ${variant.isDefault ? 'selected' : ''}" 
                                                             style="background-color: ${variant.colorCode};"
                                                             onclick="selectVariant(${variant.id}, '${variantEntry.key}')"
                                                             title="${variant.variantName}">
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="variant-option ${variant.isDefault ? 'selected' : ''}" 
                                                             onclick="selectVariant(${variant.id}, '${variantEntry.key}')">
                                                            ${variant.variantName}
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>

                        <!-- Highlights -->
                        <div class="highlights-section">
                            <h6 class="mb-3" style="font-weight: 600;">Highlights</h6>
                            <c:if test="${not empty product.category}">
                                <div class="highlight-item">
                                    <i class="fas fa-tag highlight-icon"></i>
                                    <span><strong>Category:</strong> ${product.category.displayName}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty product.brand}">
                                <div class="highlight-item">
                                    <i class="fas fa-certificate highlight-icon"></i>
                                    <span><strong>Brand:</strong> ${product.brand}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty product.weight}">
                                <div class="highlight-item">
                                    <i class="fas fa-weight highlight-icon"></i>
                                    <span><strong>Weight/Size:</strong> ${product.weight}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty product.manufacturer}">
                                <div class="highlight-item">
                                    <i class="fas fa-industry highlight-icon"></i>
                                    <span><strong>Manufacturer:</strong> ${product.manufacturer}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty product.countryOfOrigin}">
                                <div class="highlight-item">
                                    <i class="fas fa-globe highlight-icon"></i>
                                    <span><strong>Country of Origin:</strong> ${product.countryOfOrigin}</span>
                                </div>
                            </c:if>
                        </div>

                        <!-- Offers Section -->
                        <c:if test="${not empty productOffers || not empty globalOffers}">
                            <div class="offers-section">
                                <h6 class="mb-3" style="font-weight: 600; color: #856404;">
                                    <i class="fas fa-gift me-2"></i>Available Offers
                                </h6>
                                <c:set var="offerCount" value="0"/>
                                <c:forEach var="offer" items="${productOffers}">
                                    <c:if test="${offerCount < 3}">
                                        <div class="offer-item">
                                            <i class="fas fa-tag offer-icon"></i>
                                            <div class="offer-text">
                                                <strong>${offer.title}</strong>
                                                <c:if test="${not empty offer.description}">
                                                    <br><small>${offer.description}</small>
                                                </c:if>
                                            </div>
                                        </div>
                                        <c:set var="offerCount" value="${offerCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                <c:forEach var="offer" items="${globalOffers}">
                                    <c:if test="${offerCount < 3}">
                                        <div class="offer-item">
                                            <i class="fas fa-tag offer-icon"></i>
                                            <div class="offer-text">
                                                <strong>${offer.title}</strong>
                                                <c:if test="${not empty offer.description}">
                                                    <br><small>${offer.description}</small>
                                                </c:if>
                                            </div>
                                        </div>
                                        <c:set var="offerCount" value="${offerCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${offerCount >= 3}">
                                    <div class="view-more-offers">
                                        <a href="#" class="view-more-link" onclick="showAllOffers(); return false;">
                                            View ${offerCount - 3} more offers <i class="fas fa-chevron-down"></i>
                                        </a>
                                    </div>
                                </c:if>
                            </div>
                        </c:if>

                        <!-- Delivery Calculator -->
                        <div class="delivery-section">
                            <h6 class="mb-2" style="font-weight: 600;">
                                <i class="fas fa-truck me-2"></i>Delivery
                            </h6>
                            <div class="pincode-input-group">
                                <input type="text" id="pincodeInput" class="pincode-input" placeholder="Enter pincode" maxlength="6">
                                <button class="check-pincode-btn" onclick="checkDelivery()">Check</button>
                            </div>
                            <div id="deliveryInfo" class="delivery-info" style="display: none;">
                                <i class="fas fa-check-circle text-success me-2"></i>
                                <span id="deliveryText">Delivery by <strong id="deliveryDate"></strong></span>
                            </div>
                        </div>

                        <!-- EMI Options -->
                        <c:if test="${product.emiAvailable == true}">
                            <div class="emi-section">
                                <h6 class="mb-3" style="font-weight: 600;">
                                    <i class="fas fa-credit-card me-2"></i>EMI Options
                                </h6>
                                <c:if test="${not empty product.emiOptions}">
                                    <c:forEach var="emiOption" items="${product.emiOptions}">
                                        <div class="emi-option">
                                            <span>EMI starting from ₹${emiOption.monthlyAmount}/month</span>
                                            <span class="text-muted">${emiOption.months} months</span>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <small class="text-muted">No Cost EMI available on select cards</small>
                            </div>
                        </c:if>

                        <!-- Warranty -->
                        <c:if test="${not empty product.warrantyPeriod}">
                            <div class="warranty-section">
                                <h6 class="mb-2" style="font-weight: 600;">
                                    <i class="fas fa-shield-alt me-2"></i>Warranty
                                </h6>
                                <p class="mb-1"><strong>${product.warrantyPeriod} Warranty</strong></p>
                                <c:if test="${not empty product.warrantyDetails}">
                                    <p class="mb-0" style="font-size: 0.9rem;">${product.warrantyDetails}</p>
                                </c:if>
                            </div>
                        </c:if>

                        <!-- Seller Information -->
                        <div class="seller-section">
                            <h6 class="mb-2" style="font-weight: 600;">
                                <i class="fas fa-store me-2"></i>Seller Information
                            </h6>
                            <div class="seller-name">${product.vendor.storeDisplayName}</div>
                            <div class="seller-rating">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="${i <= product.vendor.averageRating ? 'fas' : 'far'} fa-star" style="color: #ffc107; font-size: 0.9rem;"></i>
                                </c:forEach>
                                <span style="margin-left: 5px; font-size: 0.9rem;">${product.vendor.averageRating} (${product.vendor.totalReviews} ratings)</span>
                            </div>
                            <div class="seller-policy">
                                <c:if test="${not empty product.replacementPolicy}">
                                    <div class="mb-2">
                                        <i class="fas fa-sync-alt me-2" style="color: var(--primary);"></i>
                                        <strong>${product.replacementPeriodDays} Days Replacement Policy</strong>
                                    </div>
                                </c:if>
                                <c:if test="${not empty product.returnPolicy}">
                                    <div>
                                        <i class="fas fa-undo me-2" style="color: var(--primary);"></i>
                                        <strong>${product.returnPeriodDays} Days Return Policy</strong>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <c:if test="${product.stockQuantity > 0}">
                            <div class="quantity-selector">
                                <label>Quantity:</label>
                                <div class="quantity-input">
                                    <button type="button" onclick="decreaseQty()">-</button>
                                    <input type="number" id="quantity" value="1" min="1" max="${product.stockQuantity}">
                                    <button type="button" onclick="increaseQty(${product.stockQuantity})">+</button>
                                </div>
                            </div>

                            <div class="action-buttons">
                                <c:if test="${not empty product && not empty product.id}">
                                    <button class="btn-add-cart" onclick="window.addToCart(${product.id})" type="button">
                                    <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                </button>
                                    <button class="btn-buy-now" onclick="window.buyNow(${product.id})" type="button">
                                    <i class="fas fa-bolt me-2"></i>Buy Now
                                </button>
                                    <button class="btn-wishlist ${inWishlist ? 'active' : ''}" onclick="window.toggleWishlist(${product.id})" title="Add to Wishlist" type="button">
                                    <i class="fas fa-heart"></i>
                                </button>
                                </c:if>
                            </div>
                        </c:if>

                        <div class="product-meta">
                            <div class="meta-item">
                                <span class="meta-label">SKU:</span>
                                <span class="meta-value">${product.sku}</span>
                            </div>
                            <c:if test="${not empty product.category}">
                                <div class="meta-item">
                                    <span class="meta-label">Category:</span>
                                    <span class="meta-value"><a href="${pageContext.request.contextPath}/products/category/${product.category.slug}">${product.category.displayName}</a></span>
                                </div>
                            </c:if>
                            <c:if test="${not empty product.weight}">
                                <div class="meta-item">
                                    <span class="meta-label">Weight/Size:</span>
                                    <span class="meta-value">${product.weight}</span>
                                </div>
                            </c:if>
                            <div class="meta-item">
                                <span class="meta-label">Sold By:</span>
                                <span class="meta-value">${product.vendor.storeDisplayName}</span>
                            </div>
                        </div>

                        <div class="share-section">
                            <span class="text-muted me-2"><strong>Share:</strong></span>
                            <c:set var="shareUrl" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/products/${product.slug}"/>
                            <c:set var="shareText" value="Check out ${product.productName} on AyurVeda!"/>
                            <a href="https://www.facebook.com/sharer/sharer.php?u=${shareUrl}" 
                               target="_blank" 
                               style="background: #3b5998;"
                               title="Share on Facebook">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a href="https://twitter.com/intent/tweet?text=${shareText}&url=${shareUrl}" 
                               target="_blank" 
                               style="background: #1da1f2;"
                               title="Share on Twitter">
                                <i class="fab fa-twitter"></i>
                            </a>
                            <a href="https://wa.me/?text=${shareText}%20${shareUrl}" 
                               target="_blank" 
                               style="background: #25d366;"
                               title="Share on WhatsApp">
                                <i class="fab fa-whatsapp"></i>
                            </a>
                            <a href="https://www.linkedin.com/sharing/share-offsite/?url=${shareUrl}" 
                               target="_blank" 
                               style="background: #0077b5;"
                               title="Share on LinkedIn">
                                <i class="fab fa-linkedin-in"></i>
                            </a>
                            <button onclick="copyProductLink()" 
                                    style="background: #6c757d; border: none; color: white; width: 35px; height: 35px; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; margin-right: 8px; cursor: pointer;"
                                    title="Copy Link">
                                <i class="fas fa-link"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product Tabs -->
            <div class="product-tabs">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description" type="button" role="tab" aria-controls="description" aria-selected="true">Description</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="ingredients-tab" data-bs-toggle="tab" data-bs-target="#ingredients" type="button" role="tab" aria-controls="ingredients" aria-selected="false">Ingredients</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="usage-tab" data-bs-toggle="tab" data-bs-target="#usage" type="button" role="tab" aria-controls="usage" aria-selected="false">How to Use</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button" role="tab" aria-controls="reviews" aria-selected="false">Reviews (${product.totalReviews})</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="qa-tab" data-bs-toggle="tab" data-bs-target="#qa" type="button" role="tab" aria-controls="qa" aria-selected="false">Q&A (${questionCount})</button>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="description" role="tabpanel" aria-labelledby="description-tab">
                        <c:choose>
                            <c:when test="${not empty product.description}">
                                <div style="white-space: pre-wrap; line-height: 1.8;">${product.description}</div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted">No description available.</p>
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${not empty product.benefits}">
                            <h5 class="mt-4 mb-3" style="color: var(--primary);">Benefits</h5>
                            <div style="white-space: pre-wrap; line-height: 1.8;">${product.benefits}</div>
                        </c:if>
                    </div>
                    <div class="tab-pane fade" id="ingredients" role="tabpanel" aria-labelledby="ingredients-tab">
                        <c:choose>
                            <c:when test="${not empty product.ingredients}">
                                <div style="white-space: pre-wrap; line-height: 1.8;">${product.ingredients}</div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted">Ingredient information not available.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="tab-pane fade" id="usage" role="tabpanel" aria-labelledby="usage-tab">
                        <c:choose>
                            <c:when test="${not empty product.usageInstructions}">
                                <div style="white-space: pre-wrap; line-height: 1.8;">${product.usageInstructions}</div>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted">Usage instructions not available.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="tab-pane fade" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
                        <!-- Rating Summary -->
                        <div class="row mb-4">
                            <div class="col-md-4 text-center">
                                <h1 class="mb-0">${product.averageRating}</h1>
                                <div class="stars mb-2">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="${i <= product.averageRating ? 'fas' : 'far'} fa-star"></i>
                                    </c:forEach>
                                </div>
                                <p class="text-muted">${product.totalReviews} reviews</p>
                            </div>
                            <div class="col-md-8">
                                <c:set var="totalReviewsForDistribution" value="${product.totalReviews > 0 ? product.totalReviews : 1}"/>
                                <c:forEach begin="1" end="5" var="i">
                                    <c:set var="r" value="${6 - i}"/>
                                    <c:set var="ratingCount" value="${ratingDistribution != null && ratingDistribution[r] != null ? ratingDistribution[r] : 0}"/>
                                    <c:set var="ratingPercent" value="${(ratingCount * 100) / totalReviewsForDistribution}"/>
                                    <div class="rating-breakdown">
                                        <span>${r}</span>
                                        <i class="fas fa-star text-warning"></i>
                                        <div class="rating-bar">
                                            <div class="rating-bar-fill" style="width: ${ratingPercent}%"></div>
                                        </div>
                                        <span class="text-muted">${ratingCount} (${ratingPercent}%)</span>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Review Filters -->
                        <div class="review-filters">
                            <button class="filter-btn active" onclick="filterReviews('all')">All Reviews</button>
                            <button class="filter-btn" onclick="filterReviews('5')">5 Stars</button>
                            <button class="filter-btn" onclick="filterReviews('4')">4 Stars</button>
                            <button class="filter-btn" onclick="filterReviews('3')">3 Stars</button>
                            <button class="filter-btn" onclick="filterReviews('2')">2 Stars</button>
                            <button class="filter-btn" onclick="filterReviews('1')">1 Star</button>
                            <button class="filter-btn" onclick="filterReviews('withImages')">With Images</button>
                            <button class="filter-btn" onclick="filterReviews('verified')">Verified Purchase</button>
                        </div>

                        <!-- Reviews List -->
                        <c:choose>
                            <c:when test="${not empty reviews}">
                                <c:forEach items="${reviews}" var="review">
                                    <div class="review-card" data-rating="${review.rating}" data-verified="${review.isVerifiedPurchase}" data-has-images="${not empty review.imageUrls}">
                                        <div class="reviewer">
                                            <div class="reviewer-avatar">${review.user.fullName.substring(0, 1)}</div>
                                            <div>
                                                <strong>${review.user.fullName}</strong>
                                                <c:if test="${review.isVerifiedPurchase}">
                                                    <span class="verified-badge"><i class="fas fa-check me-1"></i>Verified Purchase</span>
                                                </c:if>
                                                <br><small class="text-muted"><fmt:formatDate value="${review.createdAt}" pattern="dd MMM yyyy"/></small>
                                            </div>
                                        </div>
                                        <div class="stars mb-2">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i class="${i <= review.rating ? 'fas' : 'far'} fa-star"></i>
                                            </c:forEach>
                                        </div>
                                        <c:if test="${not empty review.title}">
                                            <h6>${review.title}</h6>
                                        </c:if>
                                        <p>${review.comment}</p>
                                        
                                        <!-- Review Images -->
                                        <c:if test="${not empty review.imageUrls}">
                                            <div class="review-images">
                                                <c:forTokens items="${review.imageUrls}" delims="," var="imgUrl">
                                                    <img src="${imgUrl.startsWith('http') ? imgUrl : pageContext.request.contextPath.concat(imgUrl)}" 
                                                         alt="Review image" 
                                                         class="review-image"
                                                         onclick="openImageModal('${imgUrl.startsWith('http') ? imgUrl : pageContext.request.contextPath.concat(imgUrl)}')">
                                                </c:forTokens>
                                            </div>
                                        </c:if>
                                        
                                        <c:if test="${not empty review.pros}">
                                            <p class="text-success mb-1"><i class="fas fa-thumbs-up me-2"></i><strong>Pros:</strong> ${review.pros}</p>
                                        </c:if>
                                        <c:if test="${not empty review.cons}">
                                            <p class="text-danger mb-2"><i class="fas fa-thumbs-down me-2"></i><strong>Cons:</strong> ${review.cons}</p>
                                        </c:if>
                                        
                                        <!-- Helpful Buttons -->
                                        <div class="helpful-buttons">
                                            <button class="helpful-btn" onclick="voteHelpful(${review.id}, true)">
                                                <i class="fas fa-thumbs-up me-1"></i>Helpful (${review.helpfulCount})
                                            </button>
                                            <button class="helpful-btn" onclick="voteHelpful(${review.id}, false)">
                                                <i class="fas fa-thumbs-down me-1"></i>Not Helpful (${review.notHelpfulCount})
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-comments fa-3x text-muted mb-3"></i>
                                    <p>No reviews yet. Be the first to review this product!</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Q&A Tab -->
                    <div class="tab-pane fade" id="qa" role="tabpanel" aria-labelledby="qa-tab">
                        <div class="qa-section">
                            <c:choose>
                                <c:when test="${not empty questions}">
                                    <c:forEach items="${questions}" var="question">
                                        <div class="question-card">
                                            <div class="question-header">
                                                <div>
                                                    <div class="question-text">Q: ${question.question}</div>
                                                    <div class="question-meta">
                                                        Asked by ${question.user.fullName} on <fmt:formatDate value="${question.createdAt}" pattern="dd MMM yyyy"/>
                    </div>
                </div>
            </div>

                                            <!-- Answers -->
                                            <c:set var="answers" value="${question.answers}"/>
                                            <c:if test="${not empty answers}">
                                                <c:forEach items="${answers}" var="answer">
                                                    <div class="answer-card">
                                                        <div class="answer-header">
                                                            <div>
                                                                <strong>A: ${answer.answer}</strong>
                                                                <c:if test="${answer.isVendorAnswer}">
                                                                    <span class="vendor-badge ms-2">Vendor</span>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="question-meta">
                                                            Answered by ${answer.user.fullName} on <fmt:formatDate value="${answer.createdAt}" pattern="dd MMM yyyy"/>
                                                        </div>
                                                        <div class="helpful-buttons" style="margin-top: 8px;">
                                                            <button class="helpful-btn" onclick="voteAnswerHelpful(${answer.id}, true)">
                                                                <i class="fas fa-thumbs-up me-1"></i>Helpful (${answer.helpfulCount})
                                                            </button>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                            
                                            <!-- Answer Button -->
                                            <c:if test="${not empty currentUser}">
                                                <button class="btn btn-sm btn-outline-primary mt-2" onclick="showAnswerForm(${question.id})">
                                                    <i class="fas fa-reply me-1"></i>Answer
                                                </button>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-4">
                                        <i class="fas fa-question-circle fa-3x text-muted mb-3"></i>
                                        <p>No questions yet. Be the first to ask a question!</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            
                            <!-- Ask Question Button -->
                            <c:if test="${not empty currentUser}">
                                <div class="ask-question-btn">
                                    <button class="btn btn-primary" onclick="showQuestionForm()">
                                        <i class="fas fa-plus me-2"></i>Ask a Question
                                    </button>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Similar Products Carousel -->
            <c:if test="${not empty similarProducts}">
                <div class="similar-products mt-5">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="mb-0">You May Also Like</h4>
                        <div class="carousel-controls">
                            <button class="btn btn-sm btn-outline-secondary" onclick="scrollCarousel('similarProducts', -1)">
                                <i class="fas fa-chevron-left"></i>
                            </button>
                            <button class="btn btn-sm btn-outline-secondary" onclick="scrollCarousel('similarProducts', 1)">
                                <i class="fas fa-chevron-right"></i>
                            </button>
                        </div>
                    </div>
                    <div class="products-carousel" id="similarProducts" style="overflow-x: auto; scroll-behavior: smooth; -webkit-overflow-scrolling: touch;">
                        <div class="d-flex gap-3" style="width: max-content;">
                        <c:forEach items="${similarProducts}" var="sp">
                                <div style="min-width: 250px; max-width: 250px;">
                                <a href="${pageContext.request.contextPath}/products/${sp.slug}" class="text-decoration-none">
                                    <div class="similar-product-card">
                                            <div style="position: relative; height: 200px; overflow: hidden;">
                                        <c:choose>
                                            <c:when test="${not empty sp.imageUrl}">
                                                        <img src="${sp.imageUrl.startsWith('http') ? sp.imageUrl : pageContext.request.contextPath.concat(sp.imageUrl)}" 
                                                             alt="${sp.productName}"
                                                             style="width: 100%; height: 100%; object-fit: cover;"
                                                             onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                        <div style="display: none; width: 100%; height: 100%; background: #f0f0f0; align-items: center; justify-content: center; color: #999;">
                                                            <i class="fas fa-image" style="font-size: 1.5rem;"></i>
                                                        </div>
                                            </c:when>
                                            <c:otherwise>
                                                        <div style="width: 100%; height: 100%; background: #f0f0f0; display: flex; align-items: center; justify-content: center; color: #999;">
                                                            <i class="fas fa-image" style="font-size: 1.5rem;"></i>
                                                        </div>
                                            </c:otherwise>
                                        </c:choose>
                                                <c:if test="${sp.discountPercentage != null && sp.discountPercentage > 0}">
                                                    <span class="badge bg-danger position-absolute top-0 start-0 m-2">${sp.discountPercentage}% OFF</span>
                                                </c:if>
                                            </div>
                                        <div class="card-body">
                                                <p class="title text-dark mb-2" style="font-size: 0.9rem; min-height: 40px;">${sp.productName}</p>
                                                <div class="d-flex align-items-center gap-2 mb-2">
                                                    <div class="stars" style="font-size: 0.8rem;">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="${i <= sp.averageRating ? 'fas' : 'far'} fa-star"></i>
                                                        </c:forEach>
                                                    </div>
                                                    <small class="text-muted">(${sp.totalReviews})</small>
                                                </div>
                                                <div>
                                                    <span class="price fw-bold">₹<fmt:formatNumber value="${sp.price}"/></span>
                                                    <c:if test="${sp.mrp != null && sp.mrp > sp.price}">
                                                        <span class="text-muted text-decoration-line-through ms-2" style="font-size: 0.85rem;">₹<fmt:formatNumber value="${sp.mrp}"/></span>
                                                    </c:if>
                                                </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <!-- Recently Viewed Products -->
            <c:if test="${not empty recentViews && recentViews.size() > 0}">
                <div class="similar-products mt-5">
                    <h4 class="mb-4">
                        <i class="fas fa-clock me-2"></i>Recently Viewed
                    </h4>
                    <div class="products-carousel" id="recentProducts" style="overflow-x: auto; scroll-behavior: smooth;">
                        <div class="d-flex gap-3" style="width: max-content;">
                            <c:forEach items="${recentViews}" var="recentView" end="9">
                                <div style="min-width: 200px; max-width: 200px;">
                                    <a href="${pageContext.request.contextPath}/products/${recentView.product.slug}" class="text-decoration-none">
                                        <div class="similar-product-card">
                                            <div style="height: 180px; overflow: hidden;">
                                                <c:choose>
                                                    <c:when test="${not empty recentView.product.imageUrl}">
                                                        <img src="${recentView.product.imageUrl.startsWith('http') ? recentView.product.imageUrl : pageContext.request.contextPath.concat(recentView.product.imageUrl)}" 
                                                             alt="${recentView.product.productName}"
                                                             style="width: 100%; height: 100%; object-fit: cover;"
                                                             onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                        <div style="display: none; width: 100%; height: 100%; background: #f0f0f0; align-items: center; justify-content: center; color: #999;">
                                                            <i class="fas fa-image" style="font-size: 1.5rem;"></i>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div style="width: 100%; height: 100%; background: #f0f0f0; display: flex; align-items: center; justify-content: center; color: #999;">
                                                            <i class="fas fa-image" style="font-size: 1.5rem;"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="card-body">
                                                <p class="title text-dark mb-2" style="font-size: 0.85rem; min-height: 35px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                                    ${recentView.product.productName}
                                                </p>
                                                <span class="price fw-bold" style="font-size: 0.9rem;">₹<fmt:formatNumber value="${recentView.product.price}"/></span>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </section>

    <!-- Footer -->
    <footer class="py-4 mt-5" style="background: var(--primary-dark); color: white;">
        <div class="container text-center">
            <p class="mb-0 opacity-75">&copy; 2024 AyurVeda. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set JavaScript variables from JSP (outside functions to avoid rendering issues)
        // Set as window properties so functions in head can access them
        try {
            // Debug: Log currentUser status
            <c:choose>
                <c:when test="${not empty currentUser}">
                    console.log('currentUser in JSP: EXISTS - User:', '${currentUser.fullName}');
                    window.isUserLoggedIn = true;
                    console.log('Setting isUserLoggedIn to TRUE');
                </c:when>
                <c:otherwise>
                    console.log('currentUser in JSP: NULL or EMPTY');
                    window.isUserLoggedIn = false;
                    console.log('Setting isUserLoggedIn to FALSE');
                    // Fallback: Check if user dropdown exists in DOM (means user is logged in)
                    setTimeout(function() {
                        var userDropdown = document.querySelector('.dropdown-toggle[data-bs-toggle="dropdown"]');
                        if (userDropdown && userDropdown.textContent && userDropdown.textContent.trim().length > 0) {
                            var dropdownText = userDropdown.textContent.trim();
                            if (!dropdownText.includes('Login') && !dropdownText.includes('Sign Up')) {
                                console.log('Fallback: User detected in navbar, setting isUserLoggedIn to TRUE');
                                window.isUserLoggedIn = true;
                            }
                        }
                    }, 100);
                </c:otherwise>
            </c:choose>
            window.contextPath = '${pageContext.request.contextPath}';
            window.currentPath = window.location.pathname;
            <c:choose>
                <c:when test="${not empty product && product.deliveryDaysMin != null}">
                    window.productDeliveryDays = ${product.deliveryDaysMin};
                </c:when>
                <c:otherwise>
                    window.productDeliveryDays = 3;
                </c:otherwise>
            </c:choose>
            // Also set local variables for backward compatibility
            var isUserLoggedIn = window.isUserLoggedIn;
            var contextPath = window.contextPath;
            var currentPath = window.currentPath;
            var productDeliveryDays = window.productDeliveryDays;
            console.log('Final isUserLoggedIn value:', window.isUserLoggedIn);
            
            // Final fallback: Check DOM for user dropdown after page loads
            document.addEventListener('DOMContentLoaded', function() {
                if (!window.isUserLoggedIn) {
                    var userDropdown = document.querySelector('.dropdown-toggle[data-bs-toggle="dropdown"]');
                    if (userDropdown) {
                        var dropdownText = userDropdown.textContent.trim();
                        // If dropdown has user name (not "Login"), user is logged in
                        if (dropdownText && dropdownText.length > 0 && !dropdownText.includes('Login') && !dropdownText.includes('Sign Up')) {
                            console.log('DOM Fallback: User detected in navbar dropdown:', dropdownText);
                            window.isUserLoggedIn = true;
                            console.log('Updated window.isUserLoggedIn to TRUE');
                        }
                    }
                }
            });
        } catch(e) {
            console.error('Error setting up JavaScript variables:', e);
            window.isUserLoggedIn = false;
            window.contextPath = '';
            window.currentPath = window.location.pathname;
            window.productDeliveryDays = 3;
            var isUserLoggedIn = false;
            var contextPath = '';
            var currentPath = window.location.pathname;
            var productDeliveryDays = 3;
        }
        
        function changeImage(url, element) {
            document.getElementById('mainImage').src = url;
            document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active'));
            element.classList.add('active');
        }
        
        function decreaseQty() {
            var input = document.getElementById('quantity');
            var currentValue = parseInt(input.value) || 1;
            if (currentValue > 1) {
                input.value = currentValue - 1;
            }
        }
        
        function increaseQty(max) {
            var input = document.getElementById('quantity');
            var currentValue = parseInt(input.value) || 1;
            var maxValue = parseInt(max) || 999;
            if (currentValue < maxValue) {
                input.value = currentValue + 1;
            }
        }
        
        // addToCart, buyNow, and toggleWishlist functions are already defined in head section
        // as window.addToCart, window.buyNow, and window.toggleWishlist
        // No need for duplicate definitions here
        
        // Variant Selection
        let selectedVariants = {};
        function selectVariant(variantId, variantType) {
            selectedVariants[variantType] = variantId;
            // Update UI
            document.querySelectorAll('.variant-option').forEach(opt => opt.classList.remove('selected'));
            event.target.closest('.variant-option').classList.add('selected');
            // TODO: Update price and image based on variant
        }
        
        // Delivery Calculator
        function checkDelivery() {
            console.log('checkDelivery called');
            const pincodeInput = document.getElementById('pincodeInput');
            if (!pincodeInput) {
                alert('Pincode input field not found');
                return;
            }
            const pincode = pincodeInput.value;
            if (pincode.length !== 6 || !/^\d+$/.test(pincode)) {
                alert('Please enter a valid 6-digit pincode');
                return;
            }
            
            // Calculate delivery date (mock - replace with actual API call)
            const today = new Date();
            const deliveryDays = productDeliveryDays;
            today.setDate(today.getDate() + deliveryDays);
            const deliveryDate = today.toLocaleDateString('en-IN', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
            
            const deliveryDateEl = document.getElementById('deliveryDate');
            const deliveryInfoEl = document.getElementById('deliveryInfo');
            if (deliveryDateEl) {
                deliveryDateEl.textContent = deliveryDate;
            }
            if (deliveryInfoEl) {
                deliveryInfoEl.style.display = 'block';
            }
        }
        
        // Review Filters
        function filterReviews(filter) {
            document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
            
            const reviews = document.querySelectorAll('.review-card');
            reviews.forEach(review => {
                let show = true;
                if (filter === 'all') {
                    show = true;
                } else if (filter === 'withImages') {
                    show = review.dataset.hasImages === 'true';
                } else if (filter === 'verified') {
                    show = review.dataset.verified === 'true';
                } else {
                    show = review.dataset.rating === filter;
                }
                review.style.display = show ? 'block' : 'none';
            });
        }
        
        // Helpful Vote
        function voteHelpful(reviewId, helpful) {
            <c:choose>
                <c:when test="${not empty currentUser}">
                    fetch('${pageContext.request.contextPath}/api/reviews/' + reviewId + '/vote', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify({helpful: helpful})
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            location.reload();
                        }
                    })
                    .catch(error => console.error('Error:', error));
                </c:when>
                <c:otherwise>
                    alert('Please login to vote');
                </c:otherwise>
            </c:choose>
        }
        
        // Answer Helpful Vote
        function voteAnswerHelpful(answerId, helpful) {
            <c:choose>
                <c:when test="${not empty currentUser}">
                    fetch('${pageContext.request.contextPath}/api/answers/' + answerId + '/vote', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify({helpful: helpful})
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            location.reload();
                        }
                    })
                    .catch(error => console.error('Error:', error));
                </c:when>
                <c:otherwise>
                    alert('Please login to vote');
                </c:otherwise>
            </c:choose>
        }
        
        // Show Question Form
        function showQuestionForm() {
            const question = prompt('Enter your question:');
            if (question && question.trim()) {
                <c:if test="${not empty product && not empty product.id}">
                fetch('${pageContext.request.contextPath}/api/products/${product.id}/questions', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({question: question.trim()})
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert(data.message || 'Error submitting question');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error submitting question');
                });
                </c:if>
            }
        }
        
        // Show Answer Form
        function showAnswerForm(questionId) {
            const answer = prompt('Enter your answer:');
            if (answer && answer.trim()) {
                fetch('${pageContext.request.contextPath}/api/questions/' + questionId + '/answers', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({answer: answer.trim()})
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert(data.message || 'Error submitting answer');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error submitting answer');
                });
            }
        }
        
        // Image Modal
        function openImageModal(imageUrl) {
            const modal = document.createElement('div');
            modal.style.cssText = 'position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.9);z-index:10000;display:flex;align-items:center;justify-content:center;cursor:pointer;';
            modal.innerHTML = '<img src="' + imageUrl + '" style="max-width:90%;max-height:90%;object-fit:contain;">';
            modal.onclick = () => modal.remove();
            document.body.appendChild(modal);
        }
        
        // Show All Offers
        function showAllOffers() {
            // Toggle visibility of hidden offers
            const hiddenOffers = document.querySelectorAll('.offer-item:nth-child(n+4)');
            hiddenOffers.forEach(offer => {
                offer.style.display = offer.style.display === 'none' ? 'flex' : 'none';
            });
        }
        
        // Image Zoom (basic implementation)
        document.addEventListener('DOMContentLoaded', function() {
            const mainImage = document.getElementById('mainImage');
            if (mainImage) {
                mainImage.addEventListener('click', function() {
                    openImageModal(this.src);
                });
            }
        });
        
        // Carousel Scroll
        function scrollCarousel(carouselId, direction) {
            const carousel = document.getElementById(carouselId);
            if (carousel) {
                const scrollAmount = 300;
                carousel.scrollBy({
                    left: direction * scrollAmount,
                    behavior: 'smooth'
                });
            }
        }
        
        // Copy Product Link
        function copyProductLink() {
            const url = window.location.href;
            navigator.clipboard.writeText(url).then(() => {
                showToast('Product link copied to clipboard!', 'success');
            }).catch(() => {
                // Fallback for older browsers
                const textArea = document.createElement('textarea');
                textArea.value = url;
                document.body.appendChild(textArea);
                textArea.select();
                document.execCommand('copy');
                document.body.removeChild(textArea);
                showToast('Product link copied!', 'success');
            });
        }
        
        // Toast Notification
        function showToast(message, type) {
            const toast = document.createElement('div');
            var alertType = type === 'success' ? 'success' : 'danger';
            var iconType = type === 'success' ? 'check-circle' : 'exclamation-circle';
            toast.className = 'alert alert-' + alertType + ' position-fixed top-0 end-0 m-3';
            toast.style.zIndex = '9999';
            toast.style.minWidth = '250px';
            toast.innerHTML = '<i class="fas fa-' + iconType + ' me-2"></i>' + message;
            document.body.appendChild(toast);
            setTimeout(() => {
                toast.style.opacity = '0';
                toast.style.transition = 'opacity 0.3s';
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }
    </script>
</body>
</html>

