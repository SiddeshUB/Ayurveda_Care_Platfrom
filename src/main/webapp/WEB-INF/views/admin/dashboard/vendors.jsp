<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="All Vendors" scope="request"/>
<c:choose>
    <c:when test="${not empty currentStatus && currentStatus == 'PENDING'}">
        <c:set var="activePage" value="pending-vendors" scope="request"/>
    </c:when>
    <c:otherwise>
        <c:set var="activePage" value="vendors" scope="request"/>
    </c:otherwise>
</c:choose>
<%@ include file="/WEB-INF/views/admin/layouts/admin-header.jsp" %>
<style>
        .stats-card { border-radius: 10px; padding: 20px; color: white; margin-bottom: 20px; }
        .stats-card.pending { background: linear-gradient(135deg, #f6d365, #fda085); }
        .stats-card.approved { background: linear-gradient(135deg, #11998e, #38ef7d); }
        .stats-card.total { background: linear-gradient(135deg, #667eea, #764ba2); }
        .status-badge { padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 500; }
        .vendor-avatar { width: 50px; height: 50px; border-radius: 50%; object-fit: cover; background: #eee; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; color: #666; }
        .filter-tabs { display: flex; gap: 10px; margin-bottom: 24px; flex-wrap: wrap; }
        .filter-tab { padding: 10px 20px; border-radius: 25px; font-weight: 600; font-size: 0.9rem; text-decoration: none; transition: all 0.3s ease; border: 2px solid #e5e7eb; color: #6b7280; background: white; }
        .filter-tab:hover { border-color: var(--admin-accent); color: var(--admin-primary); }
        .filter-tab.active { background: var(--admin-primary); color: white; border-color: var(--admin-primary); }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden; }
        table thead { background: #f9fafb; }
        table th { padding: 16px; text-align: left; font-weight: 600; color: #374151; border-bottom: 2px solid #e5e7eb; }
        table td { padding: 16px; border-bottom: 1px solid #e5e7eb; }
        table tbody tr:hover { background: #f9fafb; }
        .btn-action { padding: 8px 12px; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; font-size: 0.9rem; }
        .btn-action.view { background: #dbeafe; color: #1e40af; }
        .btn-action.view:hover { background: #1e40af; color: white; }
        .empty-state { text-align: center; padding: 60px 20px; color: #9ca3af; }
        .empty-state i { font-size: 4rem; margin-bottom: 20px; color: #d1d5db; }
        .alert { padding: 15px 20px; border-radius: 10px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .alert-success { background: #d1fae5; color: #059669; }
        .alert-error { background: #fee2e2; color: #dc2626; }
</style>
            <div class="page-title-section">
                <h1><i class="fas fa-store"></i> All Vendors</h1>
            </div>

            <c:if test="${not empty success}">
                <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${error}</div>
            </c:if>

            <!-- Stats -->
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 24px;">
                <div class="stats-card pending">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <h3 style="margin: 0; font-size: 2rem;">${pendingCount}</h3>
                            <p style="margin: 5px 0 0; opacity: 0.9;">Pending Approval</p>
                        </div>
                        <i class="fas fa-clock" style="font-size: 2.5rem; opacity: 0.5;"></i>
                    </div>
                </div>
                <div class="stats-card approved">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <h3 style="margin: 0; font-size: 2rem;">${totalVendors - pendingCount}</h3>
                            <p style="margin: 5px 0 0; opacity: 0.9;">Active Vendors</p>
                        </div>
                        <i class="fas fa-check-circle" style="font-size: 2.5rem; opacity: 0.5;"></i>
                    </div>
                </div>
                <div class="stats-card total">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <h3 style="margin: 0; font-size: 2rem;">${totalVendors}</h3>
                            <p style="margin: 5px 0 0; opacity: 0.9;">Total Vendors</p>
                        </div>
                        <i class="fas fa-store" style="font-size: 2.5rem; opacity: 0.5;"></i>
                    </div>
                </div>
            </div>

            <!-- Filter Tabs -->
            <div class="filter-tabs">
                <a href="${pageContext.request.contextPath}/admin/vendors" class="filter-tab ${empty currentStatus || currentStatus == 'all' ? 'active' : ''}">All</a>
                <a href="${pageContext.request.contextPath}/admin/vendors?status=PENDING" class="filter-tab ${currentStatus == 'PENDING' ? 'active' : ''}">
                    Pending <c:if test="${pendingCount > 0}"><span style="background: rgba(255,255,255,0.2); padding: 2px 8px; border-radius: 10px; font-size: 0.8rem; margin-left: 6px;">${pendingCount}</span></c:if>
                </a>
                <a href="${pageContext.request.contextPath}/admin/vendors?status=APPROVED" class="filter-tab ${currentStatus == 'APPROVED' ? 'active' : ''}">Approved</a>
                <a href="${pageContext.request.contextPath}/admin/vendors?status=REJECTED" class="filter-tab ${currentStatus == 'REJECTED' ? 'active' : ''}">Rejected</a>
                <a href="${pageContext.request.contextPath}/admin/vendors?status=SUSPENDED" class="filter-tab ${currentStatus == 'SUSPENDED' ? 'active' : ''}">Suspended</a>
                <a href="${pageContext.request.contextPath}/admin/vendors?status=BLOCKED" class="filter-tab ${currentStatus == 'BLOCKED' ? 'active' : ''}">Blocked</a>
            </div>

            <!-- Vendors Table -->
            <div style="background: white; border-radius: 12px; overflow: hidden;">
                <c:choose>
                    <c:when test="${not empty vendors.content}">
                        <table>
                            <thead>
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
                                            <div style="display: flex; align-items: center; gap: 12px;">
                                                <div class="vendor-avatar">
                                                    <c:choose>
                                                        <c:when test="${not empty vendor.storeLogoUrl}">
                                                            <img src="${pageContext.request.contextPath}${vendor.storeLogoUrl}" alt="${vendor.storeDisplayName}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-store"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div>
                                                    <strong>${vendor.storeDisplayName}</strong>
                                                    <br><small style="color: #6b7280; font-size: 0.85rem;">${vendor.ownerFullName}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span style="font-size: 0.9rem;">${vendor.businessName}</span>
                                            <br><small style="color: #6b7280; font-size: 0.85rem;">${vendor.businessType != null ? vendor.businessType.displayName : '-'}</small>
                                        </td>
                                        <td>
                                            <span style="font-size: 0.9rem;">${vendor.email}</span>
                                            <br><small style="color: #6b7280; font-size: 0.85rem;">${vendor.mobileNumber}</small>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${vendor.commissionPercentage != null}">
                                                    <strong style="color: var(--admin-accent);">${vendor.commissionPercentage}%</strong>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #9ca3af;">Not set</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="status-badge" style="
                                                ${vendor.status == 'PENDING' ? 'background: #fef3c7; color: #d97706;' : ''}
                                                ${vendor.status == 'APPROVED' ? 'background: #d1fae5; color: #059669;' : ''}
                                                ${vendor.status == 'REJECTED' ? 'background: #fee2e2; color: #dc2626;' : ''}
                                                ${vendor.status == 'SUSPENDED' ? 'background: #e5e7eb; color: #374151;' : ''}
                                                ${vendor.status == 'BLOCKED' ? 'background: #1f2937; color: white;' : ''}
                                            ">
                                                ${vendor.status != null ? vendor.status.displayName : 'Unknown'}
                                            </span>
                                        </td>
                                        <td>
                                            <c:if test="${vendor.createdAt != null}">
                                                ${vendor.createdAt}
                                            </c:if>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/vendors/${vendor.id}" class="btn-action view">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- Pagination -->
                        <c:if test="${vendors.totalPages > 1}">
                            <div style="padding: 20px; text-align: center;">
                                <div style="display: inline-flex; gap: 8px; align-items: center;">
                                    <a href="?status=${currentStatus}&page=${vendors.number - 1}" style="padding: 8px 16px; border: 2px solid #e5e7eb; border-radius: 8px; text-decoration: none; color: #374151; ${vendors.first ? 'opacity: 0.5; pointer-events: none;' : ''}">
                                        <i class="fas fa-chevron-left"></i> Previous
                                    </a>
                                    <c:forEach begin="0" end="${vendors.totalPages - 1}" var="i">
                                        <a href="?status=${currentStatus}&page=${i}" style="padding: 8px 16px; border: 2px solid ${vendors.number == i ? 'var(--admin-primary)' : '#e5e7eb'}; border-radius: 8px; text-decoration: none; color: ${vendors.number == i ? 'white' : '#374151'}; background: ${vendors.number == i ? 'var(--admin-primary)' : 'white'};">
                                            ${i + 1}
                                        </a>
                                    </c:forEach>
                                    <a href="?status=${currentStatus}&page=${vendors.number + 1}" style="padding: 8px 16px; border: 2px solid #e5e7eb; border-radius: 8px; text-decoration: none; color: #374151; ${vendors.last ? 'opacity: 0.5; pointer-events: none;' : ''}">
                                        Next <i class="fas fa-chevron-right"></i>
                                    </a>
                                </div>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-store"></i>
                            <h3>No vendors found</h3>
                            <p>No vendors match the selected filter.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
<%@ include file="/WEB-INF/views/admin/layouts/admin-footer.jsp" %>

