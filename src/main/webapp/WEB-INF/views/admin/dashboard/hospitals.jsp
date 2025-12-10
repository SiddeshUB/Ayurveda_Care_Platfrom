<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Hospitals - Admin Dashboard</title>
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
            --admin-dark: #0f0f23;
        }
        
        .sidebar {
            background: linear-gradient(180deg, var(--admin-primary) 0%, var(--admin-dark) 100%);
        }
        
        .sidebar-logo .highlight {
            color: var(--admin-accent);
        }
        
        .nav-item.active {
            border-left-color: var(--admin-accent);
        }
        
        .nav-badge {
            background: #ef4444;
        }
        
        .filter-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }
        
        .filter-tab {
            padding: 10px 20px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.9rem;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 2px solid #e5e7eb;
            color: #6b7280;
            background: white;
        }
        
        .filter-tab:hover {
            border-color: var(--admin-accent);
            color: var(--admin-primary);
        }
        
        .filter-tab.active {
            background: var(--admin-primary);
            color: white;
            border-color: var(--admin-primary);
        }
        
        .filter-tab .count {
            background: rgba(255, 255, 255, 0.2);
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 0.8rem;
            margin-left: 6px;
        }
        
        .filter-tab.active .count {
            background: rgba(255, 255, 255, 0.3);
        }
        
        .hospitals-table {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        
        .hospitals-table table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .hospitals-table th {
            background: #f8fafc;
            padding: 16px 20px;
            text-align: left;
            font-weight: 700;
            font-size: 0.85rem;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .hospitals-table td {
            padding: 20px;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }
        
        .hospitals-table tr:last-child td {
            border-bottom: none;
        }
        
        .hospitals-table tr:hover {
            background: #fafbfc;
        }
        
        .hospital-cell {
            display: flex;
            align-items: center;
            gap: 14px;
        }
        
        .hospital-avatar {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--admin-primary), var(--admin-secondary));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            flex-shrink: 0;
            overflow: hidden;
        }
        
        .hospital-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .hospital-details h4 {
            margin: 0 0 4px;
            font-size: 1rem;
            color: var(--admin-primary);
        }
        
        .hospital-details p {
            margin: 0;
            font-size: 0.85rem;
            color: #64748b;
        }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .status-badge.pending {
            background: #fef3c7;
            color: #d97706;
        }
        
        .status-badge.approved {
            background: #d1fae5;
            color: #059669;
        }
        
        .status-badge.rejected {
            background: #fee2e2;
            color: #dc2626;
        }
        
        .status-badge.suspended {
            background: #f3f4f6;
            color: #6b7280;
        }
        
        .verified-badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            color: #10b981;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .verified-badge i {
            font-size: 1rem;
        }
        
        .unverified-badge {
            color: #9ca3af;
            font-size: 0.85rem;
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        .btn-action {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }
        
        .btn-action.view {
            background: #e0f2fe;
            color: #0284c7;
        }
        
        .btn-action.view:hover {
            background: #0284c7;
            color: white;
        }
        
        .btn-action.approve {
            background: #d1fae5;
            color: #059669;
        }
        
        .btn-action.approve:hover {
            background: #059669;
            color: white;
        }
        
        .btn-action.reject {
            background: #fee2e2;
            color: #dc2626;
        }
        
        .btn-action.reject:hover {
            background: #dc2626;
            color: white;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #9ca3af;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: #d1d5db;
        }
        
        .empty-state h3 {
            color: #6b7280;
            margin-bottom: 10px;
        }
        
        .empty-state p {
            margin: 0;
        }
        
        .date-cell {
            font-size: 0.9rem;
            color: #64748b;
        }
        
        .date-cell small {
            display: block;
            color: #9ca3af;
            font-size: 0.8rem;
        }
        
        .page-title-section {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
        }
        
        .page-title-section h1 {
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .page-title-section h1 i {
            color: var(--admin-accent);
        }
        
        .search-box {
            position: relative;
            width: 300px;
        }
        
        .search-box input {
            width: 100%;
            padding: 12px 20px 12px 45px;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }
        
        .search-box input:focus {
            outline: none;
            border-color: var(--admin-accent);
        }
        
        .search-box i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-success {
            background: #d1fae5;
            color: #059669;
        }
        
        .alert-error {
            background: #fee2e2;
            color: #dc2626;
        }
    </style>
</head>
<body class="dashboard-body">
    <!-- Sidebar -->
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
            <a href="${pageContext.request.contextPath}/admin/hospitals" class="nav-item ${empty currentStatus ? 'active' : ''}">
                <i class="fas fa-hospital"></i>
                <span>All Hospitals</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/hospitals?status=PENDING" class="nav-item ${currentStatus == 'PENDING' ? 'active' : ''}">
                <i class="fas fa-clock"></i>
                <span>Pending Approval</span>
                <c:if test="${stats.pendingHospitals > 0}">
                    <span class="nav-badge">${stats.pendingHospitals}</span>
                </c:if>
            </a>
            <a href="${pageContext.request.contextPath}/admin/hospitals?status=APPROVED" class="nav-item ${currentStatus == 'APPROVED' ? 'active' : ''}">
                <i class="fas fa-check-circle"></i>
                <span>Approved</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/hospitals?status=REJECTED" class="nav-item ${currentStatus == 'REJECTED' ? 'active' : ''}">
                <i class="fas fa-times-circle"></i>
                <span>Rejected</span>
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
            <a href="${pageContext.request.contextPath}/admin/products" class="nav-item">
                <i class="fas fa-shopping-bag"></i>
                <span>All Products</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline btn-sm" target="_blank">
                <i class="fas fa-external-link-alt"></i> View Website
            </a>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="dashboard-main">
        <!-- Top Bar -->
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Manage Hospitals</h1>
            </div>
            
            <div class="header-right">
                <div class="header-notifications">
                    <button class="notification-btn">
                        <i class="fas fa-bell"></i>
                        <c:if test="${stats.pendingHospitals > 0}">
                            <span class="notification-badge">${stats.pendingHospitals}</span>
                        </c:if>
                    </button>
                </div>
                
                <div class="header-profile">
                    <div class="profile-info">
                        <span class="profile-name">${admin.fullName}</span>
                        <span style="font-size: 0.8rem; color: #9ca3af;">Administrator</span>
                    </div>
                    <div class="profile-avatar">
                        <i class="fas fa-user-shield"></i>
                    </div>
                </div>
            </div>
        </header>

        <!-- Dashboard Content -->
        <div class="dashboard-content">
            <!-- Alert Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <!-- Page Title -->
            <div class="page-title-section">
                <h1>
                    <i class="fas fa-hospital"></i>
                    <c:choose>
                        <c:when test="${currentStatus == 'PENDING'}">Pending Hospitals</c:when>
                        <c:when test="${currentStatus == 'APPROVED'}">Approved Hospitals</c:when>
                        <c:when test="${currentStatus == 'REJECTED'}">Rejected Hospitals</c:when>
                        <c:when test="${currentStatus == 'SUSPENDED'}">Suspended Hospitals</c:when>
                        <c:otherwise>All Hospitals</c:otherwise>
                    </c:choose>
                </h1>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search hospitals..." onkeyup="filterTable()">
                </div>
            </div>
            
            <!-- Filter Tabs -->
            <div class="filter-tabs">
                <a href="${pageContext.request.contextPath}/admin/hospitals" class="filter-tab ${empty currentStatus ? 'active' : ''}">
                    All <span class="count">${stats.totalHospitals}</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/hospitals?status=PENDING" class="filter-tab ${currentStatus == 'PENDING' ? 'active' : ''}">
                    Pending <span class="count">${stats.pendingHospitals}</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/hospitals?status=APPROVED" class="filter-tab ${currentStatus == 'APPROVED' ? 'active' : ''}">
                    Approved <span class="count">${stats.approvedHospitals}</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/hospitals?status=REJECTED" class="filter-tab ${currentStatus == 'REJECTED' ? 'active' : ''}">
                    Rejected <span class="count">${stats.rejectedHospitals}</span>
                </a>
            </div>
            
            <!-- Hospitals Table -->
            <div class="hospitals-table">
                <c:choose>
                    <c:when test="${not empty hospitals}">
                        <table id="hospitalsTable">
                            <thead>
                                <tr>
                                    <th>Hospital</th>
                                    <th>Location</th>
                                    <th>Status</th>
                                    <th>Verified</th>
                                    <th>Registered</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="hospital" items="${hospitals}">
                                    <tr>
                                        <td>
                                            <div class="hospital-cell">
                                                <div class="hospital-avatar">
                                                    <c:choose>
                                                        <c:when test="${not empty hospital.logoUrl}">
                                                            <img src="${pageContext.request.contextPath}${hospital.logoUrl}" alt="${hospital.centerName}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-hospital"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="hospital-details">
                                                    <h4>${hospital.centerName}</h4>
                                                    <p>${hospital.email}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="hospital-details">
                                                <p style="color: #374151; font-weight: 500;">${hospital.city}</p>
                                                <p>${hospital.state}</p>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="status-badge ${hospital.status.toString().toLowerCase()}">
                                                <c:choose>
                                                    <c:when test="${hospital.status == 'PENDING'}">
                                                        <i class="fas fa-clock"></i>
                                                    </c:when>
                                                    <c:when test="${hospital.status == 'APPROVED'}">
                                                        <i class="fas fa-check"></i>
                                                    </c:when>
                                                    <c:when test="${hospital.status == 'REJECTED'}">
                                                        <i class="fas fa-times"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-ban"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                                ${hospital.status}
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${hospital.isVerified}">
                                                    <span class="verified-badge">
                                                        <i class="fas fa-check-circle"></i> Verified
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="unverified-badge">Not Verified</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="date-cell">
                                            <fmt:parseDate value="${hospital.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                            <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                            <small><fmt:formatDate value="${parsedDate}" pattern="hh:mm a"/></small>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}" class="btn-action view" title="View Details">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}/complete" class="btn-action" title="View Complete Details" style="background: #10b981; color: white;">
                                                    <i class="fas fa-list-alt"></i>
                                                </a>
                                                <c:if test="${hospital.status == 'PENDING'}">
                                                    <form action="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}/approve" method="post" style="display: inline;">
                                                        <button type="submit" class="btn-action approve" title="Approve">
                                                            <i class="fas fa-check"></i>
                                                        </button>
                                                    </form>
                                                    <form action="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}/reject" method="post" style="display: inline;">
                                                        <button type="submit" class="btn-action reject" title="Reject">
                                                            <i class="fas fa-times"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-hospital"></i>
                            <h3>No hospitals found</h3>
                            <p>There are no hospitals matching your criteria.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <script>
        // Sidebar toggle for mobile
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
            });
        }
        
        // Table search filter
        function filterTable() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.getElementById('hospitalsTable');
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
        
        // Auto-dismiss alerts
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                alert.style.opacity = '0';
                alert.style.transition = 'opacity 0.5s ease';
                setTimeout(function() {
                    alert.remove();
                }, 500);
            });
        }, 5000);
    </script>
</body>
</html>

