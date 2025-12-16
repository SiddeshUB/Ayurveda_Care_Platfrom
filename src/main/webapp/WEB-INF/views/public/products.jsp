<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ayurvedic Products - Shop Natural Wellness</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Playfair+Display:wght@400;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #2d5a27;
            --primary-dark: #1e3d1a;
            --accent: #8b4513;
            --gold: #d4a84b;
            --cream: #faf8f5;
        }
        
      body {
    font-family: 'Poppins', sans-serif;
    background:
        linear-gradient(rgba(250, 248, 245, 0.92), rgba(250, 248, 245, 0.92)),
        url('${pageContext.request.contextPath}/images/ayu.jpg')
        center / cover no-repeat fixed;
}
section {
    background: transparent;
}



        h1, h2, h3, h4, h5 {
            font-family: 'Playfair Display', serif;
        }
        
        /* Navbar */
        .navbar {
            background: white;
            box-shadow: 0 2px 20px rgba(0,0,0,0.08);
            padding: 15px 0;
        }
        
        .navbar-brand {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            font-size: 1.5rem;
            color: var(--primary) !important;
        }
        
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
        
        .nav-link {
            color: #333 !important;
            font-weight: 500;
            margin: 0 10px;
            transition: color 0.3s ease;
            white-space: nowrap;
        }
        
        .nav-link:hover, .nav-link.active {
            color: var(--primary) !important;
        }
        
        .cart-icon {
            position: relative;
        }
        
        .cart-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: var(--accent);
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 0.7rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        /* Hero Banner */
       .shop-hero {
    position: relative;
    margin-top: 80px;
    padding: 90px 0;
    text-align: center;
    color: white;
    background:
        linear-gradient(rgba(0,0,0,0.55), rgba(0,0,0,0.55)),
         url("${pageContext.request.contextPath}/views/images/ayu.jpg") center/cover no-repeat;
        
}

        .shop-hero h1 {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }
        
        /* Filters Sidebar */
        .filter-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        
        .filter-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--cream);
        }
        
        .category-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .category-list li {
            padding: 8px 0;
            border-bottom: 1px solid #eee;
        }
        
        .category-list li:last-child {
            border-bottom: none;
        }
        
        .category-list a {
            color: #555;
            text-decoration: none;
            display: flex;
            justify-content: space-between;
            transition: all 0.3s ease;
        }
        
        .category-list a:hover, .category-list a.active {
            color: var(--primary);
            font-weight: 500;
        }
        
        .category-count {
            background: var(--cream);
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 0.8rem;
        }
        
        /* Product Cards */
        .product-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
        }
        
        .product-image {
            position: relative;
            height: 220px;
            overflow: hidden;
        }
        
        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .product-card:hover .product-image img {
            transform: scale(1.1);
        }
        
        .product-badges {
            position: absolute;
            top: 10px;
            left: 10px;
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        
        .badge-discount {
            background: #dc3545;
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .badge-new {
            background: var(--gold);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .product-actions {
            position: absolute;
            top: 10px;
            right: 10px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .product-card:hover .product-actions {
            opacity: 1;
        }
        
        .action-btn {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: white;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .action-btn:hover {
            background: var(--primary);
            color: white;
        }
        
        .action-btn.wishlisted {
            background: #dc3545;
            color: white;
        }
        
        .product-info {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        
        .product-category {
            font-size: 0.8rem;
            color: var(--accent);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 5px;
        }
        
        .product-title {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: #333;
        }
        
        .product-title a {
            color: inherit;
            text-decoration: none;
        }
        
        .product-title a:hover {
            color: var(--primary);
        }
        
        .product-rating {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .stars {
            color: #ffc107;
        }
        
        .rating-count {
            color: #888;
            font-size: 0.85rem;
            margin-left: 5px;
        }
        
        .product-price {
            margin-top: auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .current-price {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary);
        }
        
        .original-price {
            font-size: 0.9rem;
            color: #888;
            text-decoration: line-through;
            margin-left: 8px;
        }
        
        
        .add-to-cart {
            background: var(--primary);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 25px;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .add-to-cart:hover {
            background: var(--primary-dark);
        }
        
        /* Sort Bar */
        .sort-bar {
            background: white;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        /* Pagination */
        .pagination .page-link {
            border: none;
            color: #555;
            margin: 0 3px;
            border-radius: 8px;
        }
        
        .pagination .page-link:hover {
            background: var(--cream);
            color: var(--primary);
        }
        
        .pagination .page-item.active .page-link {
            background: var(--primary);
            color: white;
        }
        
        /* Ensure navbar items stay in single row on desktop */
        @media (min-width: 992px) {
            .navbar-nav {
                flex-wrap: nowrap !important;
            }
            
            .navbar-nav .nav-item {
                flex-shrink: 0;
            }
        }
        
        /* No Products */
        .no-products {
            text-align: center;
            padding: 60px 20px;
        }
        
        .no-products i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/products" style="color: #c9a227 !important;"></i>Products</a>
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
                            <!-- Logged in user - show cart, wishlist and dropdown -->
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/dashboard/wishlist" style="color: #fff !important;">
                                    <i class="fas fa-heart"></i>
                                </a>
                            </li>
                            <li class="nav-item position-relative">
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/dashboard/cart" style="color: #fff !important;">
                                    <i class="fas fa-shopping-cart"></i>
                                    <c:if test="${cartCount > 0}">
                                        <span class="cart-badge">${cartCount}</span>
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
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile"><i class="fas fa-user me-2" style="color: #c9a227;"></i>Profile</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout"><i class="fas fa-sign-out-alt me-2" style="color: #c9a227;"></i>Sign Out</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <!-- Not logged in -->
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/login" style="color: #fff !important;">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/user/register" style="background: linear-gradient(135deg, #c9a227 0%, #e6b55c 100%); color: #1a2e1a !important; padding: 10px 25px !important; border-radius: 30px; font-weight: 600; margin-left: 10px;">Sign Up</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/hospital/register" style="background: linear-gradient(135deg, #c9a227 0%, #e6b55c 100%); color: #1a2e1a !important; padding: 10px 25px !important; border-radius: 30px; font-weight: 600; margin-left: 10px;">For Centers</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Banner -->
    <!-- Hero Banner -->
<section class="shop-hero"
    style="
        margin-top: 80px;
        background: 
            linear-gradient(rgba(0, 0, 0, 0.45), rgba(0, 0, 0, 0.45)),
            url('${pageContext.request.contextPath}/views/images/Screenshot 2025-12-15 124242.png') center center / cover no-repeat;
    ">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8 text-center">
                <h1 class="display-4 mb-3">Gifts for Winter Wellness</h1>
                <p class="lead mb-4" style="font-size: 1.25rem; color: rgba(255,255,255,0.9);">
                    20% Off Orders of $75+
                </p>
                <a href="${pageContext.request.contextPath}/products?category=winter-wellness" 
                   class="btn btn-lg" 
                   style="
                       background: linear-gradient(135deg, #c9a227 0%, #e6b55c 100%); 
                       color: #1a2e1a !important; 
                       padding: 12px 40px !important; 
                       border-radius: 30px; 
                       font-weight: 600;
                       font-size: 1.1rem;
                   ">
                    SHOP THE SALE
                </a>
            </div>
        </div>
    </div>
</section>
    <!-- Promotional Banner with Background Image -->
    <section class="py-5" style="margin-top: 20px;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="rounded-4 overflow-hidden shadow-lg position-relative" style="
                        background: linear-gradient(rgba(45, 90, 39, 0.85), rgba(30, 61, 26, 0.9)), 
                                    url('https://images.unsplash.com/photo-1542884748-6a3f4c9c9e3d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1200&q=80') center/cover no-repeat;
                        border: 1px solid rgba(201, 162, 39, 0.3);
                        min-height: 180px;
                    ">
                        <div class="row align-items-center h-100">
                            <div class="col-md-8 p-4 p-md-5">
                                <h3 class="mb-2" style="color: white; font-weight: 700; font-size: 1.8rem; font-family: 'Playfair Display', serif;">
                                    Gifts for Winter Wellness
                                </h3>
                                <p class="mb-0" style="color: rgba(255, 255, 255, 0.95); font-size: 1.2rem; font-weight: 500;">
                                    20% Off Orders of $75+
                                </p>
                            </div>
                            <div class="col-md-4 p-4 p-md-5 text-center text-md-end">
                                <a href="${pageContext.request.contextPath}/products?promo=winter20" 
                                   class="btn px-4 py-3 rounded-pill shadow" 
                                   style="
                                       background: #c9a227;
                                       color: #1a2e1a;
                                       font-weight: 700;
                                       border: none;
                                       font-size: 1.1rem;
                                       transition: all 0.3s ease;
                                   "
                                   onmouseover="this.style.transform='translateY(-3px)'; this.style.boxShadow='0 10px 25px rgba(201, 162, 39, 0.4)';"
                                   onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 5px 15px rgba(0,0,0,0.1)';">
                                    SHOP THE SALE
                                </a>
                            </div>
                        </div>
                        
                        <!-- Decorative leaf icon overlay -->
                        <div class="position-absolute top-0 end-0 opacity-10" style="font-size: 150px; transform: rotate(45deg); margin-top: -30px; margin-right: -30px;">
                            <i class="fas fa-leaf" style="color: #c9a227;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <!-- Filters Sidebar -->
                <div class="col-lg-3 mb-4">
                    <!-- Search -->
                    <div class="filter-card">
                        <form action="${pageContext.request.contextPath}/products" method="get">
                            <div class="input-group">
                                <input type="text" class="form-control" name="search" value="${searchTerm}" placeholder="Search products...">
                                <button class="btn btn-primary" type="submit" style="background: var(--primary); border: none;">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Categories -->
                    <div class="filter-card">
                        <h5 class="filter-title"><i class="fas fa-tags me-2"></i>Categories</h5>
                        <ul class="category-list">
                            <li>
                                <a href="${pageContext.request.contextPath}/products" class="${empty selectedCategory ? 'active' : ''}">
                                    All Products
                                </a>
                            </li>
                            <c:forEach items="${categories}" var="cat">
                                <li>
                                    <a href="${pageContext.request.contextPath}/products?category=${cat.id}" class="${selectedCategory == cat.id ? 'active' : ''}">
                                        ${cat.displayName}
                                        <span class="category-count">${cat.productCount}</span>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>

                    <!-- Price Filter -->
                    <div class="filter-card">
                        <h5 class="filter-title"><i class="fas fa-rupee-sign me-2"></i>Price Range</h5>
                        <form action="${pageContext.request.contextPath}/products" method="get">
                            <c:if test="${not empty selectedCategory}">
                                <input type="hidden" name="category" value="${selectedCategory}">
                            </c:if>
                            <div class="row g-2 mb-3">
                                <div class="col-6">
                                    <input type="number" class="form-control form-control-sm" name="minPrice" value="${minPrice}" placeholder="Min">
                                </div>
                                <div class="col-6">
                                    <input type="number" class="form-control form-control-sm" name="maxPrice" value="${maxPrice}" placeholder="Max">
                                </div>
                            </div>
                            <button type="submit" class="btn btn-sm w-100" style="background: var(--primary); color: white;">Apply</button>
                        </form>
                    </div>

                    <!-- Rating Filter -->
                    <div class="filter-card">
                        <h5 class="filter-title"><i class="fas fa-star me-2"></i>Rating</h5>
                        <c:forEach begin="4" end="4" var="r">
                            <a href="${pageContext.request.contextPath}/products?rating=4${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}" 
                               class="d-block mb-2 text-decoration-none ${selectedRating == 4 ? 'fw-bold' : ''}">
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="far fa-star text-warning"></i>
                                & Up
                            </a>
                        </c:forEach>
                        <a href="${pageContext.request.contextPath}/products?rating=3${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}" 
                           class="d-block mb-2 text-decoration-none ${selectedRating == 3 ? 'fw-bold' : ''}">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="far fa-star text-warning"></i>
                            <i class="far fa-star text-warning"></i>
                            & Up
                        </a>
                    </div>
                </div>

                <!-- Products Grid -->
                <div class="col-lg-9">
                    <!-- Sort Bar -->
                    <div class="sort-bar d-flex justify-content-between align-items-center flex-wrap">
                        <div>
                            <span class="text-muted">Showing ${products.numberOfElements} of ${products.totalElements} products</span>
                        </div>
                        <div class="d-flex align-items-center">
                            <label class="me-2 text-muted">Sort by:</label>
                            <select class="form-select form-select-sm" style="width: auto;" onchange="window.location.href=this.value">
                                <option value="${pageContext.request.contextPath}/products?sort=newest${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}" ${currentSort == 'newest' ? 'selected' : ''}>Newest</option>
                                <option value="${pageContext.request.contextPath}/products?sort=popular${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}" ${currentSort == 'popular' ? 'selected' : ''}>Popular</option>
                                <option value="${pageContext.request.contextPath}/products?sort=price_low${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}" ${currentSort == 'price_low' ? 'selected' : ''}>Price: Low to High</option>
                                <option value="${pageContext.request.contextPath}/products?sort=price_high${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}" ${currentSort == 'price_high' ? 'selected' : ''}>Price: High to Low</option>
                                <option value="${pageContext.request.contextPath}/products?sort=rating${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}" ${currentSort == 'rating' ? 'selected' : ''}>Rating</option>
                            </select>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${not empty products.content}">
                            <div class="row g-4">
                                <c:forEach items="${products.content}" var="product">
                                    <div class="col-md-6 col-lg-4">
                                        <div class="product-card">
                                            <div class="product-image">
                                                <a href="${pageContext.request.contextPath}/products/${product.slug}">
                                                    <c:choose>
                                                        <c:when test="${not empty product.imageUrl}">
                                                            <img src="${product.imageUrl.startsWith('http') ? product.imageUrl : pageContext.request.contextPath.concat(product.imageUrl)}" alt="${product.productName}" onerror="this.src='${pageContext.request.contextPath}/images/no-product.png'">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/images/no-product.png" alt="${product.productName}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                                <div class="product-badges">
                                                    <c:if test="${product.discountPercentage != null && product.discountPercentage > 0}">
                                                        <span class="badge-discount">${product.discountPercentage}% OFF</span>
                                                    </c:if>
                                                    <c:if test="${product.isNew}">
                                                        <span class="badge-new">NEW</span>
                                                    </c:if>
                                                </div>
                                                <div class="product-actions">
                                                    <button class="action-btn ${wishlistIds.contains(product.id) ? 'wishlisted' : ''}" title="Add to Wishlist" onclick="addToWishlist(${product.id})">
                                                        <i class="fas fa-heart"></i>
                                                    </button>
                                                    <a href="${pageContext.request.contextPath}/products/${product.slug}" class="action-btn" title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="product-info">
                                                <span class="product-category">${product.category.displayName}</span>
                                                <h5 class="product-title">
                                                    <a href="${pageContext.request.contextPath}/products/${product.slug}">${product.productName}</a>
                                                </h5>
                                                <div class="product-rating">
                                                    <div class="stars">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="${i <= product.averageRating ? 'fas' : 'far'} fa-star"></i>
                                                        </c:forEach>
                                                    </div>
                                                    <span class="rating-count">(${product.totalReviews})</span>
                                                </div>
                                                <div class="product-price">
                                                    <div>
                                                        <span class="current-price">₹<fmt:formatNumber value="${product.price}" pattern="#,##0"/></span>
                                                        <c:if test="${product.mrp != null && product.mrp > product.price}">
                                                            <span class="original-price">₹<fmt:formatNumber value="${product.mrp}" pattern="#,##0"/></span>
                                                        </c:if>
                                                    </div>
                                                    <button class="add-to-cart" onclick="addToCart(${product.id})">
                                                        <i class="fas fa-shopping-cart"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${products.totalPages > 1}">
                                <nav class="mt-5">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item ${products.first ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${products.number - 1}${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}${not empty currentSort ? '&sort='.concat(currentSort) : ''}">
                                                <i class="fas fa-chevron-left"></i>
                                            </a>
                                        </li>
                                        <c:forEach begin="0" end="${products.totalPages - 1}" var="i">
                                            <c:if test="${i < 5 || i > products.totalPages - 3 || (i >= products.number - 1 && i <= products.number + 1)}">
                                                <li class="page-item ${products.number == i ? 'active' : ''}">
                                                    <a class="page-link" href="?page=${i}${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}${not empty currentSort ? '&sort='.concat(currentSort) : ''}">${i + 1}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <li class="page-item ${products.last ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${products.number + 1}${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}${not empty currentSort ? '&sort='.concat(currentSort) : ''}">
                                                <i class="fas fa-chevron-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <div class="no-products">
                                <i class="fas fa-box-open"></i>
                                <h4>No Products Found</h4>
                                <p class="text-muted">Try adjusting your filters or search term</p>
                                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary" style="background: var(--primary); border: none;">View All Products</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="py-5 mt-5" style="background: var(--primary-dark); color: white;">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5><i class="fas fa-leaf me-2"></i>AyurVeda</h5>
                    <p class="opacity-75">Your trusted platform for authentic Ayurvedic wellness products and services.</p>
                </div>
                <div class="col-md-2 mb-4">
                    <h6>Quick Links</h6>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/" class="text-white opacity-75">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/products" class="text-white opacity-75">Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/hospitals" class="text-white opacity-75">Centers</a></li>
                    </ul>
                </div>
                <div class="col-md-3 mb-4">
                    <h6>Sell on AyurVeda</h6>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/vendor/register" class="text-white opacity-75">Become a Seller</a></li>
                        <li><a href="${pageContext.request.contextPath}/vendor/login" class="text-white opacity-75">Seller Login</a></li>
                    </ul>
                </div>
                <div class="col-md-3 mb-4">
                    <h6>Contact</h6>
                    <p class="opacity-75 mb-1"><i class="fas fa-envelope me-2"></i>support@ayurveda.com</p>
                    <p class="opacity-75"><i class="fas fa-phone me-2"></i>+91 98765 43210</p>
                </div>
            </div>
            <hr class="opacity-25">
            <p class="text-center mb-0 opacity-75">&copy; 2024 AyurVeda. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function addToCart(productId) {
            <c:choose>
                <c:when test="${not empty currentUser}">
                    // User is logged in - redirect to add to cart
                    window.location.href = '${pageContext.request.contextPath}/user/dashboard/cart/add/' + productId;
                </c:when>
                <c:otherwise>
                    // User not logged in - redirect to login
                    window.location.href = '${pageContext.request.contextPath}/user/login?redirect=/products';
                </c:otherwise>
            </c:choose>
        }
        
        function addToWishlist(productId) {
            <c:choose>
                <c:when test="${not empty currentUser}">
                    window.location.href = '${pageContext.request.contextPath}/user/dashboard/wishlist/add/' + productId;
                </c:when>
                <c:otherwise>
                    window.location.href = '${pageContext.request.contextPath}/user/login?redirect=/products';
                </c:otherwise>
            </c:choose>
        }
    </script>
</body>
</html>