<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit' : 'Create'} Prescription - Doctor Dashboard</title>
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
            --hover-shadow: 0 15px 50px rgba(10, 61, 44, 0.15);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            --error: #e74c3c;
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
            margin-top: 30px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .form-card h3:first-child {
            margin-top: 0;
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
            min-height: 100px;
        }
        
        .form-actions {
            margin-top: 30px;
            padding-top: 25px;
            border-top: 2px solid #f0f7f4;
            display: flex;
            gap: 15px;
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
        
        .btn-secondary {
            background: linear-gradient(135deg, #6b7280, #4b5563);
            color: white;
        }
        
        .btn-secondary:hover {
            background: linear-gradient(135deg, #4b5563, #374151);
            transform: translateY(-3px) scale(1.05);
        }
        
        .medicine-item {
            background: linear-gradient(to right, #f8fafc, #f0f7f4);
            border: 2px solid rgba(46, 125, 90, 0.2);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            transition: var(--transition);
        }
        
        .medicine-item:hover {
            border-color: var(--ayur-accent-gold);
            box-shadow: 0 5px 15px rgba(46, 125, 90, 0.1);
        }
        
        .medicine-item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .medicine-item-header h4 {
            margin: 0;
            color: var(--primary-forest);
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .remove-medicine {
            background: linear-gradient(135deg, #e74c3c, #ec7063);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            cursor: pointer;
            font-weight: 600;
            transition: var(--transition);
        }
        
        .remove-medicine:hover {
            background: linear-gradient(135deg, #c0392b, #e74c3c);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.3);
        }
        
        .add-medicine-btn {
            background: linear-gradient(135deg, var(--primary-sage), var(--ayur-light-green));
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px 24px;
            cursor: pointer;
            font-weight: 600;
            margin-bottom: 20px;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(46, 125, 90, 0.2);
        }
        
        .add-medicine-btn:hover {
            background: linear-gradient(135deg, var(--ayur-light-green), var(--ayur-teal));
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(46, 125, 90, 0.3);
        }
        
        .medicine-search {
            position: relative;
        }
        
        .medicine-search-results {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 2px solid rgba(46, 125, 90, 0.2);
            border-radius: 8px;
            max-height: 200px;
            overflow-y: auto;
            z-index: 100;
            display: none;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        
        .medicine-search-result {
            padding: 12px;
            cursor: pointer;
            border-bottom: 1px solid #f1f5f9;
            transition: var(--transition);
        }
        
        .medicine-search-result:hover {
            background: linear-gradient(to right, rgba(46, 125, 90, 0.1), rgba(212, 175, 55, 0.1));
        }
        
        .medicine-search-result:last-child {
            border-bottom: none;
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
            
            .form-row {
                grid-template-columns: 1fr;
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
                <h1>${isEdit ? 'Edit' : 'Create'} Prescription</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <a href="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Appointment
            </a>

            <div class="form-card">
                <div style="background: linear-gradient(135deg, rgba(46, 125, 90, 0.1), rgba(212, 175, 55, 0.1)); padding: 15px; border-radius: 10px; margin-bottom: 25px; border-left: 4px solid var(--ayur-accent-gold);">
                    <strong style="color: var(--ayur-dark-green);">Patient:</strong> ${consultation.patientName} | 
                    <strong style="color: var(--ayur-dark-green);">Date:</strong> 
                    <fmt:parseDate value="${consultation.consultationDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                    <fmt:formatDate value="${parsedDate}" pattern="dd MMMM yyyy"/>
                </div>

                <form action="${pageContext.request.contextPath}/doctor/prescriptions/create/${consultation.id}" method="post" id="prescriptionForm">
                    <h3><i class="fas fa-stethoscope"></i> Diagnosis & Assessment</h3>
                    
                    <div class="form-group">
                        <label class="form-label">Chief Complaints</label>
                        <textarea name="chiefComplaints" class="form-textarea" rows="3" placeholder="Patient's main complaints...">${prescription.chiefComplaints}</textarea>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Diagnosis</label>
                            <textarea name="diagnosis" class="form-textarea" rows="3" placeholder="Diagnosis...">${prescription.diagnosis}</textarea>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Dosha Imbalance</label>
                            <select name="doshaImbalance" class="form-select">
                                <option value="">Select Dosha</option>
                                <option value="Vata" ${prescription.doshaImbalance == 'Vata' ? 'selected' : ''}>Vata</option>
                                <option value="Pitta" ${prescription.doshaImbalance == 'Pitta' ? 'selected' : ''}>Pitta</option>
                                <option value="Kapha" ${prescription.doshaImbalance == 'Kapha' ? 'selected' : ''}>Kapha</option>
                                <option value="Vata-Pitta" ${prescription.doshaImbalance == 'Vata-Pitta' ? 'selected' : ''}>Vata-Pitta</option>
                                <option value="Vata-Kapha" ${prescription.doshaImbalance == 'Vata-Kapha' ? 'selected' : ''}>Vata-Kapha</option>
                                <option value="Pitta-Kapha" ${prescription.doshaImbalance == 'Pitta-Kapha' ? 'selected' : ''}>Pitta-Kapha</option>
                                <option value="Tridosha" ${prescription.doshaImbalance == 'Tridosha' ? 'selected' : ''}>Tridosha</option>
                            </select>
                        </div>
                    </div>

                    <h3 style="margin-top: 30px;"><i class="fas fa-pills"></i> Medicines</h3>
                    
                    <div id="medicinesContainer">
                        <!-- Medicines will be added here dynamically -->
                    </div>
                    
                    <button type="button" class="add-medicine-btn" onclick="addMedicineRow()">
                        <i class="fas fa-plus"></i> Add Medicine
                    </button>

                    <h3 style="margin-top: 30px;"><i class="fas fa-leaf"></i> Lifestyle & Diet Guidelines</h3>
                    
                    <div class="form-group">
                        <label class="form-label">Diet Guidelines</label>
                        <textarea name="dietGuidelines" class="form-textarea" rows="4" placeholder="Diet recommendations (what to eat, what to avoid)...">${prescription.dietGuidelines}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Lifestyle Guidelines</label>
                        <textarea name="lifestyleGuidelines" class="form-textarea" rows="4" placeholder="Lifestyle recommendations (sleep, exercise, daily routine)...">${prescription.lifestyleGuidelines}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Yoga & Pranayama</label>
                        <textarea name="yogaPranayama" class="form-textarea" rows="3" placeholder="Recommended yoga asanas and breathing exercises...">${prescription.yogaPranayama}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Other Instructions</label>
                        <textarea name="otherInstructions" class="form-textarea" rows="3" placeholder="Any other instructions...">${prescription.otherInstructions}</textarea>
                    </div>

                    <h3 style="margin-top: 30px;"><i class="fas fa-calendar-check"></i> Follow-up</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Follow-up Date</label>
                            <input type="date" name="followUpDate" class="form-input" value="${prescription.followUpDate}">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Follow-up After (Days)</label>
                            <input type="number" name="followUpDays" class="form-input" value="${prescription.followUpDays}" min="1" placeholder="e.g., 7, 14, 30">
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> ${isEdit ? 'Update' : 'Create'} Prescription
                        </button>
                        <a href="${pageContext.request.contextPath}/doctor/appointments/${consultation.id}" class="btn btn-secondary">
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <script>
        let medicineCount = 0;
        const medicines = [
            <c:forEach var="medicine" items="${medicines}" varStatus="status">
            {id: ${medicine.id}, name: "${medicine.name}", category: "${medicine.category}", dosage: "${medicine.dosage}"}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        function addMedicineRow() {
            medicineCount++;
            const container = document.getElementById('medicinesContainer');
            const medicineItem = document.createElement('div');
            medicineItem.className = 'medicine-item';
            medicineItem.id = 'medicine-' + medicineCount;
            
            medicineItem.innerHTML = `
                <div class="medicine-item-header">
                    <h4>Medicine ${medicineCount}</h4>
                    <button type="button" class="remove-medicine" onclick="removeMedicineRow(${medicineCount})">
                        <i class="fas fa-times"></i> Remove
                    </button>
                </div>
                <div class="form-row">
                    <div class="form-group" style="flex: 1;">
                        <label class="form-label">Medicine Name</label>
                        <div class="medicine-search">
                            <input type="text" name="medicineNames" class="form-input medicine-search-input" 
                                   placeholder="Search or type medicine name" 
                                   onkeyup="searchMedicines(this, ${medicineCount})" 
                                   autocomplete="off">
                            <input type="hidden" name="medicineIds" class="medicine-id-input">
                            <div class="medicine-search-results" id="search-results-${medicineCount}"></div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Dosage</label>
                        <input type="text" name="dosages" class="form-input" placeholder="e.g., 1 teaspoon, 2 tablets">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Frequency</label>
                        <select name="frequencies" class="form-select">
                            <option value="">Select Frequency</option>
                            <option value="Once daily">Once daily</option>
                            <option value="Twice daily">Twice daily</option>
                            <option value="Thrice daily">Thrice daily</option>
                            <option value="Four times daily">Four times daily</option>
                            <option value="As needed">As needed</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Timing</label>
                        <select name="timings" class="form-select">
                            <option value="">Select Timing</option>
                            <option value="Morning">Morning</option>
                            <option value="Afternoon">Afternoon</option>
                            <option value="Evening">Evening</option>
                            <option value="Night">Night</option>
                            <option value="Before food">Before food</option>
                            <option value="After food">After food</option>
                            <option value="With food">With food</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Duration (Days)</label>
                        <input type="number" name="durationDays" class="form-input" min="1" placeholder="e.g., 7, 14, 30">
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Special Instructions</label>
                    <textarea name="medicineInstructions" class="form-textarea" rows="2" placeholder="Any special instructions for this medicine..."></textarea>
                </div>
            `;
            
            container.appendChild(medicineItem);
        }

        function removeMedicineRow(id) {
            const medicineItem = document.getElementById('medicine-' + id);
            if (medicineItem) {
                medicineItem.remove();
            }
        }

        function searchMedicines(input, rowId) {
            const query = input.value.trim();
            const resultsDiv = document.getElementById('search-results-' + rowId);
            
            if (query.length < 2) {
                resultsDiv.style.display = 'none';
                return;
            }
            
            // Simple client-side search
            const filtered = medicines.filter(m => 
                m.name.toLowerCase().includes(query.toLowerCase()) ||
                (m.category && m.category.toLowerCase().includes(query.toLowerCase()))
            );
            
            if (filtered.length > 0) {
                resultsDiv.innerHTML = filtered.slice(0, 10).map(m => 
                    `<div class="medicine-search-result" onclick="selectMedicine('${m.name}', ${m.id}, ${rowId})">
                        <strong>${m.name}</strong><br>
                        <small>${m.category || ''}</small>
                    </div>`
                ).join('');
                resultsDiv.style.display = 'block';
            } else {
                resultsDiv.innerHTML = '<div class="medicine-search-result">No medicines found</div>';
                resultsDiv.style.display = 'block';
            }
        }

        function selectMedicine(name, id, rowId) {
            const row = document.getElementById('medicine-' + rowId);
            const nameInput = row.querySelector('.medicine-search-input');
            const idInput = row.querySelector('.medicine-id-input');
            const resultsDiv = document.getElementById('search-results-' + rowId);
            
            nameInput.value = name;
            idInput.value = id;
            resultsDiv.style.display = 'none';
        }

        // Close search results when clicking outside
        document.addEventListener('click', function(e) {
            if (!e.target.closest('.medicine-search')) {
                document.querySelectorAll('.medicine-search-results').forEach(div => {
                    div.style.display = 'none';
                });
            }
        });

        // Add first medicine row on page load
        window.onload = function() {
            addMedicineRow();
        };
        
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

