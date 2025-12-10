<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="My Profile"/>
    <jsp:param name="activeNav" value="profile"/>
</jsp:include>

<!-- Alerts -->
<c:if test="${not empty success}">
    <div class="alert-box success">
        <i class="fas fa-check-circle"></i>
        <span>${success}</span>
        <button class="alert-close"><i class="fas fa-times"></i></button>
    </div>
</c:if>

<c:if test="${not empty error}">
    <div class="alert-box danger">
        <i class="fas fa-exclamation-circle"></i>
        <span>${error}</span>
        <button class="alert-close"><i class="fas fa-times"></i></button>
    </div>
</c:if>

<!-- Profile Header -->
<div class="profile-header-card">
    <div class="profile-cover"></div>
    <div class="profile-info-section">
        <div class="profile-avatar-large">
            <c:choose>
                <c:when test="${not empty user && not empty user.fullName}">
                    ${fn:substring(user.fullName, 0, 1)}
                </c:when>
                <c:otherwise>
                    <i class="fas fa-user"></i>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="profile-details">
            <h2>${user.fullName}</h2>
            <p><i class="fas fa-envelope"></i> ${user.email}</p>
            <p><i class="fas fa-map-marker-alt"></i> ${user.city != null ? user.city : 'Location not set'}, ${user.country != null ? user.country : ''}</p>
        </div>
    </div>
</div>

<!-- Tabs -->
<div class="profile-tabs">
    <button class="profile-tab active" data-tab="personal">
        <i class="fas fa-user"></i> Personal Info
    </button>
    <button class="profile-tab" data-tab="password">
        <i class="fas fa-lock"></i> Security
    </button>
</div>

<!-- Personal Information Tab -->
<div id="personal-tab" class="tab-panel active">
    <div class="dashboard-card">
        <div class="card-header-custom">
            <h3 class="card-title">
                <i class="fas fa-id-card"></i> Personal Information
            </h3>
        </div>
        <div class="card-body-custom">
            <form action="${pageContext.request.contextPath}/user/profile" method="post">
                <div class="row g-4">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Full Name <span class="required">*</span></label>
                            <input type="text" name="fullName" class="form-input" value="${user.fullName}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Email Address</label>
                            <input type="email" class="form-input disabled" value="${user.email}" disabled>
                            <span class="form-hint">Email cannot be changed</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" name="phone" class="form-input" value="${user.phone}" placeholder="+91 98765 43210">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Country <span class="required">*</span></label>
                            <input type="text" name="country" class="form-input" value="${user.country}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">State</label>
                            <input type="text" name="state" class="form-input" value="${user.state}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">City</label>
                            <input type="text" name="city" class="form-input" value="${user.city}">
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="form-group">
                            <label class="form-label">Full Address</label>
                            <textarea name="address" class="form-input" rows="2" placeholder="Enter your complete address">${user.address}</textarea>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Gender</label>
                            <select name="gender" class="form-input">
                                <option value="">Select Gender</option>
                                <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                                <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" name="dateOfBirth" class="form-input" 
                                   value="<c:if test='${user.dateOfBirth != null}'><fmt:formatDate value='${user.dateOfBirth}' pattern='yyyy-MM-dd'/></c:if>">
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="form-group">
                            <label class="form-label">Purpose of Visit / Health Goals</label>
                            <textarea name="purpose" class="form-input" rows="3" placeholder="Tell us about your wellness goals and what you're looking for...">${user.purpose}</textarea>
                        </div>
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn-gold">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Password Tab -->
<div id="password-tab" class="tab-panel">
    <div class="dashboard-card">
        <div class="card-header-custom">
            <h3 class="card-title">
                <i class="fas fa-shield-alt"></i> Change Password
            </h3>
        </div>
        <div class="card-body-custom">
            <form action="${pageContext.request.contextPath}/user/change-password" method="post">
                <div class="row g-4">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Current Password <span class="required">*</span></label>
                            <div class="password-input-wrapper">
                                <input type="password" name="oldPassword" class="form-input" required>
                                <button type="button" class="password-toggle"><i class="fas fa-eye"></i></button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6"></div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">New Password <span class="required">*</span></label>
                            <div class="password-input-wrapper">
                                <input type="password" name="newPassword" class="form-input" required>
                                <button type="button" class="password-toggle"><i class="fas fa-eye"></i></button>
                            </div>
                            <span class="form-hint">Minimum 8 characters</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Confirm New Password <span class="required">*</span></label>
                            <div class="password-input-wrapper">
                                <input type="password" name="confirmPassword" class="form-input" required>
                                <button type="button" class="password-toggle"><i class="fas fa-eye"></i></button>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn-gold">
                            <i class="fas fa-key"></i> Update Password
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<style>
    /* Profile Header Card */
    .profile-header-card {
        background: #fff;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        margin-bottom: 30px;
    }
    
    .profile-cover {
        height: 120px;
        background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary-green) 100%);
        position: relative;
    }
    
    .profile-cover::after {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 300px;
        height: 100%;
        background: radial-gradient(circle, rgba(201, 162, 39, 0.3) 0%, transparent 70%);
    }
    
    .profile-info-section {
        display: flex;
        align-items: center;
        gap: 25px;
        padding: 0 30px 30px;
        margin-top: -50px;
    }
    
    .profile-avatar-large {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'Cormorant Garamond', serif;
        font-size: 42px;
        font-weight: 700;
        color: var(--primary-dark);
        border: 5px solid #fff;
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
    }
    
    .profile-details h2 {
        font-size: 26px;
        color: var(--primary-dark);
        margin: 0 0 8px 0;
    }
    
    .profile-details p {
        color: #888;
        font-size: 14px;
        margin: 5px 0;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .profile-details p i {
        color: var(--accent-gold);
        width: 16px;
    }
    
    /* Profile Tabs */
    .profile-tabs {
        display: flex;
        gap: 10px;
        margin-bottom: 30px;
        background: #fff;
        padding: 8px;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    }
    
    .profile-tab {
        flex: 1;
        padding: 15px 25px;
        border: none;
        background: transparent;
        border-radius: 10px;
        font-weight: 600;
        color: #888;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        font-size: 15px;
    }
    
    .profile-tab:hover {
        color: var(--primary-dark);
        background: var(--bg-light);
    }
    
    .profile-tab.active {
        background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
        color: var(--primary-dark);
    }
    
    .tab-panel {
        display: none;
    }
    
    .tab-panel.active {
        display: block;
    }
    
    /* Form Styles */
    .form-group {
        margin-bottom: 0;
    }
    
    .form-label {
        display: block;
        font-weight: 600;
        color: var(--primary-dark);
        margin-bottom: 8px;
        font-size: 14px;
    }
    
    .form-label .required {
        color: #dc3545;
    }
    
    .form-input {
        width: 100%;
        padding: 14px 18px;
        border: 2px solid #e9ecef;
        border-radius: 12px;
        font-size: 15px;
        transition: all 0.3s ease;
        background: var(--bg-light);
    }
    
    .form-input:focus {
        outline: none;
        border-color: var(--accent-gold);
        background: #fff;
        box-shadow: 0 0 0 4px rgba(201, 162, 39, 0.1);
    }
    
    .form-input.disabled {
        background: #e9ecef;
        color: #888;
        cursor: not-allowed;
    }
    
    .form-hint {
        display: block;
        font-size: 12px;
        color: #888;
        margin-top: 6px;
    }
    
    textarea.form-input {
        resize: vertical;
        min-height: 80px;
    }
    
    select.form-input {
        cursor: pointer;
    }
    
    /* Password Input */
    .password-input-wrapper {
        position: relative;
    }
    
    .password-toggle {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        color: #888;
        cursor: pointer;
        padding: 5px;
    }
    
    .password-toggle:hover {
        color: var(--accent-gold);
    }
    
    /* Alerts */
    .alert-box {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 16px 20px;
        border-radius: 12px;
        margin-bottom: 25px;
        font-weight: 500;
    }
    
    .alert-box.success {
        background: rgba(40, 167, 69, 0.1);
        color: #28a745;
        border: 1px solid rgba(40, 167, 69, 0.2);
    }
    
    .alert-box.danger {
        background: rgba(220, 53, 69, 0.1);
        color: #dc3545;
        border: 1px solid rgba(220, 53, 69, 0.2);
    }
    
    .alert-box i {
        font-size: 20px;
    }
    
    .alert-box span {
        flex: 1;
    }
    
    .alert-close {
        background: none;
        border: none;
        cursor: pointer;
        color: inherit;
        opacity: 0.7;
    }
    
    .alert-close:hover {
        opacity: 1;
    }
    
    /* Responsive */
    @media (max-width: 767px) {
        .profile-info-section {
            flex-direction: column;
            text-align: center;
            padding: 0 20px 25px;
        }
        
        .profile-avatar-large {
            margin-top: -60px;
        }
        
        .profile-tabs {
            flex-direction: column;
        }
    }
</style>

        </div>
    </main>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Sidebar Toggle
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebarOverlay = document.getElementById('sidebarOverlay');
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', () => {
                sidebar.classList.toggle('active');
                sidebarOverlay.classList.toggle('active');
            });
        }
        
        if (sidebarOverlay) {
            sidebarOverlay.addEventListener('click', () => {
                sidebar.classList.remove('active');
                sidebarOverlay.classList.remove('active');
            });
        }
        
        // Tab Switching
        document.querySelectorAll('.profile-tab').forEach(tab => {
            tab.addEventListener('click', function() {
                const tabName = this.getAttribute('data-tab');
                
                // Remove active from all tabs
                document.querySelectorAll('.profile-tab').forEach(t => t.classList.remove('active'));
                document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
                
                // Add active to clicked tab
                this.classList.add('active');
                document.getElementById(tabName + '-tab').classList.add('active');
            });
        });
        
        // Password Toggle
        document.querySelectorAll('.password-toggle').forEach(btn => {
            btn.addEventListener('click', function() {
                const input = this.previousElementSibling;
                const icon = this.querySelector('i');
                
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.replace('fa-eye', 'fa-eye-slash');
                } else {
                    input.type = 'password';
                    icon.classList.replace('fa-eye-slash', 'fa-eye');
                }
            });
        });
        
        // Alert Close
        document.querySelectorAll('.alert-close').forEach(btn => {
            btn.addEventListener('click', function() {
                this.closest('.alert-box').remove();
            });
        });
    </script>
</body>
</html>
