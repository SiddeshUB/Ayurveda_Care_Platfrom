<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Management - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root { --primary: #4e73df; --sidebar-bg: #1e1e2d; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f8f9fc; }
        .sidebar { position: fixed; top: 0; left: 0; height: 100vh; width: 250px; background: var(--sidebar-bg); z-index: 1000; }
        .sidebar-brand { padding: 20px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .sidebar-brand h4 { color: white; margin: 0; }
        .sidebar-menu a { display: flex; align-items: center; padding: 12px 20px; color: rgba(255,255,255,0.7); text-decoration: none; border-left: 3px solid transparent; }
        .sidebar-menu a:hover, .sidebar-menu a.active { background: rgba(255,255,255,0.05); color: white; border-left-color: var(--primary); }
        .sidebar-menu a i { width: 30px; }
        .sidebar-menu .menu-label { padding: 15px 20px 5px; color: rgba(255,255,255,0.4); font-size: 0.75rem; text-transform: uppercase; }
        .main-content { margin-left: 250px; padding: 20px; }
        .card { border: none; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .card-header { background: white; border-bottom: 1px solid #eee; padding: 15px 20px; font-weight: 600; }
        .stats-card { border-radius: 10px; padding: 20px; color: white; }
        .stats-card.pending { background: linear-gradient(135deg, #f6d365, #fda085); }
        .stats-card.approved { background: linear-gradient(135deg, #11998e, #38ef7d); }
        .stats-card.total { background: linear-gradient(135deg, #667eea, #764ba2); }
        .status-badge { padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 500; }
        .vendor-avatar { width: 50px; height: 50px; border-radius: 50%; object-fit: cover; background: #eee; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; color: #666; }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-brand">
            <h4><i class="fas fa-shield-alt me-2"></i>Admin</h4>
        </div>
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
            <div class="menu-label">Management</div>
            <a href="${pageContext.request.contextPath}/admin/hospitals"><i class="fas fa-hospital"></i>Hospitals</a>
            <a href="${pageContext.request.contextPath}/admin/vendors" class="active"><i class="fas fa-store"></i>Vendors</a>
            <a href="${pageContext.request.contextPath}/admin/doctors"><i class="fas fa-user-md"></i>Doctors</a>
            <a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i>Users</a>
            <div class="menu-label">Products</div>
            <a href="${pageContext.request.contextPath}/admin/categories"><i class="fas fa-tags"></i>Categories</a>
            <a href="${pageContext.request.contextPath}/admin/products"><i class="fas fa-box"></i>Products</a>
            <a href="${pageContext.request.contextPath}/admin/reviews"><i class="fas fa-star"></i>Reviews</a>
            <div class="menu-label">Activity</div>
            <a href="${pageContext.request.contextPath}/admin/bookings"><i class="fas fa-calendar-check"></i>Bookings</a>
            <a href="${pageContext.request.contextPath}/admin/enquiries"><i class="fas fa-envelope"></i>Enquiries</a>
            <div class="menu-label">Account</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="text-danger"><i class="fas fa-sign-out-alt"></i>Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="mb-0">Vendor Management</h4>
                <small class="text-muted">Manage all marketplace vendors</small>
            </div>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>

        <!-- Stats -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="stats-card pending">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h3>${pendingCount}</h3>
                            <p class="mb-0">Pending Approval</p>
                        </div>
                        <i class="fas fa-clock fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card approved">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h3>${totalVendors - pendingCount}</h3>
                            <p class="mb-0">Active Vendors</p>
                        </div>
                        <i class="fas fa-check-circle fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card total">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h3>${totalVendors}</h3>
                            <p class="mb-0">Total Vendors</p>
                        </div>
                        <i class="fas fa-store fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter Tabs -->
        <ul class="nav nav-pills mb-4">
            <li class="nav-item">
                <a class="nav-link ${empty currentStatus || currentStatus == 'all' ? 'active' : ''}" href="?status=all">All</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 'PENDING' ? 'active' : ''}" href="?status=PENDING">
                    Pending <span class="badge bg-warning text-dark">${pendingCount}</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 'APPROVED' ? 'active' : ''}" href="?status=APPROVED">Approved</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 'REJECTED' ? 'active' : ''}" href="?status=REJECTED">Rejected</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 'SUSPENDED' ? 'active' : ''}" href="?status=SUSPENDED">Suspended</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 'BLOCKED' ? 'active' : ''}" href="?status=BLOCKED">Blocked</a>
            </li>
        </ul>

        <!-- Vendors Table -->
        <div class="card">
            <div class="card-header">
                <i class="fas fa-store me-2"></i>Vendors (${vendors.totalElements})
            </div>
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${not empty vendors.content}">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Vendor</th>
                                        <th>Business</th>
                                        <th>Contact</th>
                                        <th>Commission</th>
                                        <th>Status</th>
                                        <th>Registered</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${vendors.content}" var="vendor">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="vendor-avatar me-3">
                                                        <c:choose>
                                                            <c:when test="${not empty vendor.storeLogoUrl}">
                                                                <img src="${vendor.storeLogoUrl}" alt="${vendor.storeDisplayName}" class="w-100 h-100 rounded-circle">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fas fa-store"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div>
                                                        <strong>${vendor.storeDisplayName}</strong>
                                                        <br><small class="text-muted">${vendor.ownerFullName}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                ${vendor.businessName}
                                                <br><small class="text-muted">${vendor.businessType != null ? vendor.businessType.displayName : '-'}</small>
                                            </td>
                                            <td>
                                                <small>${vendor.email}</small>
                                                <br><small class="text-muted">${vendor.mobileNumber}</small>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${vendor.commissionPercentage != null}">
                                                        <strong>${vendor.commissionPercentage}%</strong>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not set</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="status-badge 
                                                    ${vendor.status == 'PENDING' ? 'bg-warning' : ''}
                                                    ${vendor.status == 'APPROVED' ? 'bg-success text-white' : ''}
                                                    ${vendor.status == 'REJECTED' ? 'bg-danger text-white' : ''}
                                                    ${vendor.status == 'SUSPENDED' ? 'bg-secondary text-white' : ''}
                                                    ${vendor.status == 'BLOCKED' ? 'bg-dark text-white' : ''}">
                                                    ${vendor.status != null ? vendor.status.displayName : 'Unknown'}
                                                </span>
                                            </td>
                                            <td>
                                                <c:if test="${vendor.createdAt != null}">
                                                    ${vendor.createdAt.dayOfMonth} ${vendor.createdAt.month.toString().substring(0,3)} ${vendor.createdAt.year}
                                                </c:if>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/vendors/${vendor.id}" class="btn btn-sm btn-primary">
                                                    <i class="fas fa-eye me-1"></i>View
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${vendors.totalPages > 1}">
                            <nav class="p-3">
                                <ul class="pagination justify-content-center mb-0">
                                    <li class="page-item ${vendors.first ? 'disabled' : ''}">
                                        <a class="page-link" href="?status=${currentStatus}&page=${vendors.number - 1}">Previous</a>
                                    </li>
                                    <c:forEach begin="0" end="${vendors.totalPages - 1}" var="i">
                                        <li class="page-item ${vendors.number == i ? 'active' : ''}">
                                            <a class="page-link" href="?status=${currentStatus}&page=${i}">${i + 1}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${vendors.last ? 'disabled' : ''}">
                                        <a class="page-link" href="?status=${currentStatus}&page=${vendors.number + 1}">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-store fa-4x text-muted mb-3"></i>
                            <h5>No Vendors Found</h5>
                            <p class="text-muted">No vendors match the selected filter</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

