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
            background: var(--cream);
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
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 60px 0;
            text-align: center;
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
        
        /* List View Styles */
        .list-view .product-item { max-width: 100%; }
        .list-view .product-card { flex-direction: row; }
        .list-view .product-image { width: 200px; height: 200px; flex-shrink: 0; }
        .list-view .product-info { flex: 1; }
        
        /* Mobile Sticky Cart Button */
        .sticky-cart-btn { 
            position: fixed; 
            bottom: 20px; 
            right: 20px; 
            z-index: 1000; 
            display: none;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            border-radius: 50px;
            padding: 15px 25px;
            background: var(--primary);
            color: white;
            border: none;
            font-weight: 600;
        }
        
        /* Mobile Responsive */
        @media (max-width: 768px) {
            .sticky-cart-btn { display: flex; align-items: center; gap: 8px; }
            .filter-card { margin-bottom: 15px; padding: 15px; }
            .product-card { margin-bottom: 15px; }
            .sort-bar { flex-direction: column; gap: 15px; padding: 12px; }
            .product-image { height: 180px; }
            .cart-badge { width: 18px; height: 18px; font-size: 0.65rem; }
        }
        
        @media (max-width: 576px) {
            .shop-hero h1 { font-size: 1.8rem; }
            .shop-hero { padding: 40px 0; }
            .product-title { font-size: 0.9rem; }
            .current-price { font-size: 1.1rem; }
            .add-to-cart { padding: 6px 15px; font-size: 0.85rem; }
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
    <section class="shop-hero" style="margin-top: 80px;">
        <div class="container">
            <h1>Ayurvedic Products</h1>
            <p class="mb-0 opacity-75">Discover authentic Ayurvedic products for your wellness journey</p>
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
                        <h5 class="filter-title"><i class="fas fa-star me-2"></i>Customer Rating</h5>
                        <c:forEach begin="4" end="4" var="r">
                            <a href="${pageContext.request.contextPath}/products?rating=4${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}${not empty minPrice ? '&minPrice='.concat(minPrice) : ''}${not empty maxPrice ? '&maxPrice='.concat(maxPrice) : ''}" 
                               class="d-block mb-2 text-decoration-none ${selectedRating == 4 ? 'fw-bold text-primary' : 'text-dark'}">
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="far fa-star text-warning"></i>
                                & Up
                            </a>
                        </c:forEach>
                        <a href="${pageContext.request.contextPath}/products?rating=3${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}${not empty minPrice ? '&minPrice='.concat(minPrice) : ''}${not empty maxPrice ? '&maxPrice='.concat(maxPrice) : ''}" 
                           class="d-block mb-2 text-decoration-none ${selectedRating == 3 ? 'fw-bold text-primary' : 'text-dark'}">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="far fa-star text-warning"></i>
                            <i class="far fa-star text-warning"></i>
                            & Up
                        </a>
                    </div>

                    <!-- Availability Filter -->
                    <div class="filter-card">
                        <h5 class="filter-title"><i class="fas fa-check-circle me-2"></i>Availability</h5>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="inStock" checked onchange="applyFilters()">
                            <label class="form-check-label" for="inStock">
                                In Stock Only
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="outOfStock" onchange="applyFilters()">
                            <label class="form-check-label" for="outOfStock">
                                Include Out of Stock
                            </label>
                        </div>
                    </div>

                    <!-- Discount Filter -->
                    <div class="filter-card">
                        <h5 class="filter-title"><i class="fas fa-percent me-2"></i>Discount</h5>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="discount10" value="10" onchange="applyFilters()">
                            <label class="form-check-label" for="discount10">
                                10% or more
                            </label>
                        </div>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="discount20" value="20" onchange="applyFilters()">
                            <label class="form-check-label" for="discount20">
                                20% or more
                            </label>
                        </div>
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" id="discount30" value="30" onchange="applyFilters()">
                            <label class="form-check-label" for="discount30">
                                30% or more
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="discount40" value="40" onchange="applyFilters()">
                            <label class="form-check-label" for="discount40">
                                40% or more
                            </label>
                        </div>
                    </div>

                    <!-- Clear Filters -->
                    <div class="filter-card">
                        <button class="btn btn-outline-secondary w-100" onclick="clearFilters()">
                            <i class="fas fa-times me-2"></i>Clear All Filters
                        </button>
                    </div>
                </div>

                <!-- Products Grid -->
                <div class="col-lg-9">
                    <!-- Sort Bar -->
                    <div class="sort-bar d-flex justify-content-between align-items-center flex-wrap mb-4" style="background: white; padding: 15px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
                        <div class="d-flex align-items-center gap-3">
                            <span class="text-muted">Showing <strong>${products.numberOfElements}</strong> of <strong>${products.totalElements}</strong> products</span>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-sm btn-outline-secondary active" id="gridView" onclick="setView('grid')" title="Grid View">
                                    <i class="fas fa-th"></i>
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-secondary" id="listView" onclick="setView('list')" title="List View">
                                    <i class="fas fa-list"></i>
                                </button>
                            </div>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <label class="text-muted mb-0">Sort by:</label>
                            <select class="form-select form-select-sm" style="width: auto; min-width: 180px;" onchange="applySort(this.value)">
                                <option value="newest" ${currentSort == 'newest' ? 'selected' : ''}>Newest First</option>
                                <option value="popular" ${currentSort == 'popular' ? 'selected' : ''}>Popularity</option>
                                <option value="price_low" ${currentSort == 'price_low' ? 'selected' : ''}>Price: Low to High</option>
                                <option value="price_high" ${currentSort == 'price_high' ? 'selected' : ''}>Price: High to Low</option>
                                <option value="rating" ${currentSort == 'rating' ? 'selected' : ''}>Customer Rating</option>
                                <option value="discount" ${currentSort == 'discount' ? 'selected' : ''}>Discount</option>
                            </select>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${not empty products.content}">
                            <div class="row g-4" id="productsContainer">
                                <c:forEach items="${products.content}" var="product">
                                    <div class="col-md-6 col-lg-4 product-item">
                                        <div class="product-card">
                                            <div class="product-image">
                                                <a href="${pageContext.request.contextPath}/products/${not empty product.slug ? product.slug : product.id}">
                                                    <c:choose>
                                                        <c:when test="${not empty product.imageUrl}">
                                                            <img src="${product.imageUrl.startsWith('http') ? product.imageUrl : pageContext.request.contextPath.concat(product.imageUrl)}" alt="${product.productName}" onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                            <div class="product-image-placeholder" style="display: none; width: 100%; height: 100%; background: #f0f0f0; align-items: center; justify-content: center; color: #999;">
                                                                <i class="fas fa-image" style="font-size: 2rem;"></i>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="product-image-placeholder" style="width: 100%; height: 100%; background: #f0f0f0; display: flex; align-items: center; justify-content: center; color: #999;">
                                                                <i class="fas fa-image" style="font-size: 2rem;"></i>
                                                            </div>
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
                                                    <button class="action-btn ${wishlistIds.contains(product.id) ? 'wishlisted' : ''}" title="Add to Wishlist" onclick="addToWishlist(${product.id}, event)">
                                                        <i class="fas fa-heart"></i>
                                                    </button>
                                                    <button class="action-btn" title="Quick View" onclick="quickView(${product.id})">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button class="action-btn" title="Share" onclick="shareProduct(${product.id}, '${product.productName}', event)">
                                                        <i class="fas fa-share-alt"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="product-info">
                                                <span class="product-category">${product.category.displayName}</span>
                                                <h5 class="product-title">
                                                    <a href="${pageContext.request.contextPath}/products/${not empty product.slug ? product.slug : product.id}">${product.productName}</a>
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
                                                    <button class="add-to-cart" onclick="addToCart(${product.id}, event)">
                                                        <i class="fas fa-shopping-cart"></i> Add to Cart
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Recently Viewed Products -->
                            <c:if test="${not empty recentViews && recentViews.size() > 0}">
                                <div class="mt-5">
                                    <h4 class="mb-4" style="font-weight: 600;">
                                        <i class="fas fa-clock me-2"></i>Recently Viewed
                                    </h4>
                                    <div class="row g-3">
                                        <c:forEach items="${recentViews}" var="recentView" end="4">
                                            <div class="col-6 col-md-3 col-lg-2">
                                                <a href="${pageContext.request.contextPath}/products/${not empty recentView.product.slug ? recentView.product.slug : recentView.product.id}" class="text-decoration-none">
                                                    <div class="product-card" style="height: auto;">
                                                        <div class="product-image" style="height: 150px;">
                                                            <c:choose>
                                                                <c:when test="${not empty recentView.product.imageUrl}">
                                                                    <img src="${recentView.product.imageUrl.startsWith('http') ? recentView.product.imageUrl : pageContext.request.contextPath.concat(recentView.product.imageUrl)}" 
                                                                         alt="${recentView.product.productName}"
                                                                         onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                                    <div class="product-image-placeholder" style="display: none; width: 100%; height: 100%; background: #f0f0f0; align-items: center; justify-content: center; color: #999;">
                                                                        <i class="fas fa-image" style="font-size: 1.5rem;"></i>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="product-image-placeholder" style="width: 100%; height: 100%; background: #f0f0f0; display: flex; align-items: center; justify-content: center; color: #999;">
                                                                        <i class="fas fa-image" style="font-size: 1.5rem;"></i>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="product-info" style="padding: 10px;">
                                                            <h6 class="product-title" style="font-size: 0.85rem; margin-bottom: 5px;">
                                                                ${recentView.product.productName}
                                                            </h6>
                                                            <div class="product-price" style="font-size: 0.9rem;">
                                                                <span class="current-price">₹<fmt:formatNumber value="${recentView.product.price}" pattern="#,##0"/></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>

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

    <!-- Quick View Modal -->
    <div class="modal fade" id="quickViewModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Quick View</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="quickViewContent">
                    <div class="text-center py-5">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Mobile Sticky Cart Button -->
    <c:if test="${not empty currentUser && cartCount > 0}">
        <button class="sticky-cart-btn" onclick="window.location.href='${pageContext.request.contextPath}/user/dashboard/cart'">
            <i class="fas fa-shopping-cart"></i>
            <span>Cart (${cartCount})</span>
        </button>
    </c:if>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // View Toggle (Grid/List)
        function setView(view) {
            localStorage.setItem('productView', view);
            const container = document.getElementById('productsContainer');
            const items = container.querySelectorAll('.product-item');
            
            if (view === 'list') {
                container.classList.add('list-view');
                items.forEach(item => {
                    item.className = 'col-12 product-item';
                });
                document.getElementById('gridView').classList.remove('active');
                document.getElementById('listView').classList.add('active');
            } else {
                container.classList.remove('list-view');
                items.forEach(item => {
                    item.className = 'col-md-6 col-lg-4 product-item';
                });
                document.getElementById('gridView').classList.add('active');
                document.getElementById('listView').classList.remove('active');
            }
        }
        
        // Load saved view preference
        const savedView = localStorage.getItem('productView') || 'grid';
        if (savedView === 'list') {
            setTimeout(() => setView('list'), 100);
        }
        
        // Apply Sort
        function applySort(sort) {
            const url = new URL(window.location.href);
            url.searchParams.set('sort', sort);
            url.searchParams.set('page', '0'); // Reset to first page
            window.location.href = url.toString();
        }
        
        // Apply Filters
        function applyFilters() {
            const url = new URL(window.location.href);
            const inStock = document.getElementById('inStock').checked;
            const outOfStock = document.getElementById('outOfStock').checked;
            
            // Get discount filters
            const discountFilters = [];
            [10, 20, 30, 40].forEach(discount => {
                if (document.getElementById('discount' + discount).checked) {
                    discountFilters.push(discount);
                }
            });
            
            if (discountFilters.length > 0) {
                url.searchParams.set('discount', discountFilters.join(','));
            } else {
                url.searchParams.delete('discount');
            }
            
            url.searchParams.set('page', '0');
            window.location.href = url.toString();
        }
        
        // Clear Filters
        function clearFilters() {
            window.location.href = '${pageContext.request.contextPath}/products';
        }
        
        // Add to Cart
        function addToCart(productId, event) {
            if (event) event.stopPropagation();
            <c:choose>
                <c:when test="${not empty currentUser}">
                    var contextPath = '${pageContext.request.contextPath}';
                    fetch(contextPath + '/user/dashboard/cart/add/' + productId, {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'}
                    })
                    .then(function(response) {
                        if (response.ok) {
                            showToast('Product added to cart!', 'success');
                            setTimeout(function() { location.reload(); }, 1000);
                        } else {
                            showToast('Failed to add to cart', 'error');
                        }
                    })
                    .catch(function(error) {
                        console.error('Error:', error);
                        showToast('Error adding to cart', 'error');
                    });
                </c:when>
                <c:otherwise>
                    window.location.href = '${pageContext.request.contextPath}/user/login?redirect=/products';
                </c:otherwise>
            </c:choose>
        }
        
        // Add to Wishlist
        function addToWishlist(productId, event) {
            if (event) event.stopPropagation();
            <c:choose>
                <c:when test="${not empty currentUser}">
                    var contextPath = '${pageContext.request.contextPath}';
                    fetch(contextPath + '/user/dashboard/wishlist/toggle/' + productId, {
                        method: 'POST'
                    })
                    .then(function(response) {
                        if (response.ok) {
                            var btn = event.target.closest('.action-btn');
                            if (btn) {
                                btn.classList.toggle('wishlisted');
                                showToast(btn.classList.contains('wishlisted') ? 'Added to wishlist!' : 'Removed from wishlist', 'success');
                            }
                        }
                    })
                    .catch(function(error) {
                        console.error('Error:', error);
                        showToast('Error updating wishlist', 'error');
                    });
                </c:when>
                <c:otherwise>
                    window.location.href = '${pageContext.request.contextPath}/user/login?redirect=/products';
                </c:otherwise>
            </c:choose>
        }
        
        // Quick View
        function quickView(productId) {
            var modal = new bootstrap.Modal(document.getElementById('quickViewModal'));
            var content = document.getElementById('quickViewContent');
            var contextPath = '${pageContext.request.contextPath}';
            
            content.innerHTML = '<div class="text-center py-5"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>';
            modal.show();
            
            fetch(contextPath + '/products/' + productId + '/quick-view')
                .then(function(response) {
                    if (!response.ok) throw new Error('Product not found');
                    return response.json();
                })
                .then(function(product) {
                    var imageUrl = (product.imageUrl && product.imageUrl.startsWith('http')) 
                        ? product.imageUrl 
                        : (product.imageUrl ? contextPath + product.imageUrl : 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgZmlsbD0iI2YwZjBmMCIvPjx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMTQiIGZpbGw9IiM5OTkiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGR5PSIuM2VtIj5ObyBJbWFnZTwvdGV4dD48L3N2Zz4=');
                    var slug = product.slug || product.id;
                    var productName = product.productName || 'Product';
                    var price = (product.price || 0).toLocaleString('en-IN');
                    var mrpHtml = '';
                    if (product.mrp && product.mrp > product.price) {
                        var mrp = product.mrp.toLocaleString('en-IN');
                        var discount = product.discountPercentage || 0;
                        mrpHtml = '<span class="text-muted text-decoration-line-through ms-2">₹' + mrp + '</span><span class="badge bg-danger ms-2">' + discount + '% OFF</span>';
                    }
                    var description = product.shortDescription || product.description || 'No description available';
                    
                    var imageHtml = imageUrl 
                        ? '<img src="' + imageUrl + '" class="img-fluid rounded" alt="' + productName + '" onerror="this.onerror=null; this.style.display=\'none\'; this.nextElementSibling.style.display=\'flex\';">' +
                          '<div style="display: none; width: 100%; height: 300px; background: #f0f0f0; align-items: center; justify-content: center; color: #999; border-radius: 0.375rem;"><i class="fas fa-image" style="font-size: 3rem;"></i></div>'
                        : '<div style="width: 100%; height: 300px; background: #f0f0f0; display: flex; align-items: center; justify-content: center; color: #999; border-radius: 0.375rem;"><i class="fas fa-image" style="font-size: 3rem;"></i></div>';
                    content.innerHTML = 
                        '<div class="row g-4">' +
                            '<div class="col-md-6">' +
                                imageHtml +
                            '</div>' +
                            '<div class="col-md-6">' +
                                '<h4 class="mb-3">' + productName + '</h4>' +
                                '<div class="mb-3">' +
                                    '<span class="h5 text-primary fw-bold">₹' + price + '</span>' + mrpHtml +
                                '</div>' +
                                '<p class="text-muted mb-3">' + description + '</p>' +
                                '<div class="d-flex gap-2 flex-wrap">' +
                                    '<button class="btn btn-primary" onclick="addToCart(' + product.id + ', event); var modalEl = document.getElementById(\'quickViewModal\'); if(modalEl) { bootstrap.Modal.getInstance(modalEl).hide(); }">' +
                                        '<i class="fas fa-shopping-cart me-2"></i>Add to Cart' +
                                    '</button>' +
                                    '<a href="' + contextPath + '/products/' + slug + '" class="btn btn-outline-primary">' +
                                        '<i class="fas fa-eye me-2"></i>View Details' +
                                    '</a>' +
                                '</div>' +
                            '</div>' +
                        '</div>';
                })
                .catch(function(error) {
                    console.error('Error:', error);
                    content.innerHTML = '<div class="alert alert-danger"><i class="fas fa-exclamation-circle me-2"></i>Error loading product details. Please try again.</div>';
                });
        }
        
        // Share Product
        function shareProduct(productId, productName, event) {
            if (event) event.stopPropagation();
            const url = window.location.origin + '${pageContext.request.contextPath}/products/' + productId;
            const text = `Check out ${productName} on AyurVeda!`;
            
            if (navigator.share) {
                navigator.share({
                    title: productName,
                    text: text,
                    url: url
                });
            } else {
                // Fallback: Copy to clipboard
                navigator.clipboard.writeText(url).then(() => {
                    showToast('Link copied to clipboard!', 'success');
                });
            }
        }
        
        // Toast Notification
        function showToast(message, type) {
            const toast = document.createElement('div');
            var alertType = type === 'success' ? 'success' : 'danger';
            var iconType = type === 'success' ? 'check-circle' : 'exclamation-circle';
            toast.className = 'alert alert-' + alertType + ' position-fixed top-0 end-0 m-3';
            toast.style.zIndex = '9999';
            toast.innerHTML = '<i class="fas fa-' + iconType + ' me-2"></i>' + message;
            document.body.appendChild(toast);
            setTimeout(() => toast.remove(), 3000);
        }
    </script>
</body>
</html>

