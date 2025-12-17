<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order #${order.orderNumber} - AyurVeda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #2d5a27; --primary-dark: #1e3d1a; --cream: #faf8f5; }
        body { font-family: 'Poppins', sans-serif; background: var(--cream); }
        h1, h2, h3, h4, h5 { font-family: 'Playfair Display', serif; }
        
        .navbar { background: white; box-shadow: 0 2px 20px rgba(0,0,0,0.08); padding: 15px 0; }
        .navbar-brand { font-family: 'Playfair Display', serif; font-weight: 700; font-size: 1.5rem; color: var(--primary) !important; }
        
        .card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .card-header { background: white; border-bottom: 1px solid #eee; padding: 20px; font-weight: 600; }
        
        .order-status-badge { padding: 8px 20px; border-radius: 20px; font-size: 0.9rem; font-weight: 500; }
        
        .timeline { position: relative; padding-left: 30px; }
        .timeline::before { content: ''; position: absolute; left: 10px; top: 0; bottom: 0; width: 2px; background: #ddd; }
        .timeline-item { position: relative; padding-bottom: 25px; }
        .timeline-item:last-child { padding-bottom: 0; }
        .timeline-item::before { content: ''; position: absolute; left: -24px; top: 5px; width: 12px; height: 12px; border-radius: 50%; background: #ddd; }
        .timeline-item.active::before { background: var(--primary); }
        .timeline-item.done::before { background: #28a745; }
        .timeline-item h6 { margin-bottom: 3px; }
        .timeline-item small { color: #888; }
        
        .order-item { display: flex; align-items: center; padding: 15px 0; border-bottom: 1px solid #eee; }
        .order-item:last-child { border-bottom: none; }
        .order-item img { width: 80px; height: 80px; border-radius: 10px; object-fit: cover; margin-right: 20px; }
        .order-item-info { flex: 1; }
        .order-item-name { font-weight: 600; margin-bottom: 3px; }
        .order-item-vendor { color: #888; font-size: 0.9rem; }
        
        .summary-row { display: flex; justify-content: space-between; padding: 8px 0; }
        .summary-row.total { font-size: 1.2rem; font-weight: 700; border-top: 2px solid #eee; padding-top: 15px; margin-top: 10px; color: var(--primary); }
        
        .address-card { background: var(--cream); border-radius: 10px; padding: 20px; }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="fas fa-leaf me-2"></i>AyurVeda</a>
        </div>
    </nav>

    <!-- Content -->
    <section class="py-5">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <a href="${pageContext.request.contextPath}/user/dashboard/orders" class="text-decoration-none text-muted">
                        <i class="fas fa-arrow-left me-2"></i>Back to Orders
                    </a>
                    <h4 class="mt-2 mb-0">Order #${order.orderNumber}</h4>
                    <small class="text-muted">Placed on 
                        <c:if test="${order.createdAt != null}">
                            <%
                                com.ayurveda.entity.ProductOrder orderHeader = (com.ayurveda.entity.ProductOrder) pageContext.getAttribute("order");
                                if (orderHeader != null && orderHeader.getCreatedAt() != null) {
                                    out.print(orderHeader.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
                                }
                            %>
                        </c:if>
                    </small>
                </div>
                <span class="order-status-badge 
                    ${order.status.name() == 'PENDING' ? 'bg-warning' : ''}
                    ${order.status.name() == 'CONFIRMED' ? 'bg-info text-white' : ''}
                    ${order.status.name() == 'SHIPPED' ? 'bg-primary text-white' : ''}
                    ${order.status.name() == 'DELIVERED' ? 'bg-success text-white' : ''}
                    ${order.status.name() == 'CANCELLED' ? 'bg-danger text-white' : ''}">
                    ${order.status != null ? order.status.displayName : 'Unknown'}
                </span>
            </div>

            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
            </c:if>

            <div class="row">
                <!-- Left Column -->
                <div class="col-lg-8">
                    <!-- Order Items -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-box me-2"></i>Order Items (${order.orderItems.size()})
                        </div>
                        <div class="card-body">
                            <c:forEach items="${order.orderItems}" var="item">
                                <div class="order-item">
                                    <img src="${not empty item.productImageUrl ? item.productImageUrl : pageContext.request.contextPath.concat('/images/no-product.png')}" alt="${item.productName}">
                                    <div class="order-item-info">
                                        <div class="order-item-name">${item.productName}</div>
                                        <div class="order-item-vendor">Sold by: ${item.vendor != null ? item.vendor.storeDisplayName : 'Unknown Seller'}</div>
                                        <div class="text-muted">Qty: ${item.quantity} × ₹<fmt:formatNumber value="${item.unitPrice}"/></div>
                                    </div>
                                    <div class="text-end">
                                        <strong class="text-primary">₹<fmt:formatNumber value="${item.totalPrice}"/></strong>
                                        <br>
                                        <span class="badge ${item.status.name() == 'DELIVERED' ? 'bg-success' : 'bg-secondary'}">${item.status.displayName}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Order Timeline -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-truck me-2"></i>Order Timeline
                        </div>
                        <div class="card-body">
                            <div class="timeline">
                                <%
                                    // Get order object once for use in all scriptlets
                                    com.ayurveda.entity.ProductOrder orderObj = (com.ayurveda.entity.ProductOrder) pageContext.getAttribute("order");
                                    
                                    // Check order status flags
                                    boolean isOrderPending = false;
                                    boolean isOrderCancelled = false;
                                    boolean isOrderShipped = false;
                                    boolean isOrderDelivered = false;
                                    
                                    if (orderObj != null && orderObj.getStatus() != null) {
                                        String statusName = orderObj.getStatus().name();
                                        isOrderPending = "PENDING".equals(statusName);
                                        isOrderCancelled = "CANCELLED".equals(statusName);
                                        isOrderShipped = "SHIPPED".equals(statusName);
                                        isOrderDelivered = "DELIVERED".equals(statusName);
                                    }
                                    
                                    pageContext.setAttribute("isOrderPending", isOrderPending);
                                    pageContext.setAttribute("isOrderCancelled", isOrderCancelled);
                                    pageContext.setAttribute("isOrderShipped", isOrderShipped);
                                    pageContext.setAttribute("isOrderDelivered", isOrderDelivered);
                                %>
                                <c:set var="orderItems" value="${order.orderItems}"/>
                                <c:set var="hasConfirmedItem" value="false"/>
                                <c:set var="hasShippedItem" value="false"/>
                                <c:set var="allItemsDelivered" value="true"/>
                                <c:forEach items="${orderItems}" var="item">
                                    <c:if test="${item.status.name() == 'CONFIRMED' || item.status.name() == 'PACKED'}">
                                        <c:set var="hasConfirmedItem" value="true"/>
                                    </c:if>
                                    <c:if test="${item.status.name() == 'SHIPPED' || item.status.name() == 'DELIVERED'}">
                                        <c:set var="hasShippedItem" value="true"/>
                                    </c:if>
                                    <c:if test="${item.status.name() != 'DELIVERED'}">
                                        <c:set var="allItemsDelivered" value="false"/>
                                    </c:if>
                                </c:forEach>
                                
                                <div class="timeline-item done">
                                    <h6>Order Placed</h6>
                                    <small>
                                        <c:if test="${order.createdAt != null}">
                                            <%
                                                if (orderObj != null && orderObj.getCreatedAt() != null) {
                                                    out.print(orderObj.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
                                                }
                                            %>
                                        </c:if>
                                    </small>
                                </div>
                                
                                <div class="timeline-item ${(!isOrderPending && !isOrderCancelled) || hasConfirmedItem || order.paymentDate != null ? 'done' : ''}">
                                    <h6>Order Confirmed</h6>
                                    <small>
                                        <c:if test="${order.paymentDate != null}">
                                            <%
                                                if (orderObj != null && orderObj.getPaymentDate() != null) {
                                                    out.print(orderObj.getPaymentDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
                                                }
                                            %>
                                        </c:if>
                                    </small>
                                </div>
                                
                                <div class="timeline-item ${isOrderShipped || isOrderDelivered || hasShippedItem || order.shippedDate != null ? 'done' : ''}">
                                    <h6>Shipped</h6>
                                    <small>
                                        <c:if test="${order.shippedDate != null}">
                                            <%
                                                if (orderObj != null && orderObj.getShippedDate() != null) {
                                                    out.print(orderObj.getShippedDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
                                                }
                                            %>
                                        </c:if>
                                    </small>
                                </div>
                                
                                <div class="timeline-item ${isOrderDelivered || allItemsDelivered || order.deliveredDate != null ? 'done' : ''}">
                                    <h6>Delivered</h6>
                                    <small>
                                        <c:if test="${order.deliveredDate != null}">
                                            <%
                                                if (orderObj != null && orderObj.getDeliveredDate() != null) {
                                                    out.print(orderObj.getDeliveredDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
                                                }
                                            %>
                                        </c:if>
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="col-lg-4">
                    <!-- Payment Summary -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-rupee-sign me-2"></i>Payment Summary
                        </div>
                        <div class="card-body">
                            <div class="summary-row">
                                <span>Subtotal</span>
                                <span>₹<fmt:formatNumber value="${order.subtotal}"/></span>
                            </div>
                            <c:if test="${order.discount != null && order.discount > 0}">
                                <div class="summary-row text-success">
                                    <span>Discount</span>
                                    <span>-₹<fmt:formatNumber value="${order.discount}"/></span>
                                </div>
                            </c:if>
                            <div class="summary-row">
                                <span>Shipping</span>
                                <span>₹<fmt:formatNumber value="${order.shippingCharges != null ? order.shippingCharges : 0}"/></span>
                            </div>
                            <div class="summary-row total">
                                <span>Total Paid</span>
                                <span>₹<fmt:formatNumber value="${order.totalAmount}"/></span>
                            </div>
                            <hr>
                            <c:if test="${order.paymentMethod != null}">
                                <div class="d-flex justify-content-between small">
                                    <span>Payment Method</span>
                                    <strong>${order.paymentMethod.displayName}</strong>
                                </div>
                            </c:if>
                            <div class="d-flex justify-content-between small mt-2">
                                <span>Payment Status</span>
                                <span class="badge ${order.paymentStatus != null && order.paymentStatus.name() == 'PAID' ? 'bg-success' : 'bg-warning'}">${order.paymentStatus != null ? order.paymentStatus.displayName : 'Pending'}</span>
                            </div>
                        </div>
                    </div>

                    <!-- Shipping Address -->
                    <div class="card">
                        <div class="card-header">
                            <i class="fas fa-map-marker-alt me-2"></i>Shipping Address
                        </div>
                        <div class="card-body">
                            <div class="address-card">
                                <strong>${order.shippingName}</strong><br>
                                ${order.shippingAddressLine1}<br>
                                <c:if test="${not empty order.shippingAddressLine2}">
                                    ${order.shippingAddressLine2}<br>
                                </c:if>
                                ${order.shippingCity}, ${order.shippingState} - ${order.shippingPostalCode}<br>
                                <i class="fas fa-phone me-1"></i>${order.shippingPhone}
                            </div>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="card">
                        <div class="card-body">
                            <c:if test="${order.status != null && order.status.name() == 'DELIVERED'}">
                                <a href="#" class="btn btn-outline-primary w-100 mb-2">
                                    <i class="fas fa-redo me-2"></i>Reorder
                                </a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/contact" class="btn btn-outline-secondary w-100">
                                <i class="fas fa-headset me-2"></i>Need Help?
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
