<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Your Center - AyurVedaCare</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .register-page {
            min-height: 100vh;
            background: linear-gradient(135deg, var(--neutral-cream) 0%, var(--neutral-sand) 100%);
            padding: 90px 0 var(--spacing-3xl);
        }
        
        .register-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 var(--spacing-xl);
        }
        
        .register-header {
            text-align: center;
            margin-bottom: var(--spacing-2xl);
        }
        
        .register-header h1 {
            margin-bottom: var(--spacing-sm);
        }
        
        .register-header p {
            color: var(--text-medium);
            font-size: 1.1rem;
        }
        
        /* Progress Steps */
        .progress-steps {
            display: flex;
            justify-content: center;
            margin-bottom: var(--spacing-2xl);
            position: relative;
        }
        
        .progress-steps::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 15%;
            right: 15%;
            height: 3px;
            background: var(--neutral-stone);
            z-index: 0;
        }
        
        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 1;
            flex: 1;
            max-width: 120px;
        }
        
        .step-number {
            width: 45px;
            height: 45px;
            border-radius: var(--radius-full);
            background: white;
            border: 3px solid var(--neutral-stone);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: var(--text-muted);
            margin-bottom: var(--spacing-sm);
            transition: all var(--transition-base);
        }
        
        .step.active .step-number {
            background: var(--primary-forest);
            border-color: var(--primary-forest);
            color: white;
        }
        
        .step.completed .step-number {
            background: var(--success);
            border-color: var(--success);
            color: white;
        }
        
        .step-label {
            font-size: 0.8rem;
            color: var(--text-muted);
            text-align: center;
            font-weight: 500;
        }
        
        .step.active .step-label,
        .step.completed .step-label {
            color: var(--text-dark);
        }
        
        /* Form Card */
        .form-card {
            background: white;
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            padding: var(--spacing-2xl);
        }
        
        .step-content {
            display: none;
        }
        
        .step-content.active {
            display: block;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .step-title {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-xl);
            padding-bottom: var(--spacing-lg);
            border-bottom: 2px solid var(--neutral-sand);
        }
        
        .step-title i {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary-forest), var(--primary-sage));
            border-radius: var(--radius-full);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
        }
        
        .step-title h3 {
            margin: 0;
        }
        
        .step-title p {
            color: var(--text-medium);
            margin: 0;
            font-size: 0.9rem;
        }
        
        /* Form Grid */
        .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: var(--spacing-lg);
        }
        
        .form-row.single {
            grid-template-columns: 1fr;
        }
        
        /* Checkbox Groups */
        .checkbox-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: var(--spacing-md);
        }
        
        .checkbox-card {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            padding: var(--spacing-md) var(--spacing-lg);
            background: var(--neutral-sand);
            border: 2px solid transparent;
            border-radius: var(--radius-md);
            cursor: pointer;
            transition: all var(--transition-fast);
        }
        
        .checkbox-card:hover {
            border-color: var(--primary-sage);
        }
        
        .checkbox-card input:checked + .checkbox-content {
            color: var(--primary-forest);
        }
        
        .checkbox-card:has(input:checked) {
            background: rgba(45, 90, 61, 0.1);
            border-color: var(--primary-forest);
        }
        
        .checkbox-content {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }
        
        .checkbox-content i {
            font-size: 1.25rem;
            color: var(--primary-sage);
        }
        
        /* Tags Input */
        .tags-input-wrapper {
            border: 2px solid var(--neutral-stone);
            border-radius: var(--radius-md);
            padding: var(--spacing-sm);
            display: flex;
            flex-wrap: wrap;
            gap: var(--spacing-sm);
            min-height: 100px;
            cursor: text;
        }
        
        .tags-input-wrapper:focus-within {
            border-color: var(--primary-sage);
        }
        
        .tags-input-wrapper .tag {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
        }
        
        .tags-input-wrapper .tag .remove {
            cursor: pointer;
            opacity: 0.7;
        }
        
        .tags-input-wrapper .tag .remove:hover {
            opacity: 1;
        }
        
        .tags-input-wrapper input {
            flex: 1;
            min-width: 150px;
            border: none;
            padding: var(--spacing-sm);
            outline: none;
        }
        
        /* File Upload */
        .file-upload-area {
            border: 2px dashed var(--neutral-stone);
            border-radius: var(--radius-md);
            padding: var(--spacing-xl);
            text-align: center;
            cursor: pointer;
            transition: all var(--transition-base);
        }
        
        .file-upload-area:hover {
            border-color: var(--primary-sage);
            background: rgba(107, 142, 107, 0.05);
        }
        
        .file-upload-area i {
            font-size: 2.5rem;
            color: var(--primary-sage);
            margin-bottom: var(--spacing-md);
        }
        
        .file-upload-area h4 {
            margin-bottom: var(--spacing-xs);
        }
        
        .file-upload-area p {
            color: var(--text-muted);
            font-size: 0.875rem;
        }
        
        .file-upload-area input {
            display: none;
        }
        
        .uploaded-file {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            padding: var(--spacing-md);
            background: var(--neutral-sand);
            border-radius: var(--radius-md);
            margin-top: var(--spacing-md);
        }
        
        .uploaded-file i {
            font-size: 1.5rem;
            color: var(--success);
        }
        
        .uploaded-file .file-info {
            flex: 1;
        }
        
        .uploaded-file .file-name {
            font-weight: 500;
        }
        
        .uploaded-file .file-size {
            font-size: 0.875rem;
            color: var(--text-muted);
        }
        
        /* Form Actions */
        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: var(--spacing-2xl);
            padding-top: var(--spacing-xl);
            border-top: 1px solid var(--neutral-stone);
        }
        
        .form-actions .btn {
            min-width: 150px;
        }
        
        /* Success Message */
        .success-content {
            text-align: center;
            padding: var(--spacing-2xl);
        }
        
        .success-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, var(--success), #66BB6A);
            border-radius: var(--radius-full);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto var(--spacing-xl);
        }
        
        .success-icon i {
            font-size: 3rem;
            color: white;
        }
        
        .success-content h2 {
            color: var(--success);
            margin-bottom: var(--spacing-md);
        }
        
        .success-content p {
            color: var(--text-medium);
            max-width: 500px;
            margin: 0 auto var(--spacing-xl);
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .checkbox-grid {
                grid-template-columns: 1fr;
            }
            
            .progress-steps {
                overflow-x: auto;
                padding-bottom: var(--spacing-md);
            }
            
            .step {
                min-width: 80px;
            }
            
            .form-actions {
                flex-direction: column;
                gap: var(--spacing-md);
            }
            
            .form-actions .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/" class="nav-logo">
                <i class="fas fa-leaf"></i>
                <span>AyurVeda<span class="highlight">Care</span></span>
            </a>
            
            <div class="nav-menu" id="navMenu">
                <a href="${pageContext.request.contextPath}/" class="nav-link">Home</a>
                <a href="${pageContext.request.contextPath}/hospitals" class="nav-link">Find Centers</a>
                <a href="${pageContext.request.contextPath}/hospital/login" class="nav-link">Login</a>
            </div>
            
            <button class="nav-toggle" id="navToggle">
                <i class="fas fa-bars"></i>
            </button>
        </div>
    </nav>

    <div class="register-page">
        <div class="register-container">
            <div class="register-header">
                <h1>Register Your Center</h1>
                <p>Join thousands of Ayurvedic centers on India's leading wellness platform</p>
            </div>
            
            <!-- Progress Steps -->
            <div class="progress-steps">
                <div class="step ${currentStep == 1 ? 'active' : (currentStep > 1 ? 'completed' : '')}">
                    <div class="step-number">
                        <c:choose>
                            <c:when test="${currentStep > 1}"><i class="fas fa-check"></i></c:when>
                            <c:otherwise>1</c:otherwise>
                        </c:choose>
                    </div>
                    <span class="step-label">Account</span>
                </div>
                <div class="step ${currentStep == 2 ? 'active' : (currentStep > 2 ? 'completed' : '')}">
                    <div class="step-number">
                        <c:choose>
                            <c:when test="${currentStep > 2}"><i class="fas fa-check"></i></c:when>
                            <c:otherwise>2</c:otherwise>
                        </c:choose>
                    </div>
                    <span class="step-label">Basic Info</span>
                </div>
                <div class="step ${currentStep == 3 ? 'active' : (currentStep > 3 ? 'completed' : '')}">
                    <div class="step-number">
                        <c:choose>
                            <c:when test="${currentStep > 3}"><i class="fas fa-check"></i></c:when>
                            <c:otherwise>3</c:otherwise>
                        </c:choose>
                    </div>
                    <span class="step-label">Location</span>
                </div>
                <div class="step ${currentStep == 4 ? 'active' : (currentStep > 4 ? 'completed' : '')}">
                    <div class="step-number">
                        <c:choose>
                            <c:when test="${currentStep > 4}"><i class="fas fa-check"></i></c:when>
                            <c:otherwise>4</c:otherwise>
                        </c:choose>
                    </div>
                    <span class="step-label">Credentials</span>
                </div>
                <div class="step ${currentStep == 5 ? 'active' : (currentStep > 5 ? 'completed' : '')}">
                    <div class="step-number">
                        <c:choose>
                            <c:when test="${currentStep > 5}"><i class="fas fa-check"></i></c:when>
                            <c:otherwise>5</c:otherwise>
                        </c:choose>
                    </div>
                    <span class="step-label">Documents</span>
                </div>
                <div class="step ${currentStep == 6 ? 'active' : ''}">
                    <div class="step-number">6</div>
                    <span class="step-label">Specializations</span>
                </div>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    ${success}
                </div>
            </c:if>
            
            <div class="form-card">
                <!-- Step 1: Account Creation -->
                <div class="step-content ${currentStep == 1 ? 'active' : ''}" id="step1">
                    <div class="step-title">
                        <i class="fas fa-user-plus"></i>
                        <div>
                            <h3>Create Your Account</h3>
                            <p>Set up your login credentials and contact information</p>
                        </div>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/hospital/register/step1" method="post">
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">Email Address</label>
                                <input type="email" name="email" class="form-input" placeholder="your@email.com" required
                                       value="${sessionScope.registrationData.email}">
                                <div class="form-hint">This will be used for login and notifications</div>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label required">Password</label>
                                <input type="password" name="password" class="form-input" placeholder="Create a strong password" required minlength="8">
                                <div class="form-hint">Minimum 8 characters</div>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">Contact Person Name</label>
                                <input type="text" name="contactPersonName" class="form-input" placeholder="Full name" required
                                       value="${sessionScope.registrationData.contactPersonName}">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label required">Contact Phone</label>
                                <input type="tel" name="contactPersonPhone" class="form-input" placeholder="+91 98765 43210" required
                                       value="${sessionScope.registrationData.contactPersonPhone}">
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <a href="${pageContext.request.contextPath}/hospital/login" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back to Login
                            </a>
                            <button type="submit" class="btn btn-primary">
                                Continue <i class="fas fa-arrow-right"></i>
                            </button>
                        </div>
                    </form>
                </div>
                
                <!-- Step 2: Basic Information -->
                <div class="step-content ${currentStep == 2 ? 'active' : ''}" id="step2">
                    <div class="step-title">
                        <i class="fas fa-hospital"></i>
                        <div>
                            <h3>Center Basic Information</h3>
                            <p>Tell us about your Ayurvedic center</p>
                        </div>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/hospital/register/step2" method="post">
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">Center Name</label>
                                <input type="text" name="centerName" class="form-input" placeholder="Official name of your center" required
                                       value="${sessionScope.registrationData.centerName}">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label required">Center Type</label>
                                <select name="centerType" class="form-select" required>
                                    <option value="">Select type...</option>
                                    <c:forEach var="type" items="${centerTypes}">
                                        <option value="${type}" ${sessionScope.registrationData.centerType == type ? 'selected' : ''}>${type}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Year Established</label>
                                <input type="number" name="yearEstablished" class="form-input" placeholder="e.g., 1995" min="1900" max="2024"
                                       value="${sessionScope.registrationData.yearEstablished}">
                            </div>
                            <div class="form-group"></div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-textarea" rows="5" placeholder="Describe your center's philosophy, approach to healing, and what makes you unique (300-500 words recommended)">${sessionScope.registrationData.description}</textarea>
                        </div>
                        
                        <div class="form-actions">
                            <a href="${pageContext.request.contextPath}/hospital/register/back" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Previous
                            </a>
                            <button type="submit" class="btn btn-primary">
                                Continue <i class="fas fa-arrow-right"></i>
                            </button>
                        </div>
                    </form>
                </div>
                
                <!-- Step 3: Location & Contact -->
                <div class="step-content ${currentStep == 3 ? 'active' : ''}" id="step3">
                    <div class="step-title">
                        <i class="fas fa-map-marker-alt"></i>
                        <div>
                            <h3>Location & Contact Details</h3>
                            <p>Help patients find and reach you</p>
                        </div>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/hospital/register/step3" method="post">
                        <div class="form-group">
                            <label class="form-label required">Street Address</label>
                            <input type="text" name="streetAddress" class="form-input" placeholder="Full street address" required
                                   value="${sessionScope.registrationData.streetAddress}">
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">City</label>
                                <input type="text" name="city" class="form-input" placeholder="City" required
                                       value="${sessionScope.registrationData.city}">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label required">State</label>
                                <input type="text" name="state" class="form-input" placeholder="State" required
                                       value="${sessionScope.registrationData.state}">
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label required">PIN Code</label>
                                <input type="text" name="pinCode" class="form-input" placeholder="PIN Code" required
                                       value="${sessionScope.registrationData.pinCode}">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">Google Maps URL</label>
                                <input type="url" name="googleMapsUrl" class="form-input" placeholder="https://maps.google.com/..."
                                       value="${sessionScope.registrationData.googleMapsUrl}">
                            </div>
                        </div>
                        
                        <hr style="margin: var(--spacing-xl) 0; border: none; border-top: 1px solid var(--neutral-stone);">
                        
                        <h4 style="margin-bottom: var(--spacing-lg);">Contact Numbers</h4>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Reception Phone</label>
                                <input type="tel" name="receptionPhone" class="form-input" placeholder="Reception number"
                                       value="${sessionScope.registrationData.receptionPhone}">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">Emergency Phone</label>
                                <input type="tel" name="emergencyPhone" class="form-input" placeholder="Emergency number"
                                       value="${sessionScope.registrationData.emergencyPhone}">
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Booking Phone</label>
                                <input type="tel" name="bookingPhone" class="form-input" placeholder="Booking inquiries"
                                       value="${sessionScope.registrationData.bookingPhone}">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">Public Email</label>
                                <input type="email" name="publicEmail" class="form-input" placeholder="Public contact email"
                                       value="${sessionScope.registrationData.publicEmail}">
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Website</label>
                                <input type="url" name="website" class="form-input" placeholder="https://www.yourwebsite.com"
                                       value="${sessionScope.registrationData.website}">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">Instagram</label>
                                <input type="url" name="instagramUrl" class="form-input" placeholder="Instagram profile URL"
                                       value="${sessionScope.registrationData.instagramUrl}">
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Facebook</label>
                                <input type="url" name="facebookUrl" class="form-input" placeholder="Facebook page URL"
                                       value="${sessionScope.registrationData.facebookUrl}">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">YouTube</label>
                                <input type="url" name="youtubeUrl" class="form-input" placeholder="YouTube channel URL"
                                       value="${sessionScope.registrationData.youtubeUrl}">
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <a href="${pageContext.request.contextPath}/hospital/register/back" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Previous
                            </a>
                            <button type="submit" class="btn btn-primary">
                                Continue <i class="fas fa-arrow-right"></i>
                            </button>
                        </div>
                    </form>
                </div>
                
                <!-- Step 4: Medical Credentials -->
                <div class="step-content ${currentStep == 4 ? 'active' : ''}" id="step4">
                    <div class="step-title">
                        <i class="fas fa-certificate"></i>
                        <div>
                            <h3>Medical Credentials</h3>
                            <p>Your certifications and capacity</p>
                        </div>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/hospital/register/step4" method="post">
                        <h4 style="margin-bottom: var(--spacing-lg);">Accreditations</h4>
                        
                        <div class="checkbox-grid">
                            <label class="checkbox-card">
                                <input type="checkbox" name="ayushCertified" value="true" ${sessionScope.registrationData.ayushCertified ? 'checked' : ''}>
                                <span class="checkbox-content">
                                    <i class="fas fa-certificate"></i>
                                    <span>AYUSH Certified</span>
                                </span>
                            </label>
                            
                            <label class="checkbox-card">
                                <input type="checkbox" name="nabhCertified" value="true" ${sessionScope.registrationData.nabhCertified ? 'checked' : ''}>
                                <span class="checkbox-content">
                                    <i class="fas fa-award"></i>
                                    <span>NABH Accredited</span>
                                </span>
                            </label>
                            
                            <label class="checkbox-card">
                                <input type="checkbox" name="isoCertified" value="true" ${sessionScope.registrationData.isoCertified ? 'checked' : ''}>
                                <span class="checkbox-content">
                                    <i class="fas fa-globe"></i>
                                    <span>ISO Certified</span>
                                </span>
                            </label>
                            
                            <label class="checkbox-card">
                                <input type="checkbox" name="stateGovtApproved" value="true" ${sessionScope.registrationData.stateGovtApproved ? 'checked' : ''}>
                                <span class="checkbox-content">
                                    <i class="fas fa-landmark"></i>
                                    <span>State Govt. Approved</span>
                                </span>
                            </label>
                        </div>
                        
                        <div class="form-group" style="margin-top: var(--spacing-xl);">
                            <label class="form-label">Medical License Number</label>
                            <input type="text" name="medicalLicenseNumber" class="form-input" placeholder="Enter license number"
                                   value="${sessionScope.registrationData.medicalLicenseNumber}">
                        </div>
                        
                        <hr style="margin: var(--spacing-xl) 0; border: none; border-top: 1px solid var(--neutral-stone);">
                        
                        <h4 style="margin-bottom: var(--spacing-lg);">Capacity</h4>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Number of Doctors</label>
                                <input type="number" name="doctorsCount" class="form-input" placeholder="e.g., 10" min="0"
                                       value="${sessionScope.registrationData.doctorsCount}">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">Number of Therapists</label>
                                <input type="number" name="therapistsCount" class="form-input" placeholder="e.g., 25" min="0"
                                       value="${sessionScope.registrationData.therapistsCount}">
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Bed Capacity</label>
                                <input type="number" name="bedsCapacity" class="form-input" placeholder="Total patient capacity" min="0"
                                       value="${sessionScope.registrationData.bedsCapacity}">
                            </div>
                            <div class="form-group"></div>
                        </div>
                        
                        <div class="form-actions">
                            <a href="${pageContext.request.contextPath}/hospital/register/back" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Previous
                            </a>
                            <button type="submit" class="btn btn-primary">
                                Continue <i class="fas fa-arrow-right"></i>
                            </button>
                        </div>
                    </form>
                </div>
                
                <!-- Step 5: Document Uploads -->
                <div class="step-content ${currentStep == 5 ? 'active' : ''}" id="step5">
                    <div class="step-title">
                        <i class="fas fa-file-upload"></i>
                        <div>
                            <h3>Document Uploads</h3>
                            <p>Upload your certificates and verification documents</p>
                        </div>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/hospital/register/step5" method="post">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle"></i>
                            <span>Documents can be uploaded after registration from your dashboard. Click "Continue" to proceed.</span>
                        </div>
                        
                        <p style="color: var(--text-medium); margin-bottom: var(--spacing-xl);">
                            Required documents include:
                        </p>
                        
                        <ul style="color: var(--text-medium); margin-left: var(--spacing-xl); margin-bottom: var(--spacing-xl);">
                            <li>Registration Certificate (Business registration)</li>
                            <li>Medical License Copy</li>
                            <li>Accreditation Certificates (AYUSH/NABH documents)</li>
                            <li>Doctor Degree Certificates</li>
                            <li>Center Photos (5-10 images)</li>
                            <li>Owner/Manager ID Proof</li>
                        </ul>
                        
                        <div class="form-actions">
                            <a href="${pageContext.request.contextPath}/hospital/register/back" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Previous
                            </a>
                            <button type="submit" class="btn btn-primary">
                                Continue <i class="fas fa-arrow-right"></i>
                            </button>
                        </div>
                    </form>
                </div>
                
                <!-- Step 6: Specializations & Facilities -->
                <div class="step-content ${currentStep == 6 ? 'active' : ''}" id="step6">
                    <div class="step-title">
                        <i class="fas fa-spa"></i>
                        <div>
                            <h3>Specializations & Facilities</h3>
                            <p>Tell patients what you offer</p>
                        </div>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/hospital/register/step6" method="post">
                        <div class="form-group">
                            <label class="form-label">Therapies Offered</label>
                            <textarea name="therapiesOffered" class="form-textarea" rows="3" placeholder="e.g., Panchakarma, Shirodhara, Abhyanga, Nasya, Basti, Detox, Yoga, Meditation">${sessionScope.registrationData.therapiesOffered}</textarea>
                            <div class="form-hint">Enter comma-separated list of therapies</div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Special Treatments</label>
                            <textarea name="specialTreatments" class="form-textarea" rows="3" placeholder="e.g., Arthritis, Back Pain, Stress Management, Weight Loss, Diabetes, Skin Disorders">${sessionScope.registrationData.specialTreatments}</textarea>
                            <div class="form-hint">Health conditions you specialize in treating</div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Facilities Available</label>
                            <textarea name="facilitiesAvailable" class="form-textarea" rows="3" placeholder="e.g., AC Rooms, Garden, Wi-Fi, Swimming Pool, Yoga Hall, Meditation Center, Restaurant, Parking">${sessionScope.registrationData.facilitiesAvailable}</textarea>
                            <div class="form-hint">Amenities and facilities at your center</div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Languages Spoken</label>
                            <textarea name="languagesSpoken" class="form-textarea" rows="2" placeholder="e.g., English, Hindi, Malayalam, Tamil, German, French">${sessionScope.registrationData.languagesSpoken}</textarea>
                            <div class="form-hint">Languages your staff can communicate in</div>
                        </div>
                        
                        <div class="form-actions">
                            <a href="${pageContext.request.contextPath}/hospital/register/back" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Previous
                            </a>
                            <button type="submit" class="btn btn-gold">
                                <i class="fas fa-check"></i> Complete Registration
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-container">
            <div class="footer-bottom">
                <p>&copy; 2024 AyurVedaCare. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>

