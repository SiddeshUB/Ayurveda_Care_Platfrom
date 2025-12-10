<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wallet - Vendor Dashboard</title>
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
        .card-header { background: white; border-bottom: 1px solid #eee; padding: 20px; font-weight: 600; }
        .wallet-card { background: linear-gradient(135deg, #2d5a27 0%, #4a7c43 100%); color: white; border-radius: 20px; padding: 30px; }
        .wallet-card h2 { font-size: 2.5rem; font-weight: 700; }
        .balance-item { background: rgba(255,255,255,0.1); border-radius: 10px; padding: 15px; margin-top: 15px; }
        .txn-icon { width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; }
        .txn-credit { background: #d4edda; color: #155724; }
        .txn-debit { background: #f8d7da; color: #721c24; }
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
            <a href="${pageContext.request.contextPath}/vendor/wallet" class="active"><i class="fas fa-wallet"></i>Wallet</a>
            <div class="menu-label">Settings</div>
            <a href="${pageContext.request.contextPath}/vendor/profile"><i class="fas fa-user-cog"></i>Profile</a>
            <a href="${pageContext.request.contextPath}/vendor/logout" class="text-danger"><i class="fas fa-sign-out-alt"></i>Logout</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="top-navbar">
            <h5 class="mb-0">My Wallet</h5>
            <small class="text-muted">View your earnings and transactions</small>
        </div>

        <div class="row">
            <!-- Wallet Balance Card -->
            <div class="col-lg-4 mb-4">
                <div class="wallet-card">
                    <p class="mb-1 opacity-75">Available Balance</p>
                    <h2>₹<fmt:formatNumber value="${wallet.availableBalance}" pattern="#,##0.00"/></h2>
                    
                    <div class="balance-item">
                        <div class="d-flex justify-content-between">
                            <span class="opacity-75">Pending</span>
                            <strong>₹<fmt:formatNumber value="${wallet.pendingBalance}"/></strong>
                        </div>
                    </div>
                    
                    <div class="mt-4">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="opacity-75">Total Earnings</span>
                            <strong>₹<fmt:formatNumber value="${wallet.totalEarnings}"/></strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="opacity-75">Commission Paid</span>
                            <strong>₹<fmt:formatNumber value="${wallet.totalCommissionDeducted}"/></strong>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="opacity-75">Total Withdrawn</span>
                            <strong>₹<fmt:formatNumber value="${wallet.totalWithdrawn}"/></strong>
                        </div>
                    </div>
                </div>

                <!-- Commission Info -->
                <div class="card mt-4">
                    <div class="card-body">
                        <h6><i class="fas fa-info-circle text-info me-2"></i>Commission Info</h6>
                        <p class="mb-2">Your commission rate: <strong>${vendor.commissionPercentage}%</strong></p>
                        <p class="mb-2">Payment cycle: <strong>${vendor.paymentCycle.displayName}</strong></p>
                        <p class="mb-0">Min payout: <strong>₹${vendor.minPayoutThreshold}</strong></p>
                    </div>
                </div>
            </div>

            <!-- Transactions -->
            <div class="col-lg-8 mb-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-history me-2"></i>Transaction History</span>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty transactions.content}">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Transaction</th>
                                                <th>Description</th>
                                                <th>Date</th>
                                                <th class="text-end">Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${transactions.content}" var="txn">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="txn-icon ${txn.type == 'ORDER_CREDIT' ? 'txn-credit' : 'txn-debit'} me-3">
                                                                <i class="fas fa-${txn.type == 'ORDER_CREDIT' ? 'arrow-down' : 'arrow-up'}"></i>
                                                            </div>
                                                            <div>
                                                                <strong>${txn.type.displayName}</strong>
                                                                <br><small class="text-muted">${txn.transactionId}</small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        ${txn.description}
                                                        <c:if test="${not empty txn.orderNumber}">
                                                            <br><small class="text-muted">Order: ${txn.orderNumber}</small>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${txn.createdAt}" pattern="dd MMM yyyy"/>
                                                        <br><small class="text-muted"><fmt:formatDate value="${txn.createdAt}" pattern="hh:mm a"/></small>
                                                    </td>
                                                    <td class="text-end">
                                                        <strong class="${txn.type == 'ORDER_CREDIT' ? 'text-success' : 'text-danger'}">
                                                            ${txn.type == 'ORDER_CREDIT' ? '+' : '-'}₹<fmt:formatNumber value="${txn.netAmount}"/>
                                                        </strong>
                                                        <c:if test="${txn.commissionAmount != null && txn.commissionAmount > 0}">
                                                            <br><small class="text-muted">Commission: ₹<fmt:formatNumber value="${txn.commissionAmount}"/></small>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <c:if test="${transactions.totalPages > 1}">
                                    <nav class="p-3">
                                        <ul class="pagination justify-content-center mb-0">
                                            <li class="page-item ${transactions.first ? 'disabled' : ''}">
                                                <a class="page-link" href="?page=${transactions.number - 1}">Previous</a>
                                            </li>
                                            <c:forEach begin="0" end="${transactions.totalPages - 1}" var="i">
                                                <c:if test="${i < 5 || i > transactions.totalPages - 3 || (i >= transactions.number - 1 && i <= transactions.number + 1)}">
                                                    <li class="page-item ${transactions.number == i ? 'active' : ''}">
                                                        <a class="page-link" href="?page=${i}">${i + 1}</a>
                                                    </li>
                                                </c:if>
                                            </c:forEach>
                                            <li class="page-item ${transactions.last ? 'disabled' : ''}">
                                                <a class="page-link" href="?page=${transactions.number + 1}">Next</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-wallet fa-4x text-muted mb-3"></i>
                                    <h5>No Transactions Yet</h5>
                                    <p class="text-muted">Your transaction history will appear here</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

