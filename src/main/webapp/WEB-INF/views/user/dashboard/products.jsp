<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="Browse Products"/>
    <jsp:param name="activeNav" value="products"/>
</jsp:include>

<div class="dashboard-content">
    <div class="page-header">
        <h1><i class="fas fa-shopping-bag"></i> Browse Products</h1>
        <p>Discover Ayurvedic products from trusted hospitals</p>
    </div>

    <!-- Search and Filters -->
    <div class="filters-card" style="background: white; padding: var(--spacing-lg); border-radius: var(--radius-lg); box-shadow: var(--shadow-sm); margin-bottom: var(--spacing-xl);">
        <form method="get" action="${pageContext.request.contextPath}/user/products" class="filters-form">
            <div style="display: grid; grid-template-columns: 2fr 1fr 1fr auto; gap: var(--spacing-md); align-items: end;">
                <div class="form-group">
                    <label>Search Products</label>
                    <input type="text" name="search" value="${search}" placeholder="Search by name or description..." class="form-input">
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <select name="category" class="form-select">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat}" ${category == cat ? 'selected' : ''}>${cat.displayName}</option>
                        </c:forEach>
                    </select>
                </div>
                <c:if test="${hospitalId != null}">
                    <input type="hidden" name="hospitalId" value="${hospitalId}">
                </c:if>
                <button type="submit" class="btn">
                    <i class="fas fa-search"></i> Search
                </button>
            </div>
        </form>
    </div>

    <!-- Products Grid -->
    <c:choose>
        <c:when test="${not empty products}">
            <div class="products-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: var(--spacing-lg);">
                <c:forEach var="product" items="${products}">
                    <div class="product-card" style="background: white; border-radius: var(--radius-lg); overflow: hidden; box-shadow: var(--shadow-sm); transition: transform var(--transition-fast);">
                        <div class="product-image" style="position: relative; height: 200px; overflow: hidden; background: var(--neutral-sand);">
                            <c:choose>
                                <c:when test="${not empty product.imageUrl}">
                                    <img src="${product.imageUrl.startsWith('http') ? product.imageUrl : pageContext.request.contextPath.concat(product.imageUrl)}" alt="${product.productName}" style="width: 100%; height: 100%; object-fit: cover;">
                                </c:when>
                                <c:otherwise>
                                    <div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
                                        <i class="fas fa-box" style="font-size: 3rem; color: var(--text-muted);"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${product.discountPrice != null}">
                                <span class="badge" style="position: absolute; top: var(--spacing-sm); right: var(--spacing-sm); background: var(--accent-coral); color: white; padding: var(--spacing-xs) var(--spacing-sm); border-radius: var(--radius-md); font-weight: 600;">
                                    Sale
                                </span>
                            </c:if>
                        </div>
                        <div class="product-body" style="padding: var(--spacing-lg);">
                            <h3 style="margin: 0 0 var(--spacing-xs) 0; color: var(--primary-forest); font-size: 1.1rem;">${product.productName}</h3>
                            <p style="color: var(--text-muted); font-size: 0.85rem; margin-bottom: var(--spacing-sm);">
                                ${product.category != null ? product.category.displayName : 'Product'}
                            </p>
                            <c:if test="${not empty product.shortDescription}">
                                <p style="color: var(--text-medium); font-size: 0.9rem; margin-bottom: var(--spacing-md); line-height: 1.5;">
                                    ${fn:substring(product.shortDescription, 0, 80)}${fn:length(product.shortDescription) > 80 ? '...' : ''}
                                </p>
                            </c:if>
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: var(--spacing-md); padding-top: var(--spacing-md); border-top: 1px solid var(--neutral-sand);">
                                <div>
                                    <c:choose>
                                        <c:when test="${product.discountPrice != null}">
                                            <span style="font-size: 1.25rem; font-weight: 700; color: var(--primary-forest);">
                                                ₹<fmt:formatNumber value="${product.discountPrice}" maxFractionDigits="0"/>
                                            </span>
                                            <span style="font-size: 0.9rem; color: var(--text-muted); text-decoration: line-through; margin-left: var(--spacing-xs);">
                                                ₹<fmt:formatNumber value="${product.price}" maxFractionDigits="0"/>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="font-size: 1.25rem; font-weight: 700; color: var(--primary-forest);">
                                                ₹<fmt:formatNumber value="${product.price}" maxFractionDigits="0"/>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <form method="post" action="${pageContext.request.contextPath}/user/cart/add/${product.id}" style="margin: 0;">
                                    <button type="submit" class="btn btn-sm" style="padding: var(--spacing-xs) var(--spacing-md);">
                                        <i class="fas fa-cart-plus"></i> Add to Cart
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state" style="text-align: center; padding: var(--spacing-3xl); background: white; border-radius: var(--radius-lg); box-shadow: var(--shadow-sm);">
                <i class="fas fa-box-open" style="font-size: 4rem; color: var(--text-muted); margin-bottom: var(--spacing-lg);"></i>
                <h3>No Products Found</h3>
                <p style="color: var(--text-medium);">Try adjusting your search or filters.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-footer.jsp"/>

