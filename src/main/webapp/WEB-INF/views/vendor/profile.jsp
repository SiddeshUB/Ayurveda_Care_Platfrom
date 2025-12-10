<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Vendor Dashboard</title>
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
        .card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .card-header { background: white; border-bottom: 1px solid #eee; padding: 20px; font-weight: 600; }
        .form-control, .form-select { border-radius: 8px; border: 2px solid #e0e0e0; }
        .form-control:focus, .form-select:focus { border-color: var(--primary); box-shadow: 0 0 0 0.2rem rgba(45, 90, 39, 0.15); }
        .store-logo { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 4px solid var(--primary); }
        .doc-item { display: flex; align-items: center; justify-content: space-between; padding: 10px 15px; background: #f8f9fa; border-radius: 8px; margin-bottom: 10px; }
        .doc-status { padding: 4px 10px; border-radius: 15px; font-size: 0.75rem; }
        .nav-tabs .nav-link { color: #666; border: none; padding: 12px 20px; }
        .nav-tabs .nav-link.active { color: var(--primary); border-bottom: 3px solid var(--primary); background: transparent; }
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
            <a href="${pageContext.request.contextPath}/vendor/reviews"><i class="fas fa-star"></i>Reviews</a>
            <div class="menu-label">Finance</div>
            <a href="${pageContext.request.contextPath}/vendor/wallet"><i class="fas fa-wallet"></i>Wallet</a>
            <div class="menu-label">Settings</div>
            <a href="${pageContext.request.contextPath}/vendor/profile" class="active"><i class="fas fa-user-cog"></i>Profile</a>
            <a href="${pageContext.request.contextPath}/vendor/logout" class="text-danger"><i class="fas fa-sign-out-alt"></i>Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="top-navbar">
            <h5 class="mb-0">My Profile</h5>
            <small class="text-muted">Manage your store profile and settings</small>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        </c:if>

        <!-- Tabs -->
        <ul class="nav nav-tabs mb-4">
            <li class="nav-item">
                <a class="nav-link active" data-bs-toggle="tab" href="#storeInfo">Store Info</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#businessInfo">Business Details</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#documents">Documents</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#bankDetails">Bank Details</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#security">Security</a>
            </li>
        </ul>

        <div class="tab-content">
            <!-- Store Info Tab -->
            <div class="tab-pane fade show active" id="storeInfo">
                <form action="${pageContext.request.contextPath}/vendor/profile/update" method="post">
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="card">
                                <div class="card-header"><i class="fas fa-store me-2"></i>Store Information</div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Owner Full Name</label>
                                            <input type="text" class="form-control" name="ownerFullName" value="${vendor.ownerFullName}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Email</label>
                                            <input type="email" class="form-control" value="${vendor.email}" readonly>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Mobile Number</label>
                                            <input type="tel" class="form-control" name="mobileNumber" value="${vendor.mobileNumber}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Alternate Phone</label>
                                            <input type="tel" class="form-control" name="alternatePhone" value="${vendor.alternatePhone}">
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Store Display Name</label>
                                        <input type="text" class="form-control" name="storeDisplayName" value="${vendor.storeDisplayName}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Store Description</label>
                                        <textarea class="form-control" name="storeDescription" rows="4">${vendor.storeDescription}</textarea>
                                    </div>
                                    <h6 class="mt-4 mb-3">Social Media</h6>
                                    <div class="row">
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label"><i class="fas fa-globe me-2"></i>Website</label>
                                            <input type="url" class="form-control" name="websiteUrl" value="${vendor.websiteUrl}">
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label"><i class="fab fa-facebook me-2"></i>Facebook</label>
                                            <input type="url" class="form-control" name="facebookUrl" value="${vendor.facebookUrl}">
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label class="form-label"><i class="fab fa-instagram me-2"></i>Instagram</label>
                                            <input type="text" class="form-control" name="instagramHandle" value="${vendor.instagramHandle}">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary mt-3">
                                        <i class="fas fa-save me-2"></i>Save Changes
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="card">
                                <div class="card-body text-center">
                                    <img src="${not empty vendor.storeLogoUrl ? vendor.storeLogoUrl : pageContext.request.contextPath.concat('/images/default-store.png')}" alt="Store Logo" class="store-logo mb-3">
                                    <h5>${vendor.storeDisplayName}</h5>
                                    <span class="badge ${vendor.status == 'APPROVED' ? 'bg-success' : vendor.status == 'PENDING' ? 'bg-warning' : 'bg-danger'}">
                                        ${vendor.status.displayName}
                                    </span>
                                    <hr>
                                    <div class="text-start">
                                        <p class="mb-2"><strong>Member since:</strong><br><fmt:formatDate value="${vendor.createdAt}" pattern="dd MMMM yyyy"/></p>
                                        <p class="mb-2"><strong>Commission Rate:</strong><br>${vendor.commissionPercentage}%</p>
                                        <p class="mb-0"><strong>Payment Cycle:</strong><br>${vendor.paymentCycle.displayName}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Business Info Tab -->
            <div class="tab-pane fade" id="businessInfo">
                <div class="card">
                    <div class="card-header"><i class="fas fa-building me-2"></i>Business Details (Read Only)</div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Business Name</label>
                                <input type="text" class="form-control" value="${vendor.businessName}" readonly>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Business Type</label>
                                <input type="text" class="form-control" value="${vendor.businessType.displayName}" readonly>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">GST Number</label>
                                <input type="text" class="form-control" value="${vendor.gstNumber}" readonly>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">PAN Number</label>
                                <input type="text" class="form-control" value="${vendor.panNumber}" readonly>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Year Established</label>
                                <input type="text" class="form-control" value="${vendor.yearEstablished}" readonly>
                            </div>
                        </div>
                        <h6 class="mt-4 mb-3">Business Address</h6>
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label class="form-label">Address</label>
                                <input type="text" class="form-control" value="${vendor.businessAddressLine1}, ${vendor.businessAddressLine2}" readonly>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">City</label>
                                <input type="text" class="form-control" value="${vendor.businessCity}" readonly>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">State</label>
                                <input type="text" class="form-control" value="${vendor.businessState}" readonly>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">PIN Code</label>
                                <input type="text" class="form-control" value="${vendor.businessPinCode}" readonly>
                            </div>
                        </div>
                        <p class="text-muted mt-3"><i class="fas fa-info-circle me-2"></i>Contact admin to update business details.</p>
                    </div>
                </div>
            </div>

            <!-- Documents Tab -->
            <div class="tab-pane fade" id="documents">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-file-alt me-2"></i>Uploaded Documents</span>
                        <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#uploadDocModal">
                            <i class="fas fa-upload me-2"></i>Upload Document
                        </button>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty documents}">
                                <c:forEach items="${documents}" var="doc">
                                    <div class="doc-item">
                                        <div>
                                            <i class="fas fa-file-pdf text-danger me-2"></i>
                                            <strong>${doc.documentType.displayName}</strong>
                                            <br><small class="text-muted">${doc.documentName}</small>
                                        </div>
                                        <div>
                                            <span class="doc-status ${doc.verificationStatus == 'VERIFIED' ? 'bg-success text-white' : doc.verificationStatus == 'PENDING' ? 'bg-warning' : 'bg-danger text-white'}">
                                                ${doc.verificationStatus.displayName}
                                            </span>
                                            <a href="${doc.documentUrl}" target="_blank" class="btn btn-sm btn-outline-primary ms-2">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted text-center py-3">No documents uploaded yet</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Bank Details Tab -->
            <div class="tab-pane fade" id="bankDetails">
                <div class="card">
                    <div class="card-header"><i class="fas fa-university me-2"></i>Bank Details (Read Only)</div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Bank Name</label>
                                <input type="text" class="form-control" value="${vendor.bankName}" readonly>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Account Holder Name</label>
                                <input type="text" class="form-control" value="${vendor.accountHolderName}" readonly>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Account Number</label>
                                <input type="text" class="form-control" value="****${vendor.accountNumber.substring(vendor.accountNumber.length() - 4)}" readonly>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">IFSC Code</label>
                                <input type="text" class="form-control" value="${vendor.ifscCode}" readonly>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Account Type</label>
                                <input type="text" class="form-control" value="${vendor.accountType.displayName}" readonly>
                            </div>
                        </div>
                        <p class="text-muted mt-3"><i class="fas fa-info-circle me-2"></i>Contact admin to update bank details.</p>
                    </div>
                </div>
            </div>

            <!-- Security Tab -->
            <div class="tab-pane fade" id="security">
                <div class="card">
                    <div class="card-header"><i class="fas fa-lock me-2"></i>Change Password</div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/vendor/profile/change-password" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Current Password</label>
                                        <input type="password" class="form-control" name="currentPassword" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">New Password</label>
                                        <input type="password" class="form-control" name="newPassword" minlength="6" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Confirm New Password</label>
                                        <input type="password" class="form-control" name="confirmPassword" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-key me-2"></i>Update Password
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Upload Document Modal -->
    <div class="modal fade" id="uploadDocModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Upload Document</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/vendor/profile/upload-document" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Document Type</label>
                            <select class="form-select" name="documentType" required>
                                <option value="">Select Type</option>
                                <c:forEach items="${documentTypes}" var="type">
                                    <option value="${type}">${type.displayName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Select File</label>
                            <input type="file" class="form-control" name="document" accept=".pdf,.jpg,.jpeg,.png" required>
                            <small class="text-muted">PDF, JPG, PNG (Max 5MB)</small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Upload</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

