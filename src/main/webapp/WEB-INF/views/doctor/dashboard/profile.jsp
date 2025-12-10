<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Doctor Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        /* ============================================
           AYURVEDIC DOCTOR DASHBOARD - WOW DESIGN
           ============================================ */
        
        /* Base Reset & Variables - Ayurvedic Color Palette */
        :root {
            /* Ayurvedic Green Theme */
            --ayur-dark-green: #0a3d2c;      /* Deep forest green */
            --ayur-medium-green: #1a5c40;    /* Sage green */
            --ayur-light-green: #2e7d5a;     /* Healing green */
            --ayur-accent-gold: #d4af37;     /* Ayurvedic gold */
            --ayur-warm-brown: #8b7355;      /* Earthy brown */
            --ayur-cream: #f5f1e6;          /* Cream background */
            --ayur-teal: #2a9d8f;           /* Healing teal */
            --ayur-olive: #6a994e;          /* Olive green */
            --ayur-moss: #386641;           /* Moss green */
            --ayur-spice: #bc6c25;          /* Spice orange */
            
            /* Dashboard Layout */
            --sidebar-width: 280px;
            --sidebar-collapsed: 80px;
            --header-height: 80px;
            --border-radius: 16px;
            --card-shadow: 0 10px 40px rgba(10, 61, 44, 0.1);
            --hover-shadow: 0 15px 50px rgba(10, 61, 44, 0.15);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        /* Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Nunito Sans', sans-serif;
            background: linear-gradient(135deg, #f0f7f4 0%, #e8f1ed 100%);
            color: #2c3e50;
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        .dashboard-body {
            display: flex;
            min-height: 100vh;
        }
        
        /* ============ SIDEBAR STYLES - AYURVEDIC DESIGN ============ */
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
            background: linear-gradient(90deg, 
                transparent, 
                var(--ayur-accent-gold), 
                transparent
            );
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
            background: linear-gradient(90deg, 
                transparent, 
                rgba(212, 175, 55, 0.1), 
                transparent
            );
            transition: left 0.6s ease;
        }
        
        .nav-item:hover::before {
            left: 100%;
        }
        
        .nav-item:hover {
            background: linear-gradient(90deg, 
                rgba(212, 175, 55, 0.15), 
                rgba(46, 125, 90, 0.2)
            );
            color: white;
            padding-left: 35px;
            transform: translateX(5px);
            border-left-color: var(--ayur-accent-gold);
        }
        
        .nav-item.active {
            background: linear-gradient(135deg, 
                rgba(46, 125, 90, 0.3), 
                rgba(212, 175, 55, 0.2)
            );
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
        
        /* ============ MAIN CONTENT ============ */
        .dashboard-main {
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: var(--transition);
            background: linear-gradient(135deg, #f5f9f7 0%, #edf5f1 100%);
            min-height: 100vh;
        }
        
        /* Header Styles */
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
        
        .header-right {
            display: flex;
            align-items: center;
            gap: 30px;
        }
        
        /* Dashboard Content */
        .dashboard-content {
            padding: 35px;
            max-width: 1500px;
            margin: 0 auto;
            width: 100%;
        }
        
        /* Form Styles */
        .form-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 35px;
            box-shadow: var(--card-shadow);
            border: 2px solid rgba(46, 125, 90, 0.1);
        }
        
        .form-card h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.6rem;
            color: var(--ayur-dark-green);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .form-card h3 i {
            color: var(--ayur-accent-gold);
        }
        
        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: var(--ayur-dark-green);
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        .form-input, .form-select, .form-textarea {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid rgba(46, 125, 90, 0.2);
            border-radius: 10px;
            font-size: 0.95rem;
            transition: var(--transition);
            font-family: 'Nunito Sans', sans-serif;
        }
        
        .form-input:focus, .form-select:focus, .form-textarea:focus {
            outline: none;
            border-color: var(--ayur-accent-gold);
            box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.1);
        }
        
        .form-textarea {
            resize: vertical;
            min-height: 120px;
        }
        
        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            color: var(--ayur-dark-green);
            font-weight: 500;
        }
        
        .checkbox-label input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: var(--ayur-accent-gold);
        }
        
        .form-actions {
            margin-top: 30px;
            padding-top: 25px;
            border-top: 2px solid #f0f7f4;
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
        
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .alert-success {
            background: linear-gradient(135deg, rgba(106, 153, 78, 0.1), rgba(56, 102, 65, 0.1));
            color: var(--ayur-olive);
            border-left: 4px solid var(--ayur-olive);
        }
        
        .alert-error {
            background: linear-gradient(135deg, rgba(231, 76, 60, 0.1), rgba(236, 112, 99, 0.1));
            color: #e74c3c;
            border-left: 4px solid #e74c3c;
        }
        
        /* Responsive Design */
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
            
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .header-left h1 {
                font-size: 1.6rem;
            }
        }
        
        @media (max-width: 480px) {
            .dashboard-header {
                padding: 0 20px;
            }
            
            .form-card {
                padding: 25px;
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
            <a href="${pageContext.request.contextPath}/doctor/profile" class="nav-item active">
                <i class="fas fa-user-circle"></i>
                <span>Profile</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Appointments</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/prescriptions" class="nav-item">
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
                <h1>Profile Management</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <div class="form-card">
                <form action="${pageContext.request.contextPath}/doctor/profile/update" method="post" enctype="multipart/form-data">
                    <h3><i class="fas fa-user"></i> Personal Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="name" class="form-input" value="${doctor.name}" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Gender</label>
                            <select name="gender" class="form-select">
                                <option value="">Select Gender</option>
                                <option value="MALE" ${doctor.gender == 'MALE' ? 'selected' : ''}>Male</option>
                                <option value="FEMALE" ${doctor.gender == 'FEMALE' ? 'selected' : ''}>Female</option>
                                <option value="OTHER" ${doctor.gender == 'OTHER' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-input" value="${doctor.email}" disabled>
                            <small style="color: var(--text-muted);">Email cannot be changed</small>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" name="phone" class="form-input" value="${doctor.phone}">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Photo</label>
                        <input type="file" name="photoFile" class="form-input" accept="image/*">
                        <c:if test="${not empty doctor.photoUrl}">
                            <div style="margin-top: 10px;">
                                <img src="${pageContext.request.contextPath}${doctor.photoUrl}" alt="Current Photo" style="width: 100px; height: 100px; border-radius: 8px; object-fit: cover;">
                            </div>
                        </c:if>
                    </div>
                    
                    <h3 style="margin-top: 30px;"><i class="fas fa-graduation-cap"></i> Professional Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Qualifications</label>
                            <input type="text" name="qualifications" class="form-input" value="${doctor.qualifications}">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Registration Number</label>
                            <input type="text" name="registrationNumber" class="form-input" value="${doctor.registrationNumber}">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Specializations</label>
                            <input type="text" name="specializations" class="form-input" value="${doctor.specializations}" placeholder="e.g., Panchakarma, Kayachikitsa">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Experience (Years)</label>
                            <input type="number" name="experienceYears" class="form-input" value="${doctor.experienceYears}" min="0">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Degree University</label>
                            <input type="text" name="degreeUniversity" class="form-input" value="${doctor.degreeUniversity}">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Languages Known</label>
                            <input type="text" name="languagesSpoken" class="form-input" value="${doctor.languagesSpoken}" placeholder="e.g., English, Hindi, Malayalam">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Biography</label>
                        <textarea name="biography" class="form-textarea" rows="5">${doctor.biography}</textarea>
                    </div>
                    
                    <h3 style="margin-top: 30px;"><i class="fas fa-clock"></i> Availability Settings</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Consultation Days</label>
                            <input type="text" name="consultationDays" class="form-input" value="${doctor.consultationDays}" placeholder="e.g., Monday to Saturday">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Consultation Timings</label>
                            <input type="text" name="consultationTimings" class="form-input" value="${doctor.consultationTimings}" placeholder="e.g., 9:00 AM - 5:00 PM">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Available Locations</label>
                        <input type="text" name="availableLocations" class="form-input" value="${doctor.availableLocations}" placeholder="e.g., OPD, Online, Home Visit">
                    </div>
                    
                    <div class="form-group">
                        <label class="checkbox-label">
                            <input type="checkbox" name="isAvailable" value="true" ${doctor.isAvailable == null || doctor.isAvailable ? 'checked' : ''}>
                            <span>Currently Available for Consultation</span>
                        </label>
                    </div>
                    
                    <div class="form-actions" style="border-top: none; margin-top: 30px;">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update Profile
                        </button>
                    </div>
                </form>
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
                this.style.transform = sidebar.classList.contains('active') ? 'rotate(90deg)' : 'rotate(0)';
            });
        }
    </script>
</body>
</html>

