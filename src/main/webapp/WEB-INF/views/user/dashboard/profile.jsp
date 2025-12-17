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
    /* Profile Header Card - Green Design */
    .profile-header-card {
        background: linear-gradient(135deg, #ffffff 0%, #f0f5f0 100%);
        border-radius: 0;
        box-shadow: 0 15px 50px rgba(26, 46, 26, 0.15), 0 5px 20px rgba(0,0,0,0.1);
        margin-bottom: 30px;
        position: relative;
        clip-path: polygon(0 0, calc(100% - 30px) 0, 100% 30px, 100% 100%, 0 100%);
        overflow: visible;
        border: 1px solid rgba(45, 90, 61, 0.2);
    }
    
    .profile-header-card::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 30px;
        height: 30px;
        background: linear-gradient(135deg, #2d4a2d 0%, #3d6a3d 50%, #4a7c4a 100%);
        clip-path: polygon(0 0, 100% 0, 100% 100%);
        z-index: 1;
        box-shadow: 0 0 20px rgba(45, 90, 61, 0.5);
    }
    
    .profile-cover {
        height: 200px;
        background: linear-gradient(135deg, 
            #1a2e1a 0%, 
            #2d4a2d 25%, 
            #3d6a3d 50%, 
            #4a7c4a 75%, 
            #5a8f5a 100%);
        position: relative;
        overflow: hidden;
    }
    
    .profile-cover::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: 
            radial-gradient(circle at 15% 25%, rgba(45, 90, 61, 0.4) 0%, transparent 45%),
            radial-gradient(circle at 85% 75%, rgba(61, 106, 61, 0.3) 0%, transparent 50%),
            radial-gradient(circle at 50% 50%, rgba(74, 124, 74, 0.2) 0%, transparent 60%);
        animation: gradientShift 8s ease infinite;
    }
    
    @keyframes gradientShift {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.8; }
    }
    
    .profile-cover::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 80px;
        background: linear-gradient(to top, #ffffff 0%, rgba(255,255,255,0.95) 50%, transparent 100%);
    }
    
    .profile-info-section {
        display: flex;
        align-items: flex-start;
        gap: 30px;
        padding: 25px 40px 45px;
        position: relative;
        z-index: 2;
        background: linear-gradient(135deg, #ffffff 0%, #fafbfc 100%);
    }
    
    .profile-avatar-large {
        width: 130px;
        height: 130px;
        min-width: 130px;
        border-radius: 0;
        background: linear-gradient(135deg, 
            #2d4a2d 0%, 
            #3d6a3d 30%, 
            #4a7c4a 60%, 
            #5a8f5a 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'Cormorant Garamond', serif;
        font-size: 52px;
        font-weight: 700;
        color: #ffffff;
        border: 5px solid #fff;
        box-shadow: 
            0 20px 50px rgba(45, 90, 61, 0.4),
            0 10px 30px rgba(0,0,0,0.2),
            inset 0 2px 10px rgba(255,255,255,0.3);
        clip-path: polygon(0 0, calc(100% - 15px) 0, 100% 15px, 100% 100%, 0 100%);
        position: relative;
        margin-top: -65px;
        transition: all 0.4s ease;
    }
    
    .profile-avatar-large:hover {
        transform: translateY(-5px) scale(1.05);
        box-shadow: 
            0 25px 60px rgba(45, 90, 61, 0.5),
            0 15px 40px rgba(0,0,0,0.3),
            inset 0 2px 10px rgba(255,255,255,0.4);
    }
    
    .profile-avatar-large::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 15px;
        height: 15px;
        background: linear-gradient(135deg, rgba(255,255,255,0.6), rgba(255,255,255,0.3));
        clip-path: polygon(0 0, 100% 0, 100% 100%);
    }
    
    .profile-avatar-large::after {
        content: '';
        position: absolute;
        inset: -3px;
        background: linear-gradient(135deg, #2d4a2d, #3d6a3d, #4a7c4a);
        border-radius: inherit;
        z-index: -1;
        opacity: 0;
        transition: opacity 0.4s ease;
    }
    
    .profile-avatar-large:hover::after {
        opacity: 0.3;
    }
    
    .profile-details {
        flex: 1;
        padding-top: 10px;
    }
    
    .profile-details h2 {
        font-size: clamp(1.75rem, 3vw, 2.25rem);
        background: linear-gradient(135deg, #1a2e1a 0%, #2d4a2d 50%, #1a2e1a 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin: 0 0 15px 0;
        font-weight: 700;
        line-height: 1.2;
        text-shadow: 0 2px 10px rgba(26, 46, 26, 0.1);
    }
    
    .profile-details p {
        color: #555;
        font-size: 15px;
        margin: 10px 0;
        display: flex;
        align-items: center;
        gap: 12px;
        line-height: 1.7;
        padding: 8px 0;
        transition: all 0.3s ease;
    }
    
    .profile-details p:hover {
        color: #1a2e1a;
        transform: translateX(5px);
    }
    
    .profile-details p i {
        color: #2d4a2d;
        width: 20px;
        font-size: 18px;
        background: linear-gradient(135deg, rgba(45, 90, 61, 0.1), rgba(61, 106, 61, 0.1));
        padding: 8px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
    }
    
    .profile-details p:hover i {
        background: linear-gradient(135deg, rgba(45, 90, 61, 0.2), rgba(61, 106, 61, 0.2));
        transform: scale(1.1);
        color: #3d6a3d;
    }
    
    /* Profile Tabs - Green Design */
    .profile-tabs {
        display: flex;
        gap: 15px;
        margin-bottom: 30px;
        background: linear-gradient(135deg, #ffffff 0%, #f0f5f0 100%);
        padding: 12px;
        border-radius: 0;
        box-shadow: 
            0 10px 40px rgba(26, 46, 26, 0.12),
            0 5px 20px rgba(0,0,0,0.08);
        clip-path: polygon(0 0, calc(100% - 20px) 0, 100% 20px, 100% 100%, 0 100%);
        position: relative;
        border: 1px solid rgba(45, 90, 61, 0.2);
    }
    
    .profile-tabs::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 20px;
        height: 20px;
        background: linear-gradient(135deg, #2d4a2d 0%, #3d6a3d 50%, #4a7c4a 100%);
        clip-path: polygon(0 0, 100% 0, 100% 100%);
        box-shadow: 0 0 15px rgba(45, 90, 61, 0.5);
    }
    
    .profile-tab {
        flex: 1;
        padding: 18px 30px;
        border: none;
        background: transparent;
        border-radius: 0;
        font-weight: 600;
        color: #666;
        cursor: pointer;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 12px;
        font-size: 15px;
        position: relative;
        clip-path: polygon(0 0, calc(100% - 8px) 0, 100% 8px, 100% 100%, 0 100%);
    }
    
    .profile-tab::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 8px;
        height: 8px;
        background: linear-gradient(135deg, #2d4a2d, #3d6a3d);
        clip-path: polygon(0 0, 100% 0, 100% 100%);
        opacity: 0;
        transition: opacity 0.3s ease;
    }
    
    .profile-tab i {
        transition: all 0.3s ease;
    }
    
    .profile-tab:hover {
        color: #1a2e1a;
        background: linear-gradient(135deg, rgba(45, 90, 61, 0.15), rgba(61, 106, 61, 0.1));
        transform: translateY(-2px);
    }
    
    .profile-tab:hover i {
        color: #2d4a2d;
        transform: scale(1.2);
    }
    
    .profile-tab:hover::before {
        opacity: 1;
    }
    
    .profile-tab.active {
        background: linear-gradient(135deg, 
            #2d4a2d 0%, 
            #3d6a3d 50%, 
            #4a7c4a 100%);
        color: #ffffff;
        box-shadow: 
            0 5px 20px rgba(45, 90, 61, 0.4),
            inset 0 2px 10px rgba(255,255,255,0.3);
    }
    
    .profile-tab.active i {
        color: #ffffff;
    }
    
    .profile-tab.active::before {
        opacity: 1;
        background: linear-gradient(135deg, rgba(255,255,255,0.4), rgba(255,255,255,0.2));
    }
    
    .tab-panel {
        display: none;
    }
    
    .tab-panel.active {
        display: block;
        animation: fadeInUp 0.5s ease;
    }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    /* Dashboard Card - Green Design */
    .dashboard-card {
        background: linear-gradient(135deg, #ffffff 0%, #f0f5f0 100%);
        border-radius: 0;
        box-shadow: 
            0 10px 40px rgba(26, 46, 26, 0.12),
            0 5px 20px rgba(0,0,0,0.08);
        margin-bottom: 30px;
        overflow: hidden;
        clip-path: polygon(0 0, calc(100% - 25px) 0, 100% 25px, 100% 100%, 0 100%);
        position: relative;
        border: 1px solid rgba(45, 90, 61, 0.15);
        transition: all 0.4s ease;
    }
    
    .dashboard-card:hover {
        transform: translateY(-5px);
        box-shadow: 
            0 15px 50px rgba(26, 46, 26, 0.2),
            0 10px 30px rgba(0,0,0,0.12);
    }
    
    .dashboard-card::before {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        width: 25px;
        height: 25px;
        background: linear-gradient(135deg, #2d4a2d 0%, #3d6a3d 50%, #4a7c4a 100%);
        clip-path: polygon(0 0, 100% 0, 100% 100%);
        z-index: 1;
        box-shadow: 0 0 15px rgba(45, 90, 61, 0.4);
    }
    
    .card-header-custom {
        background: linear-gradient(135deg, 
            rgba(45, 90, 61, 0.08) 0%, 
            rgba(61, 106, 61, 0.05) 100%);
        padding: 25px 30px;
        border-bottom: 2px solid rgba(45, 90, 61, 0.2);
        position: relative;
    }
    
    .card-header-custom::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 60px;
        height: 3px;
        background: linear-gradient(90deg, #2d4a2d, #3d6a3d);
    }
    
    .card-title {
        font-size: 1.5rem;
        color: #1a2e1a;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 12px;
        font-weight: 700;
    }
    
    .card-title i {
        color: #2d4a2d;
        font-size: 1.4rem;
        background: linear-gradient(135deg, rgba(45, 90, 61, 0.15), rgba(61, 106, 61, 0.1));
        padding: 10px;
        border-radius: 10px;
    }
    
    .card-body-custom {
        padding: 30px;
        background: #ffffff;
    }
    
    /* Green Button */
    .btn-gold {
        background: linear-gradient(135deg, 
            #2d4a2d 0%, 
            #3d6a3d 50%, 
            #4a7c4a 100%);
        color: #ffffff;
        padding: 14px 32px;
        border: none;
        border-radius: 10px;
        font-weight: 600;
        font-size: 15px;
        cursor: pointer;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        display: inline-flex;
        align-items: center;
        gap: 10px;
        box-shadow: 
            0 5px 20px rgba(45, 90, 61, 0.4),
            inset 0 2px 10px rgba(255,255,255,0.2);
        position: relative;
        overflow: hidden;
    }
    
    .btn-gold::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        width: 0;
        height: 0;
        border-radius: 50%;
        background: rgba(255,255,255,0.2);
        transform: translate(-50%, -50%);
        transition: width 0.6s, height 0.6s;
    }
    
    .btn-gold:hover::before {
        width: 400px;
        height: 400px;
    }
    
    .btn-gold:hover {
        transform: translateY(-3px);
        box-shadow: 
            0 10px 30px rgba(45, 90, 61, 0.5),
            0 5px 15px rgba(45, 90, 61, 0.3),
            inset 0 2px 10px rgba(255,255,255,0.3);
        background: linear-gradient(135deg, 
            #3d6a3d 0%, 
            #4a7c4a 50%, 
            #5a8f5a 100%);
    }
    
    .btn-gold:active {
        transform: translateY(-1px);
    }
    
    .btn-gold i {
        font-size: 16px;
        transition: transform 0.3s ease;
    }
    
    .btn-gold:hover i {
        transform: scale(1.2);
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
        background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
    }
    
    .form-input:focus {
        outline: none;
        border-color: #2d4a2d;
        background: #ffffff;
        box-shadow: 
            0 0 0 4px rgba(45, 90, 61, 0.15),
            0 5px 15px rgba(45, 90, 61, 0.2);
        transform: translateY(-2px);
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
    
    /* Alerts - Beautiful Design */
    .alert-box {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 18px 24px;
        border-radius: 12px;
        margin-bottom: 25px;
        font-weight: 500;
        box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        border-left: 4px solid;
    }
    
    .alert-box.success {
        background: linear-gradient(135deg, rgba(40, 167, 69, 0.12) 0%, rgba(40, 167, 69, 0.08) 100%);
        color: #155724;
        border-left-color: #28a745;
        box-shadow: 0 5px 20px rgba(40, 167, 69, 0.2);
    }
    
    .alert-box.danger {
        background: linear-gradient(135deg, rgba(220, 53, 69, 0.12) 0%, rgba(220, 53, 69, 0.08) 100%);
        color: #721c24;
        border-left-color: #dc3545;
        box-shadow: 0 5px 20px rgba(220, 53, 69, 0.2);
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
    
    /* Responsive Design */
    @media (max-width: 992px) {
        .profile-info-section {
            padding: 20px 30px 35px;
            gap: 25px;
        }
        
        .profile-avatar-large {
            width: 100px;
            height: 100px;
            min-width: 100px;
            font-size: 40px;
            margin-top: -50px;
        }
    }
    
    @media (max-width: 767px) {
        .profile-header-card {
            margin-bottom: 20px;
        }
        
        .profile-cover {
            height: 150px;
        }
        
        .profile-info-section {
            flex-direction: column;
            align-items: center;
            text-align: center;
            padding: 15px 20px 30px;
            gap: 20px;
        }
        
        .profile-avatar-large {
            width: 90px;
            height: 90px;
            min-width: 90px;
            font-size: 36px;
            margin-top: -45px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .profile-details {
            width: 100%;
            padding-top: 0;
        }
        
        .profile-details h2 {
            font-size: 1.5rem;
        }
        
        .profile-details p {
            justify-content: center;
            font-size: 14px;
        }
        
        .profile-tabs {
            flex-direction: column;
            padding: 8px;
        }
        
        .profile-tab {
            width: 100%;
            padding: 14px 20px;
        }
    }
    
    @media (max-width: 576px) {
        .profile-cover {
            height: 120px;
        }
        
        .profile-avatar-large {
            width: 80px;
            height: 80px;
            min-width: 80px;
            font-size: 32px;
            margin-top: -40px;
        }
        
        .profile-details h2 {
            font-size: 1.25rem;
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
