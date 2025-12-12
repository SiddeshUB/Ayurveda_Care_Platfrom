<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${pkg.id != null}">Edit</c:when><c:otherwise>Add</c:otherwise></c:choose> Package - Dashboard</title>
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
            <a href="${pageContext.request.contextPath}/dashboard/packages" class="nav-item active">
                <i class="fas fa-box"></i>
                <span>Packages</span>
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
                <h1><c:choose><c:when test="${pkg.id != null}">Edit</c:when><c:otherwise>Add New</c:otherwise></c:choose> Package</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <div class="form-card">
                <c:choose>
                    <c:when test="${pkg.id != null}">
                        <form action="${pageContext.request.contextPath}/dashboard/packages/edit/${pkg.id}" 
                              method="post" enctype="multipart/form-data">
                    </c:when>
                    <c:otherwise>
                        <form action="${pageContext.request.contextPath}/dashboard/packages/add" 
                              method="post" enctype="multipart/form-data">
                    </c:otherwise>
                </c:choose>
                    
                    <h3><i class="fas fa-info-circle"></i> Basic Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Package Name</label>
                            <input type="text" name="packageName" class="form-input" 
                                   value="${pkg.packageName}" placeholder="e.g., 7-Day Panchakarma Detox" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label required">Package Type</label>
                            <select name="packageType" id="packageType" class="form-select" required onchange="handlePackageTypeChange()">
                                <option value="">Select type...</option>
                                <c:forEach var="type" items="${packageTypes}">
                                    <c:if test="${type != 'OTHERS'}">
                                        <option value="${type}" ${pkg.packageType == type ? 'selected' : ''}>
                                            ${fn:replace(type, '_', ' ')}
                                        </option>
                                    </c:if>
                                </c:forEach>
                                <option value="OTHERS" ${pkg.packageType == 'OTHERS' ? 'selected' : ''}>Others</option>
                            </select>
                        </div>
                    </div>
                    
                    <!-- Custom Type Input (shown when Others is selected) -->
                    <div class="form-group" id="customTypeGroup" style="display: ${pkg.packageType == 'OTHERS' ? 'block' : 'none'};">
                        <label class="form-label required">Enter Custom Package Type</label>
                        <input type="text" name="customType" id="customType" class="form-input" 
                               value="${pkg.customType}" placeholder="e.g., Custom Wellness Program">
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Duration (Days)</label>
                            <input type="number" name="durationDays" class="form-input" 
                                   value="${pkg.durationDays}" placeholder="e.g., 7" min="1" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Package Image</label>
                            <input type="file" name="imageFile" class="form-input" accept="image/*">
                            <c:if test="${not empty pkg.imageUrl}">
                                <small style="color: var(--text-muted);">Current image: ${pkg.imageUrl}</small>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Short Description</label>
                        <input type="text" name="shortDescription" class="form-input" 
                               value="${pkg.shortDescription}" placeholder="Brief 1-2 line description">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Full Description</label>
                        <textarea name="description" class="form-textarea" rows="5" 
                                  placeholder="Detailed description of the package...">${pkg.description}</textarea>
                    </div>
                    
                    <!-- Add Doctors Section -->
                    <h3 style="margin-top: var(--spacing-2xl);"><i class="fas fa-user-md"></i> Select Doctors for This Package</h3>
                    <div class="form-group">
                        <label class="form-label">Doctors</label>
                        <div style="border: 1px solid #ddd; border-radius: 5px; padding: 15px; max-height: 200px; overflow-y: auto; background: #f9f9f9;">
                            <c:choose>
                                <c:when test="${not empty doctors}">
                                    <c:forEach var="doctor" items="${doctors}">
                                        <label class="checkbox-label" style="display: block; margin-bottom: 10px;">
                                            <input type="checkbox" name="doctorIds" value="${doctor.id}" 
                                                   ${fn:contains(associatedDoctorIds, doctor.id) ? 'checked' : ''}>
                                            <span><strong>${doctor.name}</strong> - ${doctor.specializations != null ? doctor.specializations : 'No specialization'}</span>
                                        </label>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <p style="color: var(--text-muted);">No doctors registered yet. <a href="${pageContext.request.contextPath}/dashboard/doctors/add">Add doctors first</a></p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <small style="color: var(--text-muted);">Select doctors who will be associated with this package</small>
                    </div>
                    
                    <!-- Room Details Section -->
                    <h3 style="margin-top: var(--spacing-2xl);"><i class="fas fa-bed"></i> Room Details & Availability</h3>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Budget Rooms Count</label>
                            <input type="number" name="budgetRoomCount" class="form-input" 
                                   value="${pkg.budgetRoomCount}" placeholder="e.g., 10" min="0">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Standard Rooms Count</label>
                            <input type="number" name="standardRoomCount" class="form-input" 
                                   value="${pkg.standardRoomCount}" placeholder="e.g., 15" min="0">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Deluxe Rooms Count</label>
                            <input type="number" name="deluxeRoomCount" class="form-input" 
                                   value="${pkg.deluxeRoomCount}" placeholder="e.g., 8" min="0">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Suite Rooms Count</label>
                            <input type="number" name="suiteRoomCount" class="form-input" 
                                   value="${pkg.suiteRoomCount}" placeholder="e.g., 5" min="0">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Villas Count</label>
                            <input type="number" name="villaCount" class="form-input" 
                                   value="${pkg.villaCount}" placeholder="e.g., 5" min="0">
                        </div>
                        <div class="form-group">
                            <label class="form-label">VIP Rooms Count</label>
                            <input type="number" name="vipRoomCount" class="form-input" 
                                   value="${pkg.vipRoomCount}" placeholder="e.g., 3" min="0">
                        </div>
                    </div>
                    
                    <!-- Budget Room Pricing -->
                    <div style="background: #f9f9f9; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
                        <h4 style="margin-bottom: 15px; color: #333;"><i class="fas fa-bed"></i> Budget Room</h4>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Base Price (₹)</label>
                                <input type="number" name="budgetRoomPrice" class="form-input" step="0.01"
                                       value="${pkg.budgetRoomPrice}" placeholder="e.g., 15000" min="0">
                            </div>
                            <div class="form-group">
                                <label class="form-label">GST %</label>
                                <input type="number" name="budgetRoomGstPercent" class="form-input" step="0.01"
                                       value="${pkg.budgetRoomGstPercent}" placeholder="e.g., 18" min="0" max="100">
                            </div>
                            <div class="form-group">
                                <label class="form-label">CGST %</label>
                                <input type="number" name="budgetRoomCgstPercent" class="form-input" step="0.01"
                                       value="${pkg.budgetRoomCgstPercent}" placeholder="e.g., 9" min="0" max="100">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Standard Room Pricing -->
                    <div style="background: #f9f9f9; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
                        <h4 style="margin-bottom: 15px; color: #333;"><i class="fas fa-bed"></i> Standard Room</h4>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Base Price (₹)</label>
                                <input type="number" name="standardRoomPrice" class="form-input" step="0.01"
                                       value="${pkg.standardRoomPrice}" placeholder="e.g., 25000" min="0">
                            </div>
                            <div class="form-group">
                                <label class="form-label">GST %</label>
                                <input type="number" name="standardRoomGstPercent" class="form-input" step="0.01"
                                       value="${pkg.standardRoomGstPercent}" placeholder="e.g., 18" min="0" max="100">
                            </div>
                            <div class="form-group">
                                <label class="form-label">CGST %</label>
                                <input type="number" name="standardRoomCgstPercent" class="form-input" step="0.01"
                                       value="${pkg.standardRoomCgstPercent}" placeholder="e.g., 9" min="0" max="100">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Deluxe Room Pricing -->
                    <div style="background: #f9f9f9; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
                        <h4 style="margin-bottom: 15px; color: #333;"><i class="fas fa-bed"></i> Deluxe Room</h4>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Base Price (₹)</label>
                                <input type="number" name="deluxeRoomPrice" class="form-input" step="0.01"
                                       value="${pkg.deluxeRoomPrice}" placeholder="e.g., 35000" min="0">
                            </div>
                            <div class="form-group">
                                <label class="form-label">GST %</label>
                                <input type="number" name="deluxeRoomGstPercent" class="form-input" step="0.01"
                                       value="${pkg.deluxeRoomGstPercent}" placeholder="e.g., 18" min="0" max="100">
                            </div>
                            <div class="form-group">
                                <label class="form-label">CGST %</label>
                                <input type="number" name="deluxeRoomCgstPercent" class="form-input" step="0.01"
                                       value="${pkg.deluxeRoomCgstPercent}" placeholder="e.g., 9" min="0" max="100">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Suite Room Pricing -->
                    <div style="background: #f9f9f9; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
                        <h4 style="margin-bottom: 15px; color: #333;"><i class="fas fa-bed"></i> Suite Room</h4>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Base Price (₹)</label>
                                <input type="number" name="suiteRoomPrice" class="form-input" step="0.01"
                                       value="${pkg.suiteRoomPrice}" placeholder="e.g., 50000" min="0">
                            </div>
                            <div class="form-group">
                                <label class="form-label">GST %</label>
                                <input type="number" name="suiteRoomGstPercent" class="form-input" step="0.01"
                                       value="${pkg.suiteRoomGstPercent}" placeholder="e.g., 18" min="0" max="100">
                            </div>
                            <div class="form-group">
                                <label class="form-label">CGST %</label>
                                <input type="number" name="suiteRoomCgstPercent" class="form-input" step="0.01"
                                       value="${pkg.suiteRoomCgstPercent}" placeholder="e.g., 9" min="0" max="100">
                            </div>
                        </div>
                    </div>
                    
                    <!-- Villa Pricing -->
                    <div style="background: #f9f9f9; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
                        <h4 style="margin-bottom: 15px; color: #333;"><i class="fas fa-home"></i> Villa</h4>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Base Price (₹)</label>
                                <input type="number" name="villaPrice" class="form-input" step="0.01"
                                       value="${pkg.villaPrice}" placeholder="e.g., 50000" min="0">
                            </div>
                            <div class="form-group">
                                <label class="form-label">GST %</label>
                                <input type="number" name="villaGstPercent" class="form-input" step="0.01"
                                       value="${pkg.villaGstPercent}" placeholder="e.g., 18" min="0" max="100">
                            </div>
                            <div class="form-group">
                                <label class="form-label">CGST %</label>
                                <input type="number" name="villaCgstPercent" class="form-input" step="0.01"
                                       value="${pkg.villaCgstPercent}" placeholder="e.g., 9" min="0" max="100">
                            </div>
                        </div>
                    </div>
                    
                    <!-- VIP Room Pricing -->
                    <div style="background: #f9f9f9; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
                        <h4 style="margin-bottom: 15px; color: #333;"><i class="fas fa-crown"></i> VIP Room</h4>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Base Price (₹)</label>
                                <input type="number" name="vipRoomPrice" class="form-input" step="0.01"
                                       value="${pkg.vipRoomPrice}" placeholder="e.g., 75000" min="0">
                            </div>
                            <div class="form-group">
                                <label class="form-label">GST %</label>
                                <input type="number" name="vipRoomGstPercent" class="form-input" step="0.01"
                                       value="${pkg.vipRoomGstPercent}" placeholder="e.g., 18" min="0" max="100">
                            </div>
                            <div class="form-group">
                                <label class="form-label">CGST %</label>
                                <input type="number" name="vipRoomCgstPercent" class="form-input" step="0.01"
                                       value="${pkg.vipRoomCgstPercent}" placeholder="e.g., 9" min="0" max="100">
                            </div>
                        </div>
                    </div>
                    
                    <h3 style="margin-top: var(--spacing-2xl);"><i class="fas fa-list-check"></i> Details</h3>
                    
                    <div class="form-group">
                        <label class="form-label">Inclusions</label>
                        <textarea name="inclusions" class="form-textarea" rows="4" 
                                  placeholder="List what's included (one item per line):&#10;- Daily doctor consultation&#10;- All therapies and treatments&#10;- Ayurvedic meals&#10;- Accommodation">${pkg.inclusions}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Exclusions</label>
                        <textarea name="exclusions" class="form-textarea" rows="3" 
                                  placeholder="List what's NOT included (one per line):&#10;- Travel and transportation&#10;- Additional treatments&#10;- Personal expenses">${pkg.exclusions}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Expected Results / Benefits</label>
                        <textarea name="expectedResults" class="form-textarea" rows="3" 
                                  placeholder="What patients can expect after completing this package...">${pkg.expectedResults}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Suitable For</label>
                        <textarea name="suitableFor" class="form-textarea" rows="2" 
                                  placeholder="Who is this package ideal for? (e.g., People with chronic stress, those seeking detox...)">${pkg.suitableFor}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Day-wise Schedule (Optional)</label>
                        <textarea name="dayWiseSchedule" class="form-textarea" rows="6" 
                                  placeholder="Day 1: Consultation and assessment&#10;Day 2-3: Preparatory treatments&#10;Day 4-6: Main therapies...">${pkg.dayWiseSchedule}</textarea>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="isFeatured" value="true" ${pkg.isFeatured ? 'checked' : ''}>
                                <span>Featured Package (shown prominently)</span>
                            </label>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Sort Order</label>
                            <input type="number" name="sortOrder" class="form-input" 
                                   value="${pkg.sortOrder != null ? pkg.sortOrder : 0}" min="0">
                        </div>
                    </div>
                    
                    <div class="form-actions" style="border-top: none; margin-top: var(--spacing-xl);">
                        <a href="${pageContext.request.contextPath}/dashboard/packages" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> <c:choose><c:when test="${pkg.id != null}">Update</c:when><c:otherwise>Create</c:otherwise></c:choose> Package
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
        
        // Handle Package Type change - show/hide custom type input
        function handlePackageTypeChange() {
            const packageTypeSelect = document.getElementById('packageType');
            const customTypeGroup = document.getElementById('customTypeGroup');
            const customTypeInput = document.getElementById('customType');
            
            if (packageTypeSelect && customTypeGroup) {
                if (packageTypeSelect.value === 'OTHERS') {
                    customTypeGroup.style.display = 'block';
                    if (customTypeInput) {
                        customTypeInput.setAttribute('required', 'required');
                    }
                } else {
                    customTypeGroup.style.display = 'none';
                    if (customTypeInput) {
                        customTypeInput.removeAttribute('required');
                        customTypeInput.value = '';
                    }
                }
            }
        }
        
        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            handlePackageTypeChange();
        });
    </script>
</body>
</html>
