<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Registration - AyurVedaCare</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Override any conflicting styles */
        .doctor-register-container form,
        .doctor-register-container form * {
            visibility: visible !important;
            display: block !important;
        }
        
        .doctor-register-container form .form-row,
        .doctor-register-container form .form-group,
        .doctor-register-container form .input-wrapper {
            display: block !important;
        }
        
        .doctor-register-container form .form-row {
            display: grid !important;
        }
        
        .doctor-register-container form input,
        .doctor-register-container form select,
        .doctor-register-container form textarea {
            display: block !important;
            visibility: visible !important;
            opacity: 1 !important;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            min-height: 100vh;
            display: flex;
            background: linear-gradient(135deg, #2d5016 0%, #4a7c2a 50%, #6b9e3d 100%);
            font-family: 'Nunito Sans', sans-serif;
        }
        
        .doctor-register-container {
            display: flex;
            width: 100%;
            min-height: 100vh;
        }
        
        .doctor-branding {
            flex: 1;
            background: linear-gradient(135deg, rgba(45, 80, 22, 0.95), rgba(74, 124, 42, 0.9)),
                        url('https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=1200') center/cover;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px;
            color: white;
            text-align: center;
            position: relative;
        }
        
        .doctor-branding h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }
        
        .doctor-branding h1 i {
            color: #C7A369;
            margin-right: 15px;
        }
        
        .doctor-branding p {
            font-size: 1.2rem;
            max-width: 500px;
            opacity: 0.9;
            line-height: 1.8;
            position: relative;
            z-index: 1;
        }
        
        .benefits-list {
            margin-top: 50px;
            text-align: left;
            position: relative;
            z-index: 1;
        }
        
        .benefit-item {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            padding: 15px 25px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            border: 1px solid rgba(199, 163, 105, 0.3);
        }
        
        .benefit-item i {
            font-size: 1.5rem;
            color: #C7A369;
            width: 30px;
        }
        
        .benefit-item span {
            font-size: 1rem;
        }
        
        .doctor-form-section {
            flex: 0 0 700px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            padding: 50px 60px;
            background: #ffffff;
            overflow-y: auto;
            max-height: 100vh;
        }
        
        .doctor-header {
            margin-bottom: 35px;
        }
        
        .doctor-header .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: #2d5016;
            margin-bottom: 35px;
            text-decoration: none;
        }
        
        .doctor-header .logo i {
            color: #C7A369;
        }
        
        .doctor-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: linear-gradient(135deg, #2d5016, #4a7c2a);
            color: white;
            padding: 8px 16px;
            border-radius: 30px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 20px;
        }
        
        .doctor-badge i {
            color: #C7A369;
        }
        
        .doctor-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: #2d5016;
            margin-bottom: 10px;
        }
        
        .doctor-header p {
            color: #666;
            font-size: 1rem;
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 0.95rem;
        }
        
        .alert-error {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }
        
        .alert-success {
            background: #f0fdf4;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }
        
        .form-section {
            margin-bottom: 30px;
        }
        
        .form-section-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #2d5016;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e5e7eb;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .form-section-title i {
            color: #C7A369;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
            width: 100%;
        }
        
        .form-row > * {
            min-width: 0;
        }
        
        .form-group {
            margin-bottom: 0;
        }
        
        .form-group.full-width {
            grid-column: span 2;
        }
        
        .form-row .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            font-weight: 600;
            color: #2d5016;
            margin-bottom: 10px;
            font-size: 0.95rem;
            width: 100%;
        }
        
        .form-label .required {
            color: #dc2626;
        }
        
        .input-wrapper {
            position: relative;
        }
        
        .input-wrapper {
            position: relative;
            display: block;
            width: 100%;
        }
        
        .input-wrapper i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            z-index: 1;
            pointer-events: none;
        }
        
        .form-input, .form-select, .form-textarea {
            width: 100%;
            padding: 15px 18px 15px 50px;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f9fafb;
            font-family: 'Nunito Sans', sans-serif;
            display: block;
            box-sizing: border-box;
        }
        
        .form-textarea {
            padding-left: 18px;
            resize: vertical;
            min-height: 100px;
        }
        
        .form-select {
            padding-left: 50px;
            cursor: pointer;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%239ca3af' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 18px center;
            padding-right: 40px;
            background-color: #f9fafb;
        }
        
        .form-select:focus {
            background-color: white;
        }
        
        .form-input:focus, .form-select:focus, .form-textarea:focus {
            outline: none;
            border-color: #C7A369;
            background: white;
            box-shadow: 0 0 0 4px rgba(199, 163, 105, 0.1);
        }
        
        .form-input:focus + i,
        .input-wrapper:focus-within i {
            color: #C7A369;
        }
        
        .terms-checkbox {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 25px;
        }
        
        .terms-checkbox input {
            width: 20px;
            height: 20px;
            margin-top: 2px;
            accent-color: #C7A369;
        }
        
        .terms-checkbox label {
            color: #666;
            font-size: 0.95rem;
            line-height: 1.5;
        }
        
        .terms-checkbox a {
            color: #C7A369;
            font-weight: 600;
            text-decoration: none;
        }
        
        .btn-doctor-register {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #2d5016, #4a7c2a);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            transition: all 0.3s ease;
        }
        
        .btn-doctor-register:hover {
            background: linear-gradient(135deg, #4a7c2a, #6b9e3d);
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(45, 80, 22, 0.3);
        }
        
        .divider {
            display: flex;
            align-items: center;
            margin: 30px 0;
            color: #9ca3af;
        }
        
        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #e5e7eb;
        }
        
        .divider span {
            padding: 0 20px;
            font-size: 0.9rem;
        }
        
        .login-link {
            text-align: center;
        }
        
        .login-link p {
            color: #666;
            font-size: 1rem;
        }
        
        .login-link a {
            color: #C7A369;
            font-weight: 700;
            text-decoration: none;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        .back-to-home {
            position: absolute;
            top: 30px;
            left: 30px;
            display: flex;
            align-items: center;
            gap: 8px;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            font-size: 0.95rem;
            transition: color 0.3s ease;
            z-index: 10;
        }
        
        .back-to-home:hover {
            color: white;
        }
        
        @media (max-width: 992px) {
            .doctor-branding {
                display: none;
            }
            
            .doctor-form-section {
                flex: 1;
                max-width: 100%;
            }
        }
        
        @media (max-width: 600px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .form-group.full-width {
                grid-column: span 1;
            }
            
            .doctor-form-section {
                padding: 40px 25px;
            }
        }
    </style>
</head>
<body>
    <div class="doctor-register-container">
        <div class="doctor-branding">
            <a href="${pageContext.request.contextPath}/" class="back-to-home">
                <i class="fas fa-arrow-left"></i> Back to Home
            </a>
            
            <h1><i class="fas fa-user-md"></i>Doctor Portal</h1>
            <p>Join AyurVedaCare as an Ayurvedic doctor and connect with patients seeking authentic Ayurvedic treatments and consultations.</p>
            
            <div class="benefits-list">
                <div class="benefit-item">
                    <i class="fas fa-check-circle"></i>
                    <span>Manage your own profile and availability</span>
                </div>
                <div class="benefit-item">
                    <i class="fas fa-calendar-check"></i>
                    <span>Accept consultations from patients</span>
                </div>
                <div class="benefit-item">
                    <i class="fas fa-prescription"></i>
                    <span>Create digital prescriptions</span>
                </div>
                <div class="benefit-item">
                    <i class="fas fa-hospital"></i>
                    <span>Associate with multiple hospitals</span>
                </div>
            </div>
        </div>
        
        <div class="doctor-form-section">
            <div class="doctor-header">
                <a href="${pageContext.request.contextPath}/" class="logo">
                    <i class="fas fa-leaf"></i>
                    <span>AyurVedaCare</span>
                </a>
                
                <span class="doctor-badge">
                    <i class="fas fa-user-md"></i> Doctor Registration
                </span>
                
                <h2>Create Doctor Account</h2>
                <p>Fill in your details to register as an Ayurvedic doctor</p>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/doctor/register" method="post">
                <!-- Personal Information -->
                <div class="form-section">
                    <h3 class="form-section-title">
                        <i class="fas fa-user"></i> Personal Information
                    </h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Full Name <span class="required">*</span></label>
                            <div class="input-wrapper">
                                <input type="text" name="name" class="form-input" placeholder="Dr. Full Name" required>
                                <i class="fas fa-user"></i>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Gender <span class="required">*</span></label>
                            <div class="input-wrapper">
                                <select name="gender" class="form-select" required>
                                    <option value="">Select Gender</option>
                                    <option value="MALE">Male</option>
                                    <option value="FEMALE">Female</option>
                                    <option value="OTHER">Other</option>
                                </select>
                                <i class="fas fa-venus-mars"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Email Address <span class="required">*</span></label>
                            <div class="input-wrapper">
                                <input type="email" name="email" class="form-input" placeholder="doctor@example.com" required>
                                <i class="fas fa-envelope"></i>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Phone Number <span class="required">*</span></label>
                            <div class="input-wrapper">
                                <input type="tel" name="phone" class="form-input" placeholder="+91 XXXXX XXXXX" required>
                                <i class="fas fa-phone"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Professional Information -->
                <div class="form-section">
                    <h3 class="form-section-title">
                        <i class="fas fa-graduation-cap"></i> Professional Information
                    </h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Qualifications <span class="required">*</span></label>
                            <div class="input-wrapper">
                                <input type="text" name="qualifications" class="form-input" placeholder="e.g., BAMS, MD (Ayurveda), PhD Ayurveda" required>
                                <i class="fas fa-certificate"></i>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Registration Number <span class="required">*</span></label>
                            <div class="input-wrapper">
                                <input type="text" name="registrationNumber" class="form-input" placeholder="AYUSH/State Medical Council Number" required>
                                <i class="fas fa-id-card"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Specializations</label>
                            <div class="input-wrapper">
                                <input type="text" name="specializations" class="form-input" placeholder="e.g., Panchakarma, Kayachikitsa, Shalakya">
                                <i class="fas fa-stethoscope"></i>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Experience (Years)</label>
                            <div class="input-wrapper">
                                <input type="number" name="experienceYears" class="form-input" placeholder="Years of practice" min="0">
                                <i class="fas fa-briefcase"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Degree University</label>
                            <div class="input-wrapper">
                                <input type="text" name="degreeUniversity" class="form-input" placeholder="University name">
                                <i class="fas fa-university"></i>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Languages Known</label>
                            <div class="input-wrapper">
                                <input type="text" name="languagesSpoken" class="form-input" placeholder="e.g., English, Hindi, Malayalam">
                                <i class="fas fa-language"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Biography</label>
                        <textarea name="biography" class="form-textarea" rows="4" placeholder="Brief biography about your practice and expertise..."></textarea>
                    </div>
                </div>
                
                <!-- Availability -->
                <div class="form-section">
                    <h3 class="form-section-title">
                        <i class="fas fa-clock"></i> Availability Settings
                    </h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Consultation Days</label>
                            <div class="input-wrapper">
                                <input type="text" name="consultationDays" class="form-input" placeholder="e.g., Monday to Saturday">
                                <i class="fas fa-calendar"></i>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Consultation Timings</label>
                            <div class="input-wrapper">
                                <input type="text" name="consultationTimings" class="form-input" placeholder="e.g., 9:00 AM - 5:00 PM">
                                <i class="fas fa-clock"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Available Locations</label>
                        <div class="input-wrapper">
                            <input type="text" name="availableLocations" class="form-input" placeholder="e.g., OPD, Online, Home Visit">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                    </div>
                </div>
                
                <!-- Account Security -->
                <div class="form-section">
                    <h3 class="form-section-title">
                        <i class="fas fa-lock"></i> Account Security
                    </h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Password <span class="required">*</span></label>
                            <div class="input-wrapper">
                                <input type="password" name="password" class="form-input" placeholder="Create a password" required minlength="6">
                                <i class="fas fa-lock"></i>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Confirm Password <span class="required">*</span></label>
                            <div class="input-wrapper">
                                <input type="password" name="confirmPassword" class="form-input" placeholder="Confirm password" required>
                                <i class="fas fa-lock"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="terms-checkbox">
                    <input type="checkbox" id="terms" name="terms" required>
                    <label for="terms">
                        I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>. I confirm that all information provided is accurate.
                    </label>
                </div>
                
                <button type="submit" class="btn-doctor-register">
                    <i class="fas fa-user-plus"></i> Create Doctor Account
                </button>
            </form>
            
            <div class="divider">
                <span>Already have an account?</span>
            </div>
            
            <div class="login-link">
                <p>Already registered? <a href="${pageContext.request.contextPath}/doctor/login">Sign in here</a></p>
            </div>
        </div>
    </div>
</body>
</html>

