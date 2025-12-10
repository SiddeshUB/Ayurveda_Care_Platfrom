<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${doctor.id != null ? 'Edit' : 'Add'} Doctor - Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body class="dashboard-body">
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                <i class="fas fa-leaf"></i>
                <span>AyurVeda<span class="highlight">Care</span></span>
            </a>
        </div>
        
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/profile" class="nav-item">
                <i class="fas fa-hospital"></i>
                <span>Profile</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/packages" class="nav-item">
                <i class="fas fa-box"></i>
                <span>Packages</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/products" class="nav-item">
                <i class="fas fa-shopping-bag"></i>
                <span>Products</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/doctors" class="nav-item active">
                <i class="fas fa-user-md"></i>
                <span>Doctors</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/bookings" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Bookings</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/enquiries" class="nav-item">
                <i class="fas fa-envelope"></i>
                <span>Enquiries</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/gallery" class="nav-item">
                <i class="fas fa-images"></i>
                <span>Gallery</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/documents" class="nav-item">
                <i class="fas fa-file-alt"></i>
                <span>Documents</span>
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/reviews" class="nav-item">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/hospital/logout" class="logout-link">
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
                <h1>${doctor.id != null ? 'Edit' : 'Add'} Doctor</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/dashboard/doctors/${doctor.id != null ? 'edit/'.concat(doctor.id) : 'add'}" 
                      method="post" enctype="multipart/form-data">
                    
                    <h3><i class="fas fa-user-md"></i> Doctor Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Doctor Name</label>
                            <input type="text" name="name" class="form-input" 
                                   value="${doctor.name}" placeholder="Dr. Full Name" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Photo</label>
                            <input type="file" name="photoFile" class="form-input" accept="image/*">
                        </div>
                    </div>
                    
                    <c:if test="${doctor.id == null}">
                        <h3 style="margin-top: var(--spacing-xl);"><i class="fas fa-key"></i> Login Credentials</h3>
                        <div style="background: #eff6ff; border-left: 4px solid #3b82f6; padding: 12px 16px; margin-bottom: var(--spacing-md); border-radius: 6px;">
                            <p style="color: #1e40af; margin: 0; font-size: 0.9rem; font-weight: 500;">
                                <i class="fas fa-info-circle"></i> After registration, the doctor can login at <code>/doctor/login</code> using these credentials.
                            </p>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">Email</label>
                                <input type="email" name="email" class="form-input" 
                                       value="${doctor.email}" placeholder="doctor@example.com" required>
                                <small style="color: var(--text-muted); font-size: 0.85rem;">This will be used for login</small>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label required">Password</label>
                                <input type="password" name="password" class="form-input" 
                                       placeholder="Minimum 6 characters" required minlength="6">
                                <small style="color: var(--text-muted); font-size: 0.85rem;">Minimum 6 characters - Share this with the doctor securely</small>
                            </div>
                        </div>
                    </c:if>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Qualifications</label>
                            <input type="text" name="qualifications" class="form-input" 
                                   value="${doctor.qualifications}" placeholder="e.g., BAMS, MD (Ayurveda)" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Specializations</label>
                            <input type="text" name="specializations" class="form-input" 
                                   value="${doctor.specializations}" placeholder="e.g., Panchakarma, Dermatology">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Experience (Years)</label>
                            <input type="number" name="experienceYears" class="form-input" 
                                   value="${doctor.experienceYears}" placeholder="Years of experience" min="0">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Registration Number</label>
                            <input type="text" name="registrationNumber" class="form-input" 
                                   value="${doctor.registrationNumber}" placeholder="Medical registration number">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Languages Spoken</label>
                            <input type="text" name="languagesSpoken" class="form-input" 
                                   value="${doctor.languagesSpoken}" placeholder="e.g., English, Hindi, Malayalam">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Degree University</label>
                            <input type="text" name="degreeUniversity" class="form-input" 
                                   value="${doctor.degreeUniversity}" placeholder="University name">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Biography</label>
                        <textarea name="biography" class="form-textarea" rows="4" 
                                  placeholder="Brief biography about the doctor...">${doctor.biography}</textarea>
                    </div>
                    
                    <h3 style="margin-top: var(--spacing-2xl);"><i class="fas fa-clock"></i> Availability</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Consultation Days</label>
                            <input type="text" name="consultationDays" class="form-input" 
                                   value="${doctor.consultationDays}" placeholder="e.g., Monday to Saturday">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Consultation Timings</label>
                            <input type="text" name="consultationTimings" class="form-input" 
                                   value="${doctor.consultationTimings}" placeholder="e.g., 9:00 AM - 5:00 PM">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="checkbox-label">
                            <input type="checkbox" name="isAvailable" value="true" ${doctor.isAvailable == null || doctor.isAvailable ? 'checked' : ''}>
                            <span>Currently Available for Consultation</span>
                        </label>
                    </div>
                    
                    <div class="form-actions" style="border-top: none; margin-top: var(--spacing-xl);">
                        <a href="${pageContext.request.contextPath}/dashboard/doctors" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> ${doctor.id != null ? 'Update' : 'Add'} Doctor
                        </button>
                    </div>
                </form>
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
    </script>
</body>
</html>

