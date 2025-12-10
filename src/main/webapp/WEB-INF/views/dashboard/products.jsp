<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body class="dashboard-body">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-leaf"></i>
                <span>AyurVeda<span class="highlight">Care</span></span>
            </a>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/profile" class="nav-item">
                <i class="fas fa-hospital"></i>
                <span>Profile</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/packages" class="nav-item">
                <i class="fas fa-box"></i>
                <span>Packages</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/products" class="nav-item active">
                <i class="fas fa-shopping-bag"></i>
                <span>Products</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/doctors" class="nav-item">
                <i class="fas fa-user-md"></i>
                <span>Doctors</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/bookings" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Bookings</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/enquiries" class="nav-item">
                <i class="fas fa-envelope"></i>
                <span>Enquiries</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/gallery" class="nav-item">
                <i class="fas fa-images"></i>
                <span>Gallery</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/reviews" class="nav-item">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}" class="btn btn-outline btn-sm" target="_blank">
                <i class="fas fa-external-link-alt"></i> View Public Profile
            </a>
            <a href="${pageContext.request.contextPath}/hospital/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Product Management</h1>
            </div>
            
            <div class="header-right">
                <div class="header-profile">
                    <div class="profile-info">
                        <span class="profile-name">${hospital.centerName}</span>
                    </div>
                    <div class="profile-avatar">
                        <i class="fas fa-hospital"></i>
                    </div>
                </div>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success" data-auto-dismiss="5000">
                    <i class="fas fa-check-circle"></i>
                    ${success}
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error" data-auto-dismiss="5000">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <div class="page-header">
                <div>
                    <h2 style="margin: 0;">Your Products</h2>
                    <p style="color: var(--text-muted); margin: var(--spacing-xs) 0 0;">Manage your e-commerce products</p>
                </div>
                <a href="${pageContext.request.contextPath}/dashboard/products/add" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add Product
                </a>
            </div>

            <c:choose>
                <c:when test="${not empty products}">
                    <div class="item-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">
                        <c:forEach var="product" items="${products}">
                            <div class="product-card" style="background: white; border-radius: var(--radius-lg); padding: var(--spacing-lg); box-shadow: var(--shadow-sm);">
                                <div style="position: relative; margin-bottom: var(--spacing-md);">
                                    <c:choose>
                                        <c:when test="${not empty product.imageUrl}">
                                            <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.productName}" 
                                                 style="width: 100%; height: 200px; object-fit: cover; border-radius: var(--radius-md);">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="width: 100%; height: 200px; background: var(--bg-light); border-radius: var(--radius-md); display: flex; align-items: center; justify-content: center;">
                                                <i class="fas fa-image" style="font-size: 3rem; color: var(--text-muted);"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${product.isFeatured}">
                                        <span style="position: absolute; top: 8px; right: 8px; background: var(--accent-gold); color: white; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; font-weight: 600;">
                                            <i class="fas fa-star"></i> Featured
                                        </span>
                                    </c:if>
                                    <c:if test="${!product.isActive}">
                                        <span style="position: absolute; top: 8px; left: 8px; background: #ef4444; color: white; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; font-weight: 600;">
                                            Inactive
                                        </span>
                                    </c:if>
                                </div>
                                
                                <div style="margin-bottom: var(--spacing-sm);">
                                    <h4 style="margin: 0 0 var(--spacing-xs); font-size: 1.1rem; color: var(--text-dark);">${product.productName}</h4>
                                    <div style="color: var(--text-muted); font-size: 0.85rem; margin-bottom: var(--spacing-xs);">
                                        <i class="fas fa-tag"></i> ${product.category.displayName}
                                    </div>
                                    <c:if test="${not empty product.sku}">
                                        <div style="color: var(--text-muted); font-size: 0.8rem; margin-bottom: var(--spacing-xs);">
                                            SKU: ${product.sku}
                                        </div>
                                    </c:if>
                                </div>
                                
                                <div style="margin-bottom: var(--spacing-md);">
                                    <div style="display: flex; align-items: center; gap: var(--spacing-sm);">
                                        <c:choose>
                                            <c:when test="${not empty product.discountPrice}">
                                                <span style="font-size: 1.25rem; font-weight: 700; color: var(--primary);">
                                                    ₹<fmt:formatNumber value="${product.discountPrice}" maxFractionDigits="0"/>
                                                </span>
                                                <span style="font-size: 0.9rem; color: var(--text-muted); text-decoration: line-through;">
                                                    ₹<fmt:formatNumber value="${product.price}" maxFractionDigits="0"/>
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="font-size: 1.25rem; font-weight: 700; color: var(--primary);">
                                                    ₹<fmt:formatNumber value="${product.price}" maxFractionDigits="0"/>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <c:if test="${product.trackInventory && product.stockQuantity != null}">
                                        <div style="margin-top: var(--spacing-xs); font-size: 0.85rem; color: ${product.stockQuantity > 0 ? 'var(--success)' : 'var(--error)'};">
                                            <i class="fas fa-box"></i> Stock: ${product.stockQuantity}
                                            <c:if test="${product.minStockLevel != null && product.stockQuantity <= product.minStockLevel}">
                                                <span style="color: var(--error);"> (Low Stock!)</span>
                                            </c:if>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <div style="display: flex; gap: var(--spacing-xs); flex-wrap: wrap; border-top: 1px solid var(--border-color); padding-top: var(--spacing-md);">
                                    <a href="${pageContext.request.contextPath}/dashboard/products/edit/${product.id}" class="btn btn-sm btn-secondary" style="flex: 1;">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <form action="${pageContext.request.contextPath}/dashboard/products/toggle/${product.id}" method="post" style="flex: 1;">
                                        <button type="submit" class="btn btn-sm ${product.isActive ? 'btn-warning' : 'btn-success'}" style="width: 100%;">
                                            <i class="fas fa-${product.isActive ? 'eye-slash' : 'eye'}"></i> ${product.isActive ? 'Deactivate' : 'Activate'}
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/dashboard/products/feature/${product.id}" method="post" style="flex: 1;">
                                        <button type="submit" class="btn btn-sm ${product.isFeatured ? 'btn-secondary' : 'btn-primary'}" style="width: 100%;">
                                            <i class="fas fa-star"></i> ${product.isFeatured ? 'Unfeature' : 'Feature'}
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/dashboard/products/delete/${product.id}" method="post" onsubmit="return confirm('Delete this product?');" style="flex: 1;">
                                        <button type="submit" class="btn btn-sm" style="width: 100%; background: var(--error); color: white;">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" style="background: white; border-radius: var(--radius-lg); padding: var(--spacing-3xl);">
                        <i class="fas fa-shopping-bag" style="font-size: 4rem; color: var(--text-muted); margin-bottom: var(--spacing-lg);"></i>
                        <h3>No Products Yet</h3>
                        <p>Start by adding your first product</p>
                        <a href="${pageContext.request.contextPath}/dashboard/products/add" class="btn btn-primary" style="margin-top: var(--spacing-lg);">
                            <i class="fas fa-plus"></i> Add Product
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
            });
        }
    </script>
</body>
</html>

