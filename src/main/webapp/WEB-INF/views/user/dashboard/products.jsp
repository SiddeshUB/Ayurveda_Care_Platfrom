<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="Browse Products"/>
    <jsp:param name="activeNav" value="products"/>
</jsp:include>

<style>
    .products-page {
        padding: 0;
    }
    
    /* Page Header */
    .products-page .page-header-section {
        background: linear-gradient(135deg, rgba(45, 74, 45, 0.05), rgba(201, 162, 39, 0.05));
        border-radius: 20px;
        padding: 40px;
        margin-bottom: 30px;
        position: relative;
        overflow: hidden;
    }
    
    .products-page .page-header-section::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 300px;
        height: 300px;
        background: radial-gradient(circle, rgba(45, 74, 45, 0.1), transparent);
        border-radius: 50%;
    }
    
    .products-page .page-header-section::after {
        content: '';
        position: absolute;
        bottom: -30%;
        left: -30%;
        width: 200px;
        height: 200px;
        background: radial-gradient(circle, rgba(201, 162, 39, 0.1), transparent);
        border-radius: 50%;
    }
    
    .products-page .page-header-content {
        position: relative;
        z-index: 1;
    }
    
    .products-page .page-title {
        font-size: 32px;
        font-weight: 700;
        color: #1a2e1a;
        margin: 0 0 10px 0;
        display: flex;
        align-items: center;
        gap: 15px;
        font-family: 'Poppins', sans-serif;
    }
    
    .products-page .page-title i {
        color: #2d4a2d;
        font-size: 36px;
    }
    
    .products-page .page-subtitle {
        color: #666;
        font-size: 16px;
        margin: 0;
    }
    
    /* Search and Filters Section */
    .products-page .filters-section {
        background: #ffffff;
        border-radius: 20px;
        padding: 30px;
        margin-bottom: 30px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.06);
        border: 1px solid rgba(0,0,0,0.04);
    }
    
    .products-page .filters-form {
        display: grid;
        grid-template-columns: 2fr 1fr auto;
        gap: 20px;
        align-items: end;
    }
    
    .products-page .form-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }
    
    .products-page .form-group label {
        font-size: 14px;
        font-weight: 600;
        color: #1a2e1a;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .products-page .form-input,
    .products-page .form-select {
        padding: 14px 18px;
        border: 2px solid #e9ecef;
        border-radius: 12px;
        font-size: 15px;
        transition: all 0.3s ease;
        background: #fff;
        color: #333;
        font-family: 'Poppins', sans-serif;
    }
    
    .products-page .form-input:focus,
    .products-page .form-select:focus {
        outline: none;
        border-color: #2d4a2d;
        box-shadow: 0 0 0 4px rgba(45, 74, 45, 0.1);
    }
    
    .products-page .btn-search {
        padding: 14px 30px;
        background: linear-gradient(135deg, #2d4a2d, #1a2e1a);
        color: #fff;
        border: none;
        border-radius: 12px;
        font-weight: 600;
        font-size: 15px;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 10px;
        white-space: nowrap;
        box-shadow: 0 4px 15px rgba(45, 74, 45, 0.3);
    }
    
    .products-page .btn-search:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(45, 74, 45, 0.4);
    }
    
    .products-page .btn-search:active {
        transform: translateY(0);
    }
    
    /* Products Grid */
    .products-page .products-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 25px;
        margin-bottom: 30px;
    }
    
    .products-page .product-card {
        background: #ffffff;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 5px 25px rgba(0,0,0,0.06);
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        border: 1px solid rgba(0,0,0,0.04);
        position: relative;
        display: flex;
        flex-direction: column;
    }
    
    .products-page .product-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 40px rgba(0,0,0,0.12);
        border-color: rgba(45, 74, 45, 0.2);
    }
    
    .products-page .product-image-wrapper {
        position: relative;
        height: 250px;
        overflow: hidden;
        background: linear-gradient(135deg, #f8f6f1, #e8f1ed);
    }
    
    .products-page .product-image-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }
    
    .products-page .product-card:hover .product-image-wrapper img {
        transform: scale(1.1);
    }
    
    .products-page .product-image-placeholder {
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        background: linear-gradient(135deg, rgba(45, 74, 45, 0.05), rgba(201, 162, 39, 0.05));
    }
    
    .products-page .product-image-placeholder i {
        font-size: 60px;
        color: #2d4a2d;
        opacity: 0.3;
    }
    
    .products-page .product-badge {
        position: absolute;
        top: 15px;
        right: 15px;
        background: linear-gradient(135deg, #dc3545, #c82333);
        color: #fff;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        box-shadow: 0 4px 15px rgba(220, 53, 69, 0.4);
        z-index: 2;
    }
    
    .products-page .product-body {
        padding: 25px;
        flex: 1;
        display: flex;
        flex-direction: column;
    }
    
    .products-page .product-category {
        font-size: 12px;
        color: #2d4a2d;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 8px;
        display: inline-block;
        padding: 4px 12px;
        background: rgba(45, 74, 45, 0.1);
        border-radius: 12px;
        width: fit-content;
    }
    
    .products-page .product-name {
        font-size: 20px;
        font-weight: 700;
        color: #1a2e1a;
        margin: 0 0 12px 0;
        line-height: 1.3;
        font-family: 'Poppins', sans-serif;
        min-height: 52px;
    }
    
    .products-page .product-description {
        color: #666;
        font-size: 14px;
        line-height: 1.6;
        margin-bottom: 20px;
        flex: 1;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
    
    .products-page .product-footer {
        margin-top: auto;
        padding-top: 20px;
        border-top: 1px solid #f0f0f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 15px;
    }
    
    .products-page .product-price-section {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }
    
    .products-page .product-price {
        font-size: 24px;
        font-weight: 700;
        color: #2d4a2d;
        font-family: 'Poppins', sans-serif;
    }
    
    .products-page .product-original-price {
        font-size: 16px;
        color: #999;
        text-decoration: line-through;
        font-weight: 500;
    }
    
    .products-page .product-discount {
        font-size: 12px;
        color: #dc3545;
        font-weight: 600;
    }
    
    .products-page .btn-add-cart {
        padding: 12px 24px;
        background: linear-gradient(135deg, #2d4a2d, #1a2e1a);
        color: #fff;
        border: none;
        border-radius: 12px;
        font-weight: 600;
        font-size: 14px;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
        white-space: nowrap;
        box-shadow: 0 4px 15px rgba(45, 74, 45, 0.3);
    }
    
    .products-page .btn-add-cart:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(45, 74, 45, 0.4);
        background: linear-gradient(135deg, #1a2e1a, #2d4a2d);
    }
    
    .products-page .btn-add-cart:active {
        transform: translateY(0);
    }
    
    .products-page .btn-add-cart i {
        font-size: 16px;
    }
    
    /* Empty State */
    .products-page .empty-state {
        background: #ffffff;
        border-radius: 20px;
        padding: 80px 40px;
        text-align: center;
        box-shadow: 0 5px 25px rgba(0,0,0,0.06);
        border: 1px solid rgba(0,0,0,0.04);
    }
    
    .products-page .empty-state-icon {
        width: 120px;
        height: 120px;
        margin: 0 auto 30px;
        background: linear-gradient(135deg, rgba(45, 74, 45, 0.1), rgba(201, 162, 39, 0.1));
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .products-page .empty-state-icon i {
        font-size: 50px;
        color: #2d4a2d;
        opacity: 0.5;
    }
    
    .products-page .empty-state h3 {
        font-size: 24px;
        font-weight: 700;
        color: #1a2e1a;
        margin: 0 0 10px 0;
        font-family: 'Poppins', sans-serif;
    }
    
    .products-page .empty-state p {
        color: #666;
        font-size: 16px;
        margin: 0;
    }
    
    /* Responsive Design */
    @media (max-width: 992px) {
        .products-page .filters-form {
            grid-template-columns: 1fr;
        }
        
        .products-page .products-grid {
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }
    }
    
    @media (max-width: 768px) {
        .products-page .page-header-section {
            padding: 25px;
        }
        
        .products-page .page-title {
            font-size: 24px;
        }
        
        .products-page .filters-section {
            padding: 20px;
        }
        
        .products-page .products-grid {
            grid-template-columns: 1fr;
        }
        
        .products-page .product-footer {
            flex-direction: column;
            align-items: stretch;
        }
        
        .products-page .btn-add-cart {
            width: 100%;
            justify-content: center;
        }
    }
</style>

<div class="products-page">
    <!-- Page Header -->
    <div class="page-header-section">
        <div class="page-header-content">
            <h1 class="page-title">
                <i class="fas fa-shopping-bag"></i>
                Browse Products
            </h1>
            <p class="page-subtitle">Discover authentic Ayurvedic products from trusted hospitals and wellness centers</p>
        </div>
    </div>

    <!-- Search and Filters -->
    <div class="filters-section">
        <form method="get" action="${pageContext.request.contextPath}/user/products" class="filters-form">
            <div class="form-group">
                <label for="search">Search Products</label>
                <input type="text" 
                       id="search" 
                       name="search" 
                       value="${search}" 
                       placeholder="Search by name, description..." 
                       class="form-input">
            </div>
            <div class="form-group">
                <label for="category">Category</label>
                <select id="category" name="category" class="form-select">
                    <option value="">All Categories</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat}" ${category == cat ? 'selected' : ''}>${cat.displayName}</option>
                    </c:forEach>
                </select>
            </div>
            <c:if test="${hospitalId != null}">
                <input type="hidden" name="hospitalId" value="${hospitalId}">
            </c:if>
            <button type="submit" class="btn-search">
                <i class="fas fa-search"></i>
                Search
            </button>
        </form>
    </div>

    <!-- Products Grid -->
    <c:choose>
        <c:when test="${not empty products}">
            <div class="products-grid">
                <c:forEach var="product" items="${products}">
                    <div class="product-card">
                        <!-- Product Image -->
                        <div class="product-image-wrapper">
                            <c:choose>
                                <c:when test="${not empty product.imageUrl}">
                                    <img src="${product.imageUrl.startsWith('http') ? product.imageUrl : pageContext.request.contextPath.concat(product.imageUrl)}" 
                                         alt="${product.productName}"
                                         loading="lazy">
                                </c:when>
                                <c:otherwise>
                                    <div class="product-image-placeholder">
                                        <i class="fas fa-box"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${product.discountPrice != null}">
                                <span class="product-badge">
                                    <i class="fas fa-tag"></i> Sale
                                </span>
                            </c:if>
                        </div>
                        
                        <!-- Product Body -->
                        <div class="product-body">
                            <span class="product-category">
                                ${product.category != null ? product.category.displayName : 'Product'}
                            </span>
                            <h3 class="product-name">${product.productName}</h3>
                            <c:if test="${not empty product.shortDescription}">
                                <p class="product-description">
                                    ${fn:substring(product.shortDescription, 0, 120)}${fn:length(product.shortDescription) > 120 ? '...' : ''}
                                </p>
                            </c:if>
                            
                            <!-- Product Footer -->
                            <div class="product-footer">
                                <div class="product-price-section">
                                    <c:choose>
                                        <c:when test="${product.discountPrice != null}">
                                            <div class="product-price">
                                                ₹<fmt:formatNumber value="${product.discountPrice}" maxFractionDigits="0"/>
                                            </div>
                                            <div style="display: flex; align-items: center; gap: 10px;">
                                                <span class="product-original-price">
                                                    ₹<fmt:formatNumber value="${product.price}" maxFractionDigits="0"/>
                                                </span>
                                                <c:set var="discountPercent" value="${((product.price - product.discountPrice) / product.price) * 100}"/>
                                                <span class="product-discount">
                                                    <fmt:formatNumber value="${discountPercent}" maxFractionDigits="0"/>% OFF
                                                </span>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="product-price">
                                                ₹<fmt:formatNumber value="${product.price}" maxFractionDigits="0"/>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <form method="post" action="${pageContext.request.contextPath}/user/cart/add/${product.id}" style="margin: 0;">
                                    <button type="submit" class="btn-add-cart">
                                        <i class="fas fa-cart-plus"></i>
                                        Add to Cart
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fas fa-box-open"></i>
                </div>
                <h3>No Products Found</h3>
                <p>Try adjusting your search criteria or browse different categories</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

        </div>
    </main>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Sidebar Toggle
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebarOverlay = document.getElementById('sidebarOverlay');
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', () => {
                sidebar.classList.toggle('active');
                sidebarOverlay.classList.toggle('active');
            });
        }
        
        if (sidebarOverlay) {
            sidebarOverlay.addEventListener('click', () => {
                sidebar.classList.remove('active');
                sidebarOverlay.classList.remove('active');
            });
        }
    </script>
</body>
</html>
