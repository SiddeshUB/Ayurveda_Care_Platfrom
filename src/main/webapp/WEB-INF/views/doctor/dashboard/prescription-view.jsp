<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Prescription - Doctor Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        :root {
            --ayur-dark-green: #0a3d2c;
            --ayur-medium-green: #1a5c40;
            --ayur-light-green: #2e7d5a;
            --ayur-accent-gold: #d4af37;
            --ayur-teal: #2a9d8f;
            --primary-forest: #0a3d2c;
            --primary-sage: #1a5c40;
            --text-medium: #6b7280;
            --sidebar-width: 280px;
            --header-height: 80px;
            --border-radius: 16px;
            --card-shadow: 0 10px 40px rgba(10, 61, 44, 0.1);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Nunito Sans', sans-serif;
            background: linear-gradient(135deg, #f0f7f4 0%, #e8f1ed 100%);
            color: #2c3e50;
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        .dashboard-body { display: flex; min-height: 100vh; }
        
        .sidebar {
            width: var(--sidebar-width);
            background: linear-gradient(180deg, var(--ayur-dark-green) 0%, var(--ayur-medium-green) 100%);
            color: white;
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100vh;
            z-index: 1000;
            transition: var(--transition);
            box-shadow: 5px 0 25px rgba(10, 61, 44, 0.2);
            border-right: 3px solid var(--ayur-accent-gold);
        }
        
        .sidebar-header {
            padding: 30px 25px;
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            text-align: center;
            background: rgba(10, 61, 44, 0.9);
            position: relative;
            overflow: hidden;
        }
        
        .sidebar-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, transparent, var(--ayur-accent-gold), transparent);
        }
        
        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 15px;
            color: white;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: 700;
            justify-content: center;
            z-index: 1;
            position: relative;
        }
        
        .sidebar-logo i {
            font-size: 2.2rem;
            color: var(--ayur-accent-gold);
            text-shadow: 0 2px 10px rgba(212, 175, 55, 0.3);
        }
        
        .sidebar-logo .highlight {
            color: var(--ayur-accent-gold);
            font-weight: 800;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
        
        .sidebar-nav {
            flex: 1;
            padding: 25px 0;
            overflow-y: auto;
        }
        
        .nav-item {
            display: flex;
            align-items: center;
            gap: 18px;
            padding: 18px 30px;
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            transition: var(--transition);
            border-left: 4px solid transparent;
            margin: 8px 15px;
            position: relative;
            overflow: hidden;
            border-radius: 12px;
        }
        
        .nav-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(212, 175, 55, 0.1), transparent);
            transition: left 0.6s ease;
        }
        
        .nav-item:hover::before { left: 100%; }
        
        .nav-item:hover {
            background: linear-gradient(90deg, rgba(212, 175, 55, 0.15), rgba(46, 125, 90, 0.2));
            color: white;
            padding-left: 35px;
            transform: translateX(5px);
            border-left-color: var(--ayur-accent-gold);
        }
        
        .nav-item.active {
            background: linear-gradient(135deg, rgba(46, 125, 90, 0.3), rgba(212, 175, 55, 0.2));
            border-left-color: var(--ayur-accent-gold);
            color: white;
            font-weight: 600;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .nav-item i {
            width: 24px;
            font-size: 1.2rem;
            text-align: center;
            color: var(--ayur-accent-gold);
        }
        
        .nav-item span {
            flex: 1;
            white-space: nowrap;
            font-size: 0.95rem;
        }
        
        .sidebar-footer {
            padding: 25px;
            border-top: 1px solid rgba(212, 175, 55, 0.2);
            display: flex;
            flex-direction: column;
            gap: 15px;
            background: rgba(10, 61, 44, 0.8);
        }
        
        .btn-outline {
            background: transparent;
            border: 2px solid var(--ayur-accent-gold);
            color: var(--ayur-accent-gold);
            padding: 12px 20px;
            border-radius: 10px;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 600;
            transition: var(--transition);
            font-size: 0.9rem;
        }
        
        .btn-outline:hover {
            background: var(--ayur-accent-gold);
            color: var(--ayur-dark-green);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
        }
        
        .logout-link {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            border-radius: 10px;
            transition: var(--transition);
            font-size: 0.9rem;
        }
        
        .logout-link:hover {
            background: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            transform: translateX(5px);
        }
        
        .dashboard-main {
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: var(--transition);
            background: linear-gradient(135deg, #f5f9f7 0%, #edf5f1 100%);
            min-height: 100vh;
        }
        
        .dashboard-header {
            background: white;
            height: var(--header-height);
            padding: 0 35px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 6px 20px rgba(10, 61, 44, 0.08);
            position: sticky;
            top: 0;
            z-index: 999;
            border-bottom: 2px solid var(--ayur-accent-gold);
        }
        
        .header-left {
            display: flex;
            align-items: center;
            gap: 25px;
        }
        
        .sidebar-toggle {
            background: var(--ayur-light-green);
            border: none;
            width: 45px;
            height: 45px;
            border-radius: 12px;
            font-size: 1.3rem;
            color: white;
            cursor: pointer;
            display: none;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(46, 125, 90, 0.2);
        }
        
        .sidebar-toggle:hover {
            background: var(--ayur-teal);
            transform: rotate(90deg);
        }
        
        .header-left h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--ayur-dark-green);
            font-weight: 700;
            background: linear-gradient(135deg, var(--ayur-dark-green), var(--ayur-teal));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .dashboard-content {
            padding: 35px;
            max-width: 1500px;
            margin: 0 auto;
            width: 100%;
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--ayur-medium-green);
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: 600;
            transition: var(--transition);
            padding: 10px 15px;
            border-radius: 8px;
        }
        
        .back-link:hover {
            background: rgba(46, 125, 90, 0.1);
            color: var(--ayur-dark-green);
            transform: translateX(-5px);
        }
        
        .prescription-header {
            background: linear-gradient(135deg, var(--primary-forest) 0%, var(--primary-sage) 100%);
            color: white;
            padding: 30px;
            border-radius: var(--border-radius);
            margin-bottom: 30px;
            box-shadow: var(--card-shadow);
        }
        
        .prescription-section {
            background: white;
            border-radius: var(--border-radius);
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: var(--card-shadow);
            border: 2px solid rgba(46, 125, 90, 0.1);
        }
        
        .prescription-section h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: var(--ayur-dark-green);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .prescription-section h3 i {
            color: var(--ayur-accent-gold);
        }
        
        .medicine-list {
            margin-top: 15px;
        }
        
        .medicine-item {
            background: linear-gradient(to right, #f8fafc, #f0f7f4);
            border-left: 4px solid var(--primary-sage);
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 10px;
            transition: var(--transition);
            border: 2px solid rgba(46, 125, 90, 0.1);
        }
        
        .medicine-item:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(46, 125, 90, 0.1);
            border-left-color: var(--ayur-accent-gold);
        }
        
        .medicine-item h4 {
            margin: 0 0 12px;
            color: var(--primary-forest);
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .medicine-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            color: var(--text-medium);
            font-size: 0.9rem;
        }
        
        .medicine-details i {
            color: var(--ayur-teal);
            margin-right: 5px;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 25px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 700;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            font-size: 0.95rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--ayur-medium-green), var(--ayur-light-green));
            color: white;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--ayur-light-green), var(--ayur-teal));
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 25px rgba(46, 125, 90, 0.3);
        }
        
        @media (max-width: 1200px) {
            .sidebar {
                transform: translateX(-100%);
                box-shadow: 10px 0 40px rgba(10, 61, 44, 0.3);
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .dashboard-main {
                margin-left: 0;
            }
            
            .sidebar-toggle {
                display: flex;
                align-items: center;
                justify-content: center;
            }
        }
        
        @media (max-width: 768px) {
            .dashboard-content {
                padding: 25px;
            }
            
            .header-left h1 {
                font-size: 1.6rem;
            }
            
            .prescription-header {
                padding: 20px;
            }
            
            .prescription-section {
                padding: 20px;
            }
        }
    </style>
</head>
<body class="dashboard-body">
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-leaf"></i>
                <span>Ayur<span class="highlight">Doctor</span></span>
            </a>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-item">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/profile" class="nav-item">
                <i class="fas fa-user-circle"></i>
                <span>Profile</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Appointments</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/prescriptions" class="nav-item active">
                <i class="fas fa-prescription"></i>
                <span>Prescriptions</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/health-records" class="nav-item">
                <i class="fas fa-file-medical"></i>
                <span>Health Records</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/reviews" class="nav-item">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availability" class="nav-item">
                <i class="fas fa-clock"></i>
                <span>Availability</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/packages" class="nav-item">
                <i class="fas fa-box"></i>
                <span>My Packages</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/bookings" class="nav-item">
                <i class="fas fa-book-medical"></i>
                <span>Package Bookings</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline btn-sm" target="_blank">
                <i class="fas fa-external-link-alt"></i> View AyurVedaCare
            </a>
            <a href="${pageContext.request.contextPath}/doctor/logout" class="logout-link">
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
                <h1>Prescription Details</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/doctor/prescriptions" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Prescriptions
            </a>

            <div class="prescription-header">
                <div style="display: flex; justify-content: space-between; align-items: start;">
                    <div>
                        <h2 style="margin: 0 0 10px;">Prescription #${prescription.prescriptionNumber}</h2>
                        <p style="margin: 0; opacity: 0.9;">
                            <i class="fas fa-user"></i> ${prescription.patientName} | 
                            <i class="fas fa-calendar"></i> 
                            <fmt:parseDate value="${prescription.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                            <fmt:formatDate value="${parsedDate}" pattern="dd MMMM yyyy 'at' hh:mm a"/>
                        </p>
                    </div>
                    <div style="text-align: right;">
                        <div style="background: rgba(255,255,255,0.2); padding: 10px 20px; border-radius: 8px; display: inline-block;">
                            <strong>Dr. ${prescription.doctor.name}</strong><br>
                            <small>${prescription.hospital != null ? prescription.hospital.centerName : 'Independent Practice'}</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Patient Information -->
            <div class="prescription-section">
                <h3><i class="fas fa-user"></i> Patient Information</h3>
                <div class="detail-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-top: 15px;">
                    <div>
                        <strong>Name:</strong> ${prescription.patientName}
                    </div>
                    <div>
                        <strong>Age:</strong> ${prescription.patientAge != null ? prescription.patientAge : 'N/A'} years
                    </div>
                    <div>
                        <strong>Gender:</strong> ${prescription.patientGender != null ? prescription.patientGender : 'N/A'}
                    </div>
                    <div>
                        <strong>Email:</strong> ${prescription.patientEmail}
                    </div>
                    <div>
                        <strong>Phone:</strong> ${prescription.patientPhone}
                    </div>
                </div>
            </div>

            <!-- Diagnosis -->
            <div class="prescription-section">
                <h3><i class="fas fa-stethoscope"></i> Diagnosis & Assessment</h3>
                <c:if test="${not empty prescription.chiefComplaints}">
                    <div style="margin-bottom: 15px;">
                        <strong>Chief Complaints:</strong>
                        <p style="color: var(--text-medium); margin-top: 5px;">${prescription.chiefComplaints}</p>
                    </div>
                </c:if>
                <c:if test="${not empty prescription.diagnosis}">
                    <div style="margin-bottom: 15px;">
                        <strong>Diagnosis:</strong>
                        <p style="color: var(--text-medium); margin-top: 5px;">${prescription.diagnosis}</p>
                    </div>
                </c:if>
                <c:if test="${not empty prescription.doshaImbalance}">
                    <div>
                        <strong>Dosha Imbalance:</strong>
                        <span style="background: var(--primary-sage); color: white; padding: 5px 12px; border-radius: 6px; display: inline-block; margin-left: 10px;">
                            ${prescription.doshaImbalance}
                        </span>
                    </div>
                </c:if>
            </div>

            <!-- Medicines -->
            <c:if test="${not empty prescription.medicines}">
                <div class="prescription-section">
                    <h3><i class="fas fa-pills"></i> Prescribed Medicines</h3>
                    <div class="medicine-list">
                        <c:forEach var="medicine" items="${prescription.medicines}">
                            <div class="medicine-item">
                                <h4>${medicine.medicineName}</h4>
                                <div class="medicine-details">
                                    <div><i class="fas fa-capsules"></i> <strong>Dosage:</strong> ${medicine.dosage != null ? medicine.dosage : 'As prescribed'}</div>
                                    <div><i class="fas fa-clock"></i> <strong>Frequency:</strong> ${medicine.frequency != null ? medicine.frequency : 'N/A'}</div>
                                    <div><i class="fas fa-sun"></i> <strong>Timing:</strong> ${medicine.timing != null ? medicine.timing : 'N/A'}</div>
                                    <c:if test="${medicine.durationDays != null}">
                                        <div><i class="fas fa-calendar-alt"></i> <strong>Duration:</strong> ${medicine.durationDays} days</div>
                                    </c:if>
                                </div>
                                <c:if test="${not empty medicine.instructions}">
                                    <div style="margin-top: 10px; padding-top: 10px; border-top: 1px solid #e5e7eb;">
                                        <strong>Instructions:</strong> ${medicine.instructions}
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!-- Lifestyle Guidelines -->
            <c:if test="${not empty prescription.dietGuidelines || not empty prescription.lifestyleGuidelines || not empty prescription.yogaPranayama}">
                <div class="prescription-section">
                    <h3><i class="fas fa-leaf"></i> Lifestyle & Diet Guidelines</h3>
                    <c:if test="${not empty prescription.dietGuidelines}">
                        <div style="margin-bottom: 20px;">
                            <strong><i class="fas fa-utensils"></i> Diet Guidelines:</strong>
                            <p style="color: var(--text-medium); margin-top: 8px; white-space: pre-wrap;">${prescription.dietGuidelines}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty prescription.lifestyleGuidelines}">
                        <div style="margin-bottom: 20px;">
                            <strong><i class="fas fa-heart"></i> Lifestyle Guidelines:</strong>
                            <p style="color: var(--text-medium); margin-top: 8px; white-space: pre-wrap;">${prescription.lifestyleGuidelines}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty prescription.yogaPranayama}">
                        <div>
                            <strong><i class="fas fa-spa"></i> Yoga & Pranayama:</strong>
                            <p style="color: var(--text-medium); margin-top: 8px; white-space: pre-wrap;">${prescription.yogaPranayama}</p>
                        </div>
                    </c:if>
                </div>
            </c:if>

            <!-- Other Instructions -->
            <c:if test="${not empty prescription.otherInstructions}">
                <div class="prescription-section">
                    <h3><i class="fas fa-info-circle"></i> Other Instructions</h3>
                    <p style="color: var(--text-medium); white-space: pre-wrap;">${prescription.otherInstructions}</p>
                </div>
            </c:if>

            <!-- Follow-up -->
            <c:if test="${prescription.followUpDate != null || prescription.followUpDays != null}">
                <div class="prescription-section">
                    <h3><i class="fas fa-calendar-check"></i> Follow-up</h3>
                    <div style="display: flex; gap: 20px; align-items: center;">
                        <c:if test="${prescription.followUpDate != null}">
                            <div>
                                <strong>Follow-up Date:</strong>
                                <fmt:parseDate value="${prescription.followUpDate}" pattern="yyyy-MM-dd" var="parsedFollowUp" type="date"/>
                                <fmt:formatDate value="${parsedFollowUp}" pattern="dd MMMM yyyy"/>
                            </div>
                        </c:if>
                        <c:if test="${prescription.followUpDays != null}">
                            <div>
                                <strong>Follow-up After:</strong> ${prescription.followUpDays} days
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>

            <div style="text-align: center; margin-top: 30px;">
                <button onclick="window.print()" class="btn btn-primary">
                    <i class="fas fa-print"></i> Print Prescription
                </button>
            </div>
        </div>
    </main>

    <script>
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
                this.style.transform = sidebar.classList.contains('active') ? 'rotate(90deg)' : 'rotate(0)';
            });
        }
    </script>
</body>
</html>

