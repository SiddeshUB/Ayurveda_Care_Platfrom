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
        .quantity-input { display: flex; align-items: center; border: 2px solid #ddd; border-radius: 8px; overflow: hidden; }
        .quantity-input button { width: 40px; height: 40px; border: none; background: white; cursor: pointer; font-size: 1.2rem; }
        .quantity-input button:hover { background: var(--cream); }
        .quantity-input input { width: 60px; height: 40px; border: none; text-align: center; font-weight: 600; }
        
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
        .similar-product-card { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 3px 10px rgba(0,0,0,0.05); transition: all 0.3s ease; }
        .similar-product-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .similar-product-card img { width: 100%; height: 150px; object-fit: cover; }
        .similar-product-card .card-body { padding: 15px; }
        .similar-product-card .title { font-size: 0.9rem; margin-bottom: 5px; }
        .similar-product-card .price { font-weight: 600; color: var(--primary); }
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
    <div class="container" style="margin-top: 100px;">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Products</a></li>
                <c:if test="${product.category != null}">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products/category/${product.category.slug}">${product.category.displayName}</a></li>
                </c:if>
                <li class="breadcrumb-item active">${product.productName}</li>
            </ol>
        </nav>
    </div>

    <!-- Product Details -->
    <section class="py-4">
        <div class="container">
            <div class="row">
                <!-- Product Gallery -->
                <div class="col-lg-5 mb-4">
                    <div class="product-gallery">
                        <div class="main-image">
<<<<<<< HEAD
                            <c:choose>
                                <c:when test="${not empty product.imageUrl}">
                                    <c:set var="mainImageUrl" value="${product.imageUrl.startsWith('http') ? product.imageUrl : pageContext.request.contextPath.concat(product.imageUrl)}" />
                                    <img src="${mainImageUrl}" alt="${product.productName}" id="mainImage">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/images/no-product.png" alt="${product.productName}" id="mainImage">
                                </c:otherwise>
                            </c:choose>
=======
                            <img src="${not empty product.imageUrl ? product.imageUrl : pageContext.request.contextPath.concat('/images/no-product.png')}" alt="${product.productName}" id="mainImage">
>>>>>>> edaa4568e405c23538b45d4e9bbc206b39763f74
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
                                <button class="btn-add-cart" onclick="addToCart(${product.id})">
                                    <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                </button>
                                <button class="btn-buy-now" onclick="buyNow(${product.id})">
                                    <i class="fas fa-bolt me-2"></i>Buy Now
                                </button>
                                <button class="btn-wishlist ${inWishlist ? 'active' : ''}" onclick="toggleWishlist(${product.id})" title="Add to Wishlist">
                                    <i class="fas fa-heart"></i>
                                </button>
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
                            <span class="text-muted me-2">Share:</span>
                            <a href="#" style="background: #3b5998;"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" style="background: #1da1f2;"><i class="fab fa-twitter"></i></a>
                            <a href="#" style="background: #25d366;"><i class="fab fa-whatsapp"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product Tabs -->
            <div class="product-tabs">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item">
                        <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#description">Description</button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#ingredients">Ingredients</button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#usage">How to Use</button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#reviews">Reviews (${product.totalReviews})</button>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="description">
                        <p>${not empty product.description ? product.description : 'No description available.'}</p>
                        <c:if test="${not empty product.benefits}">
                            <h5 class="mt-4 mb-3">Benefits</h5>
                            <p>${product.benefits}</p>
                        </c:if>
                    </div>
                    <div class="tab-pane fade" id="ingredients">
                        <p>${not empty product.ingredients ? product.ingredients : 'Ingredient information not available.'}</p>
                    </div>
                    <div class="tab-pane fade" id="usage">
                        <p>${not empty product.usageInstructions ? product.usageInstructions : 'Usage instructions not available.'}</p>
                    </div>
                    <div class="tab-pane fade" id="reviews">
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
                                <c:forEach begin="5" end="1" var="r" step="-1">
                                    <div class="rating-breakdown">
                                        <span>${r}</span>
                                        <i class="fas fa-star text-warning"></i>
                                        <div class="rating-bar">
                                            <div class="rating-bar-fill" style="width: ${ratingDistribution != null && ratingDistribution[r] != null ? ratingDistribution[r] : 0}%"></div>
                                        </div>
                                        <span class="text-muted">${ratingDistribution != null && ratingDistribution[r] != null ? ratingDistribution[r] : 0}%</span>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Reviews List -->
                        <c:choose>
                            <c:when test="${not empty reviews}">
                                <c:forEach items="${reviews}" var="review">
                                    <div class="review-card">
                                        <div class="reviewer">
                                            <div class="reviewer-avatar">${review.user.fullName.substring(0, 1)}</div>
                                            <div>
                                                <strong>${review.user.fullName}</strong>
                                                <c:if test="${review.isVerifiedPurchase}">
                                                    <span class="verified-badge"><i class="fas fa-check me-1"></i>Verified</span>
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
                                        <c:if test="${not empty review.pros}">
                                            <p class="text-success mb-1"><i class="fas fa-thumbs-up me-2"></i>${review.pros}</p>
                                        </c:if>
                                        <c:if test="${not empty review.cons}">
                                            <p class="text-danger mb-0"><i class="fas fa-thumbs-down me-2"></i>${review.cons}</p>
                                        </c:if>
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
                </div>
            </div>

            <!-- Similar Products -->
            <c:if test="${not empty similarProducts}">
                <div class="similar-products">
                    <h4 class="mb-4">You May Also Like</h4>
                    <div class="row g-4">
                        <c:forEach items="${similarProducts}" var="sp">
                            <div class="col-md-3">
                                <a href="${pageContext.request.contextPath}/products/${sp.slug}" class="text-decoration-none">
                                    <div class="similar-product-card">
<<<<<<< HEAD
                                        <c:choose>
                                            <c:when test="${not empty sp.imageUrl}">
                                                <img src="${sp.imageUrl.startsWith('http') ? sp.imageUrl : pageContext.request.contextPath.concat(sp.imageUrl)}" alt="${sp.productName}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/images/no-product.png" alt="${sp.productName}">
                                            </c:otherwise>
                                        </c:choose>
=======
                                        <img src="${not empty sp.imageUrl ? sp.imageUrl : pageContext.request.contextPath.concat('/images/no-product.png')}" alt="${sp.productName}">
>>>>>>> edaa4568e405c23538b45d4e9bbc206b39763f74
                                        <div class="card-body">
                                            <p class="title text-dark">${sp.productName}</p>
                                            <span class="price">₹<fmt:formatNumber value="${sp.price}"/></span>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
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
        function changeImage(url, element) {
            document.getElementById('mainImage').src = url;
            document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active'));
            element.classList.add('active');
        }
        
        function decreaseQty() {
            var input = document.getElementById('quantity');
            if (input.value > 1) input.value = parseInt(input.value) - 1;
        }
        
        function increaseQty(max) {
            var input = document.getElementById('quantity');
            if (parseInt(input.value) < max) input.value = parseInt(input.value) + 1;
        }
        
        function addToCart(productId) {
            var qty = document.getElementById('quantity').value;
            window.location.href = '${pageContext.request.contextPath}/user/dashboard/cart/add/' + productId + '?quantity=' + qty;
        }
        
        function buyNow(productId) {
            var qty = document.getElementById('quantity').value;
            window.location.href = '${pageContext.request.contextPath}/user/dashboard/checkout?productId=' + productId + '&quantity=' + qty;
        }
        
        function toggleWishlist(productId) {
            window.location.href = '${pageContext.request.contextPath}/user/dashboard/wishlist/toggle/' + productId;
        }
    </script>
</body>
</html>

