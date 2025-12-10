<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="All Enquiries" scope="request"/>
<c:set var="activePage" value="enquiries" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layouts/admin-header.jsp" %>
<style>
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
<%@ include file="/WEB-INF/views/admin/layouts/admin-footer.jsp" %>

