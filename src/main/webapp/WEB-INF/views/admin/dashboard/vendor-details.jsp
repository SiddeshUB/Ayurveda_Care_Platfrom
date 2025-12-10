<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Details - Admin Dashboard</title>
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
        .card { border: none; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .card-header { background: white; border-bottom: 1px solid #eee; padding: 15px 20px; font-weight: 600; }
        .status-badge { padding: 6px 15px; border-radius: 20px; font-size: 0.85rem; font-weight: 500; }
        .vendor-header { background: linear-gradient(135deg, #2d5a27, #4a7c43); color: white; border-radius: 10px; padding: 30px; margin-bottom: 20px; }
        .vendor-logo { width: 100px; height: 100px; border-radius: 50%; background: white; display: flex; align-items: center; justify-content: center; font-size: 2.5rem; color: #2d5a27; }
        .info-item { margin-bottom: 15px; }
        .info-item label { font-size: 0.85rem; color: #888; margin-bottom: 3px; }
        .info-item p { margin: 0; font-weight: 500; }
        .doc-item { display: flex; align-items: center; justify-content: space-between; padding: 12px 15px; background: #f8f9fa; border-radius: 8px; margin-bottom: 10px; }
        .doc-status { padding: 4px 10px; border-radius: 15px; font-size: 0.75rem; }
        .action-card { background: #f8f9fa; border-radius: 10px; padding: 20px; }
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
            <div class="menu-label">Account</div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="text-danger"><i class="fas fa-sign-out-alt"></i>Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <a href="${pageContext.request.contextPath}/admin/vendors" class="text-decoration-none">
                    <i class="fas fa-arrow-left me-2"></i>Back to Vendors
                </a>
            </div>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>

        <!-- Vendor Header -->
        <div class="vendor-header">
            <div class="row align-items-center">
                <div class="col-auto">
                    <div class="vendor-logo">
                        <c:choose>
                            <c:when test="${not empty vendor.storeLogoUrl}">
                                <img src="${vendor.storeLogoUrl}" alt="${vendor.storeDisplayName}" class="w-100 h-100 rounded-circle">
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-store"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="col">
                    <h3 class="mb-1">${vendor.storeDisplayName}</h3>
                    <p class="mb-2 opacity-75">${vendor.businessName}</p>
                    <span class="status-badge 
                        ${vendor.status == 'PENDING' ? 'bg-warning text-dark' : ''}
                        ${vendor.status == 'APPROVED' ? 'bg-success' : ''}
                        ${vendor.status == 'REJECTED' ? 'bg-danger' : ''}
                        ${vendor.status == 'SUSPENDED' ? 'bg-secondary' : ''}
                        ${vendor.status == 'BLOCKED' ? 'bg-dark' : ''}">
                        ${vendor.status != null ? vendor.status.displayName : 'Unknown'}
                    </span>
                    <c:if test="${vendor.isVerified}">
                        <span class="badge bg-info ms-2"><i class="fas fa-check-circle me-1"></i>Verified</span>
                    </c:if>
                </div>
                <div class="col-auto text-end">
                    <p class="mb-1 opacity-75">Registered</p>
                    <h5>
                        <c:if test="${vendor.createdAt != null}">
                            ${vendor.createdAt.dayOfMonth} ${vendor.createdAt.month.toString().substring(0,3)} ${vendor.createdAt.year}
                        </c:if>
                    </h5>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Left Column -->
            <div class="col-lg-8">
                <!-- Basic Information -->
                <div class="card">
                    <div class="card-header"><i class="fas fa-user me-2"></i>Owner Information</div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="info-item">
                                    <label>Full Name</label>
                                    <p>${vendor.ownerFullName}</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-item">
                                    <label>Email</label>
                                    <p>${vendor.email}</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-item">
                                    <label>Mobile</label>
                                    <p>${vendor.mobileNumber}</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-item">
                                    <label>Alternate Phone</label>
                                    <p>${not empty vendor.alternatePhone ? vendor.alternatePhone : '-'}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Business Details -->
                <div class="card">
                    <div class="card-header"><i class="fas fa-building me-2"></i>Business Details</div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="info-item">
                                    <label>Business Name</label>
                                    <p>${vendor.businessName}</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-item">
                                    <label>Business Type</label>
                                    <p>${vendor.businessType != null ? vendor.businessType.displayName : '-'}</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="info-item">
                                    <label>GST Number</label>
                                    <p>${vendor.gstNumber}</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="info-item">
                                    <label>PAN Number</label>
                                    <p>${vendor.panNumber}</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="info-item">
                                    <label>Year Established</label>
                                    <p>${vendor.yearEstablished}</p>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <h6>Business Address</h6>
                        <p class="mb-0">
                            ${vendor.businessAddressLine1}
                            <c:if test="${not empty vendor.businessAddressLine2}">, ${vendor.businessAddressLine2}</c:if><br>
                            ${vendor.businessCity}, ${vendor.businessState} - ${vendor.businessPinCode}
                        </p>
                    </div>
                </div>

                <!-- Bank Details -->
                <div class="card">
                    <div class="card-header"><i class="fas fa-university me-2"></i>Bank Details</div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="info-item">
                                    <label>Bank Name</label>
                                    <p>${vendor.bankName}</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-item">
                                    <label>Account Holder</label>
                                    <p>${vendor.accountHolderName}</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="info-item">
                                    <label>Account Number</label>
                                    <p>
                                        <c:choose>
                                            <c:when test="${not empty vendor.accountNumber and vendor.accountNumber.length() >= 4}">
                                                ****${vendor.accountNumber.substring(vendor.accountNumber.length() - 4)}
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="info-item">
                                    <label>IFSC Code</label>
                                    <p>${vendor.ifscCode}</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="info-item">
                                    <label>Account Type</label>
                                    <p>${vendor.accountType != null ? vendor.accountType.displayName : '-'}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Documents -->
                <div class="card">
                    <div class="card-header"><i class="fas fa-file-alt me-2"></i>Uploaded Documents</div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty documents}">
                                <c:forEach items="${documents}" var="doc">
                                    <div class="doc-item">
                                        <div>
                                            <i class="fas fa-file-pdf text-danger me-2"></i>
                                            <strong>${doc.documentType != null ? doc.documentType.displayName : 'Document'}</strong>
                                            <br><small class="text-muted">${doc.documentName}</small>
                                        </div>
                                        <div>
                                            <span class="doc-status ${doc.verificationStatus == 'VERIFIED' ? 'bg-success text-white' : doc.verificationStatus == 'PENDING' ? 'bg-warning' : 'bg-danger text-white'}">
                                                ${doc.verificationStatus != null ? doc.verificationStatus.displayName : 'Pending'}
                                            </span>
                                            <a href="${doc.documentUrl}" target="_blank" class="btn btn-sm btn-outline-primary ms-2">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted text-center py-3">No documents uploaded</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Right Column - Actions -->
            <div class="col-lg-4">
                <!-- Quick Stats -->
                <div class="card">
                    <div class="card-header"><i class="fas fa-chart-bar me-2"></i>Statistics</div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Total Products</span>
                            <strong>${vendor.totalProducts}</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Total Orders</span>
                            <strong>${vendor.totalOrders}</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Total Revenue</span>
                            <strong>₹<fmt:formatNumber value="${vendor.totalRevenue}"/></strong>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Commission Paid</span>
                            <strong>₹<fmt:formatNumber value="${vendor.totalCommissionPaid}"/></strong>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Rating</span>
                            <strong><i class="fas fa-star text-warning"></i> ${vendor.averageRating} (${vendor.totalReviews})</strong>
                        </div>
                    </div>
                </div>

                <!-- Commission Settings -->
                <div class="card">
                    <div class="card-header"><i class="fas fa-percentage me-2"></i>Commission</div>
                    <div class="card-body">
                        <p class="mb-2">Current Rate: <strong>${vendor.commissionPercentage != null ? vendor.commissionPercentage : 'Not Set'}%</strong></p>
                        <p class="mb-3 small text-muted">Payment Cycle: ${vendor.paymentCycle != null ? vendor.paymentCycle.displayName : 'Weekly'}</p>
                        <form action="${pageContext.request.contextPath}/admin/vendors/${vendor.id}/update-commission" method="post">
                            <div class="input-group mb-2">
                                <input type="number" class="form-control" name="commissionPercentage" step="0.01" min="0" max="100" value="${vendor.commissionPercentage}" placeholder="Enter %">
                                <span class="input-group-text">%</span>
                            </div>
                            <button type="submit" class="btn btn-primary btn-sm w-100">Update Commission</button>
                        </form>
                    </div>
                </div>

                <!-- Actions -->
                <div class="card">
                    <div class="card-header"><i class="fas fa-cog me-2"></i>Actions</div>
                    <div class="card-body">
                        <c:if test="${vendor.status == 'PENDING'}">
                            <div class="action-card mb-3">
                                <h6 class="text-success"><i class="fas fa-check-circle me-2"></i>Approve Vendor</h6>
                                <form action="${pageContext.request.contextPath}/admin/vendors/${vendor.id}/approve" method="post">
                                    <div class="mb-2">
                                        <label class="form-label small">Commission Rate (%)</label>
                                        <input type="number" class="form-control form-control-sm" name="commissionPercentage" step="0.01" min="0" max="100" value="10" required>
                                    </div>
                                    <button type="submit" class="btn btn-success btn-sm w-100">Approve</button>
                                </form>
                            </div>
                            <div class="action-card">
                                <h6 class="text-danger"><i class="fas fa-times-circle me-2"></i>Reject Vendor</h6>
                                <form action="${pageContext.request.contextPath}/admin/vendors/${vendor.id}/reject" method="post">
                                    <div class="mb-2">
                                        <label class="form-label small">Reason</label>
                                        <textarea class="form-control form-control-sm" name="reason" rows="2" required placeholder="Reason for rejection"></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-danger btn-sm w-100">Reject</button>
                                </form>
                            </div>
                        </c:if>

                        <c:if test="${vendor.status == 'APPROVED'}">
                            <div class="action-card mb-3">
                                <h6 class="text-warning"><i class="fas fa-pause-circle me-2"></i>Suspend Vendor</h6>
                                <form action="${pageContext.request.contextPath}/admin/vendors/${vendor.id}/suspend" method="post">
                                    <div class="mb-2">
                                        <textarea class="form-control form-control-sm" name="reason" rows="2" required placeholder="Reason for suspension"></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-warning btn-sm w-100">Suspend</button>
                                </form>
                            </div>
                            <div class="action-card">
                                <h6 class="text-danger"><i class="fas fa-ban me-2"></i>Block Vendor</h6>
                                <form action="${pageContext.request.contextPath}/admin/vendors/${vendor.id}/block" method="post">
                                    <div class="mb-2">
                                        <textarea class="form-control form-control-sm" name="reason" rows="2" required placeholder="Reason for blocking"></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-danger btn-sm w-100">Block</button>
                                </form>
                            </div>
                        </c:if>

                        <c:if test="${vendor.status == 'SUSPENDED' || vendor.status == 'BLOCKED' || vendor.status == 'REJECTED'}">
                            <div class="action-card">
                                <h6 class="text-success"><i class="fas fa-play-circle me-2"></i>Activate Vendor</h6>
                                <form action="${pageContext.request.contextPath}/admin/vendors/${vendor.id}/activate" method="post">
                                    <button type="submit" class="btn btn-success btn-sm w-100">Activate</button>
                                </form>
                            </div>
                            <c:if test="${not empty vendor.rejectionReason}">
                                <div class="mt-3 p-3 bg-light rounded">
                                    <small class="text-muted">Reason:</small>
                                    <p class="mb-0 small">${vendor.rejectionReason}</p>
                                </div>
                            </c:if>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

