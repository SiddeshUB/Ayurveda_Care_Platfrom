<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - AyurVeda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #2d5a27; --primary-dark: #1e3d1a; --accent: #8b4513; --gold: #d4a84b; --cream: #faf8f5; }
        body { font-family: 'Poppins', sans-serif; background: var(--cream); }
        h1, h2, h3, h4, h5 { font-family: 'Playfair Display', serif; }
        
        .navbar { background: white; box-shadow: 0 2px 20px rgba(0,0,0,0.08); padding: 15px 0; }
        .navbar-brand { font-family: 'Playfair Display', serif; font-weight: 700; font-size: 1.5rem; color: var(--primary) !important; }
        
        .page-header { background: linear-gradient(135deg, var(--primary), var(--primary-dark)); color: white; padding: 40px 0; text-align: center; }
        
        .order-card { background: white; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-bottom: 20px; overflow: hidden; }
        .order-header { background: var(--cream); padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; }
        .order-id { font-weight: 600; color: var(--primary); }
        .order-date { color: #888; font-size: 0.9rem; }
        
        .order-status { padding: 5px 15px; border-radius: 20px; font-size: 0.85rem; font-weight: 500; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-confirmed { background: #cce5ff; color: #004085; }
        .status-shipped { background: #d4edda; color: #155724; }
        .status-delivered { background: #28a745; color: white; }
        .status-cancelled { background: #f8d7da; color: #721c24; }
        
        .order-items { padding: 20px; }
        .order-item { display: flex; align-items: center; margin-bottom: 15px; }
        .order-item:last-child { margin-bottom: 0; }
        .order-item img { width: 60px; height: 60px; border-radius: 8px; object-fit: cover; margin-right: 15px; }
        .order-item-info { flex: 1; }
        .order-item-name { font-weight: 500; }
        .order-item-qty { color: #888; font-size: 0.9rem; }
        .order-item-price { font-weight: 600; color: var(--primary); }
        
        .order-footer { border-top: 1px solid #eee; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
        .order-total { font-size: 1.2rem; font-weight: 700; color: var(--primary); }
        
        .btn-view-order { background: var(--primary); color: white; border: none; padding: 8px 20px; border-radius: 20px; }
        .btn-view-order:hover { background: var(--primary-dark); color: white; }
        
        .empty-orders { text-align: center; padding: 60px 20px; background: white; border-radius: 15px; }
        .empty-orders i { font-size: 5rem; color: #ddd; margin-bottom: 20px; }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="fas fa-leaf me-2"></i>AyurVeda</a>
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/user/dashboard/cart" class="btn btn-link text-dark"><i class="fas fa-shopping-cart fa-lg"></i></a>
                <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-link text-dark"><i class="fas fa-user fa-lg"></i></a>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-shopping-bag me-3"></i>My Orders</h1>
        </div>
    </div>

    <!-- Orders Content -->
    <section class="py-5">
        <div class="container">
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>

            <c:choose>
                <c:when test="${not empty orders}">
                    <c:forEach items="${orders}" var="order">
                        <div class="order-card">
                            <div class="order-header">
                                <div>
                                    <span class="order-id">Order #${order.orderNumber}</span>
                                    <span class="order-date ms-3">
                                        <c:if test="${order.createdAt != null}">
                                            ${order.createdAt.dayOfMonth} ${order.createdAt.month.toString().substring(0,3)} ${order.createdAt.year}, ${order.createdAt.hour}:${order.createdAt.minute < 10 ? '0' : ''}${order.createdAt.minute}
                                        </c:if>
                                    </span>
                                </div>
                                <span class="order-status 
                                    ${order.status == 'PENDING' ? 'status-pending' : ''}
                                    ${order.status == 'CONFIRMED' ? 'status-confirmed' : ''}
                                    ${order.status == 'SHIPPED' ? 'status-shipped' : ''}
                                    ${order.status == 'DELIVERED' ? 'status-delivered' : ''}
                                    ${order.status == 'CANCELLED' ? 'status-cancelled' : ''}">
                                    ${order.status != null ? order.status.displayName : 'Unknown'}
                                </span>
                            </div>
                            
                            <div class="order-items">
                                <c:forEach items="${order.orderItems}" var="item" end="2">
                                    <div class="order-item">
                                        <img src="${not empty item.productImageUrl ? item.productImageUrl : pageContext.request.contextPath.concat('/images/no-product.png')}" alt="${item.productName}">
                                        <div class="order-item-info">
                                            <div class="order-item-name">${item.productName}</div>
                                            <div class="order-item-qty">Qty: ${item.quantity}</div>
                                        </div>
                                        <div class="order-item-price">₹<fmt:formatNumber value="${item.totalPrice}"/></div>
                                    </div>
                                </c:forEach>
                                <c:if test="${order.orderItems.size() > 3}">
                                    <div class="text-muted mt-2">+${order.orderItems.size() - 3} more item(s)</div>
                                </c:if>
                            </div>
                            
                            <div class="order-footer">
                                <div class="order-total">
                                    Total: ₹<fmt:formatNumber value="${order.totalAmount}"/>
                                </div>
                                <div>
                                    <a href="${pageContext.request.contextPath}/user/dashboard/orders/${order.id}" class="btn btn-view-order">
                                        View Details <i class="fas fa-arrow-right ms-2"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-orders">
                        <i class="fas fa-shopping-bag"></i>
                        <h4>No Orders Yet</h4>
                        <p class="text-muted mb-4">You haven't placed any orders yet</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-view-order">
                            <i class="fas fa-shopping-cart me-2"></i>Start Shopping
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
