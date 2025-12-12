<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wishlist - AyurVeda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #2d5a27; --primary-dark: #1e3d1a; --accent: #8b4513; --gold: #d4a84b; --cream: #faf8f5; }
        body { font-family: 'Poppins', sans-serif; background: var(--cream); }
        h1, h2, h3, h4, h5 { font-family: 'Playfair Display', serif; }
        
        .navbar { background: white; box-shadow: 0 2px 20px rgba(0,0,0,0.08); padding: 15px 0; }
        .navbar-brand { font-family: 'Playfair Display', serif; font-weight: 700; font-size: 1.5rem; color: var(--primary) !important; }
        
        .page-header { background: linear-gradient(135deg, #dc3545, #a71d2a); color: white; padding: 40px 0; text-align: center; }
        
        .wishlist-card { background: white; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); overflow: hidden; }
        
        .wishlist-item { display: flex; align-items: center; padding: 20px; border-bottom: 1px solid #eee; }
        .wishlist-item:last-child { border-bottom: none; }
        
        .wishlist-item-image { width: 100px; height: 100px; border-radius: 10px; overflow: hidden; margin-right: 20px; }
        .wishlist-item-image img { width: 100%; height: 100%; object-fit: cover; }
        
        .wishlist-item-info { flex: 1; }
        .wishlist-item-name { font-weight: 600; margin-bottom: 5px; }
        .wishlist-item-name a { color: #333; text-decoration: none; }
        .wishlist-item-price { font-size: 1.1rem; color: var(--primary); font-weight: 600; }
        
        .stock-status { font-size: 0.85rem; }
        .in-stock { color: #28a745; }
        .out-of-stock { color: #dc3545; }
        
        .btn-cart { background: var(--primary); color: white; border: none; padding: 10px 25px; border-radius: 25px; font-weight: 500; }
        .btn-cart:hover { background: var(--primary-dark); color: white; }
        
        .btn-remove { color: #dc3545; background: none; border: none; font-size: 1.2rem; cursor: pointer; }
        
        .empty-wishlist { text-align: center; padding: 60px 20px; }
        .empty-wishlist i { font-size: 5rem; color: #ddd; margin-bottom: 20px; }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="fas fa-leaf me-2"></i>AyurVeda</a>
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/user/dashboard/cart" class="btn btn-link text-dark position-relative">
                    <i class="fas fa-shopping-cart fa-lg"></i>
                </a>
                <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-link text-dark"><i class="fas fa-user fa-lg"></i></a>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-heart me-3"></i>My Wishlist</h1>
        </div>
    </div>

    <!-- Wishlist Content -->
    <section class="py-5">
        <div class="container">
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>

            <c:choose>
                <c:when test="${not empty wishlistItems}">
                    <div class="wishlist-card">
                        <div class="p-3 border-bottom">
                            <h5 class="mb-0">${wishlistItems.size()} item(s) in your wishlist</h5>
                        </div>
                        
                        <c:forEach items="${wishlistItems}" var="item">
                            <div class="wishlist-item">
                                <div class="wishlist-item-image">
                                    <a href="${pageContext.request.contextPath}/products/${item.product.slug}">
                                        <img src="${not empty item.product.imageUrl ? (item.product.imageUrl.startsWith('http') ? item.product.imageUrl : pageContext.request.contextPath.concat(item.product.imageUrl)) : pageContext.request.contextPath.concat('/images/no-product.png')}" alt="${item.product.productName}">
                                    </a>
                                </div>
                                <div class="wishlist-item-info">
                                    <h6 class="wishlist-item-name">
                                        <a href="${pageContext.request.contextPath}/products/${item.product.slug}">${item.product.productName}</a>
                                    </h6>
                                    <p class="wishlist-item-price mb-1">
                                        ₹<fmt:formatNumber value="${item.product.price}"/>
                                        <c:if test="${item.product.mrp != null && item.product.mrp > item.product.price}">
                                            <small class="text-muted text-decoration-line-through ms-2">₹<fmt:formatNumber value="${item.product.mrp}"/></small>
                                        </c:if>
                                    </p>
                                    <c:choose>
                                        <c:when test="${item.product.stockQuantity > 0}">
                                            <span class="stock-status in-stock"><i class="fas fa-check-circle me-1"></i>In Stock</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="stock-status out-of-stock"><i class="fas fa-times-circle me-1"></i>Out of Stock</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="d-flex align-items-center">
                                    <c:if test="${item.product.stockQuantity > 0}">
                                        <a href="${pageContext.request.contextPath}/user/dashboard/wishlist/move-to-cart/${item.product.id}" class="btn btn-cart me-3">
                                            <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                        </a>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/user/dashboard/wishlist/toggle/${item.product.id}" class="btn-remove" title="Remove">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="wishlist-card">
                        <div class="empty-wishlist">
                            <i class="fas fa-heart"></i>
                            <h4>Your wishlist is empty</h4>
                            <p class="text-muted mb-4">Save items you love by clicking the heart icon</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-cart">
                                <i class="fas fa-shopping-bag me-2"></i>Explore Products
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

