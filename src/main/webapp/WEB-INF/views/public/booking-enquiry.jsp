<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Enquiry - ${hospital.centerName}</title>
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
        
        .hospital-summary {
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-lg);
            display: flex;
            align-items: center;
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-xl);
            box-shadow: var(--shadow-sm);
        }
        
        .hospital-summary-image {
            width: 100px;
            height: 100px;
            border-radius: var(--radius-md);
            background: var(--neutral-sand);
            overflow: hidden;
        }
        
        .hospital-summary-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .hospital-summary-info h3 {
            margin: 0 0 var(--spacing-xs);
        }
        
        .hospital-summary-info p {
            color: var(--text-muted);
            margin: 0;
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
        
        .package-select-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-lg);
        }
        
        .package-option {
            border: 2px solid var(--neutral-stone);
            border-radius: var(--radius-md);
            padding: var(--spacing-lg);
            cursor: pointer;
            transition: all var(--transition-fast);
        }
        
        .package-option:hover {
            border-color: var(--primary-sage);
        }
        
        .package-option.selected {
            border-color: var(--primary-forest);
            background: rgba(45, 90, 61, 0.05);
        }
        
        .package-option input {
            display: none;
        }
        
        .package-option h4 {
            margin: 0 0 var(--spacing-xs);
        }
        
        .package-option .meta {
            font-size: 0.9rem;
            color: var(--text-muted);
        }
        
        .package-option .price {
            font-weight: 700;
            color: var(--primary-forest);
            margin-top: var(--spacing-sm);
        }
        
        .room-type-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: var(--spacing-md);
        }
        
        .room-option {
            text-align: center;
            border: 2px solid var(--neutral-stone);
            border-radius: var(--radius-md);
            padding: var(--spacing-lg);
            cursor: pointer;
            transition: all var(--transition-fast);
        }
        
        .room-option:hover {
            border-color: var(--primary-sage);
        }
        
        .room-option.selected {
            border-color: var(--primary-forest);
            background: rgba(45, 90, 61, 0.05);
        }
        
        .room-option input {
            display: none;
        }
        
        .room-option i {
            font-size: 2rem;
            color: var(--primary-sage);
            margin-bottom: var(--spacing-sm);
        }
        
        .room-option h5 {
            margin: 0;
            font-size: 0.95rem;
        }
        
        @media (max-width: 768px) {
            .package-select-grid {
                grid-template-columns: 1fr;
            }
            
            .room-type-grid {
                grid-template-columns: repeat(2, 1fr);
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
            </div>
        </div>
    </nav>

    <div class="booking-page">
        <div class="booking-container">
            <div class="booking-header">
                <h1>Book Your Stay</h1>
                <p>Fill in your details and we'll get back to you within 24 hours</p>
            </div>
            
            <div class="hospital-summary">
                <div class="hospital-summary-image">
                    <c:choose>
                        <c:when test="${not empty hospital.coverPhotoUrl}">
                            <img src="${pageContext.request.contextPath}${hospital.coverPhotoUrl}" alt="${hospital.centerName}">
                        </c:when>
                        <c:otherwise>
                            <div style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
                                <i class="fas fa-hospital" style="font-size: 2rem; color: var(--text-muted);"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="hospital-summary-info">
                    <h3>${hospital.centerName}</h3>
                    <p><i class="fas fa-map-marker-alt"></i> ${hospital.city}, ${hospital.state}</p>
                </div>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <form class="booking-form" action="${pageContext.request.contextPath}/booking/enquiry/${hospital.id}" method="post">
                <!-- Package Selection -->
                <div class="form-section">
                    <h3><i class="fas fa-box"></i> Select Package</h3>
                    
                    <c:if test="${not empty packages}">
                        <div class="package-select-grid">
                            <c:forEach var="pkg" items="${packages}">
                                <label class="package-option ${selectedPackage != null && selectedPackage.id == pkg.id ? 'selected' : ''}">
                                    <input type="radio" name="packageId" value="${pkg.id}" ${selectedPackage != null && selectedPackage.id == pkg.id ? 'checked' : ''} required>
                                    <h4>${pkg.packageName}</h4>
                                    <div class="meta">${pkg.durationDays} Days • ${pkg.packageType}</div>
                                    <div class="price">From ₹<fmt:formatNumber value="${pkg.budgetRoomPrice}" maxFractionDigits="0"/></div>
                                </label>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
                
                <!-- Room Type -->
                <div class="form-section">
                    <h3><i class="fas fa-bed"></i> Room Type</h3>
                    
                    <div class="room-type-grid">
                        <c:forEach var="room" items="${roomTypes}">
                            <label class="room-option">
                                <input type="radio" name="roomType" value="${room}" required>
                                <i class="fas fa-bed"></i>
                                <h5>${room}</h5>
                            </label>
                        </c:forEach>
                    </div>
                </div>
                
                <!-- Price Breakdown (shown when package and room type selected) -->
                <div class="form-section" id="priceBreakdownSection" style="display: none;">
                    <h3><i class="fas fa-calculator"></i> Price Breakdown</h3>
                    <div style="background: #f9f9f9; padding: 20px; border-radius: 8px; border: 2px solid #e6b55c;">
                        <table style="width: 100%; border-collapse: collapse;">
                            <tr>
                                <td style="padding: 8px 0; font-weight: 600;">Base Price:</td>
                                <td style="text-align: right; padding: 8px 0;" id="basePriceDisplay">₹0.00</td>
                            </tr>
                            <tr>
                                <td style="padding: 8px 0;">GST (<span id="gstPercentDisplay">0</span>%):</td>
                                <td style="text-align: right; padding: 8px 0;" id="gstAmountDisplay">₹0.00</td>
                            </tr>
                            <tr>
                                <td style="padding: 8px 0;">CGST (<span id="cgstPercentDisplay">0</span>%):</td>
                                <td style="text-align: right; padding: 8px 0;" id="cgstAmountDisplay">₹0.00</td>
                            </tr>
                            <tr style="border-top: 2px solid #333; font-weight: bold; font-size: 1.1em;">
                                <td style="padding: 12px 0;">Total Amount:</td>
                                <td style="text-align: right; padding: 12px 0; color: #e6b55c;" id="totalAmountDisplay">₹0.00</td>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <!-- Dates -->
                <div class="form-section">
                    <h3><i class="fas fa-calendar"></i> Preferred Dates</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Check-in Date</label>
                            <input type="date" name="checkInDate" class="form-input" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Check-out Date</label>
                            <input type="date" name="checkOutDate" class="form-input">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Number of Guests</label>
                        <select name="numberOfGuests" class="form-select">
                            <option value="1">1 Guest</option>
                            <option value="2">2 Guests</option>
                            <option value="3">3 Guests</option>
                            <option value="4">4+ Guests</option>
                        </select>
                    </div>
                </div>
                
                <!-- Personal Information -->
                <div class="form-section">
                    <h3><i class="fas fa-user"></i> Your Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Full Name</label>
                            <input type="text" name="patientName" class="form-input" placeholder="Your full name" 
                                   value="${booking.patientName != null ? booking.patientName : ''}" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label required">Email</label>
                            <input type="email" name="patientEmail" class="form-input" placeholder="your@email.com" 
                                   value="${booking.patientEmail != null ? booking.patientEmail : ''}" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Phone Number</label>
                            <input type="tel" name="patientPhone" class="form-input" placeholder="+91 98765 43210" 
                                   value="${booking.patientPhone != null ? booking.patientPhone : ''}" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Country</label>
                            <input type="text" name="patientCountry" class="form-input" placeholder="India" 
                                   value="${booking.patientCountry != null ? booking.patientCountry : 'India'}">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Age</label>
                            <input type="number" name="patientAge" class="form-input" placeholder="Age" min="1" max="120" 
                                   value="${booking.patientAge != null ? booking.patientAge : ''}">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Gender</label>
                            <select name="patientGender" class="form-select">
                                <option value="">Select...</option>
                                <option value="Male" ${booking.patientGender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${booking.patientGender == 'Female' ? 'selected' : ''}>Female</option>
                                <option value="Other" ${booking.patientGender == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <!-- Health Information -->
                <div class="form-section">
                    <h3><i class="fas fa-heartbeat"></i> Health Information</h3>
                    
                    <div class="form-group">
                        <label class="form-label">Medical Conditions (if any)</label>
                        <textarea name="medicalConditions" class="form-textarea" rows="3" placeholder="Please mention any health conditions or allergies..."></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Current Medications</label>
                        <textarea name="currentMedications" class="form-textarea" rows="2" placeholder="List any medications you're currently taking..."></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Special Requests</label>
                        <textarea name="specialRequests" class="form-textarea" rows="3" placeholder="Any special requirements or requests..."></textarea>
                    </div>
                </div>
                
                <div class="form-actions" style="border: none; justify-content: flex-end;">
                    <a href="${pageContext.request.contextPath}/hospital/profile/${hospital.id}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back
                    </a>
                    <button type="submit" class="btn btn-gold btn-lg">
                        <i class="fas fa-paper-plane"></i> Submit Enquiry
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        // All packages pricing data - key is packageId, value is pricing map for that package
        const allPackagesPricing = {
            <c:forEach var="pkgEntry" items="${allPackagesPricing}">
            "${pkgEntry.key}": {
                <c:forEach var="roomEntry" items="${pkgEntry.value}">
                "${roomEntry.key}": {
                    basePrice: ${roomEntry.value.basePrice != null ? roomEntry.value.basePrice : 0},
                    gstPercent: ${roomEntry.value.gstPercent != null ? roomEntry.value.gstPercent : 0},
                    cgstPercent: ${roomEntry.value.cgstPercent != null ? roomEntry.value.cgstPercent : 0}
                },
                </c:forEach>
            },
            </c:forEach>
        };
        
        // Debug: Log pricing data
        console.log('All Packages Pricing:', allPackagesPricing);
        
        // Calculate price breakdown
        function calculatePrice() {
            const packageInput = document.querySelector('input[name="packageId"]:checked');
            const roomTypeInput = document.querySelector('input[name="roomType"]:checked');
            const priceSection = document.getElementById('priceBreakdownSection');
            
            // Hide price section if package or room type not selected
            if (!packageInput || !roomTypeInput) {
                if (priceSection) priceSection.style.display = 'none';
                return;
            }
            
            const packageId = packageInput.value;
            const roomType = roomTypeInput.value;
            
            console.log('Calculating price for Package ID:', packageId, 'Room Type:', roomType);
            
            // Check if allPackagesPricing exists and has data
            if (!allPackagesPricing || Object.keys(allPackagesPricing).length === 0) {
                console.warn('No pricing data available');
                if (priceSection) priceSection.style.display = 'none';
                return;
            }
            
            // Get pricing for selected package
            const packagePricing = allPackagesPricing[packageId];
            if (!packagePricing) {
                console.warn('No pricing found for package ID:', packageId);
                if (priceSection) priceSection.style.display = 'none';
                return;
            }
            
            // Get pricing for selected room type
            const pricing = packagePricing[roomType];
            if (!pricing) {
                console.warn('No pricing found for room type:', roomType, 'in package:', packageId);
                if (priceSection) priceSection.style.display = 'none';
                return;
            }
            
            console.log('Pricing data:', pricing);
            
            // Calculate amounts
            const basePrice = parseFloat(pricing.basePrice) || 0;
            const gstPercent = parseFloat(pricing.gstPercent) || 0;
            const cgstPercent = parseFloat(pricing.cgstPercent) || 0;
            
            const gstAmount = (basePrice * gstPercent) / 100;
            const cgstAmount = (basePrice * cgstPercent) / 100;
            const totalAmount = basePrice + gstAmount + cgstAmount;
            
            // Update display
            document.getElementById('basePriceDisplay').textContent = '₹' + basePrice.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
            document.getElementById('gstPercentDisplay').textContent = gstPercent.toFixed(2);
            document.getElementById('gstAmountDisplay').textContent = '₹' + gstAmount.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
            document.getElementById('cgstPercentDisplay').textContent = cgstPercent.toFixed(2);
            document.getElementById('cgstAmountDisplay').textContent = '₹' + cgstAmount.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
            document.getElementById('totalAmountDisplay').textContent = '₹' + totalAmount.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
            
            // Show price breakdown
            if (priceSection) {
                priceSection.style.display = 'block';
                console.log('Price breakdown displayed');
            }
        }
        
        // Initialize all event listeners when DOM is ready
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page loaded, initializing event listeners...');
            
            // Package selection highlighting and price recalculation
            document.querySelectorAll('.package-option').forEach(option => {
                option.addEventListener('click', function() {
                    document.querySelectorAll('.package-option').forEach(o => o.classList.remove('selected'));
                    this.classList.add('selected');
                    this.querySelector('input').checked = true;
                    // Recalculate price when package changes
                    calculatePrice();
                });
            });
            
            // Room selection highlighting and price recalculation
            document.querySelectorAll('.room-option').forEach(option => {
                option.addEventListener('click', function() {
                    document.querySelectorAll('.room-option').forEach(o => o.classList.remove('selected'));
                    this.classList.add('selected');
                    calculatePrice(); // Calculate price when room type is selected
                });
            });
            
            // Listen for package selection changes
            document.querySelectorAll('input[name="packageId"]').forEach(input => {
                input.addEventListener('change', function() {
                    console.log('Package changed to:', this.value);
                    calculatePrice();
                });
            });
            
            // Listen for room type selection changes
            document.querySelectorAll('input[name="roomType"]').forEach(input => {
                input.addEventListener('change', function() {
                    console.log('Room type changed to:', this.value);
                    calculatePrice();
                });
            });
            
            // Initialize price calculation on page load if both package and room type are already selected
            const selectedPackage = document.querySelector('input[name="packageId"]:checked');
            const selectedRoomType = document.querySelector('input[name="roomType"]:checked');
            console.log('Selected package:', selectedPackage ? selectedPackage.value : 'none');
            console.log('Selected room type:', selectedRoomType ? selectedRoomType.value : 'none');
            if (selectedPackage && selectedRoomType) {
                calculatePrice();
            }
        });
    </script>
</body>
</html>

