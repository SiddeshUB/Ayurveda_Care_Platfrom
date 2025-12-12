<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${product.id != null}">Edit</c:when><c:otherwise>Add</c:otherwise></c:choose> Product - Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/hospital/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1><c:choose><c:when test="${product.id != null}">Edit</c:when><c:otherwise>Add New</c:otherwise></c:choose> Product</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <div class="form-card">
                <c:choose>
                    <c:when test="${product.id != null}">
                        <form action="${pageContext.request.contextPath}/dashboard/products/edit/${product.id}" 
                              method="post" enctype="multipart/form-data">
                    </c:when>
                    <c:otherwise>
                        <form action="${pageContext.request.contextPath}/dashboard/products/add" 
                              method="post" enctype="multipart/form-data">
                    </c:otherwise>
                </c:choose>
                    
                    <h3><i class="fas fa-info-circle"></i> Basic Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Product Name</label>
                            <input type="text" name="productName" class="form-input" 
                                   value="${product.productName}" placeholder="e.g., Organic Turmeric Oil" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">SKU / Product Code</label>
                            <input type="text" name="sku" class="form-input" 
                                   value="${product.sku}" placeholder="Auto-generated if left empty">
                            <small style="color: var(--text-muted);">Leave empty to auto-generate</small>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Category</label>
                            <select name="categoryId" class="form-select" required>
                                <option value="">Select category...</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}" ${product.category != null && product.category.id == cat.id ? 'selected' : ''}>${cat.displayName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Weight/Size</label>
                            <input type="text" name="weight" class="form-input" 
                                   value="${product.weight}" placeholder="e.g., 100ml, 500g, 60 tablets">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Short Description</label>
                        <textarea name="shortDescription" class="form-textarea" rows="2" 
                                  placeholder="Brief description for product listings...">${product.shortDescription}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Full Description</label>
                        <textarea name="description" class="form-textarea" rows="5" 
                                  placeholder="Detailed product description...">${product.description}</textarea>
                    </div>
                    
                    <h3 style="margin-top: var(--spacing-2xl);"><i class="fas fa-rupee-sign"></i> Pricing</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Price (₹)</label>
                            <input type="number" name="price" class="form-input" 
                                   value="${product.price}" placeholder="e.g., 599" min="0" step="0.01" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Discount Price (₹)</label>
                            <input type="number" name="discountPrice" class="form-input" 
                                   value="${product.discountPrice}" placeholder="Sale price (optional)" min="0" step="0.01">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Original Price / MRP (₹)</label>
                        <input type="number" name="mrp" class="form-input" 
                               value="${product.mrp}" placeholder="MRP (optional)" min="0" step="0.01">
                        <small style="color: var(--text-muted);">Set if different from regular price</small>
                    </div>
                    
                    <h3 style="margin-top: var(--spacing-2xl);"><i class="fas fa-box"></i> Inventory</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Stock Quantity</label>
                            <input type="number" name="stockQuantity" class="form-input" 
                                   value="${product.stockQuantity}" placeholder="e.g., 50" min="0">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Min Stock Level</label>
                            <input type="number" name="minStockLevel" class="form-input" 
                                   value="${product.minStockLevel}" placeholder="Alert threshold" min="0">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="checkbox-label">
                            <input type="checkbox" name="trackInventory" value="true" ${product.trackInventory == null || product.trackInventory ? 'checked' : ''}>
                            <span>Track Inventory</span>
                        </label>
                    </div>
                    
                    <h3 style="margin-top: var(--spacing-2xl);"><i class="fas fa-leaf"></i> Product Details</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Manufacturer</label>
                            <input type="text" name="manufacturer" class="form-input" 
                                   value="${product.manufacturer}" placeholder="Manufacturer name">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Expiry Date</label>
                            <input type="text" name="expiryDate" class="form-input" 
                                   value="${product.expiryDate}" placeholder="e.g., 2025-12-31">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Ingredients / Composition</label>
                        <textarea name="ingredients" class="form-textarea" rows="3" 
                                  placeholder="List ingredients or composition...">${product.ingredients}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Health Benefits</label>
                        <textarea name="benefits" class="form-textarea" rows="3" 
                                  placeholder="Describe health benefits...">${product.benefits}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Usage Instructions</label>
                        <textarea name="usageInstructions" class="form-textarea" rows="3" 
                                  placeholder="How to use this product...">${product.usageInstructions}</textarea>
                    </div>
                    
                    <h3 style="margin-top: var(--spacing-2xl);"><i class="fas fa-image"></i> Images</h3>
                    
                    <div class="form-group">
                        <label class="form-label">Main Product Image</label>
                        <input type="file" name="imageFile" class="form-input" accept="image/*">
                        <small style="color: var(--text-muted);">Upload main product image</small>
                        <c:if test="${not empty product.imageUrl}">
                            <div style="margin-top: var(--spacing-sm);">
                                <small>Current image: ${product.imageUrl}</small>
                            </div>
                        </c:if>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Additional Images</label>
                        <input type="file" name="imageFiles" class="form-input" accept="image/*" multiple>
                        <small style="color: var(--text-muted);">You can upload multiple images</small>
                    </div>
                    
                    <h3 style="margin-top: var(--spacing-2xl);"><i class="fas fa-cog"></i> Settings</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="isActive" value="true" ${product.isActive == null || product.isActive ? 'checked' : ''}>
                                <span>Active (visible to users)</span>
                            </label>
                        </div>
                        
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="isFeatured" value="true" ${product.isFeatured ? 'checked' : ''}>
                                <span>Featured Product</span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="checkbox-label">
                            <input type="checkbox" name="isAvailable" value="true" ${product.isAvailable == null || product.isAvailable ? 'checked' : ''}>
                            <span>Available for purchase</span>
                        </label>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Sort Order</label>
                        <input type="number" name="sortOrder" class="form-input" 
                               value="${product.sortOrder != null ? product.sortOrder : 0}" placeholder="0" min="0">
                        <small style="color: var(--text-muted);">Lower numbers appear first</small>
                    </div>
                    
                    <h3 style="margin-top: var(--spacing-2xl);"><i class="fas fa-tags"></i> SEO & Tags</h3>
                    
                    <div class="form-group">
                        <label class="form-label">Tags</label>
                        <input type="text" name="tags" class="form-input" 
                               value="${product.tags}" placeholder="Comma-separated tags (e.g., organic, herbal, ayurvedic)">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Meta Title</label>
                        <input type="text" name="metaTitle" class="form-input" 
                               value="${product.metaTitle}" placeholder="SEO meta title">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Meta Description</label>
                        <textarea name="metaDescription" class="form-textarea" rows="2" 
                                  placeholder="SEO meta description...">${product.metaDescription}</textarea>
                    </div>
                    
                    <div class="form-actions" style="border-top: none; margin-top: var(--spacing-xl);">
                        <a href="${pageContext.request.contextPath}/dashboard/products" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> <c:choose><c:when test="${product.id != null}">Update</c:when><c:otherwise>Create</c:otherwise></c:choose> Product
                        </button>
                    </div>
                </form>
            </div>
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

