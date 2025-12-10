<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product - Vendor Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root { --primary: #2d5a27; --sidebar-bg: #1a1a2e; --sidebar-hover: #16213e; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f6fa; }
        .sidebar { position: fixed; top: 0; left: 0; height: 100vh; width: 260px; background: var(--sidebar-bg); z-index: 1000; }
        .sidebar-brand { padding: 20px; background: rgba(0,0,0,0.2); text-align: center; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .sidebar-brand h4 { color: white; margin: 0; font-weight: 600; }
        .sidebar-brand small { color: rgba(255,255,255,0.6); }
        .sidebar-menu { padding: 20px 0; }
        .sidebar-menu a { display: flex; align-items: center; padding: 12px 25px; color: rgba(255,255,255,0.7); text-decoration: none; transition: all 0.3s ease; border-left: 3px solid transparent; }
        .sidebar-menu a:hover, .sidebar-menu a.active { background: var(--sidebar-hover); color: white; border-left-color: var(--primary); }
        .sidebar-menu a i { width: 35px; font-size: 1.1rem; }
        .sidebar-menu .menu-label { padding: 15px 25px 5px; color: rgba(255,255,255,0.4); font-size: 0.75rem; text-transform: uppercase; }
        .main-content { margin-left: 260px; padding: 20px; min-height: 100vh; }
        .top-navbar { background: white; padding: 15px 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .card-header { background: white; border-bottom: 1px solid #eee; padding: 20px; font-weight: 600; border-radius: 15px 15px 0 0 !important; }
        .form-label { font-weight: 500; color: #333; }
        .form-control, .form-select { border-radius: 8px; border: 2px solid #e0e0e0; padding: 10px 15px; }
        .form-control:focus, .form-select:focus { border-color: var(--primary); box-shadow: 0 0 0 0.2rem rgba(45, 90, 39, 0.15); }
        .section-title { color: var(--primary); font-weight: 600; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid var(--primary); }
        .image-upload-area { border: 2px dashed #ddd; border-radius: 10px; padding: 40px; text-align: center; cursor: pointer; transition: all 0.3s ease; }
        .image-upload-area:hover { border-color: var(--primary); background: #f8fff8; }
        .image-upload-area i { font-size: 3rem; color: #ccc; margin-bottom: 15px; }
        .required { color: red; }
        #customCategoryDiv { display: none; }
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
            <a href="${pageContext.request.contextPath}/vendor/products"><i class="fas fa-box"></i>All Products</a>
            <a href="${pageContext.request.contextPath}/vendor/products/add" class="active"><i class="fas fa-plus-circle"></i>Add Product</a>
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
                <h5 class="mb-0">Add New Product</h5>
                <small class="text-muted">Fill in the details to add a new product</small>
            </div>
            <a href="${pageContext.request.contextPath}/vendor/products" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to Products
            </a>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/vendor/products/add" method="post" enctype="multipart/form-data">
            <div class="row">
                <!-- Left Column -->
                <div class="col-lg-8">
                    <!-- Basic Information -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-info-circle me-2"></i>Basic Information
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label">Product Name <span class="required">*</span></label>
                                <input type="text" class="form-control" name="productName" required placeholder="Enter product name">
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Category <span class="required">*</span></label>
                                    <select class="form-select" name="categoryId" id="categorySelect" required>
                                        <option value="">Select Category</option>
                                        <c:forEach items="${categories}" var="cat">
                                            <option value="${cat.id}">${cat.displayName}</option>
                                        </c:forEach>
                                        <option value="0">+ Add New Category (Other)</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3" id="customCategoryDiv">
                                    <label class="form-label">New Category Name <span class="required">*</span></label>
                                    <input type="text" class="form-control" name="customCategory" id="customCategory" placeholder="Enter new category name">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Brand</label>
                                    <input type="text" class="form-control" name="brand" placeholder="Brand name">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Short Description</label>
                                <input type="text" class="form-control" name="shortDescription" maxlength="200" placeholder="Brief description (max 200 chars)">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Full Description</label>
                                <textarea class="form-control" name="description" rows="5" placeholder="Detailed product description..."></textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Pricing -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-rupee-sign me-2"></i>Pricing
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Selling Price <span class="required">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">₹</span>
                                        <input type="number" class="form-control" name="price" step="0.01" min="0" required placeholder="0.00">
                                    </div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">MRP (Original Price)</label>
                                    <div class="input-group">
                                        <span class="input-group-text">₹</span>
                                        <input type="number" class="form-control" name="mrp" step="0.01" min="0" placeholder="0.00">
                                    </div>
                                    <small class="text-muted">Leave blank if same as selling price</small>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Offer Badge</label>
                                    <input type="text" class="form-control" name="offerBadge" placeholder="e.g., 20% OFF, SALE">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Inventory -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-warehouse me-2"></i>Inventory
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Stock Quantity <span class="required">*</span></label>
                                    <input type="number" class="form-control" name="stockQuantity" min="0" required placeholder="0">
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Low Stock Alert Level</label>
                                    <input type="number" class="form-control" name="minStockLevel" min="0" value="5" placeholder="5">
                                    <small class="text-muted">Alert when stock falls below this</small>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">SKU (Product Code)</label>
                                    <input type="text" class="form-control" name="sku" placeholder="Auto-generated if empty">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product Details -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-list-alt me-2"></i>Product Details
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Weight/Size</label>
                                    <input type="text" class="form-control" name="weight" placeholder="e.g., 100ml, 500g, 60 tablets">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Manufacturer</label>
                                    <input type="text" class="form-control" name="manufacturer" placeholder="Manufacturer name">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Ingredients</label>
                                <textarea class="form-control" name="ingredients" rows="3" placeholder="List of ingredients (for medicines/supplements)"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Benefits</label>
                                <textarea class="form-control" name="benefits" rows="3" placeholder="Health benefits of the product"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Usage Instructions</label>
                                <textarea class="form-control" name="usageInstructions" rows="3" placeholder="How to use this product"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tags (for search)</label>
                                <input type="text" class="form-control" name="tags" placeholder="Comma-separated tags, e.g., ayurvedic, herbal, immunity">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="col-lg-4">
                    <!-- Product Image -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-image me-2"></i>Product Image
                        </div>
                        <div class="card-body">
                            <div class="image-upload-area" onclick="document.getElementById('productImage').click()">
                                <i class="fas fa-cloud-upload-alt"></i>
                                <p class="mb-0">Click to upload image</p>
                                <small class="text-muted">JPG, PNG up to 5MB</small>
                            </div>
                            <input type="file" id="productImage" name="image" accept="image/*" class="d-none" onchange="previewImage(this)">
                            <div id="imagePreview" class="mt-3 text-center" style="display: none;">
                                <img id="preview" src="" alt="Preview" class="img-fluid rounded" style="max-height: 200px;">
                                <br>
                                <button type="button" class="btn btn-sm btn-outline-danger mt-2" onclick="clearImage()">
                                    <i class="fas fa-times me-1"></i>Remove
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Status -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-toggle-on me-2"></i>Status & Visibility
                        </div>
                        <div class="card-body">
                            <div class="form-check form-switch mb-3">
                                <input class="form-check-input" type="checkbox" name="isActive" id="isActive" checked>
                                <label class="form-check-label" for="isActive">Active (Visible on store)</label>
                            </div>
                            <div class="form-check form-switch mb-3">
                                <input class="form-check-input" type="checkbox" name="isFeatured" id="isFeatured">
                                <label class="form-check-label" for="isFeatured">Featured Product</label>
                            </div>
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" name="trackInventory" id="trackInventory" checked>
                                <label class="form-check-label" for="trackInventory">Track Inventory</label>
                            </div>
                        </div>
                    </div>

                    <!-- Submit -->
                    <div class="card">
                        <div class="card-body">
                            <button type="submit" class="btn btn-primary w-100 mb-2">
                                <i class="fas fa-save me-2"></i>Save Product
                            </button>
                            <a href="${pageContext.request.contextPath}/vendor/products" class="btn btn-outline-secondary w-100">
                                Cancel
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Show custom category input when "Other" is selected
        document.getElementById('categorySelect').addEventListener('change', function() {
            const customDiv = document.getElementById('customCategoryDiv');
            const customInput = document.getElementById('customCategory');
            if (this.value === '0') {
                customDiv.style.display = 'block';
                customInput.required = true;
            } else {
                customDiv.style.display = 'none';
                customInput.required = false;
                customInput.value = '';
            }
        });

        // Image preview
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('preview').src = e.target.result;
                    document.getElementById('imagePreview').style.display = 'block';
                    document.querySelector('.image-upload-area').style.display = 'none';
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function clearImage() {
            document.getElementById('productImage').value = '';
            document.getElementById('imagePreview').style.display = 'none';
            document.querySelector('.image-upload-area').style.display = 'block';
        }
    </script>
</body>
</html>

