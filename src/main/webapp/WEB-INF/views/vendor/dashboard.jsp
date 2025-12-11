<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Dashboard - ${vendor.storeDisplayName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #2d5a27;
            --primary-dark: #1e3d1a;
            --accent: #8b4513;
            --sidebar-bg: #1a1a2e;
            --sidebar-hover: #16213e;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f6fa;
        }
        
        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 260px;
            background: var(--sidebar-bg);
            padding-top: 0;
            z-index: 1000;
            transition: all 0.3s ease;
        }
        
        .sidebar-brand {
            padding: 20px;
            background: rgba(0,0,0,0.2);
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .sidebar-brand h4 {
            color: white;
            margin: 0;
            font-weight: 600;
        }
        
        .sidebar-brand small {
            color: rgba(255,255,255,0.6);
        }
        
        .sidebar-menu {
            padding: 20px 0;
        }
        
        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 12px 25px;
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }
        
        .sidebar-menu a:hover, .sidebar-menu a.active {
            background: var(--sidebar-hover);
            color: white;
            border-left-color: var(--primary);
        }
        
        .sidebar-menu a i {
            width: 35px;
            font-size: 1.1rem;
        }
        
        .sidebar-menu .menu-label {
            padding: 15px 25px 5px;
            color: rgba(255,255,255,0.4);
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        /* Main Content */
        .main-content {
            margin-left: 260px;
            padding: 20px;
            min-height: 100vh;
        }
        
        /* Top Navbar */
        .top-navbar {
            background: white;
            padding: 15px 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .top-navbar h5 {
            margin: 0;
            color: #333;
        }
        
        /* Stats Cards */
        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            height: 100%;
            transition: transform 0.3s ease;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
        }
        
        .stats-card .icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
        }
        
        .stats-card .icon.bg-primary { background: linear-gradient(135deg, #667eea, #764ba2); }
        .stats-card .icon.bg-success { background: linear-gradient(135deg, #11998e, #38ef7d); }
        .stats-card .icon.bg-warning { background: linear-gradient(135deg, #f093fb, #f5576c); }
        .stats-card .icon.bg-info { background: linear-gradient(135deg, #4facfe, #00f2fe); }
        
        .stats-card h3 {
            font-size: 2rem;
            font-weight: 700;
            margin: 15px 0 5px;
        }
        
        .stats-card p {
            color: #888;
            margin: 0;
        }
        
        /* Cards */
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }
        
        .card-header {
            background: white;
            border-bottom: 1px solid #eee;
            padding: 20px;
            font-weight: 600;
        }
        
        .table {
            margin: 0;
        }
        
        .table th {
            border-top: none;
            color: #888;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
        }
        
        .badge-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.8rem;
        }
        
        /* Alert Cards */
        .alert-card {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        
        .alert-card.danger {
            background: #f8d7da;
            border-left-color: #dc3545;
        }
        
        /* Quick Actions */
        .quick-action {
            background: white;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
            display: block;
        }
        
        .quick-action:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-3px);
        }
        
        .quick-action i {
            font-size: 2rem;
            margin-bottom: 10px;
        }
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
            <a href="${pageContext.request.contextPath}/">
                <i class="fas fa-home"></i>Home
            </a>
            <a href="${pageContext.request.contextPath}/vendor/dashboard" class="active">
                <i class="fas fa-tachometer-alt"></i>Dashboard
            </a>
            
            <div class="menu-label">Products</div>
            <a href="${pageContext.request.contextPath}/vendor/products">
                <i class="fas fa-box"></i>All Products
            </a>
            <a href="${pageContext.request.contextPath}/vendor/products/add">
                <i class="fas fa-plus-circle"></i>Add Product
            </a>
            
            <div class="menu-label">Sales</div>
            <a href="${pageContext.request.contextPath}/vendor/orders">
                <i class="fas fa-shopping-cart"></i>Orders
            </a>
            <a href="${pageContext.request.contextPath}/vendor/reviews">
                <i class="fas fa-star"></i>Reviews
            </a>
            
            <div class="menu-label">Finance</div>
            <a href="${pageContext.request.contextPath}/vendor/wallet">
                <i class="fas fa-wallet"></i>Wallet
            </a>
            
            <div class="menu-label">Settings</div>
            <a href="${pageContext.request.contextPath}/vendor/profile">
                <i class="fas fa-user-cog"></i>Profile
            </a>
            <a href="${pageContext.request.contextPath}/vendor/logout" class="text-danger">
                <i class="fas fa-sign-out-alt"></i>Logout
            </a>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <div class="top-navbar">
            <div>
                <h5>Welcome back, ${vendor.ownerFullName}!</h5>
                <small class="text-muted">Here's what's happening with your store today.</small>
            </div>
            <div class="dropdown">
                <button class="btn btn-outline-secondary dropdown-toggle" data-bs-toggle="dropdown">
                    <i class="fas fa-user-circle me-2"></i>${vendor.storeDisplayName}
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/vendor/profile"><i class="fas fa-user me-2"></i>Profile</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/vendor/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                </ul>
            </div>
        </div>
        
        <!-- Alerts -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <!-- Stats Cards -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="icon bg-primary">
                        <i class="fas fa-box"></i>
                    </div>
                    <h3>${totalProducts}</h3>
                    <p>Total Products</p>
                    <small class="text-success"><i class="fas fa-circle me-1"></i>${activeProducts} Active</small>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="icon bg-success">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    <h3>${totalOrders}</h3>
                    <p>Total Orders</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="icon bg-warning">
                        <i class="fas fa-rupee-sign"></i>
                    </div>
                    <h3><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₹"/></h3>
                    <p>Total Revenue</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="icon bg-info">
                        <i class="fas fa-wallet"></i>
                    </div>
                    <h3><fmt:formatNumber value="${wallet.availableBalance}" type="currency" currencySymbol="₹"/></h3>
                    <p>Available Balance</p>
                    <small class="text-muted">Pending: ₹<fmt:formatNumber value="${wallet.pendingBalance}"/></small>
                </div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <a href="${pageContext.request.contextPath}/vendor/products/add" class="quick-action">
                    <i class="fas fa-plus-circle"></i>
                    <p class="mb-0">Add New Product</p>
                </a>
            </div>
            <div class="col-md-3 mb-3">
                <a href="${pageContext.request.contextPath}/vendor/orders" class="quick-action">
                    <i class="fas fa-truck"></i>
                    <p class="mb-0">Process Orders</p>
                </a>
            </div>
            <div class="col-md-3 mb-3">
                <a href="${pageContext.request.contextPath}/vendor/wallet" class="quick-action">
                    <i class="fas fa-money-bill-wave"></i>
                    <p class="mb-0">View Earnings</p>
                </a>
            </div>
            <div class="col-md-3 mb-3">
                <a href="${pageContext.request.contextPath}/vendor/profile" class="quick-action">
                    <i class="fas fa-cog"></i>
                    <p class="mb-0">Store Settings</p>
                </a>
            </div>
        </div>
        
        <div class="row">
            <!-- Low Stock Alerts -->
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-exclamation-triangle text-warning me-2"></i>Low Stock Alerts</span>
                        <a href="${pageContext.request.contextPath}/vendor/products" class="btn btn-sm btn-outline-primary">View All</a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty lowStockProducts}">
                                <c:forEach items="${lowStockProducts}" var="product" varStatus="status">
                                    <c:if test="${status.index < 5}">
                                        <div class="alert-card ${product.stockQuantity == 0 ? 'danger' : ''}">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <strong>${product.productName}</strong>
                                                    <br>
                                                    <small class="text-muted">SKU: ${product.sku}</small>
                                                </div>
                                                <div class="text-end">
                                                    <span class="badge ${product.stockQuantity == 0 ? 'bg-danger' : 'bg-warning'}">
                                                        ${product.stockQuantity} left
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center text-muted py-4">
                                    <i class="fas fa-check-circle fa-3x mb-3"></i>
                                    <p>All products have adequate stock!</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <!-- Recent Orders -->
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-shopping-cart text-primary me-2"></i>Recent Orders</span>
                        <a href="${pageContext.request.contextPath}/vendor/orders" class="btn btn-sm btn-outline-primary">View All</a>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty recentOrders}">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th>Order</th>
                                                <th>Product</th>
                                                <th>Status</th>
                                                <th>Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recentOrders}" var="item" varStatus="status">
                                                <c:if test="${status.index < 5}">
                                                    <tr>
                                                        <td><small>#${item.order.orderNumber}</small></td>
                                                        <td>${item.productName}</td>
                                                        <td>
                                                            <span class="badge-status 
                                                                ${item.status == 'DELIVERED' ? 'bg-success' : ''}
                                                                ${item.status == 'PENDING' ? 'bg-warning' : ''}
                                                                ${item.status == 'SHIPPED' ? 'bg-info' : ''}
                                                                ${item.status == 'CANCELLED' ? 'bg-danger' : ''}
                                                            ">
                                                                ${item.status.displayName}
                                                            </span>
                                                        </td>
                                                        <td>₹<fmt:formatNumber value="${item.totalPrice}"/></td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center text-muted py-4">
                                    <i class="fas fa-inbox fa-3x mb-3"></i>
                                    <p>No orders yet</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Commission Info -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h5><i class="fas fa-info-circle text-info me-2"></i>Commission Information</h5>
                        <p class="mb-0 text-muted">
                            Your current commission rate is <strong>${vendor.commissionPercentage}%</strong>. 
                            This is deducted from each sale. Payments are processed <strong>${vendor.paymentCycle.displayName}</strong>.
                            Minimum payout threshold: <strong>₹${vendor.minPayoutThreshold}</strong>
                        </p>
                    </div>
                    <div class="col-md-4 text-end">
                        <h3 class="text-primary mb-0">${vendor.commissionPercentage}%</h3>
                        <small class="text-muted">Commission Rate</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

