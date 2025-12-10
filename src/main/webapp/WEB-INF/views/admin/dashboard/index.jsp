<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Dashboard" scope="request"/>
<c:set var="activePage" value="dashboard" scope="request"/>
<%@ include file="/WEB-INF/views/admin/layouts/admin-header.jsp" %>
<style>
        .welcome-banner {
            background: linear-gradient(135deg, var(--admin-primary), var(--admin-secondary));
        }
        
        .btn-gold {
            background: linear-gradient(135deg, var(--admin-accent), #d4b07a);
            color: var(--admin-dark);
        }
        
        .stat-icon.hospitals {
            background: linear-gradient(135deg, var(--admin-accent), #d4b07a);
            color: var(--admin-dark);
        }
        
        .stat-icon.pending {
            background: linear-gradient(135deg, #f59e0b, #fbbf24);
            color: white;
        }
        
        .stat-icon.approved {
            background: linear-gradient(135deg, #10b981, #34d399);
            color: white;
        }
        
        .stat-icon.reviews {
            background: linear-gradient(135deg, #8b5cf6, #a78bfa);
            color: white;
        }
        
        .admin-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: var(--admin-accent);
            color: var(--admin-dark);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
        }
        
        .hospital-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 12px;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .hospital-card:hover {
            border-color: var(--admin-accent);
            transform: translateX(5px);
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
            font-size: 1.25rem;
        }
        
        .hospital-info {
            flex: 1;
        }
        
        .hospital-info h4 {
            margin: 0 0 4px;
            font-size: 1rem;
        }
        
        .hospital-info p {
            margin: 0;
            font-size: 0.85rem;
            color: #6b7280;
        }
        
        .hospital-status {
            text-align: right;
        }
        
        .status-badge {
            display: inline-block;
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
        
        .hospital-date {
            display: block;
            font-size: 0.75rem;
            color: #9ca3af;
            margin-top: 4px;
        }
        
        .quick-stat {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px 20px;
            background: #f8fafc;
            border-radius: 10px;
            margin-bottom: 10px;
        }
        
        .quick-stat-label {
            color: #64748b;
            font-size: 0.9rem;
        }
        
        .quick-stat-value {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--admin-primary);
        }
        
        .action-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.9rem;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .action-btn.primary {
            background: var(--admin-primary);
            color: white;
        }
        
        .action-btn.primary:hover {
            background: var(--admin-secondary);
        }
        
        .action-btn.gold {
            background: var(--admin-accent);
            color: var(--admin-dark);
        }
        
        .action-btn.gold:hover {
            background: #d4b07a;
        }
        
        .empty-state-admin {
            text-align: center;
            padding: 40px;
            color: #9ca3af;
        }
        
        .empty-state-admin i {
            font-size: 3rem;
            margin-bottom: 15px;
            color: #d1d5db;
        }
        
        .empty-state-admin p {
            margin: 0;
            font-size: 1rem;
        }
    </style>
            <!-- Welcome Banner -->
            <div class="welcome-banner">
                <div class="welcome-text">
                    <h2>Welcome back, ${admin != null ? admin.fullName : 'Admin'}!</h2>
                    <p>Here's an overview of the platform status and pending approvals.</p>
                </div>
                <div class="welcome-actions">
                    <a href="${pageContext.request.contextPath}/admin/hospitals?status=PENDING" class="btn btn-gold">
                        <i class="fas fa-clock"></i> Review Pending (${stats.pendingHospitals})
                    </a>
                </div>
            </div>

            <!-- Alert Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success" style="margin-bottom: 20px; padding: 15px 20px; background: #d1fae5; color: #059669; border-radius: 10px; display: flex; align-items: center; gap: 10px;">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error" style="margin-bottom: 20px; padding: 15px 20px; background: #fee2e2; color: #dc2626; border-radius: 10px; display: flex; align-items: center; gap: 10px;">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <!-- Stats Grid -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon hospitals">
                        <i class="fas fa-hospital"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${stats.totalHospitals}</h3>
                        <p>Total Hospitals</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon pending">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${stats.pendingHospitals}</h3>
                        <p>Pending Approval</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon approved">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${stats.approvedHospitals}</h3>
                        <p>Approved Hospitals</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon reviews">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${stats.totalReviews}</h3>
                        <p>Total Reviews</p>
                    </div>
                </div>
            </div>

            <!-- Two Column Layout -->
            <div class="dashboard-grid">
                <!-- Pending Approvals -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3><i class="fas fa-clock" style="color: #f59e0b; margin-right: 8px;"></i>Pending Approvals</h3>
                        <a href="${pageContext.request.contextPath}/admin/hospitals?status=PENDING" class="view-all">View All</a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty pendingHospitals}">
                                <c:forEach var="hospital" items="${pendingHospitals}" end="4">
                                    <a href="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}" class="hospital-card">
                                        <div class="hospital-avatar">
                                            <c:choose>
                                                <c:when test="${not empty hospital.logoUrl}">
                                                    <img src="${pageContext.request.contextPath}${hospital.logoUrl}" alt="" style="width: 100%; height: 100%; object-fit: cover; border-radius: 12px;">
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-hospital"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="hospital-info">
                                            <h4>${hospital.centerName}</h4>
                                            <p><i class="fas fa-map-marker-alt"></i> ${hospital.city}, ${hospital.state}</p>
                                        </div>
                                        <div class="hospital-status">
                                            <span class="status-badge pending">Pending</span>
                                            <span class="hospital-date">
                                                <fmt:parseDate value="${hospital.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                                <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                            </span>
                                        </div>
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state-admin">
                                    <i class="fas fa-check-double"></i>
                                    <p>No pending approvals</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Recent Registrations -->
                <div class="dashboard-card">
                    <div class="card-header">
                        <h3><i class="fas fa-history" style="color: var(--admin-accent); margin-right: 8px;"></i>Recent Registrations</h3>
                        <a href="${pageContext.request.contextPath}/admin/hospitals" class="view-all">View All</a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty recentHospitals}">
                                <c:forEach var="hospital" items="${recentHospitals}">
                                    <a href="${pageContext.request.contextPath}/admin/hospitals/${hospital.id}" class="hospital-card">
                                        <div class="hospital-avatar">
                                            <c:choose>
                                                <c:when test="${not empty hospital.logoUrl}">
                                                    <img src="${pageContext.request.contextPath}${hospital.logoUrl}" alt="" style="width: 100%; height: 100%; object-fit: cover; border-radius: 12px;">
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-hospital"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="hospital-info">
                                            <h4>${hospital.centerName}</h4>
                                            <p>${hospital.email}</p>
                                        </div>
                                        <div class="hospital-status">
                                            <span class="status-badge ${hospital.status.toString().toLowerCase()}">${hospital.status}</span>
                                            <span class="hospital-date">
                                                <fmt:parseDate value="${hospital.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                                <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                            </span>
                                        </div>
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state-admin">
                                    <i class="fas fa-hospital"></i>
                                    <p>No hospitals registered yet</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Recent Bookings -->
                <div class="dashboard-card" style="margin-top: 24px;">
                    <div class="card-header">
                        <h3><i class="fas fa-book" style="color: var(--admin-accent); margin-right: 8px;"></i>Recent Bookings</h3>
                        <a href="${pageContext.request.contextPath}/admin/bookings" class="view-all">View All</a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty recentBookings}">
                                <c:forEach var="booking" items="${recentBookings}">
                                    <a href="${pageContext.request.contextPath}/admin/bookings/${booking.id}" class="hospital-card">
                                        <div class="hospital-avatar">
                                            <i class="fas fa-calendar-check"></i>
                                        </div>
                                        <div class="hospital-info">
                                            <h4>${booking.patientName}</h4>
                                            <p>
                                                <c:if test="${booking.treatmentPackage != null}">
                                                    ${booking.treatmentPackage.packageName}
                                                    <c:if test="${booking.roomType != null}">
                                                        • ${fn:replace(booking.roomType, '_', ' ')} Room
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${booking.hospital != null}">
                                                    • ${booking.hospital.centerName}
                                                </c:if>
                                            </p>
                                        </div>
                                        <div class="hospital-status">
                                            <span class="status-badge ${booking.status.toString().toLowerCase()}">${booking.status}</span>
                                            <span class="hospital-date">
                                                <fmt:parseDate value="${booking.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                                <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy"/>
                                            </span>
                                        </div>
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state-admin">
                                    <i class="fas fa-book"></i>
                                    <p>No bookings yet</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Quick Stats Summary -->
            <div class="dashboard-card" style="margin-top: 24px;">
                <div class="card-header">
                    <h3><i class="fas fa-chart-pie" style="color: var(--admin-accent); margin-right: 8px;"></i>Platform Overview</h3>
                </div>
                <div class="card-body">
                    <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px;">
                        <div class="quick-stat">
                            <span class="quick-stat-label">Verified Hospitals</span>
                            <span class="quick-stat-value">${stats.verifiedHospitals}</span>
                        </div>
                        <div class="quick-stat">
                            <span class="quick-stat-label">Rejected</span>
                            <span class="quick-stat-value">${stats.rejectedHospitals}</span>
                        </div>
                        <div class="quick-stat">
                            <span class="quick-stat-label">Total Bookings</span>
                            <span class="quick-stat-value">${stats.totalBookings}</span>
                        </div>
                        <div class="quick-stat">
                            <span class="quick-stat-label">Total Reviews</span>
                            <span class="quick-stat-value">${stats.totalReviews}</span>
                        </div>
                    </div>
                </div>
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
<%@ include file="/WEB-INF/views/admin/layouts/admin-footer.jsp" %>

