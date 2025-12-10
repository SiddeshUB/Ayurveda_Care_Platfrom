<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Consultation - Dr. ${doctor.name} | AyurVedaCare</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Nunito+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .booking-page {
            min-height: 100vh;
            background: var(--neutral-sand);
            padding: 100px 0 var(--spacing-3xl);
        }
        
        .booking-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 var(--spacing-xl);
        }
        
        .booking-header {
            text-align: center;
            margin-bottom: var(--spacing-2xl);
        }
        
        .booking-header h1 {
            margin-bottom: var(--spacing-sm);
        }
        
        .booking-header p {
            color: var(--text-medium);
        }
        
        .doctor-summary {
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-lg);
            display: flex;
            align-items: center;
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-xl);
            box-shadow: var(--shadow-sm);
        }
        
        .doctor-summary-image {
            width: 100px;
            height: 100px;
            border-radius: var(--radius-md);
            background: var(--neutral-sand);
            overflow: hidden;
            flex-shrink: 0;
        }
        
        .doctor-summary-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .doctor-summary-info h3 {
            margin: 0 0 var(--spacing-xs);
        }
        
        .doctor-summary-info p {
            color: var(--text-muted);
            margin: 4px 0;
        }
        
        .booking-form {
            background: white;
            border-radius: var(--radius-xl);
            padding: var(--spacing-2xl);
            box-shadow: var(--shadow-md);
        }
        
        .form-section {
            margin-bottom: var(--spacing-2xl);
        }
        
        .form-section h3 {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-lg);
            padding-bottom: var(--spacing-md);
            border-bottom: 2px solid var(--neutral-sand);
        }
        
        .form-section h3 i {
            width: 40px;
            height: 40px;
            background: var(--primary-sage);
            border-radius: var(--radius-full);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: var(--spacing-lg);
        }
        
        .form-group {
            margin-bottom: var(--spacing-lg);
        }
        
        .form-label {
            display: block;
            margin-bottom: var(--spacing-xs);
            font-weight: 600;
            color: var(--text-dark);
        }
        
        .form-label.required::after {
            content: " *";
            color: #ef4444;
        }
        
        .form-input,
        .form-select,
        .form-textarea {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--neutral-stone);
            border-radius: var(--radius-md);
            font-size: 1rem;
            transition: all var(--transition-fast);
        }
        
        .form-input:focus,
        .form-select:focus,
        .form-textarea:focus {
            outline: none;
            border-color: var(--primary-sage);
            box-shadow: 0 0 0 3px rgba(45, 90, 61, 0.1);
        }
        
        .form-textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .consultation-type-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-lg);
        }
        
        .consultation-type-option {
            border: 2px solid var(--neutral-stone);
            border-radius: var(--radius-md);
            padding: var(--spacing-lg);
            cursor: pointer;
            transition: all var(--transition-fast);
            text-align: center;
        }
        
        .consultation-type-option:hover {
            border-color: var(--primary-sage);
        }
        
        .consultation-type-option.selected {
            border-color: var(--primary-forest);
            background: rgba(45, 90, 61, 0.05);
        }
        
        .consultation-type-option input {
            display: none;
        }
        
        .consultation-type-option i {
            font-size: 2rem;
            color: var(--primary-sage);
            margin-bottom: var(--spacing-sm);
        }
        
        .consultation-type-option h5 {
            margin: 0;
        }
        
        .btn-submit {
            width: 100%;
            padding: 18px;
            background: var(--primary-forest);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-fast);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: var(--spacing-md);
        }
        
        .btn-submit:hover {
            background: var(--primary-sage);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(45, 90, 61, 0.3);
        }
        
        .alert {
            padding: 16px 20px;
            border-radius: var(--radius-md);
            margin-bottom: var(--spacing-lg);
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
        }
        
        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }
        
        .alert-success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .consultation-type-grid {
                grid-template-columns: 1fr;
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
                <a href="${pageContext.request.contextPath}/doctors" class="nav-link">Find Doctors</a>
            </div>
        </div>
    </nav>

    <div class="booking-page">
        <div class="booking-container">
            <div class="booking-header">
                <h1>Book Consultation</h1>
                <p>Fill in your details to request a consultation with the doctor</p>
            </div>
            
            <div class="doctor-summary">
                <div class="doctor-summary-image">
                    <c:choose>
                        <c:when test="${not empty doctor.photoUrl}">
                            <img src="${pageContext.request.contextPath}${doctor.photoUrl}" alt="${doctor.name}">
                        </c:when>
                        <c:otherwise>
                            <div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
                                <i class="fas fa-user-md" style="font-size: 2rem; color: var(--text-muted);"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="doctor-summary-info">
                    <h3>Dr. ${doctor.name}</h3>
                    <p><i class="fas fa-graduation-cap"></i> ${doctor.qualifications != null ? doctor.qualifications : 'Qualified Doctor'}</p>
                    <p><i class="fas fa-stethoscope"></i> ${doctor.specializations != null ? doctor.specializations : 'General Practice'}</p>
                    <c:if test="${not empty doctor.hospital}">
                        <p><i class="fas fa-hospital"></i> ${doctor.hospital.centerName}</p>
                    </c:if>
                </div>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <form class="booking-form" action="${pageContext.request.contextPath}/consultation/book/${doctor.id}" method="post">
                <!-- Basic Patient Information -->
                <div class="form-section">
                    <h3><i class="fas fa-user"></i> Patient Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Full Name</label>
                            <input type="text" name="patientName" class="form-input" 
                                   value="${user.fullName != null ? user.fullName : ''}" 
                                   placeholder="Your full name" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label required">Email</label>
                            <input type="email" name="patientEmail" class="form-input" 
                                   value="${user.email != null ? user.email : ''}" 
                                   placeholder="your@email.com" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Phone Number</label>
                            <input type="tel" name="patientPhone" class="form-input" 
                                   value="${user.phone != null ? user.phone : ''}" 
                                   placeholder="+91 98765 43210" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label required">Age</label>
                            <input type="number" name="patientAge" class="form-input" 
                                   placeholder="Age" min="1" max="120" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label required">Gender</label>
                        <select name="patientGender" class="form-select" required>
                            <option value="">Select Gender</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                </div>
                
                <!-- Health Details (Optional) -->
                <div class="form-section">
                    <h3><i class="fas fa-heartbeat"></i> Health Details <span style="font-size: 0.9rem; font-weight: normal; color: var(--text-muted);">(Optional but recommended)</span></h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Height</label>
                            <input type="text" name="patientHeight" class="form-input" 
                                   placeholder="e.g., 170 cm or 5'7\""">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Weight</label>
                            <input type="text" name="patientWeight" class="form-input" 
                                   placeholder="e.g., 70 kg or 154 lbs">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Blood Pressure</label>
                        <input type="text" name="bloodPressure" class="form-input" 
                               placeholder="e.g., 120/80">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Allergies</label>
                        <textarea name="allergies" class="form-textarea" rows="2" 
                                  placeholder="List any allergies you have (e.g., Peanuts, Dust, Pollen)"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Current Medications</label>
                        <textarea name="currentMedications" class="form-textarea" rows="2" 
                                  placeholder="List any medications you're currently taking"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Medical History</label>
                        <textarea name="medicalHistory" class="form-textarea" rows="3" 
                                  placeholder="Any previous medical conditions, surgeries, or chronic illnesses"></textarea>
                    </div>
                </div>
                
                <!-- Consultation Details -->
                <div class="form-section">
                    <h3><i class="fas fa-calendar-check"></i> Consultation Details</h3>
                    
                    <div class="form-group">
                        <label class="form-label required">Consultation Type</label>
                        <div class="consultation-type-grid">
                            <label class="consultation-type-option">
                                <input type="radio" name="consultationType" value="IN_PERSON" required>
                                <i class="fas fa-hospital"></i>
                                <h5>In-Person</h5>
                                <p style="font-size: 0.85rem; color: var(--text-muted); margin: 8px 0 0;">Visit at hospital</p>
                            </label>
                            <label class="consultation-type-option">
                                <input type="radio" name="consultationType" value="ONLINE" required>
                                <i class="fas fa-video"></i>
                                <h5>Online</h5>
                                <p style="font-size: 0.85rem; color: var(--text-muted); margin: 8px 0 0;">Video consultation</p>
                            </label>
                            <label class="consultation-type-option">
                                <input type="radio" name="consultationType" value="HOME_VISIT" required>
                                <i class="fas fa-home"></i>
                                <h5>Home Visit</h5>
                                <p style="font-size: 0.85rem; color: var(--text-muted); margin: 8px 0 0;">Doctor visits you</p>
                            </label>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Preferred Date</label>
                            <input type="date" name="consultationDate" class="form-input" 
                                   min="${java.time.LocalDate.now()}" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label required">Preferred Time</label>
                            <input type="time" name="consultationTime" class="form-input" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Duration (minutes)</label>
                        <select name="durationMinutes" class="form-select">
                            <option value="30">30 minutes</option>
                            <option value="60" selected>60 minutes</option>
                            <option value="90">90 minutes</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label required">Reason for Visit / Symptoms</label>
                        <textarea name="reasonForVisit" class="form-textarea" rows="4" 
                                  placeholder="Describe your symptoms, health concerns, or reason for consultation" required></textarea>
                    </div>
                </div>
                
                <button type="submit" class="btn-submit">
                    <i class="fas fa-paper-plane"></i>
                    Submit Consultation Request
                </button>
            </form>
        </div>
    </div>

    <script>
        // Consultation type selection
        document.querySelectorAll('.consultation-type-option input[type="radio"]').forEach(radio => {
            radio.addEventListener('change', function() {
                document.querySelectorAll('.consultation-type-option').forEach(option => {
                    option.classList.remove('selected');
                });
                if (this.checked) {
                    this.closest('.consultation-type-option').classList.add('selected');
                }
            });
        });
        
        // Set minimum date to today
        const dateInput = document.querySelector('input[name="consultationDate"]');
        if (dateInput) {
            const today = new Date().toISOString().split('T')[0];
            dateInput.setAttribute('min', today);
        }
    </script>
</body>
</html>

