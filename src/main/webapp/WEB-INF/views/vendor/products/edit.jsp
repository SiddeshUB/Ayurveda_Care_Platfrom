<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product - Vendor Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root { --primary: #2d5a27; --sidebar-bg: #1a1a2e; --sidebar-hover: #16213e; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f6fa; }
        .sidebar { position: fixed; top: 0; left: 0; height: 100vh; width: 260px; background: var(--sidebar-bg); z-index: 1000; }
        .sidebar-brand { padding: 20px; background: rgba(0,0,0,0.2); text-align: center; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .sidebar-brand h4 { color: white; margin: 0; }
        .sidebar-brand small { color: rgba(255,255,255,0.6); }
        .sidebar-menu { padding: 20px 0; }
        .sidebar-menu a { display: flex; align-items: center; padding: 12px 25px; color: rgba(255,255,255,0.7); text-decoration: none; border-left: 3px solid transparent; }
        .sidebar-menu a:hover, .sidebar-menu a.active { background: var(--sidebar-hover); color: white; border-left-color: var(--primary); }
        .sidebar-menu a i { width: 35px; }
        .sidebar-menu .menu-label { padding: 15px 25px 5px; color: rgba(255,255,255,0.4); font-size: 0.75rem; text-transform: uppercase; }
        .main-content { margin-left: 260px; padding: 20px; min-height: 100vh; }
        .top-navbar { background: white; padding: 15px 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .card-header { background: white; border-bottom: 1px solid #eee; padding: 20px; font-weight: 600; }
        .form-control, .form-select { border-radius: 8px; border: 2px solid #e0e0e0; padding: 10px 15px; }
        .form-control:focus, .form-select:focus { border-color: var(--primary); box-shadow: 0 0 0 0.2rem rgba(45, 90, 39, 0.15); }
        .product-image-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 10px; }
        .product-image-item { position: relative; border-radius: 8px; overflow: hidden; }
        .product-image-item img { width: 100%; height: 100px; object-fit: cover; }
        .product-image-item .featured-badge { position: absolute; top: 5px; left: 5px; background: var(--primary); color: white; padding: 2px 8px; border-radius: 10px; font-size: 0.7rem; }
        .product-image-item .delete-btn { position: absolute; top: 5px; right: 5px; background: rgba(220,53,69,0.9); color: white; border: none; border-radius: 50%; width: 25px; height: 25px; cursor: pointer; }
        .image-upload-area { border: 2px dashed #ddd; border-radius: 10px; padding: 20px; text-align: center; cursor: pointer; }
        .image-upload-area:hover { border-color: var(--primary); background: #f8fff8; }
        .required { color: red; }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-brand">
            <h4><i class="fas fa-store me-2"></i>Vendor Panel</h4>
            <small>${vendor.storeDisplayName}</small>
        </div>
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/vendor/dashboard"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
            <div class="menu-label">Products</div>
            <a href="${pageContext.request.contextPath}/vendor/products" class="active"><i class="fas fa-box"></i>All Products</a>
            <a href="${pageContext.request.contextPath}/vendor/products/add"><i class="fas fa-plus-circle"></i>Add Product</a>
            <div class="menu-label">Sales</div>
            <a href="${pageContext.request.contextPath}/vendor/orders"><i class="fas fa-shopping-cart"></i>Orders</a>
            <a href="${pageContext.request.contextPath}/vendor/reviews"><i class="fas fa-star"></i>Reviews</a>
            <div class="menu-label">Finance</div>
            <a href="${pageContext.request.contextPath}/vendor/wallet"><i class="fas fa-wallet"></i>Wallet</a>
            <div class="menu-label">Settings</div>
            <a href="${pageContext.request.contextPath}/vendor/profile"><i class="fas fa-user-cog"></i>Profile</a>
            <a href="${pageContext.request.contextPath}/vendor/logout" class="text-danger"><i class="fas fa-sign-out-alt"></i>Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="top-navbar d-flex justify-content-between align-items-center">
            <div>
                <h5 class="mb-0">Edit Product</h5>
                <small class="text-muted">${product.productName}</small>
            </div>
            <a href="${pageContext.request.contextPath}/vendor/products" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to Products
            </a>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>

        <form action="${pageContext.request.contextPath}/vendor/products/edit/${product.id}" method="post">
            <div class="row">
                <div class="col-lg-8">
                    <!-- Basic Information -->
                    <div class="card">
                        <div class="card-header"><i class="fas fa-info-circle me-2"></i>Basic Information</div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label">Product Name <span class="required">*</span></label>
                                <input type="text" class="form-control" name="productName" value="${product.productName}" required>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Category <span class="required">*</span></label>
                                    <select class="form-select" name="categoryId" id="categorySelect">
                                        <option value="">Select Category</option>
                                        <c:forEach items="${categories}" var="cat">
                                            <option value="${cat.id}" ${product.category.id == cat.id ? 'selected' : ''}>${cat.displayName}</option>
                                        </c:forEach>
                                        <option value="0">+ Add New Category</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3" id="customCategoryDiv" style="display: none;">
                                    <label class="form-label">New Category Name</label>
                                    <input type="text" class="form-control" name="customCategory" id="customCategory">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Brand</label>
                                    <input type="text" class="form-control" name="brand" value="${product.brand}">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Short Description</label>
                                <input type="text" class="form-control" name="shortDescription" value="${product.shortDescription}" maxlength="200">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Full Description</label>
                                <textarea class="form-control" name="description" rows="5">${product.description}</textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Pricing -->
                    <div class="card">
                        <div class="card-header"><i class="fas fa-rupee-sign me-2"></i>Pricing</div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Selling Price <span class="required">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">₹</span>
                                        <input type="number" class="form-control" name="price" step="0.01" value="${product.price}" required>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">MRP</label>
                                    <div class="input-group">
                                        <span class="input-group-text">₹</span>
                                        <input type="number" class="form-control" name="mrp" step="0.01" value="${product.mrp}">
                                    </div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Offer Badge</label>
                                    <input type="text" class="form-control" name="offerBadge" value="${product.offerBadge}">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Inventory -->
                    <div class="card">
                        <div class="card-header"><i class="fas fa-warehouse me-2"></i>Inventory</div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Stock Quantity <span class="required">*</span></label>
                                    <input type="number" class="form-control" name="stockQuantity" value="${product.stockQuantity}" required>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Low Stock Alert</label>
                                    <input type="number" class="form-control" name="minStockLevel" value="${product.minStockLevel}">
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">SKU</label>
                                    <input type="text" class="form-control" value="${product.sku}" readonly>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product Details -->
                    <div class="card">
                        <div class="card-header"><i class="fas fa-list-alt me-2"></i>Product Details</div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Weight/Size</label>
                                    <input type="text" class="form-control" name="weight" value="${product.weight}">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Manufacturer</label>
                                    <input type="text" class="form-control" name="manufacturer" value="${product.manufacturer}">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Ingredients</label>
                                <textarea class="form-control" name="ingredients" rows="3">${product.ingredients}</textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Benefits</label>
                                <textarea class="form-control" name="benefits" rows="3">${product.benefits}</textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Usage Instructions</label>
                                <textarea class="form-control" name="usageInstructions" rows="3">${product.usageInstructions}</textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tags</label>
                                <input type="text" class="form-control" name="tags" value="${product.tags}">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="col-lg-4">
                    <!-- Product Images -->
                    <div class="card">
                        <div class="card-header"><i class="fas fa-images me-2"></i>Product Images</div>
                        <div class="card-body">
                            <c:if test="${not empty productImages}">
                                <div class="product-image-grid mb-3">
                                    <c:forEach items="${productImages}" var="img">
                                        <div class="product-image-item">
                                            <img src="${img.imageUrl.startsWith('http') ? img.imageUrl : pageContext.request.contextPath.concat(img.imageUrl)}" alt="Product Image">
                                            <c:if test="${img.isFeatured}">
                                                <span class="featured-badge">Main</span>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                            <c:if test="${not empty product.imageUrl}">
                                <div class="text-center mb-3">
                                    <img src="${product.imageUrl.startsWith('http') ? product.imageUrl : pageContext.request.contextPath.concat(product.imageUrl)}" alt="${product.productName}" class="img-fluid rounded" style="max-height: 200px;">
                                </div>
                            </c:if>
                            <form action="${pageContext.request.contextPath}/vendor/products/upload-image/${product.id}" method="post" enctype="multipart/form-data">
                                <div class="image-upload-area mb-2" onclick="document.getElementById('newImage').click()">
                                    <i class="fas fa-plus fa-2x text-muted mb-2"></i>
                                    <p class="mb-0 small">Add Image</p>
                                </div>
                                <input type="file" id="newImage" name="image" accept="image/*" class="d-none" onchange="this.form.submit()">
                            </form>
                        </div>
                    </div>

                    <!-- Status -->
                    <div class="card">
                        <div class="card-header"><i class="fas fa-toggle-on me-2"></i>Status</div>
                        <div class="card-body">
                            <div class="form-check form-switch mb-3">
                                <input class="form-check-input" type="checkbox" name="isActive" id="isActive" ${product.isActive ? 'checked' : ''}>
                                <label class="form-check-label" for="isActive">Active</label>
                            </div>
                            <div class="form-check form-switch mb-3">
                                <input class="form-check-input" type="checkbox" name="isFeatured" id="isFeatured" ${product.isFeatured ? 'checked' : ''}>
                                <label class="form-check-label" for="isFeatured">Featured</label>
                            </div>
                        </div>
                    </div>

                    <!-- Stats -->
                    <div class="card">
                        <div class="card-header"><i class="fas fa-chart-bar me-2"></i>Statistics</div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Views</span>
                                <strong>${product.totalViews}</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Sales</span>
                                <strong>${product.totalSales}</strong>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Rating</span>
                                <strong><i class="fas fa-star text-warning"></i> ${product.averageRating} (${product.totalReviews})</strong>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span class="text-muted">Created</span>
                                <strong><fmt:formatDate value="${product.createdAt}" pattern="dd MMM yyyy"/></strong>
                            </div>
                        </div>
                    </div>

                    <!-- Submit -->
                    <div class="card">
                        <div class="card-body">
                            <button type="submit" class="btn btn-primary w-100 mb-2">
                                <i class="fas fa-save me-2"></i>Update Product
                            </button>
                            <a href="${pageContext.request.contextPath}/vendor/products" class="btn btn-outline-secondary w-100">Cancel</a>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('categorySelect').addEventListener('change', function() {
            const customDiv = document.getElementById('customCategoryDiv');
            customDiv.style.display = this.value === '0' ? 'block' : 'none';
        });
    </script>
</body>
</html>

