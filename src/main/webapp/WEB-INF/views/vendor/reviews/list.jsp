<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reviews - Vendor Dashboard</title>
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
        .review-card { background: white; border-radius: 15px; padding: 20px; margin-bottom: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .stars { color: #ffc107; }
        .product-thumb { width: 60px; height: 60px; object-fit: cover; border-radius: 8px; }
        .vendor-response { background: #f8f9fa; border-left: 4px solid var(--primary); padding: 15px; margin-top: 15px; border-radius: 0 8px 8px 0; }
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
            <a href="${pageContext.request.contextPath}/vendor/orders"><i class="fas fa-shopping-cart"></i>Orders</a>
            <a href="${pageContext.request.contextPath}/vendor/reviews" class="active"><i class="fas fa-star"></i>Reviews</a>
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
            <h5 class="mb-0">Product Reviews</h5>
            <small class="text-muted">Customer reviews for your products</small>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>

        <c:choose>
            <c:when test="${not empty reviews.content}">
                <c:forEach items="${reviews.content}" var="review">
                    <div class="review-card">
                        <div class="row">
                            <div class="col-md-2">
                                <img src="${not empty review.product.imageUrl ? review.product.imageUrl : pageContext.request.contextPath.concat('/images/no-image.png')}" alt="${review.product.productName}" class="product-thumb mb-2">
                                <br><strong>${review.product.productName}</strong>
                            </div>
                            <div class="col-md-10">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <div class="stars mb-1">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i class="fas fa-star ${i <= review.rating ? '' : 'text-muted'}"></i>
                                            </c:forEach>
                                            <span class="text-dark ms-2">${review.rating}/5</span>
                                        </div>
                                        <h6 class="mb-1">${review.title}</h6>
                                        <small class="text-muted">
                                            By ${review.user.fullName} • <fmt:formatDate value="${review.createdAt}" pattern="dd MMM yyyy"/>
                                            <c:if test="${review.isVerifiedPurchase}">
                                                <span class="badge bg-success ms-2"><i class="fas fa-check me-1"></i>Verified Purchase</span>
                                            </c:if>
                                        </small>
                                    </div>
                                    <span class="badge ${review.status == 'APPROVED' ? 'bg-success' : review.status == 'PENDING' ? 'bg-warning' : 'bg-secondary'}">
                                        ${review.status.displayName}
                                    </span>
                                </div>
                                
                                <p class="mt-3 mb-0">${review.comment}</p>
                                
                                <c:if test="${not empty review.pros}">
                                    <p class="mt-2 mb-1 text-success"><i class="fas fa-thumbs-up me-2"></i><strong>Pros:</strong> ${review.pros}</p>
                                </c:if>
                                <c:if test="${not empty review.cons}">
                                    <p class="mb-0 text-danger"><i class="fas fa-thumbs-down me-2"></i><strong>Cons:</strong> ${review.cons}</p>
                                </c:if>

                                <!-- Vendor Response -->
                                <c:choose>
                                    <c:when test="${not empty review.vendorResponse}">
                                        <div class="vendor-response">
                                            <strong><i class="fas fa-store me-2"></i>Your Response:</strong>
                                            <p class="mb-0 mt-2">${review.vendorResponse}</p>
                                            <small class="text-muted"><fmt:formatDate value="${review.vendorRespondedAt}" pattern="dd MMM yyyy"/></small>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-sm btn-outline-primary mt-3" data-bs-toggle="modal" data-bs-target="#respondModal${review.id}">
                                            <i class="fas fa-reply me-2"></i>Respond to Review
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Response Modal -->
                    <div class="modal fade" id="respondModal${review.id}" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Respond to Review</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <form action="${pageContext.request.contextPath}/vendor/reviews/respond/${review.id}" method="post">
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label class="form-label">Your Response</label>
                                            <textarea class="form-control" name="response" rows="4" required placeholder="Thank you for your feedback..."></textarea>
                                        </div>
                                        <small class="text-muted">Your response will be visible to all customers viewing this product.</small>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn btn-primary">Submit Response</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <!-- Pagination -->
                <c:if test="${reviews.totalPages > 1}">
                    <nav class="mt-4">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${reviews.first ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${reviews.number - 1}">Previous</a>
                            </li>
                            <c:forEach begin="0" end="${reviews.totalPages - 1}" var="i">
                                <li class="page-item ${reviews.number == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}">${i + 1}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${reviews.last ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${reviews.number + 1}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="card">
                    <div class="card-body text-center py-5">
                        <i class="fas fa-star fa-4x text-muted mb-3"></i>
                        <h5>No Reviews Yet</h5>
                        <p class="text-muted">Customer reviews will appear here once they start reviewing your products</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

