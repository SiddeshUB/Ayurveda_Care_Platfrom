<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Products - Admin Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        :root {
            --admin-primary: #1a1a3e;
            --admin-secondary: #2d2d5e;
            --admin-accent: #C7A369;
        }
        .sidebar { background: linear-gradient(180deg, var(--admin-primary) 0%, #0f0f23 100%); }
        .sidebar-logo .highlight { color: var(--admin-accent); }
        .nav-item.active { border-left-color: var(--admin-accent); }
        .nav-badge { background: #ef4444; }
        .page-title-section { display: flex; align-items: center; justify-content: space-between; margin-bottom: 24px; }
        .search-box { position: relative; width: 300px; }
        .search-box input { width: 100%; padding: 12px 20px 12px 45px; border: 2px solid #e5e7eb; border-radius: 10px; }
        .search-box i { position: absolute; left: 16px; top: 50%; transform: translateY(-50%); color: #9ca3af; }
        .alert { padding: 15px 20px; border-radius: 10px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .alert-success { background: #d1fae5; color: #059669; }
        .alert-error { background: #fee2e2; color: #dc2626; }
        .empty-state { text-align: center; padding: 60px 20px; color: #9ca3af; }
        .empty-state i { font-size: 4rem; margin-bottom: 20px; color: #d1d5db; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden; }
        table thead { background: #f9fafb; }
        table th { padding: 16px; text-align: left; font-weight: 600; color: #374151; border-bottom: 2px solid #e5e7eb; }
        table td { padding: 16px; border-bottom: 1px solid #e5e7eb; }
        table tbody tr:hover { background: #f9fafb; }
        .status-badge { display: inline-flex; align-items: center; gap: 6px; padding: 4px 12px; border-radius: 20px; font-size: 0.85rem; font-weight: 600; }
        .status-badge.active { background: #d1fae5; color: #059669; }
        .status-badge.inactive { background: #fee2e2; color: #dc2626; }
        .status-badge.featured { background: #fef3c7; color: #d97706; }
        .btn-action { padding: 8px 12px; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; font-size: 0.9rem; }
        .btn-action.view { background: #dbeafe; color: #1e40af; }
        .btn-action.view:hover { background: #1e40af; color: white; }
    </style>
</head>
<body class="dashboard-body">
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-shield-alt"></i>
                <span>Admin<span class="highlight">Panel</span></span>
            </a>
        </div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/hospitals" class="nav-item">
                <i class="fas fa-hospital"></i>
                <span>All Hospitals</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-item">
                <i class="fas fa-users"></i>
                <span>All Users</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/doctors" class="nav-item">
                <i class="fas fa-user-md"></i>
                <span>All Doctors</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>All Bookings</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/products" class="nav-item active">
                <i class="fas fa-shopping-bag"></i>
                <span>All Products</span>
            </a>
        </nav>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </aside>

    <main class="dashboard-main">
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle"><i class="fas fa-bars"></i></button>
                <h1>All Products</h1>
            </div>
            <div class="header-right">
                <div class="header-profile">
                    <div class="profile-info">
                        <span class="profile-name">${admin.fullName}</span>
                    </div>
                    <div class="profile-avatar"><i class="fas fa-user-shield"></i></div>
                </div>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${error}</div>
            </c:if>

            <div class="page-title-section">
                <h1><i class="fas fa-shopping-bag"></i> All Products (${stats.totalProducts})</h1>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search products..." onkeyup="filterTable()">
                </div>
            </div>

            <div style="background: white; border-radius: 12px; overflow: hidden;">
                <c:choose>
                    <c:when test="${not empty products}">
                        <table id="productsTable">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>SKU</th>
                                    <th>Category</th>
                                    <th>Hospital</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th>Status</th>
                                    <th>Created</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${products}">
                                    <tr>
                                        <td>
                                            <div style="display: flex; align-items: center; gap: 12px;">
                                                <div style="width: 50px; height: 50px; border-radius: 8px; background: #f3f4f6; display: flex; align-items: center; justify-content: center; overflow: hidden;">
                                                    <c:choose>
                                                        <c:when test="${not empty product.imageUrl}">
                                                            <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.productName}" style="width: 100%; height: 100%; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-image" style="color: #9ca3af;"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div>
                                                    <h4 style="margin: 0; font-size: 1rem;">${product.productName}</h4>
                                                    <c:if test="${product.isFeatured}">
                                                        <span class="status-badge featured" style="margin-top: 4px;">
                                                            <i class="fas fa-star"></i> Featured
                                                        </span>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span style="font-family: monospace; font-size: 0.85rem; color: #6b7280;">${product.sku}</span>
                                        </td>
                                        <td>
                                            <span style="font-size: 0.9rem;">${product.category.displayName}</span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.hospital}">
                                                    <span style="font-size: 0.9rem;">${product.hospital.centerName}</span>
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <strong style="color: var(--admin-accent);">
                                                ₹<fmt:formatNumber value="${product.price}" maxFractionDigits="0"/>
                                            </strong>
                                            <c:if test="${not empty product.discountPrice}">
                                                <div style="font-size: 0.85rem; color: #9ca3af; text-decoration: line-through;">
                                                    ₹<fmt:formatNumber value="${product.discountPrice}" maxFractionDigits="0"/>
                                                </div>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${product.trackInventory && product.stockQuantity != null}">
                                                    <span style="color: ${product.stockQuantity > 0 ? '#059669' : '#dc2626'};">
                                                        ${product.stockQuantity}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="status-badge ${product.isActive ? 'active' : 'inactive'}">
                                                ${product.isActive ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td>
                                            <fmt:parseDate value="${product.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                            <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/products/${product.id}" class="btn-action view">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-shopping-bag"></i>
                            <h3>No products found</h3>
                            <p>There are no products yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <script>
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
            });
        }
        function filterTable() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.getElementById('productsTable');
            if (!table) return;
            const rows = table.getElementsByTagName('tr');
            for (let i = 1; i < rows.length; i++) {
                const cells = rows[i].getElementsByTagName('td');
                let found = false;
                for (let j = 0; j < cells.length; j++) {
                    const cellText = cells[j].textContent || cells[j].innerText;
                    if (cellText.toLowerCase().indexOf(filter) > -1) {
                        found = true;
                        break;
                    }
                }
                rows[i].style.display = found ? '' : 'none';
            }
        }
    </script>
</body>
</html>

