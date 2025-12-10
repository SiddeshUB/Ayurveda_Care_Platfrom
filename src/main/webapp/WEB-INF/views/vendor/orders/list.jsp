<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders - Vendor Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root { --primary: #2d5a27; --sidebar-bg: #1a1a2e; --sidebar-hover: #16213e; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f6fa; }
        .sidebar { position: fixed; top: 0; left: 0; height: 100vh; width: 260px; background: var(--sidebar-bg); z-index: 1000; }
        .sidebar-brand { padding: 20px; background: rgba(0,0,0,0.2); text-align: center; }
        .sidebar-brand h4 { color: white; margin: 0; }
        .sidebar-brand small { color: rgba(255,255,255,0.6); }
        .sidebar-menu { padding: 20px 0; }
        .sidebar-menu a { display: flex; align-items: center; padding: 12px 25px; color: rgba(255,255,255,0.7); text-decoration: none; border-left: 3px solid transparent; }
        .sidebar-menu a:hover, .sidebar-menu a.active { background: var(--sidebar-hover); color: white; border-left-color: var(--primary); }
        .sidebar-menu a i { width: 35px; }
        .sidebar-menu .menu-label { padding: 15px 25px 5px; color: rgba(255,255,255,0.4); font-size: 0.75rem; text-transform: uppercase; }
        .main-content { margin-left: 260px; padding: 20px; min-height: 100vh; }
        .top-navbar { background: white; padding: 15px 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 25px; }
        .card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        .card-header { background: white; border-bottom: 1px solid #eee; padding: 20px; font-weight: 600; }
        .status-badge { padding: 6px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 500; }
        .product-mini { display: flex; align-items: center; }
        .product-mini img { width: 40px; height: 40px; object-fit: cover; border-radius: 5px; margin-right: 10px; }
        .order-card { background: white; border-radius: 10px; padding: 20px; margin-bottom: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
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
            <a href="${pageContext.request.contextPath}/vendor/products/add"><i class="fas fa-plus-circle"></i>Add Product</a>
            <div class="menu-label">Sales</div>
            <a href="${pageContext.request.contextPath}/vendor/orders" class="active"><i class="fas fa-shopping-cart"></i>Orders</a>
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
            <h5 class="mb-0">My Orders</h5>
            <small class="text-muted">Manage orders for your products</small>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>

        <!-- Filter Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link active" href="?status=all">All</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="?status=PENDING">Pending</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="?status=CONFIRMED">Confirmed</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="?status=PACKED">Packed</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="?status=SHIPPED">Shipped</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="?status=DELIVERED">Delivered</a>
            </li>
        </ul>

        <c:choose>
            <c:when test="${not empty orderItems.content}">
                <c:forEach items="${orderItems.content}" var="item">
                    <div class="order-card">
                        <div class="row align-items-center">
                            <div class="col-md-3">
                                <div class="product-mini">
                                    <img src="${not empty item.productImageUrl ? item.productImageUrl : '/images/no-image.png'}" alt="${item.productName}">
                                    <div>
                                        <strong>${item.productName}</strong>
                                        <br><small class="text-muted">Qty: ${item.quantity}</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <small class="text-muted">Order #</small>
                                <br><strong>${item.order.orderNumber}</strong>
                            </div>
                            <div class="col-md-2">
                                <small class="text-muted">Amount</small>
                                <br><strong>₹<fmt:formatNumber value="${item.totalPrice}"/></strong>
                                <br><small class="text-success">You earn: ₹<fmt:formatNumber value="${item.vendorEarning}"/></small>
                            </div>
                            <div class="col-md-2">
                                <small class="text-muted">Customer</small>
                                <br><strong>${item.order.shippingName}</strong>
                                <br><small>${item.order.shippingCity}</small>
                            </div>
                            <div class="col-md-1">
                                <span class="status-badge 
                                    ${item.status == 'PENDING' ? 'bg-warning' : ''}
                                    ${item.status == 'CONFIRMED' ? 'bg-info text-white' : ''}
                                    ${item.status == 'PACKED' ? 'bg-primary text-white' : ''}
                                    ${item.status == 'SHIPPED' ? 'bg-info text-white' : ''}
                                    ${item.status == 'DELIVERED' ? 'bg-success text-white' : ''}
                                    ${item.status == 'CANCELLED' ? 'bg-danger text-white' : ''}">
                                    ${item.status.displayName}
                                </span>
                            </div>
                            <div class="col-md-2 text-end">
                                <c:if test="${item.status != 'DELIVERED' && item.status != 'CANCELLED'}">
                                    <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#updateModal${item.id}">
                                        <i class="fas fa-edit me-1"></i>Update
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Update Status Modal -->
                    <div class="modal fade" id="updateModal${item.id}" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Update Order Status</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <form action="${pageContext.request.contextPath}/vendor/orders/update-status/${item.id}" method="post">
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label class="form-label">Status</label>
                                            <select class="form-select" name="status" required>
                                                <option value="CONFIRMED" ${item.status == 'PENDING' ? 'selected' : ''}>Confirmed</option>
                                                <option value="PACKED" ${item.status == 'CONFIRMED' ? 'selected' : ''}>Packed</option>
                                                <option value="SHIPPED" ${item.status == 'PACKED' ? 'selected' : ''}>Shipped</option>
                                                <option value="DELIVERED" ${item.status == 'SHIPPED' ? 'selected' : ''}>Delivered</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Tracking Number (Optional)</label>
                                            <input type="text" class="form-control" name="trackingNumber" value="${item.trackingNumber}" placeholder="Enter tracking number">
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn btn-primary">Update Status</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <!-- Pagination -->
                <c:if test="${orderItems.totalPages > 1}">
                    <nav class="mt-4">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${orderItems.first ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${orderItems.number - 1}">Previous</a>
                            </li>
                            <c:forEach begin="0" end="${orderItems.totalPages - 1}" var="i">
                                <li class="page-item ${orderItems.number == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}">${i + 1}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${orderItems.last ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${orderItems.number + 1}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="card">
                    <div class="card-body text-center py-5">
                        <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
                        <h5>No Orders Yet</h5>
                        <p class="text-muted">Orders for your products will appear here</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

