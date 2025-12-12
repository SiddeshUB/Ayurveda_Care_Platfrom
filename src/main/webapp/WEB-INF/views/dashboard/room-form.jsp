<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${room.id != null}">Edit</c:when><c:otherwise>Add</c:otherwise></c:choose> Room - Dashboard</title>
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
                <h1><c:choose><c:when test="${room.id != null}">Edit</c:when><c:otherwise>Add New</c:otherwise></c:choose> Room</h1>
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
                    <c:when test="${room.id != null}">
                        <form action="${pageContext.request.contextPath}/dashboard/rooms/edit/${room.id}" 
                              method="post" enctype="multipart/form-data">
                    </c:when>
                    <c:otherwise>
                        <form action="${pageContext.request.contextPath}/dashboard/rooms/add" 
                              method="post" enctype="multipart/form-data">
                    </c:otherwise>
                </c:choose>
                    
                    <h3><i class="fas fa-info-circle"></i> Basic Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Room Name</label>
                            <input type="text" name="roomName" class="form-input" 
                                   value="${room.roomName}" placeholder="e.g., Standard Room, Deluxe Cottage" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label required">Room Type</label>
                            <select name="roomType" class="form-select" required>
                                <option value="">Select type...</option>
                                <option value="Standard" ${room.roomType == 'Standard' ? 'selected' : ''}>Standard</option>
                                <option value="Deluxe" ${room.roomType == 'Deluxe' ? 'selected' : ''}>Deluxe</option>
                                <option value="Suite" ${room.roomType == 'Suite' ? 'selected' : ''}>Suite</option>
                                <option value="Cottage" ${room.roomType == 'Cottage' ? 'selected' : ''}>Cottage</option>
                                <option value="Budget" ${room.roomType == 'Budget' ? 'selected' : ''}>Budget</option>
                                <option value="Premium" ${room.roomType == 'Premium' ? 'selected' : ''}>Premium</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-textarea" rows="4" 
                                  placeholder="Describe the room, its ambiance, and features...">${room.description}</textarea>
                    </div>
                    
                    <h3 style="margin-top: var(--spacing-2xl);"><i class="fas fa-rupee-sign"></i> Pricing & Capacity</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Price Per Night (₹)</label>
                            <input type="number" name="pricePerNight" class="form-input" 
                                   value="${room.pricePerNight}" placeholder="e.g., 1500" min="0" step="0.01" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label required">Max Occupancy</label>
                            <input type="number" name="maxOccupancy" class="form-input" 
                                   value="${room.maxOccupancy}" placeholder="e.g., 2" min="1" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Total Rooms</label>
                            <input type="number" name="totalRooms" class="form-input" 
                                   value="${room.totalRooms}" placeholder="e.g., 5" min="1" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Available Rooms</label>
                            <input type="number" name="availableRooms" class="form-input" 
                                   value="${room.availableRooms != null ? room.availableRooms : room.totalRooms}" 
                                   placeholder="Auto-filled from total" min="0">
                            <small style="color: var(--text-muted);">Leave empty to auto-calculate from total</small>
                        </div>
                    </div>
                    
                    <h3 style="margin-top: var(--spacing-2xl);"><i class="fas fa-bed"></i> Room Details</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Room Size (sq. ft.)</label>
                            <input type="number" name="roomSize" class="form-input" 
                                   value="${room.roomSize}" placeholder="e.g., 250" min="0">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Bed Type</label>
                            <select name="bedType" class="form-select">
                                <option value="">Select...</option>
                                <option value="Single" ${room.bedType == 'Single' ? 'selected' : ''}>Single</option>
                                <option value="Double" ${room.bedType == 'Double' ? 'selected' : ''}>Double</option>
                                <option value="Queen" ${room.bedType == 'Queen' ? 'selected' : ''}>Queen</option>
                                <option value="King" ${room.bedType == 'King' ? 'selected' : ''}>King</option>
                                <option value="Twin" ${room.bedType == 'Twin' ? 'selected' : ''}>Twin</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="hasAC" value="true" ${room.hasAC ? 'checked' : ''}>
                                <span>Air Conditioning (AC)</span>
                            </label>
                        </div>
                        
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="hasAttachedBathroom" value="true" ${room.hasAttachedBathroom ? 'checked' : ''}>
                                <span>Attached Bathroom</span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="hasBalcony" value="true" ${room.hasBalcony ? 'checked' : ''}>
                                <span>Balcony</span>
                            </label>
                        </div>
                        
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="hasView" value="true" ${room.hasView ? 'checked' : ''}>
                                <span>View (Garden/Mountain)</span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Facilities</label>
                        <textarea name="facilities" class="form-textarea" rows="3" 
                                  placeholder="List facilities (one per line):&#10;- Wi-Fi&#10;- TV&#10;- Mini-fridge&#10;- Room service">${room.facilities}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Additional Amenities</label>
                        <textarea name="amenities" class="form-textarea" rows="3" 
                                  placeholder="Any additional amenities or special features...">${room.amenities}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Room Images</label>
                        <input type="file" name="imageFiles" class="form-input" accept="image/*" multiple>
                        <small style="color: var(--text-muted);">You can upload multiple images. Current images will be replaced.</small>
                        <c:if test="${not empty room.imageUrls}">
                            <div style="margin-top: var(--spacing-sm);">
                                <small>Current images: ${room.imageUrls}</small>
                            </div>
                        </c:if>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="isActive" value="true" ${room.isActive == null || room.isActive ? 'checked' : ''}>
                                <span>Active (visible to users)</span>
                            </label>
                        </div>
                        
                        <div class="form-group">
                            <label class="checkbox-label">
                                <input type="checkbox" name="isAvailable" value="true" ${room.isAvailable == null || room.isAvailable ? 'checked' : ''}>
                                <span>Available for booking</span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="form-actions" style="border-top: none; margin-top: var(--spacing-xl);">
                        <a href="${pageContext.request.contextPath}/dashboard/rooms" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> <c:choose><c:when test="${room.id != null}">Update</c:when><c:otherwise>Create</c:otherwise></c:choose> Room
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

