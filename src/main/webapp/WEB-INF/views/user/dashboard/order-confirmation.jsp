<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="Order Confirmation"/>
    <jsp:param name="activeNav" value="orders"/>
</jsp:include>

<div class="dashboard-content">
    <div class="confirmation-card" style="background: white; border-radius: var(--radius-lg); padding: var(--spacing-2xl); box-shadow: var(--shadow-sm); text-align: center; margin-bottom: var(--spacing-xl);">
        <div class="success-icon" style="width: 100px; height: 100px; background: var(--primary-sage); border-radius: var(--radius-full); display: flex; align-items: center; justify-content: center; margin: 0 auto var(--spacing-lg); color: white; font-size: 3rem;">
            <i class="fas fa-check"></i>
        </div>
        <h1 style="color: var(--primary-forest); margin-bottom: var(--spacing-sm);">Order Confirmed!</h1>
        <p style="color: var(--text-medium); font-size: 1.1rem; margin-bottom: var(--spacing-md);">
            Your order has been placed successfully.
        </p>
        <p style="font-size: 1.1rem; font-weight: 600;">
            Order Number: <span style="color: var(--primary-forest);">${order.orderNumber}</span>
        </p>
    </div>

    <div class="order-details" style="background: white; border-radius: var(--radius-lg); padding: var(--spacing-xl); box-shadow: var(--shadow-sm); margin-bottom: var(--spacing-lg);">
        <h2 style="margin-bottom: var(--spacing-lg);">Order Details</h2>
        
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: var(--spacing-lg); margin-bottom: var(--spacing-lg);">
            <div>
                <h3 style="font-size: 1rem; margin-bottom: var(--spacing-md);">Shipping Address</h3>
                <p style="color: var(--text-medium); line-height: 1.8;">
                    ${order.shippingName}<br>
                    ${order.shippingAddressLine1}<br>
                    <c:if test="${not empty order.shippingAddressLine2}">
                        ${order.shippingAddressLine2}<br>
                    </c:if>
                    ${order.shippingCity}, ${order.shippingState} ${order.shippingPostalCode}<br>
                    ${order.shippingCountry}
                </p>
            </div>
            <div>
                <h3 style="font-size: 1rem; margin-bottom: var(--spacing-md);">Contact Information</h3>
                <p style="color: var(--text-medium); line-height: 1.8;">
                    <strong>Email:</strong> ${order.shippingEmail}<br>
                    <strong>Phone:</strong> ${order.shippingPhone}
                </p>
            </div>
        </div>

        <div style="margin-bottom: var(--spacing-lg);">
            <h3 style="font-size: 1rem; margin-bottom: var(--spacing-md);">Order Items</h3>
            <div class="order-items-list">
                <c:forEach var="item" items="${order.orderItems}">
                    <div style="display: flex; justify-content: space-between; padding: var(--spacing-md) 0; border-bottom: 1px solid var(--neutral-sand);">
                        <div>
                            <div style="font-weight: 600;">${item.productName}</div>
                            <div style="font-size: 0.85rem; color: var(--text-muted);">Qty: ${item.quantity} × ₹<fmt:formatNumber value="${item.unitPrice}" maxFractionDigits="0"/></div>
                        </div>
                        <div style="font-weight: 600;">
                            ₹<fmt:formatNumber value="${item.totalPrice}" maxFractionDigits="0"/>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div style="border-top: 2px solid var(--primary-forest); padding-top: var(--spacing-md);">
            <div style="display: flex; justify-content: space-between; margin-bottom: var(--spacing-sm);">
                <span style="color: var(--text-medium);">Subtotal:</span>
                <span style="font-weight: 600;">₹<fmt:formatNumber value="${order.subtotal}" maxFractionDigits="0"/></span>
            </div>
            <div style="display: flex; justify-content: space-between; margin-bottom: var(--spacing-sm);">
                <span style="color: var(--text-medium);">Shipping:</span>
                <span style="font-weight: 600;">₹<fmt:formatNumber value="${order.shippingCharges != null ? order.shippingCharges : 0}" maxFractionDigits="0"/></span>
            </div>
            <div style="display: flex; justify-content: space-between; margin-top: var(--spacing-md); padding-top: var(--spacing-md); border-top: 1px solid var(--neutral-sand);">
                <span style="font-size: 1.1rem; font-weight: 700;">Total Amount:</span>
                <span style="font-size: 1.25rem; font-weight: 700; color: var(--primary-forest);">
                    ₹<fmt:formatNumber value="${order.totalAmount}" maxFractionDigits="0"/>
                </span>
            </div>
        </div>
    </div>

    <div style="text-align: center;">
        <a href="${pageContext.request.contextPath}/user/order/details/${order.id}" class="btn" style="margin-right: var(--spacing-md);">
            <i class="fas fa-eye"></i> View Order Details
        </a>
        <a href="${pageContext.request.contextPath}/user/orders" class="btn btn-outline">
            <i class="fas fa-list"></i> View All Orders
        </a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-footer.jsp"/>

