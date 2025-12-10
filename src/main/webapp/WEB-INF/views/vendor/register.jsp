<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Registration - Ayurveda Marketplace</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #2d5a27;
            --primary-dark: #1e3d1a;
            --accent: #8b4513;
            --bg-gradient: linear-gradient(135deg, #2d5a27 0%, #4a7c43 50%, #8b4513 100%);
        }
        
        body {
            min-height: 100vh;
            background: var(--bg-gradient);
            padding: 40px 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .register-container {
            background: rgba(255, 255, 255, 0.98);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            max-width: 900px;
            margin: 0 auto;
        }
        
        .register-header {
            background: var(--primary);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .register-header i {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        
        .register-header h2 {
            margin: 0;
            font-weight: 600;
        }
        
        .register-body {
            padding: 40px;
        }
        
        .section-title {
            color: var(--primary);
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--primary);
            display: flex;
            align-items: center;
        }
        
        .section-title i {
            margin-right: 10px;
            font-size: 1.2rem;
        }
        
        .form-label {
            font-weight: 500;
            color: #333;
        }
        
        .form-control, .form-select {
            border-radius: 8px;
            border: 2px solid #e0e0e0;
            padding: 10px 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(45, 90, 39, 0.15);
        }
        
        .form-control.is-invalid {
            border-color: #dc3545;
        }
        
        .btn-register {
            background: var(--primary);
            border: none;
            padding: 15px 40px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }
        
        .btn-register:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(45, 90, 39, 0.3);
        }
        
        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }
        
        .step {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e0e0e0;
            color: #666;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin: 0 10px;
            position: relative;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .step.active {
            background: var(--primary);
            color: white;
        }
        
        .step.completed {
            background: #28a745;
            color: white;
        }
        
        .step::after {
            content: '';
            position: absolute;
            width: 60px;
            height: 3px;
            background: #e0e0e0;
            right: -70px;
            top: 50%;
            transform: translateY(-50%);
        }
        
        .step:last-child::after {
            display: none;
        }
        
        .step.completed::after {
            background: #28a745;
        }
        
        .form-section {
            display: none;
        }
        
        .form-section.active {
            display: block;
        }
        
        .category-checkbox {
            display: inline-block;
            margin: 5px;
        }
        
        .category-checkbox input {
            display: none;
        }
        
        .category-checkbox label {
            background: #f5f5f5;
            padding: 8px 15px;
            border-radius: 20px;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }
        
        .category-checkbox input:checked + label {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        
        .back-home {
            position: fixed;
            top: 20px;
            left: 20px;
            color: white;
            text-decoration: none;
            font-weight: 500;
            z-index: 100;
        }
        
        .alert {
            border-radius: 10px;
        }
        
        .required-asterisk {
            color: red;
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/" class="back-home">
        <i class="fas fa-arrow-left me-2"></i>Back to Home
    </a>
    
    <div class="container">
        <div class="register-container">
            <div class="register-header">
                <i class="fas fa-store"></i>
                <h2>Become a Seller</h2>
                <p>Start selling Ayurvedic products on our marketplace</p>
            </div>
            
            <div class="register-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i>${success}
                    </div>
                </c:if>
                
                <!-- Step Indicator -->
                <div class="step-indicator">
                    <div class="step active" data-step="1">1</div>
                    <div class="step" data-step="2">2</div>
                    <div class="step" data-step="3">3</div>
                    <div class="step" data-step="4">4</div>
                    <div class="step" data-step="5">5</div>
                </div>
                
                <form action="${pageContext.request.contextPath}/vendor/register" method="post" id="vendorRegForm">
                    
                    <!-- Step 1: Basic Information -->
                    <div class="form-section active" id="step1">
                        <h4 class="section-title"><i class="fas fa-user"></i>Basic Information</h4>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Owner Full Name <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="ownerFullName" data-required="true">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email Address <span class="required-asterisk">*</span></label>
                                <input type="email" class="form-control" name="email" data-required="true">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Mobile Number <span class="required-asterisk">*</span></label>
                                <input type="tel" class="form-control" name="mobileNumber" data-required="true" data-pattern="[0-9]{10}" placeholder="10 digit mobile number">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Alternate Phone</label>
                                <input type="tel" class="form-control" name="alternatePhone">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Password <span class="required-asterisk">*</span></label>
                                <input type="password" class="form-control" name="password" id="password" data-required="true">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Confirm Password <span class="required-asterisk">*</span></label>
                                <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" data-required="true">
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-end mt-4">
                            <button type="button" class="btn btn-primary" onclick="nextStep(2)">
                                Next <i class="fas fa-arrow-right ms-2"></i>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Step 2: Business Details -->
                    <div class="form-section" id="step2">
                        <h4 class="section-title"><i class="fas fa-building"></i>Business Details</h4>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Business/Shop Name <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="businessName" data-required="true">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Business Type <span class="required-asterisk">*</span></label>
                                <select class="form-select" name="businessType" data-required="true">
                                    <option value="">Select Type</option>
                                    <c:forEach items="${businessTypes}" var="type">
                                        <option value="${type}">${type.displayName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Year Established <span class="required-asterisk">*</span></label>
                                <input type="number" class="form-control" name="yearEstablished" min="1900" max="2024" data-required="true">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">GST Number <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="gstNumber" data-required="true" placeholder="22AAAAA0000A1Z5">
                                <small class="text-muted">Format: 22AAAAA0000A1Z5</small>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">PAN Number <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="panNumber" data-required="true" placeholder="AAAAA0000A">
                                <small class="text-muted">Format: AAAAA0000A</small>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Trade License Number</label>
                                <input type="text" class="form-control" name="tradeLicenseNumber">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">FSSAI License</label>
                                <input type="text" class="form-control" name="fssaiLicense">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Ayush License</label>
                                <input type="text" class="form-control" name="ayushLicense">
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-secondary" onclick="prevStep(1)">
                                <i class="fas fa-arrow-left me-2"></i>Previous
                            </button>
                            <button type="button" class="btn btn-primary" onclick="nextStep(3)">
                                Next <i class="fas fa-arrow-right ms-2"></i>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Step 3: Address Details -->
                    <div class="form-section" id="step3">
                        <h4 class="section-title"><i class="fas fa-map-marker-alt"></i>Business Address</h4>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Address Line 1 <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="businessAddressLine1" data-required="true">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Address Line 2</label>
                                <input type="text" class="form-control" name="businessAddressLine2">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">City <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="businessCity" data-required="true">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">State <span class="required-asterisk">*</span></label>
                                <select class="form-select" name="businessState" data-required="true">
                                    <option value="">Select State</option>
                                    <option value="Andhra Pradesh">Andhra Pradesh</option>
                                    <option value="Karnataka">Karnataka</option>
                                    <option value="Kerala">Kerala</option>
                                    <option value="Tamil Nadu">Tamil Nadu</option>
                                    <option value="Maharashtra">Maharashtra</option>
                                    <option value="Gujarat">Gujarat</option>
                                    <option value="Rajasthan">Rajasthan</option>
                                    <option value="Delhi">Delhi</option>
                                    <option value="Uttar Pradesh">Uttar Pradesh</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">PIN Code <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="businessPinCode" data-required="true" placeholder="6 digit PIN code">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="sameAddress" name="sameAsBusinessAddress" value="true" checked>
                                <label class="form-check-label" for="sameAddress">
                                    Warehouse/Pickup address is same as business address
                                </label>
                            </div>
                        </div>
                        
                        <div id="warehouseAddress" style="display: none;">
                            <h5 class="mt-4 mb-3">Warehouse Address</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Address Line 1</label>
                                    <input type="text" class="form-control" name="warehouseAddressLine1">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Address Line 2</label>
                                    <input type="text" class="form-control" name="warehouseAddressLine2">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">City</label>
                                    <input type="text" class="form-control" name="warehouseCity">
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">State</label>
                                    <input type="text" class="form-control" name="warehouseState">
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">PIN Code</label>
                                    <input type="text" class="form-control" name="warehousePinCode">
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-secondary" onclick="prevStep(2)">
                                <i class="fas fa-arrow-left me-2"></i>Previous
                            </button>
                            <button type="button" class="btn btn-primary" onclick="nextStep(4)">
                                Next <i class="fas fa-arrow-right ms-2"></i>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Step 4: Bank Details -->
                    <div class="form-section" id="step4">
                        <h4 class="section-title"><i class="fas fa-university"></i>Bank Details</h4>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Bank Name <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="bankName" data-required="true">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Account Holder Name <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="accountHolderName" data-required="true">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Account Number <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="accountNumber" data-required="true">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">IFSC Code <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="ifscCode" data-required="true" placeholder="AAAA0XXXXXX">
                                <small class="text-muted">Format: AAAA0XXXXXX</small>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Branch Name <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="branchName" data-required="true">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Account Type <span class="required-asterisk">*</span></label>
                                <select class="form-select" name="accountType" data-required="true">
                                    <option value="">Select Type</option>
                                    <c:forEach items="${accountTypes}" var="type">
                                        <option value="${type}">${type.displayName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-secondary" onclick="prevStep(3)">
                                <i class="fas fa-arrow-left me-2"></i>Previous
                            </button>
                            <button type="button" class="btn btn-primary" onclick="nextStep(5)">
                                Next <i class="fas fa-arrow-right ms-2"></i>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Step 5: Store Information & Terms -->
                    <div class="form-section" id="step5">
                        <h4 class="section-title"><i class="fas fa-store-alt"></i>Store Information</h4>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Store Display Name <span class="required-asterisk">*</span></label>
                                <input type="text" class="form-control" name="storeDisplayName" data-required="true">
                                <small class="text-muted">This name will be shown to customers</small>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Website URL</label>
                                <input type="url" class="form-control" name="websiteUrl" placeholder="https://">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Store Description <span class="required-asterisk">*</span></label>
                            <textarea class="form-control" name="storeDescription" rows="3" data-required="true" placeholder="Tell customers about your store and products..."></textarea>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label">Product Categories <span class="required-asterisk">*</span></label>
                            <p class="text-muted small">Select categories you plan to sell in</p>
                            <div>
                                <c:forEach items="${categories}" var="cat">
                                    <div class="category-checkbox">
                                        <input type="checkbox" id="cat_${cat.id}" name="selectedCategories" value="${cat.id}">
                                        <label for="cat_${cat.id}">${cat.displayName}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <h5 class="mt-4 mb-3">Social Media (Optional)</h5>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label"><i class="fab fa-facebook text-primary me-2"></i>Facebook</label>
                                <input type="url" class="form-control" name="facebookUrl" placeholder="https://facebook.com/...">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label"><i class="fab fa-instagram text-danger me-2"></i>Instagram</label>
                                <input type="text" class="form-control" name="instagramHandle" placeholder="@username">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label"><i class="fab fa-youtube text-danger me-2"></i>YouTube</label>
                                <input type="url" class="form-control" name="youtubeUrl" placeholder="https://youtube.com/...">
                            </div>
                        </div>
                        
                        <div class="bg-light p-4 rounded mb-4">
                            <h5 class="mb-3">Terms & Agreements</h5>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="terms" name="agreedToTerms" value="true">
                                <label class="form-check-label" for="terms">
                                    I agree to the <a href="#" target="_blank">Terms & Conditions</a> <span class="required-asterisk">*</span>
                                </label>
                            </div>
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" id="seller" name="agreedToSellerAgreement" value="true">
                                <label class="form-check-label" for="seller">
                                    I agree to the <a href="#" target="_blank">Seller Agreement</a> <span class="required-asterisk">*</span>
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="returnPolicy" name="agreedToReturnPolicy" value="true">
                                <label class="form-check-label" for="returnPolicy">
                                    I agree to the <a href="#" target="_blank">Return & Refund Policy</a> <span class="required-asterisk">*</span>
                                </label>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-secondary" onclick="prevStep(4)">
                                <i class="fas fa-arrow-left me-2"></i>Previous
                            </button>
                            <button type="button" class="btn btn-register btn-success" onclick="submitForm()">
                                <i class="fas fa-check-circle me-2"></i>Submit Application
                            </button>
                        </div>
                    </div>
                </form>
                
                <div class="text-center mt-4 pt-4 border-top">
                    <p>Already have an account? <a href="${pageContext.request.contextPath}/vendor/login" style="color: var(--primary); font-weight: 600;">Login here</a></p>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let currentStep = 1;
        
        function nextStep(step) {
            if (!validateStep(currentStep)) {
                return;
            }
            
            document.getElementById('step' + currentStep).classList.remove('active');
            document.getElementById('step' + step).classList.add('active');
            
            document.querySelector('.step[data-step="' + currentStep + '"]').classList.remove('active');
            document.querySelector('.step[data-step="' + currentStep + '"]').classList.add('completed');
            document.querySelector('.step[data-step="' + step + '"]').classList.add('active');
            
            currentStep = step;
            window.scrollTo(0, 0);
        }
        
        function prevStep(step) {
            document.getElementById('step' + currentStep).classList.remove('active');
            document.getElementById('step' + step).classList.add('active');
            
            document.querySelector('.step[data-step="' + currentStep + '"]').classList.remove('active');
            document.querySelector('.step[data-step="' + step + '"]').classList.add('active');
            document.querySelector('.step[data-step="' + step + '"]').classList.remove('completed');
            
            currentStep = step;
            window.scrollTo(0, 0);
        }
        
        function validateStep(step) {
            const section = document.getElementById('step' + step);
            const requiredFields = section.querySelectorAll('[data-required="true"]');
            let valid = true;
            let firstInvalidField = null;
            
            requiredFields.forEach(field => {
                if (!field.value || field.value.trim() === '') {
                    field.classList.add('is-invalid');
                    valid = false;
                    if (!firstInvalidField) firstInvalidField = field;
                } else {
                    field.classList.remove('is-invalid');
                }
            });
            
            // Validate password match in step 1
            if (step === 1) {
                const password = document.getElementById('password');
                const confirmPassword = document.getElementById('confirmPassword');
                if (password.value !== confirmPassword.value) {
                    confirmPassword.classList.add('is-invalid');
                    alert('Passwords do not match!');
                    return false;
                }
                if (password.value.length < 6) {
                    password.classList.add('is-invalid');
                    alert('Password must be at least 6 characters');
                    return false;
                }
            }
            
            if (!valid) {
                alert('Please fill all required fields');
                if (firstInvalidField) firstInvalidField.focus();
            }
            
            return valid;
        }
        
        function submitForm() {
            // Validate step 5 first
            if (!validateStep(5)) {
                return;
            }
            
            // Check categories
            const categoryCheckboxes = document.querySelectorAll('input[name="selectedCategories"]:checked');
            if (categoryCheckboxes.length === 0) {
                alert('Please select at least one product category');
                return;
            }
            
            // Check terms checkboxes
            const terms = document.getElementById('terms');
            const seller = document.getElementById('seller');
            const returnPolicy = document.getElementById('returnPolicy');
            
            if (!terms.checked) {
                alert('Please agree to the Terms & Conditions');
                return;
            }
            if (!seller.checked) {
                alert('Please agree to the Seller Agreement');
                return;
            }
            if (!returnPolicy.checked) {
                alert('Please agree to the Return & Refund Policy');
                return;
            }
            
            // All validations passed - submit the form
            document.getElementById('vendorRegForm').submit();
        }
        
        // Toggle warehouse address
        document.getElementById('sameAddress').addEventListener('change', function() {
            document.getElementById('warehouseAddress').style.display = this.checked ? 'none' : 'block';
        });
    </script>
</body>
</html>
