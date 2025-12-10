<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${hospital.centerName} - Complete Details - Admin Dashboard</title>
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
        
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #64748b;
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 20px;
            transition: color 0.3s ease;
        }
        
        .back-link:hover {
            color: var(--admin-primary);
        }
        
        .hospital-header {
            background: white;
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        
        .hospital-header-content {
            display: flex;
            align-items: flex-start;
            gap: 24px;
        }
        
        .hospital-logo {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, var(--admin-primary), var(--admin-secondary));
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2.5rem;
            flex-shrink: 0;
            overflow: hidden;
        }
        
        .hospital-logo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .hospital-header-info h1 {
            margin: 0 0 8px;
            font-size: 1.8rem;
            color: var(--admin-primary);
        }
        
        .hospital-badges {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 12px;
        }
        
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .badge.status-approved {
            background: #d1fae5;
            color: #059669;
        }
        
        .badge.status-pending {
            background: #fef3c7;
            color: #d97706;
        }
        
        /* Tabs */
        .tabs-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        
        .tabs-header {
            display: flex;
            border-bottom: 2px solid #e5e7eb;
            background: #f8fafc;
            overflow-x: auto;
        }
        
        .tab-button {
            padding: 16px 24px;
            border: none;
            background: transparent;
            font-weight: 600;
            font-size: 0.95rem;
            color: #64748b;
            cursor: pointer;
            transition: all 0.3s ease;
            border-bottom: 3px solid transparent;
            white-space: nowrap;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .tab-button:hover {
            color: var(--admin-primary);
            background: rgba(26, 26, 62, 0.05);
        }
        
        .tab-button.active {
            color: var(--admin-primary);
            border-bottom-color: var(--admin-accent);
            background: white;
        }
        
        .tab-button .count {
            background: #e5e7eb;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 700;
        }
        
        .tab-button.active .count {
            background: var(--admin-accent);
            color: white;
        }
        
        .tab-content {
            display: none;
            padding: 30px;
        }
        
        .tab-content.active {
            display: block;
        }
        
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .data-table th {
            background: #f8fafc;
            padding: 12px 16px;
            text-align: left;
            font-weight: 700;
            font-size: 0.85rem;
            color: #64748b;
            border-bottom: 2px solid #e5e7eb;
        }
        
        .data-table td {
            padding: 16px;
            border-bottom: 1px solid #e5e7eb;
            color: #1f2937;
        }
        
        .data-table tr:hover {
            background: #f8fafc;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #9ca3af;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 16px;
            opacity: 0.5;
        }
        
        .empty-state h3 {
            margin: 0 0 8px;
            color: #6b7280;
        }
        
        .info-card {
            background: #f8fafc;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 16px;
        }
        
        .info-card h4 {
            margin: 0 0 12px;
            color: var(--admin-primary);
            font-size: 1rem;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 16px;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        
        .info-item label {
            font-size: 0.85rem;
            color: #64748b;
            font-weight: 600;
        }
        
        .info-item span {
            color: #1f2937;
            font-size: 0.95rem;
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
            <a href="${pageContext.request.contextPath}/admin/hospitals" class="nav-item active">
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
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Hospital Complete Details</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/admin/hospitals" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Hospitals
            </a>

            <!-- Hospital Header -->
            <div class="hospital-header">
                <div class="hospital-header-content">
                    <div class="hospital-logo">
                        <c:choose>
                            <c:when test="${not empty hospital.logoUrl}">
                                <img src="${pageContext.request.contextPath}${hospital.logoUrl}" alt="${hospital.centerName}">
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-hospital"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="hospital-header-info">
                        <h1>${hospital.centerName}</h1>
                        <p style="color: #64748b; margin: 0 0 12px;">${hospital.email}</p>
                        <div class="hospital-badges">
                            <span class="badge status-${fn:toLowerCase(hospital.status)}">${hospital.status}</span>
                            <c:if test="${hospital.isVerified}">
                                <span class="badge" style="background: #dbeafe; color: #1e40af;">
                                    <i class="fas fa-check-circle"></i> Verified
                                </span>
                            </c:if>
                            <c:if test="${hospital.isFeatured}">
                                <span class="badge" style="background: #fef3c7; color: #d97706;">
                                    <i class="fas fa-star"></i> Featured
                                </span>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tabs Container -->
            <div class="tabs-container">
                <div class="tabs-header">
                    <button class="tab-button active" onclick="showTab('info')">
                        <i class="fas fa-info-circle"></i> Hospital Info
                    </button>
                    <button class="tab-button" onclick="showTab('doctors')">
                        <i class="fas fa-user-md"></i> Doctors
                        <span class="count">${fn:length(doctors)}</span>
                    </button>
                    <button class="tab-button" onclick="showTab('users')">
                        <i class="fas fa-users"></i> Users/Patients
                        <span class="count">${fn:length(users)}</span>
                    </button>
                    <button class="tab-button" onclick="showTab('bookings')">
                        <i class="fas fa-calendar-check"></i> Bookings
                        <span class="count">${fn:length(bookings)}</span>
                    </button>
                    <button class="tab-button" onclick="showTab('enquiries')">
                        <i class="fas fa-envelope"></i> Enquiries
                        <span class="count">${fn:length(enquiries)}</span>
                    </button>
                </div>

                <!-- Tab Content: Hospital Info -->
                <div id="tab-info" class="tab-content active">
                    <div class="info-grid">
                        <div class="info-item">
                            <label>Center Name</label>
                            <span>${hospital.centerName}</span>
                        </div>
                        <div class="info-item">
                            <label>Email</label>
                            <span>${hospital.email}</span>
                        </div>
                        <div class="info-item">
                            <label>Phone</label>
                            <span>${not empty hospital.receptionPhone ? hospital.receptionPhone : 'N/A'}</span>
                        </div>
                        <div class="info-item">
                            <label>City</label>
                            <span>${hospital.city}</span>
                        </div>
                        <div class="info-item">
                            <label>State</label>
                            <span>${hospital.state}</span>
                        </div>
                        <div class="info-item">
                            <label>Country</label>
                            <span>${hospital.country}</span>
                        </div>
                        <div class="info-item">
                            <label>Status</label>
                            <span class="badge status-${fn:toLowerCase(hospital.status)}">${hospital.status}</span>
                        </div>
                        <div class="info-item">
                            <label>Verified</label>
                            <span>${hospital.isVerified ? 'Yes' : 'No'}</span>
                        </div>
                        <div class="info-item">
                            <label>Active</label>
                            <span>${hospital.isActive ? 'Yes' : 'No'}</span>
                        </div>
                        <div class="info-item">
                            <label>Total Bookings</label>
                            <span>${hospital.totalBookings != null ? hospital.totalBookings : 0}</span>
                        </div>
                        <div class="info-item">
                            <label>Total Reviews</label>
                            <span>${hospital.totalReviews != null ? hospital.totalReviews : 0}</span>
                        </div>
                        <div class="info-item">
                            <label>Average Rating</label>
                            <span>${hospital.averageRating != null ? hospital.averageRating : 'N/A'}</span>
                        </div>
                    </div>
                    <c:if test="${not empty hospital.description}">
                        <div class="info-card">
                            <h4>Description</h4>
                            <p>${hospital.description}</p>
                        </div>
                    </c:if>
                </div>

                <!-- Tab Content: Doctors -->
                <div id="tab-doctors" class="tab-content">
                    <c:choose>
                        <c:when test="${not empty doctors}">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Qualification</th>
                                        <th>Specialization</th>
                                        <th>Experience</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="doctor" items="${doctors}">
                                        <tr>
                                            <td>
                                                <strong>${doctor.name}</strong>
                                                <c:if test="${doctor.email != null}">
                                                    <br><small style="color: #64748b;">${doctor.email}</small>
                                                </c:if>
                                            </td>
                                            <td>${not empty doctor.qualifications ? doctor.qualifications : 'N/A'}</td>
                                            <td>${not empty doctor.specializations ? doctor.specializations : 'N/A'}</td>
                                            <td>${doctor.experienceYears != null ? doctor.experienceYears : 'N/A'} years</td>
                                            <td>
                                                <span class="badge ${doctor.isActive ? 'status-approved' : ''}" style="${!doctor.isActive ? 'background: #fee2e2; color: #dc2626;' : ''}">
                                                    ${doctor.isActive ? 'Active' : 'Inactive'}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-user-md"></i>
                                <h3>No Doctors Found</h3>
                                <p>This hospital has no doctors registered yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Tab Content: Users/Patients -->
                <div id="tab-users" class="tab-content">
                    <c:choose>
                        <c:when test="${not empty users}">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>City</th>
                                        <th>Country</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${users}">
                                        <tr>
                                            <td><strong>${user.fullName}</strong></td>
                                            <td>${user.email}</td>
                                            <td>${not empty user.phone ? user.phone : 'N/A'}</td>
                                            <td>${not empty user.city ? user.city : 'N/A'}</td>
                                            <td>${not empty user.country ? user.country : 'N/A'}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-users"></i>
                                <h3>No Users Found</h3>
                                <p>No users have interacted with this hospital yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Tab Content: Bookings -->
                <div id="tab-bookings" class="tab-content">
                    <c:choose>
                        <c:when test="${not empty bookings}">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Booking #</th>
                                        <th>User</th>
                                        <th>Package</th>
                                        <th>Check-in</th>
                                        <th>Check-out</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="booking" items="${bookings}">
                                        <tr>
                                            <td><strong>${booking.bookingNumber}</strong></td>
                                            <td>${booking.user != null ? booking.user.fullName : 'N/A'}</td>
                                            <td>${booking.treatmentPackage != null ? booking.treatmentPackage.packageName : 'N/A'}</td>
                                            <td>
                                                <%
                                                    com.ayurveda.entity.Booking b = (com.ayurveda.entity.Booking) pageContext.getAttribute("booking");
                                                    if (b != null && b.getCheckInDate() != null) {
                                                        out.print(b.getCheckInDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                                    } else {
                                                        out.print("N/A");
                                                    }
                                                %>
                                            </td>
                                            <td>
                                                <%
                                                    if (b != null && b.getCheckOutDate() != null) {
                                                        out.print(b.getCheckOutDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                                    } else {
                                                        out.print("N/A");
                                                    }
                                                %>
                                            </td>
                                            <td>₹${booking.totalAmount != null ? booking.totalAmount : '0'}</td>
                                            <td>
                                                <span class="badge ${booking.status == 'CONFIRMED' ? 'status-approved' : (booking.status == 'PENDING' ? 'status-pending' : '')}" 
                                                      style="${booking.status == 'REJECTED' || booking.status == 'CANCELLED' ? 'background: #fee2e2; color: #dc2626;' : ''}">
                                                    ${booking.status}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-calendar-check"></i>
                                <h3>No Bookings Found</h3>
                                <p>This hospital has no bookings yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Tab Content: Enquiries -->
                <div id="tab-enquiries" class="tab-content">
                    <c:choose>
                        <c:when test="${not empty enquiries}">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Enquiry #</th>
                                        <th>User</th>
                                        <th>Therapy</th>
                                        <th>Preferred Dates</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="enquiry" items="${enquiries}">
                                        <tr>
                                            <td><strong>${enquiry.enquiryNumber}</strong></td>
                                            <td>${enquiry.name != null ? enquiry.name : (enquiry.user != null ? enquiry.user.fullName : 'N/A')}</td>
                                            <td>${fn:substring(enquiry.therapyRequired != null ? enquiry.therapyRequired : 'N/A', 0, 30)}${fn:length(enquiry.therapyRequired != null ? enquiry.therapyRequired : '') > 30 ? '...' : ''}</td>
                                            <td>
                                                <%
                                                    com.ayurveda.entity.UserEnquiry e = (com.ayurveda.entity.UserEnquiry) pageContext.getAttribute("enquiry");
                                                    if (e != null && e.getPreferredStartDate() != null) {
                                                        out.print(e.getPreferredStartDate().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                                    } else {
                                                        out.print("N/A");
                                                    }
                                                %>
                                            </td>
                                            <td>
                                                <span class="badge ${enquiry.status == 'PENDING' ? 'status-pending' : (enquiry.status == 'REPLIED' || enquiry.status == 'QUOTATION_SENT' ? 'status-approved' : '')}">
                                                    ${enquiry.status}
                                                </span>
                                            </td>
                                            <td>
                                                <%
                                                    if (e != null && e.getCreatedAt() != null) {
                                                        out.print(e.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")));
                                                    } else {
                                                        out.print("N/A");
                                                    }
                                                %>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-envelope"></i>
                                <h3>No Enquiries Found</h3>
                                <p>This hospital has no enquiries yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </main>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
            });
        }

        function showTab(tabName) {
            // Hide all tab contents
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Remove active class from all buttons
            document.querySelectorAll('.tab-button').forEach(btn => {
                btn.classList.remove('active');
            });
            
            // Show selected tab content
            document.getElementById('tab-' + tabName).classList.add('active');
            
            // Add active class to clicked button
            event.target.closest('.tab-button').classList.add('active');
        }
    </script>
</body>
</html>

