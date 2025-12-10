<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Products - Vendor Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #2d5a27;
            --sidebar-bg: #1a1a2e;
            --sidebar-hover: #16213e;
        }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f6fa; }
        .sidebar { position: fixed; top: 0; left: 0; height: 100vh; width: 260px; background: var(--sidebar-bg); z-index: 1000; }
        .sidebar-brand { padding: 20px; background: rgba(0,0,0,0.2); text-align: center; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .sidebar-brand h4 { color: white; margin: 0; font-weight: 600; }
        .sidebar-brand small { color: rgba(255,255,255,0.6); }
        .sidebar-menu { padding: 20px 0; }
        .sidebar-menu a { display: flex; align-items: center; padding: 12px 25px; color: rgba(255,255,255,0.7); text-decoration: none; transition: all 0.3s ease; border-left: 3px solid transparent; }
        .sidebar-menu a:hover, .sidebar-menu a.active { background: var(--sidebar-hover); color: white; border-left-color: var(--primary); }
        .sidebar-menu a i { width: 35px; font-size: 1.1rem; }
        .sidebar-menu .menu-label { padding: 15px 25px 5px; color: rgba(255,255,255,0.4); font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; }
        .main-content { margin-left: 260px; padding: 20px; min-height: 100vh; }
        .top-navbar { background: white; padding: 15px 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 25px; display: flex; justify-content: space-between; align-items: center; }
        .card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        .card-header { background: white; border-bottom: 1px solid #eee; padding: 20px; font-weight: 600; border-radius: 15px 15px 0 0 !important; }
        .product-img { width: 60px; height: 60px; object-fit: cover; border-radius: 8px; }
        .badge-stock { padding: 5px 10px; border-radius: 15px; font-size: 0.75rem; }
        .badge-low { background: #fff3cd; color: #856404; }
        .badge-out { background: #f8d7da; color: #721c24; }
        .badge-ok { background: #d4edda; color: #155724; }
        .btn-action { padding: 5px 10px; font-size: 0.85rem; }
        .status-badge { padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 500; }
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
        <div class="top-navbar">
            <div>
                <h5 class="mb-0">My Products</h5>
                <small class="text-muted">Manage your product catalog</small>
            </div>
            <a href="${pageContext.request.contextPath}/vendor/products/add" class="btn btn-primary">
                <i class="fas fa-plus me-2"></i>Add New Product
            </a>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span><i class="fas fa-box me-2"></i>Product List (${products.totalElements} products)</span>
                <div>
                    <select class="form-select form-select-sm d-inline-block w-auto" id="categoryFilter">
                        <option value="">All Categories</option>
                        <c:forEach items="${categories}" var="cat">
                            <option value="${cat.id}">${cat.displayName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0" id="productsTable">
                        <thead class="table-light">
                            <tr>
                                <th>Product</th>
                                <th>SKU</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Stock</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${products.content}" var="product">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
<<<<<<< HEAD
                                            <c:choose>
                                                <c:when test="${not empty product.imageUrl}">
                                                    <img src="${product.imageUrl.startsWith('http') ? product.imageUrl : pageContext.request.contextPath.concat(product.imageUrl)}" 
                                                         alt="${product.productName}" class="product-img me-3">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/images/no-image.png" 
                                                         alt="${product.productName}" class="product-img me-3">
                                                </c:otherwise>
                                            </c:choose>
=======
                                            <img src="${not empty product.imageUrl ? product.imageUrl : pageContext.request.contextPath.concat('/images/no-image.png')}" 
                                                 alt="${product.productName}" class="product-img me-3">
>>>>>>> edaa4568e405c23538b45d4e9bbc206b39763f74
                                            <div>
                                                <strong>${product.productName}</strong>
                                                <c:if test="${product.isFeatured}">
                                                    <span class="badge bg-warning text-dark ms-1">Featured</span>
                                                </c:if>
                                                <br>
                                                <small class="text-muted">${product.brand}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td><code>${product.sku}</code></td>
                                    <td>${product.category.displayName}</td>
                                    <td>
                                        <strong>₹<fmt:formatNumber value="${product.price}"/></strong>
                                        <c:if test="${product.mrp != null && product.mrp > product.price}">
                                            <br><small class="text-muted text-decoration-line-through">₹<fmt:formatNumber value="${product.mrp}"/></small>
                                            <span class="badge bg-success">${product.discountPercentage}% OFF</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.stockQuantity <= 0}">
                                                <span class="badge-stock badge-out">Out of Stock</span>
                                            </c:when>
                                            <c:when test="${product.stockQuantity <= product.minStockLevel}">
                                                <span class="badge-stock badge-low">${product.stockQuantity} (Low)</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-stock badge-ok">${product.stockQuantity}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.isActive && product.isAvailable}">
                                                <span class="status-badge bg-success text-white">Active</span>
                                            </c:when>
                                            <c:when test="${!product.isActive}">
                                                <span class="status-badge bg-secondary text-white">Inactive</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge bg-warning">Unavailable</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/vendor/products/edit/${product.id}" 
                                               class="btn btn-sm btn-outline-primary btn-action" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <form action="${pageContext.request.contextPath}/vendor/products/toggle-status/${product.id}" 
                                                  method="post" class="d-inline">
                                                <button type="submit" class="btn btn-sm btn-outline-${product.isActive ? 'warning' : 'success'} btn-action" 
                                                        title="${product.isActive ? 'Deactivate' : 'Activate'}">
                                                    <i class="fas fa-${product.isActive ? 'pause' : 'play'}"></i>
                                                </button>
                                            </form>
                                            <button type="button" class="btn btn-sm btn-outline-danger btn-action" 
                                                    onclick="confirmDelete(${product.id}, '${product.productName}')" title="Delete">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <c:if test="${products.totalPages > 1}">
                    <nav class="p-3">
                        <ul class="pagination justify-content-center mb-0">
                            <li class="page-item ${products.first ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${products.number - 1}">Previous</a>
                            </li>
                            <c:forEach begin="0" end="${products.totalPages - 1}" var="i">
                                <li class="page-item ${products.number == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}">${i + 1}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${products.last ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${products.number + 1}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong id="deleteProductName"></strong>?</p>
                    <p class="text-danger small">This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form id="deleteForm" method="post" class="d-inline">
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(productId, productName) {
            document.getElementById('deleteProductName').textContent = productName;
            document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/vendor/products/delete/' + productId;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>

