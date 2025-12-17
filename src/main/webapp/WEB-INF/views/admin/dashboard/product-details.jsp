<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Product Details" scope="request"/>
<c:set var="activePage" value="products" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layouts/admin-header.jsp" %>
<style>
    .page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 24px; }
    .card { border: none; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 20px; background: white; }
    .card-header { background: #f9fafb; border-bottom: 1px solid #e5e7eb; padding: 16px 20px; font-weight: 600; color: #374151; }
    .card-body { padding: 20px; }
    .product-header { background: linear-gradient(135deg, #2d5a27, #4a7c43); color: white; border-radius: 12px; padding: 30px; margin-bottom: 20px; }
    .product-image { width: 150px; height: 150px; border-radius: 12px; background: white; display: flex; align-items: center; justify-content: center; overflow: hidden; }
    .product-image img { width: 100%; height: 100%; object-fit: cover; }
    .product-image i { font-size: 4rem; color: #2d5a27; }
    .info-row { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 20px; }
    .info-item { }
    .info-item label { font-size: 0.85rem; color: #6b7280; margin-bottom: 5px; display: block; font-weight: 500; }
    .info-item p { margin: 0; font-size: 1rem; color: #111827; font-weight: 500; }
    .status-badge { display: inline-flex; align-items: center; gap: 6px; padding: 6px 15px; border-radius: 20px; font-size: 0.85rem; font-weight: 600; }
    .status-badge.active { background: #d1fae5; color: #059669; }
    .status-badge.inactive { background: #fee2e2; color: #dc2626; }
    .status-badge.featured { background: #fef3c7; color: #d97706; }
    .price-section { background: #f9fafb; border-radius: 10px; padding: 20px; margin-bottom: 20px; }
    .price-row { display: flex; align-items: center; gap: 15px; margin-bottom: 10px; }
    .price-label { color: #6b7280; font-size: 0.9rem; }
    .price-value { font-size: 1.5rem; font-weight: 700; color: #059669; }
    .mrp-value { font-size: 1rem; text-decoration: line-through; color: #9ca3af; }
    .discount-badge { background: #fee2e2; color: #dc2626; padding: 4px 10px; border-radius: 6px; font-size: 0.85rem; font-weight: 600; }
    .description-text { color: #4b5563; line-height: 1.7; white-space: pre-wrap; }
    .text-section { margin-bottom: 20px; }
    .text-section label { font-size: 0.9rem; color: #6b7280; margin-bottom: 8px; display: block; font-weight: 500; }
    .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px; margin-bottom: 20px; }
    .stat-item { background: #f9fafb; border-radius: 10px; padding: 15px; text-align: center; }
    .stat-value { font-size: 1.5rem; font-weight: 700; color: #1f2937; }
    .stat-label { font-size: 0.85rem; color: #6b7280; margin-top: 5px; }
</style>

<main class="main-content">
    <div class="page-header">
        <div>
            <a href="${pageContext.request.contextPath}/admin/products" class="text-decoration-none" style="color: #6b7280;">
                <i class="fas fa-arrow-left me-2"></i>Back to Products
            </a>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
    </c:if>

    <c:if test="${not empty product}">
        <!-- Product Header -->
        <div class="product-header">
            <div style="display: flex; align-items: center; gap: 25px;">
                <div class="product-image">
                    <c:choose>
                        <c:when test="${not empty product.imageUrl}">
                            <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.productName}">
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-box"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="flex: 1;">
                    <h2 class="mb-2" style="margin: 0; font-size: 1.75rem;">${product.productName}</h2>
                    <p class="mb-3 opacity-75" style="margin: 0; font-size: 1rem;">SKU: ${product.sku}</p>
                    <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                        <span class="status-badge ${product.isActive ? 'active' : 'inactive'}">
                            ${product.isActive ? 'Active' : 'Inactive'}
                        </span>
                        <c:if test="${product.isFeatured}">
                            <span class="status-badge featured">
                                <i class="fas fa-star"></i> Featured
                            </span>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pricing Section -->
        <div class="card">
            <div class="card-header"><i class="fas fa-tag me-2"></i>Pricing</div>
            <div class="card-body">
                <div class="price-section">
                    <div class="price-row">
                        <span class="price-label">Selling Price:</span>
                        <span class="price-value">₹<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></span>
                    </div>
                    <c:if test="${not empty product.mrp && product.mrp.compareTo(product.price) > 0}">
                        <div class="price-row">
                            <span class="price-label">MRP:</span>
                            <span class="mrp-value">₹<fmt:formatNumber value="${product.mrp}" pattern="#,##0.00"/></span>
                            <c:if test="${not empty product.discountPercentage}">
                                <span class="discount-badge">${product.discountPercentage}% OFF</span>
                            </c:if>
                        </div>
                    </c:if>
                    <c:if test="${not empty product.discountPrice}">
                        <div class="price-row">
                            <span class="price-label">Discount Price:</span>
                            <span class="price-value">₹<fmt:formatNumber value="${product.discountPrice}" pattern="#,##0.00"/></span>
                        </div>
                    </c:if>
                    <c:if test="${not empty product.offerBadge}">
                        <div class="price-row">
                            <span class="price-label">Offer:</span>
                            <span class="discount-badge">${product.offerBadge}</span>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Basic Information -->
        <div class="card">
            <div class="card-header"><i class="fas fa-info-circle me-2"></i>Basic Information</div>
            <div class="card-body">
                <div class="info-row">
                    <div class="info-item">
                        <label>Product ID</label>
                        <p>${product.id}</p>
                    </div>
                    <div class="info-item">
                        <label>SKU</label>
                        <p>${product.sku}</p>
                    </div>
                    <div class="info-item">
                        <label>Category</label>
                        <p>${not empty product.category ? product.category.displayName : 'N/A'}</p>
                    </div>
                    <div class="info-item">
                        <label>Vendor</label>
                        <p>${not empty product.vendor ? product.vendor.storeDisplayName : 'N/A'}</p>
                    </div>
                    <div class="info-item">
                        <label>Brand</label>
                        <p>${not empty product.brand ? product.brand : 'N/A'}</p>
                    </div>
                    <div class="info-item">
                        <label>Manufacturer</label>
                        <p>${not empty product.manufacturer ? product.manufacturer : 'N/A'}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Inventory Information -->
        <div class="card">
            <div class="card-header"><i class="fas fa-warehouse me-2"></i>Inventory</div>
            <div class="card-body">
                <div class="info-row">
                    <div class="info-item">
                        <label>Stock Quantity</label>
                        <p style="color: ${product.stockQuantity > 0 ? '#059669' : '#dc2626'};">
                            ${product.stockQuantity != null ? product.stockQuantity : 'N/A'}
                        </p>
                    </div>
                    <div class="info-item">
                        <label>Minimum Stock Level</label>
                        <p>${product.minStockLevel != null ? product.minStockLevel : 'N/A'}</p>
                    </div>
                    <div class="info-item">
                        <label>Track Inventory</label>
                        <p>${product.trackInventory ? 'Yes' : 'No'}</p>
                    </div>
                    <div class="info-item">
                        <label>Allow Backorder</label>
                        <p>${product.allowBackorder ? 'Yes' : 'No'}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Details -->
        <c:if test="${not empty product.description || not empty product.shortDescription || not empty product.ingredients || not empty product.benefits || not empty product.usageInstructions || not empty product.specifications}">
            <div class="card">
                <div class="card-header"><i class="fas fa-list-alt me-2"></i>Product Details</div>
                <div class="card-body">
                    <c:if test="${not empty product.shortDescription}">
                        <div class="text-section">
                            <label>Short Description</label>
                            <p class="description-text">${product.shortDescription}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty product.description}">
                        <div class="text-section">
                            <label>Full Description</label>
                            <p class="description-text">${product.description}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty product.ingredients}">
                        <div class="text-section">
                            <label>Ingredients</label>
                            <p class="description-text">${product.ingredients}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty product.benefits}">
                        <div class="text-section">
                            <label>Benefits</label>
                            <p class="description-text">${product.benefits}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty product.usageInstructions}">
                        <div class="text-section">
                            <label>Usage Instructions</label>
                            <p class="description-text">${product.usageInstructions}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty product.specifications}">
                        <div class="text-section">
                            <label>Specifications</label>
                            <p class="description-text">${product.specifications}</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>

        <!-- Physical Attributes -->
        <div class="card">
            <div class="card-header"><i class="fas fa-ruler-combined me-2"></i>Physical Attributes</div>
            <div class="card-body">
                <div class="info-row">
                    <div class="info-item">
                        <label>Weight/Size</label>
                        <p>${not empty product.weight ? product.weight : 'N/A'}</p>
                    </div>
                    <div class="info-item">
                        <label>Dimensions</label>
                        <p>${not empty product.dimensions ? product.dimensions : 'N/A'}</p>
                    </div>
                    <div class="info-item">
                        <label>Shipping Weight</label>
                        <p>${not empty product.shippingWeight ? product.shippingWeight : 'N/A'}</p>
                    </div>
                    <div class="info-item">
                        <label>Country of Origin</label>
                        <p>${not empty product.countryOfOrigin ? product.countryOfOrigin : 'N/A'}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Lifecycle -->
        <div class="card">
            <div class="card-header"><i class="fas fa-calendar me-2"></i>Product Lifecycle</div>
            <div class="card-body">
                <div class="info-row">
                    <div class="info-item">
                        <label>Created At</label>
                        <p>
                            <%
                                com.ayurveda.entity.Product p = (com.ayurveda.entity.Product) pageContext.getAttribute("product");
                                if (p != null && p.getCreatedAt() != null) {
                                    out.print(p.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
                                } else {
                                    out.print("N/A");
                                }
                            %>
                        </p>
                    </div>
                    <div class="info-item">
                        <label>Last Updated</label>
                        <p>
                            <%
                                if (p != null && p.getUpdatedAt() != null) {
                                    out.print(p.getUpdatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")));
                                } else {
                                    out.print("N/A");
                                }
                            %>
                        </p>
                    </div>
                    <c:if test="${not empty product.expiryDate}">
                        <div class="info-item">
                            <label>Expiry Date</label>
                            <p>${product.expiryDate}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty product.shelfLife}">
                        <div class="info-item">
                            <label>Shelf Life</label>
                            <p>${product.shelfLife}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty product.batchNumber}">
                        <div class="info-item">
                            <label>Batch Number</label>
                            <p>${product.batchNumber}</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Analytics & Performance -->
        <div class="card">
            <div class="card-header"><i class="fas fa-chart-line me-2"></i>Analytics & Performance</div>
            <div class="card-body">
                <div class="stats-grid">
                    <div class="stat-item">
                        <div class="stat-value">${product.totalViews != null ? product.totalViews : 0}</div>
                        <div class="stat-label">Total Views</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">${product.totalSales != null ? product.totalSales : 0}</div>
                        <div class="stat-label">Total Sales</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">${product.averageRating != null ? product.averageRating : 0.0}</div>
                        <div class="stat-label">Average Rating</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">${product.totalReviews != null ? product.totalReviews : 0}</div>
                        <div class="stat-label">Total Reviews</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Shipping & Delivery -->
        <div class="card">
            <div class="card-header"><i class="fas fa-shipping-fast me-2"></i>Shipping & Delivery</div>
            <div class="card-body">
                <div class="info-row">
                    <div class="info-item">
                        <label>Shipping Charge</label>
                        <p>${product.freeShipping ? 'Free Shipping' : (product.shippingCharge != null ? '₹' : 'N/A')}<c:if test="${not empty product.shippingCharge}"><fmt:formatNumber value="${product.shippingCharge}" pattern="#,##0.00"/></c:if></p>
                    </div>
                    <div class="info-item">
                        <label>Delivery Days</label>
                        <p>${product.deliveryDaysMin != null && product.deliveryDaysMax != null ? product.deliveryDaysMin : ''}${product.deliveryDaysMin != null && product.deliveryDaysMax != null && !product.deliveryDaysMin.equals(product.deliveryDaysMax) ? '-' : ''}${product.deliveryDaysMax != null ? product.deliveryDaysMax : ''} ${product.deliveryDaysMin != null || product.deliveryDaysMax != null ? 'days' : 'N/A'}</p>
                    </div>
                    <div class="info-item">
                        <label>Express Delivery</label>
                        <p>${product.expressDeliveryAvailable ? (product.expressDeliveryDays != null ? product.expressDeliveryDays + ' days' : 'Available') : 'Not Available'}</p>
                    </div>
                    <c:if test="${product.expressDeliveryAvailable && not empty product.expressDeliveryCharge}">
                        <div class="info-item">
                            <label>Express Delivery Charge</label>
                            <p>₹<fmt:formatNumber value="${product.expressDeliveryCharge}" pattern="#,##0.00"/></p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Additional Options -->
        <div class="card">
            <div class="card-header"><i class="fas fa-cog me-2"></i>Additional Options</div>
            <div class="card-body">
                <div class="info-row">
                    <div class="info-item">
                        <label>Warranty</label>
                        <p>${not empty product.warrantyPeriod ? product.warrantyPeriod : 'N/A'}</p>
                    </div>
                    <c:if test="${not empty product.warrantyDetails}">
                        <div class="info-item">
                            <label>Warranty Details</label>
                            <p>${product.warrantyDetails}</p>
                        </div>
                    </c:if>
                    <div class="info-item">
                        <label>EMI Available</label>
                        <p>${product.emiAvailable ? 'Yes' : 'No'}</p>
                    </div>
                    <c:if test="${product.emiAvailable && not empty product.minEmiAmount}">
                        <div class="info-item">
                            <label>Minimum EMI Amount</label>
                            <p>₹<fmt:formatNumber value="${product.minEmiAmount}" pattern="#,##0.00"/></p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Policies -->
        <c:if test="${not empty product.returnPolicy || not empty product.replacementPolicy || not empty product.cancellationPolicy}">
            <div class="card">
                <div class="card-header"><i class="fas fa-file-contract me-2"></i>Policies</div>
                <div class="card-body">
                    <c:if test="${not empty product.returnPolicy}">
                        <div class="text-section">
                            <label>Return Policy</label>
                            <p class="description-text">${product.returnPolicy} <c:if test="${product.returnPeriodDays != null}">(${product.returnPeriodDays} days)</c:if></p>
                        </div>
                    </c:if>
                    <c:if test="${not empty product.replacementPolicy}">
                        <div class="text-section">
                            <label>Replacement Policy</label>
                            <p class="description-text">${product.replacementPolicy} <c:if test="${product.replacementPeriodDays != null}">(${product.replacementPeriodDays} days)</c:if></p>
                        </div>
                    </c:if>
                    <c:if test="${not empty product.cancellationPolicy}">
                        <div class="text-section">
                            <label>Cancellation Policy</label>
                            <p class="description-text">${product.cancellationPolicy}</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>
    </c:if>

    <c:if test="${empty product}">
        <div class="card">
            <div class="card-body text-center" style="padding: 60px 20px;">
                <i class="fas fa-exclamation-triangle" style="font-size: 3rem; color: #f59e0b; margin-bottom: 20px;"></i>
                <h3>Product Not Found</h3>
                <p class="text-muted">The product you are looking for does not exist.</p>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-primary mt-3">
                    <i class="fas fa-arrow-left me-2"></i>Back to Products
                </a>
            </div>
        </div>
    </c:if>
</main>

<%@ include file="/WEB-INF/views/admin/layouts/admin-footer.jsp" %>

