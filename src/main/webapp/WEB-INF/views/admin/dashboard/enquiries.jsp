<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Enquiries - Admin Dashboard</title>
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
        .status-badge.pending { background: #fef3c7; color: #d97706; }
        .status-badge.replied { background: #dbeafe; color: #1e40af; }
        .status-badge.quotation_sent { background: #d1fae5; color: #059669; }
        .status-badge.closed { background: #e5e7eb; color: #374151; }
        .status-badge.cancelled { background: #fee2e2; color: #dc2626; }
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
            <a href="${pageContext.request.contextPath}/admin/products" class="nav-item">
                <i class="fas fa-shopping-bag"></i>
                <span>All Products</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/enquiries" class="nav-item active">
                <i class="fas fa-envelope"></i>
                <span>All Enquiries</span>
                <c:if test="${stats.pendingEnquiries > 0}">
                    <span class="nav-badge">${stats.pendingEnquiries}</span>
                </c:if>
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
                <h1>All Enquiries</h1>
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
                <h1><i class="fas fa-envelope"></i> All Enquiries (${stats.totalEnquiries})</h1>
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search enquiries..." onkeyup="filterTable()">
                </div>
            </div>

            <div style="background: white; border-radius: 12px; overflow: hidden;">
                <c:choose>
                    <c:when test="${not empty enquiries}">
                        <table id="enquiriesTable">
                            <thead>
                                <tr>
                                    <th>Enquiry #</th>
                                    <th>User</th>
                                    <th>Hospital</th>
                                    <th>Condition</th>
                                    <th>Preferred Dates</th>
                                    <th>Status</th>
                                    <th>Created</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="enquiry" items="${enquiries}">
                                    <tr>
                                        <td>
                                            <strong style="color: var(--admin-accent);">${enquiry.enquiryNumber}</strong>
                                        </td>
                                        <td>
                                            <div>
                                                <strong>${enquiry.name != null ? enquiry.name : (enquiry.user != null ? enquiry.user.fullName : 'N/A')}</strong>
                                                <p style="margin: 4px 0 0; font-size: 0.85rem; color: #6b7280;">
                                                    ${enquiry.email != null ? enquiry.email : (enquiry.user != null ? enquiry.user.email : '-')}
                                                </p>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty enquiry.hospital}">
                                                    <span style="font-size: 0.9rem;">${enquiry.hospital.centerName}</span>
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty enquiry.condition}">
                                                    <span style="font-size: 0.85rem;">${fn:substring(enquiry.condition, 0, 30)}${fn:length(enquiry.condition) > 30 ? '...' : ''}</span>
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty enquiry.preferredStartDate && not empty enquiry.preferredEndDate}">
                                                    <div style="font-size: 0.85rem;">
                                                        <fmt:formatDate value="${enquiry.preferredStartDate}" pattern="dd MMM"/> - 
                                                        <fmt:formatDate value="${enquiry.preferredEndDate}" pattern="dd MMM yyyy"/>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="status-badge ${fn:toLowerCase(fn:replace(enquiry.status.toString(), '_', ''))}">
                                                ${fn:replace(enquiry.status.toString(), '_', ' ')}
                                            </span>
                                        </td>
                                        <td>
                                            <fmt:parseDate value="${enquiry.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                            <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/enquiries/${enquiry.id}" class="btn-action view">
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
                            <i class="fas fa-envelope"></i>
                            <h3>No enquiries found</h3>
                            <p>There are no enquiries yet.</p>
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
            const table = document.getElementById('enquiriesTable');
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

