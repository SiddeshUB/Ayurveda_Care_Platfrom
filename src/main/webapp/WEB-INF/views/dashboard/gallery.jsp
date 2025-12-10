<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photo Gallery - Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        .upload-area {
            border: 2px dashed var(--neutral-stone);
            border-radius: var(--radius-lg);
            padding: var(--spacing-2xl);
            text-align: center;
            background: var(--neutral-sand);
            margin-bottom: var(--spacing-xl);
            transition: all var(--transition-fast);
        }
        
        .upload-area:hover {
            border-color: var(--primary-sage);
        }
        
        .upload-area i {
            font-size: 3rem;
            color: var(--primary-sage);
            margin-bottom: var(--spacing-md);
        }
        
        .photo-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: var(--spacing-lg);
        }
        
        .photo-item {
            position: relative;
            aspect-ratio: 1;
            border-radius: var(--radius-md);
            overflow: hidden;
            background: var(--neutral-sand);
        }
        
        .photo-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .photo-overlay {
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.6);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: var(--spacing-sm);
            opacity: 0;
            transition: opacity var(--transition-fast);
        }
        
        .photo-item:hover .photo-overlay {
            opacity: 1;
        }
        
        .photo-overlay .btn {
            padding: var(--spacing-sm);
            width: 40px;
            height: 40px;
        }
        
        .cover-badge {
            position: absolute;
            top: var(--spacing-sm);
            left: var(--spacing-sm);
            background: var(--accent-gold);
            color: white;
            padding: 2px 8px;
            border-radius: var(--radius-sm);
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        @media (max-width: 1200px) {
            .photo-grid { grid-template-columns: repeat(3, 1fr); }
        }
        
        @media (max-width: 768px) {
            .photo-grid { grid-template-columns: repeat(2, 1fr); }
        }
    </style>
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
            <a href="${pageContext.request.contextPath}/dashboard/gallery" class="nav-item active">
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
                <h1>Photo Gallery</h1>
            </div>
        </header>

        <div class="dashboard-content">
            <c:if test="${not empty success}">
                <div class="alert alert-success" data-auto-dismiss="5000">
                    <i class="fas fa-check-circle"></i>
                    ${success}
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error" data-auto-dismiss="5000">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <!-- Upload Form -->
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/dashboard/gallery/upload" method="post" enctype="multipart/form-data">
                    <div class="upload-area" onclick="document.getElementById('photoInput').click();">
                        <i class="fas fa-cloud-upload-alt"></i>
                        <h4>Click to Upload Photos</h4>
                        <p style="color: var(--text-muted);">PNG, JPG up to 10MB</p>
                        <input type="file" id="photoInput" name="photo" accept="image/*" style="display: none;" required>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Title</label>
                            <input type="text" name="title" class="form-input" placeholder="Photo title">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Category</label>
                            <select name="category" class="form-select">
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat}">${cat}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <input type="text" name="description" class="form-input" placeholder="Brief description">
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-upload"></i> Upload Photo
                    </button>
                </form>
            </div>

            <!-- Photo Grid -->
            <c:choose>
                <c:when test="${not empty photos}">
                    <div class="photo-grid">
                        <c:forEach var="photo" items="${photos}">
                            <div class="photo-item">
                                <c:if test="${photo.isCoverPhoto}">
                                    <span class="cover-badge">Cover</span>
                                </c:if>
                                <img src="${pageContext.request.contextPath}${photo.photoUrl}" alt="${photo.title}">
                                <div class="photo-overlay">
                                    <form action="${pageContext.request.contextPath}/dashboard/gallery/cover/${photo.id}" method="post">
                                        <button type="submit" class="btn btn-gold" title="Set as Cover">
                                            <i class="fas fa-star"></i>
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/dashboard/gallery/delete/${photo.id}" method="post" onsubmit="return confirm('Delete this photo?');">
                                        <button type="submit" class="btn btn-secondary" style="color: var(--error);" title="Delete">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" style="background: white; border-radius: var(--radius-lg); padding: var(--spacing-3xl);">
                        <i class="fas fa-images"></i>
                        <h3>No Photos Yet</h3>
                        <p>Upload photos to showcase your center</p>
                    </div>
                </c:otherwise>
            </c:choose>
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
        
        // Show filename when selected
        document.getElementById('photoInput').addEventListener('change', function() {
            if (this.files[0]) {
                document.querySelector('.upload-area h4').textContent = this.files[0].name;
            }
        });
    </script>
</body>
</html>

