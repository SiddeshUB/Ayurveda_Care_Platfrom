<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Management - Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/dashboard/profile" class="nav-item active">
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
            <a href="${pageContext.request.contextPath}/dashboard/doctors" class="nav-item">
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
            <a href="${pageContext.request.contextPath}/dashboard/reviews" class="nav-item">
                <i class="fas fa-star"></i>
                <span>Reviews</span>
            </a>
        </nav>
        
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}" class="btn btn-outline btn-sm" target="_blank">
                <i class="fas fa-external-link-alt"></i> View Public Profile
            </a>
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
                <h1>Profile Management</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success" data-auto-dismiss="5000">
                    <i class="fas fa-check-circle"></i>
                    ${success}
                </div>
            </c:if>

            <!-- Tabs Navigation -->
            <div class="tabs">
                <button class="tab-btn active" data-tab="basic">Basic Info</button>
                <button class="tab-btn" data-tab="location">Location</button>
                <button class="tab-btn" data-tab="contact">Contact</button>
                <button class="tab-btn" data-tab="specializations">Specializations</button>
            </div>

            <!-- Basic Info Tab -->
            <div class="tab-panel active" id="basic">
                <div class="form-card">
                    <h3><i class="fas fa-hospital"></i> Basic Information</h3>
                    <form action="${pageContext.request.contextPath}/dashboard/profile/basic" method="post">
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">Center Name</label>
                                <input type="text" name="centerName" class="form-input" value="${hospital.centerName}" required>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label required">Center Type</label>
                                <select name="centerType" class="form-select" required>
                                    <c:forEach var="type" items="${centerTypes}">
                                        <option value="${type}" ${hospital.centerType == type ? 'selected' : ''}>${type}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Year Established</label>
                                <input type="number" name="yearEstablished" class="form-input" value="${hospital.yearEstablished}" min="1900" max="2024">
                            </div>
                            <div class="form-group"></div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-textarea" rows="6" placeholder="Describe your center's philosophy, approach, and what makes you unique...">${hospital.description}</textarea>
                            <div class="form-hint">300-500 words recommended for best results</div>
                        </div>
                        
                        <div class="form-actions" style="border: none; margin-top: var(--spacing-lg);">
                            <span></span>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Location Tab -->
            <div class="tab-panel" id="location">
                <div class="form-card">
                    <h3><i class="fas fa-map-marker-alt"></i> Location Details</h3>
                    <form action="${pageContext.request.contextPath}/dashboard/profile/location" method="post">
                        <div class="form-group">
                            <label class="form-label required">Street Address</label>
                            <input type="text" name="streetAddress" class="form-input" value="${hospital.streetAddress}" required>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">City</label>
                                <input type="text" name="city" class="form-input" value="${hospital.city}" required>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label required">State</label>
                                <input type="text" name="state" class="form-input" value="${hospital.state}" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">PIN Code</label>
                                <input type="text" name="pinCode" class="form-input" value="${hospital.pinCode}" required>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">Google Maps URL</label>
                                <input type="url" name="googleMapsUrl" class="form-input" value="${hospital.googleMapsUrl}" placeholder="https://maps.google.com/...">
                            </div>
                        </div>
                        
                        <div class="form-actions" style="border: none; margin-top: var(--spacing-lg);">
                            <span></span>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Contact Tab -->
            <div class="tab-panel" id="contact">
                <div class="form-card">
                    <h3><i class="fas fa-phone"></i> Contact Information</h3>
                    <form action="${pageContext.request.contextPath}/dashboard/profile/contact" method="post">
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Reception Phone</label>
                                <input type="tel" name="receptionPhone" class="form-input" value="${hospital.receptionPhone}">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">Emergency Phone</label>
                                <input type="tel" name="emergencyPhone" class="form-input" value="${hospital.emergencyPhone}">
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Booking Phone</label>
                                <input type="tel" name="bookingPhone" class="form-input" value="${hospital.bookingPhone}">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">Public Email</label>
                                <input type="email" name="publicEmail" class="form-input" value="${hospital.publicEmail}">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Website</label>
                            <input type="url" name="website" class="form-input" value="${hospital.website}" placeholder="https://www.yourwebsite.com">
                        </div>
                        
                        <h4 style="margin: var(--spacing-xl) 0 var(--spacing-lg);">Social Media</h4>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label"><i class="fab fa-instagram"></i> Instagram</label>
                                <input type="url" name="instagramUrl" class="form-input" value="${hospital.instagramUrl}">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label"><i class="fab fa-facebook"></i> Facebook</label>
                                <input type="url" name="facebookUrl" class="form-input" value="${hospital.facebookUrl}">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label"><i class="fab fa-youtube"></i> YouTube</label>
                            <input type="url" name="youtubeUrl" class="form-input" value="${hospital.youtubeUrl}">
                        </div>
                        
                        <div class="form-actions" style="border: none; margin-top: var(--spacing-lg);">
                            <span></span>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Specializations Tab -->
            <div class="tab-panel" id="specializations">
                <div class="form-card">
                    <h3><i class="fas fa-spa"></i> Specializations & Facilities</h3>
                    <form action="${pageContext.request.contextPath}/dashboard/profile/specializations" method="post">
                        <div class="form-group">
                            <label class="form-label">Therapies Offered</label>
                            <textarea name="therapiesOffered" class="form-textarea" rows="3" placeholder="Panchakarma, Shirodhara, Abhyanga, Nasya, etc.">${hospital.therapiesOffered}</textarea>
                            <div class="form-hint">Comma-separated list of therapies</div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Special Treatments</label>
                            <textarea name="specialTreatments" class="form-textarea" rows="3" placeholder="Arthritis, Back Pain, Stress Management, etc.">${hospital.specialTreatments}</textarea>
                            <div class="form-hint">Health conditions you specialize in</div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Facilities Available</label>
                            <textarea name="facilitiesAvailable" class="form-textarea" rows="3" placeholder="AC Rooms, Garden, Wi-Fi, Pool, Yoga Hall, etc.">${hospital.facilitiesAvailable}</textarea>
                            <div class="form-hint">Amenities at your center</div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Languages Spoken</label>
                            <textarea name="languagesSpoken" class="form-textarea" rows="2" placeholder="English, Hindi, Malayalam, etc.">${hospital.languagesSpoken}</textarea>
                        </div>
                        
                        <div class="form-actions" style="border: none; margin-top: var(--spacing-lg);">
                            <span></span>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // Sidebar toggle
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebar = document.querySelector('.sidebar');
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
            });
        }
        
        // Tab functionality
        const tabBtns = document.querySelectorAll('.tab-btn');
        const tabPanels = document.querySelectorAll('.tab-panel');
        
        tabBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                const tabId = this.dataset.tab;
                
                tabBtns.forEach(b => b.classList.remove('active'));
                tabPanels.forEach(p => p.classList.remove('active'));
                
                this.classList.add('active');
                document.getElementById(tabId).classList.add('active');
            });
        });
    </script>
</body>
</html>

