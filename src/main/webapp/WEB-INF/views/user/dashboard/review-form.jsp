<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-base.jsp">
    <jsp:param name="pageTitle" value="Submit Review"/>
    <jsp:param name="activeNav" value="review"/>
</jsp:include>

<div class="content-wrapper">
    <div class="content-header">
        <h1 class="page-title">
            <i class="fas fa-star"></i> Submit Your Review
        </h1>
        <p class="text-muted">Share your experience and help others make informed decisions</p>
    </div>

    <div class="content-body">
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card" style="border: none; box-shadow: 0 2px 15px rgba(0,0,0,0.08);">
            <div class="card-body p-4">
                <form id="reviewForm" method="post">
                    <!-- Review Type Selection -->
                    <div class="mb-4">
                        <label class="form-label fw-bold">What would you like to review? *</label>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <div class="form-check review-type-option">
                                    <input class="form-check-input" type="radio" name="reviewType" id="typeHospital" value="hospital" required>
                                    <label class="form-check-label" for="typeHospital">
                                        <i class="fas fa-hospital text-primary"></i> Hospital
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-check review-type-option">
                                    <input class="form-check-input" type="radio" name="reviewType" id="typeProduct" value="product" required>
                                    <label class="form-check-label" for="typeProduct">
                                        <i class="fas fa-shopping-bag text-success"></i> Product
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-check review-type-option">
                                    <input class="form-check-input" type="radio" name="reviewType" id="typeWebsite" value="website" required>
                                    <label class="form-check-label" for="typeWebsite">
                                        <i class="fas fa-globe text-warning"></i> Website
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Hospital Selection (shown when hospital is selected) -->
                    <div class="mb-3" id="hospitalSelection" style="display: none;">
                        <label for="hospitalId" class="form-label fw-bold">Select Hospital *</label>
                        <select class="form-select" id="hospitalId" name="hospitalId">
                            <option value="">Choose a hospital...</option>
                            <c:forEach var="hospital" items="${hospitals}">
                                <option value="${hospital.id}">${hospital.centerName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Product Selection (shown when product is selected) -->
                    <div class="mb-3" id="productSelection" style="display: none;">
                        <label for="productId" class="form-label fw-bold">Select Product *</label>
                        <select class="form-select" id="productId" name="productId">
                            <option value="">Choose a product...</option>
                            <c:forEach var="product" items="${products}">
                                <option value="${product.id}">${product.productName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Overall Rating -->
                    <div class="mb-4">
                        <label class="form-label fw-bold">Overall Rating *</label>
                        <div class="rating-input d-flex justify-content-center gap-2 my-3">
                            <input type="radio" id="rating5" name="rating" value="5" required>
                            <label for="rating5" class="rating-star" data-rating="5">
                                <i class="fas fa-star"></i>
                            </label>
                            <input type="radio" id="rating4" name="rating" value="4">
                            <label for="rating4" class="rating-star" data-rating="4">
                                <i class="fas fa-star"></i>
                            </label>
                            <input type="radio" id="rating3" name="rating" value="3">
                            <label for="rating3" class="rating-star" data-rating="3">
                                <i class="fas fa-star"></i>
                            </label>
                            <input type="radio" id="rating2" name="rating" value="2">
                            <label for="rating2" class="rating-star" data-rating="2">
                                <i class="fas fa-star"></i>
                            </label>
                            <input type="radio" id="rating1" name="rating" value="1">
                            <label for="rating1" class="rating-star" data-rating="1">
                                <i class="fas fa-star"></i>
                            </label>
                        </div>
                        <div class="text-center">
                            <span id="ratingText" class="text-muted">Select a rating</span>
                        </div>
                    </div>

                    <!-- Review Title -->
                    <div class="mb-3">
                        <label for="title" class="form-label fw-bold">Review Title</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Give your review a catchy title (optional)">
                    </div>

                    <!-- Review Text -->
                    <div class="mb-3">
                        <label for="reviewText" class="form-label fw-bold">Your Review *</label>
                        <textarea class="form-control" id="reviewText" name="reviewText" rows="6" required placeholder="Share your detailed experience..."></textarea>
                        <small class="text-muted">Minimum 50 characters</small>
                    </div>

                    <!-- Pros and Cons (for Product/Website reviews) -->
                    <div class="row mb-3" id="prosConsSection" style="display: none;">
                        <div class="col-md-6">
                            <label for="pros" class="form-label fw-bold">What you liked</label>
                            <textarea class="form-control" id="pros" name="pros" rows="3" placeholder="What did you like?"></textarea>
                        </div>
                        <div class="col-md-6">
                            <label for="cons" class="form-label fw-bold">What could be better</label>
                            <textarea class="form-control" id="cons" name="cons" rows="3" placeholder="Any suggestions for improvement?"></textarea>
                        </div>
                    </div>

                    <!-- Hospital Specific Fields -->
                    <div id="hospitalFields" style="display: none;">
                        <div class="mb-3">
                            <label for="treatmentTaken" class="form-label fw-bold">Treatment Taken</label>
                            <input type="text" class="form-control" id="treatmentTaken" name="treatmentTaken" placeholder="e.g., Panchakarma, Abhyanga, etc.">
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="treatmentRating" class="form-label">Treatment Rating</label>
                                <select class="form-select" id="treatmentRating" name="treatmentRating">
                                    <option value="">Select rating</option>
                                    <option value="5">5 - Excellent</option>
                                    <option value="4">4 - Very Good</option>
                                    <option value="3">3 - Good</option>
                                    <option value="2">2 - Fair</option>
                                    <option value="1">1 - Poor</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="accommodationRating" class="form-label">Accommodation Rating</label>
                                <select class="form-select" id="accommodationRating" name="accommodationRating">
                                    <option value="">Select rating</option>
                                    <option value="5">5 - Excellent</option>
                                    <option value="4">4 - Very Good</option>
                                    <option value="3">3 - Good</option>
                                    <option value="2">2 - Fair</option>
                                    <option value="1">1 - Poor</option>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label for="staffRating" class="form-label">Staff Rating</label>
                                <select class="form-select" id="staffRating" name="staffRating">
                                    <option value="">Select rating</option>
                                    <option value="5">5 - Excellent</option>
                                    <option value="4">4 - Very Good</option>
                                    <option value="3">3 - Good</option>
                                    <option value="2">2 - Fair</option>
                                    <option value="1">1 - Poor</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="foodRating" class="form-label">Food Rating</label>
                                <select class="form-select" id="foodRating" name="foodRating">
                                    <option value="">Select rating</option>
                                    <option value="5">5 - Excellent</option>
                                    <option value="4">4 - Very Good</option>
                                    <option value="3">3 - Good</option>
                                    <option value="2">2 - Fair</option>
                                    <option value="1">1 - Poor</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="valueForMoneyRating" class="form-label">Value for Money</label>
                                <select class="form-select" id="valueForMoneyRating" name="valueForMoneyRating">
                                    <option value="">Select rating</option>
                                    <option value="5">5 - Excellent</option>
                                    <option value="4">4 - Very Good</option>
                                    <option value="3">3 - Good</option>
                                    <option value="2">2 - Fair</option>
                                    <option value="1">1 - Poor</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Product/Website Specific Fields -->
                    <div id="productFields" style="display: none;">
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="isRecommended" name="isRecommended" value="true" checked>
                            <label class="form-check-label" for="isRecommended">
                                I recommend this
                            </label>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-primary btn-lg" style="background: linear-gradient(135deg, #c9a227, #e6b55c); border: none; padding: 12px 50px; font-weight: 600;">
                            <i class="fas fa-paper-plane me-2"></i> Submit Review
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<style>
    .rating-input input[type="radio"] {
        display: none;
    }
    
    .rating-star {
        font-size: 2.5rem;
        color: #ddd;
        cursor: pointer;
        transition: color 0.2s, transform 0.2s;
    }
    
    .rating-star:hover {
        transform: scale(1.1);
    }
    
    .rating-star.active,
    .rating-input input[type="radio"]:checked ~ label,
    .rating-star:hover ~ .rating-star {
        color: #ffc107;
    }
    
    .review-type-option {
        padding: 15px;
        border: 2px solid #e5e7eb;
        border-radius: 10px;
        transition: all 0.3s;
        cursor: pointer;
    }
    
    .review-type-option:hover {
        border-color: #c9a227;
        background: #fdfaf4;
    }
    
    .review-type-option input[type="radio"]:checked ~ label,
    .review-type-option:has(input[type="radio"]:checked) {
        border-color: #c9a227;
        background: #fdfaf4;
    }
    
    .form-label {
        color: #1a2e1a;
        margin-bottom: 8px;
    }
    
    .form-control, .form-select {
        border: 2px solid #e5e7eb;
        border-radius: 8px;
        padding: 10px 15px;
        transition: border-color 0.3s;
    }
    
    .form-control:focus, .form-select:focus {
        border-color: #c9a227;
        box-shadow: 0 0 0 3px rgba(201, 162, 39, 0.1);
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const reviewTypeInputs = document.querySelectorAll('input[name="reviewType"]');
        const hospitalSelection = document.getElementById('hospitalSelection');
        const productSelection = document.getElementById('productSelection');
        const hospitalFields = document.getElementById('hospitalFields');
        const productFields = document.getElementById('productFields');
        const prosConsSection = document.getElementById('prosConsSection');
        const reviewForm = document.getElementById('reviewForm');
        const ratingStars = document.querySelectorAll('.rating-star');
        const ratingText = document.getElementById('ratingText');
        const ratingInputs = document.querySelectorAll('input[name="rating"]');

        // Handle review type selection
        reviewTypeInputs.forEach(input => {
            input.addEventListener('change', function() {
                const type = this.value;
                
                // Reset form sections
                hospitalSelection.style.display = 'none';
                productSelection.style.display = 'none';
                hospitalFields.style.display = 'none';
                productFields.style.display = 'none';
                prosConsSection.style.display = 'none';
                
                // Show relevant sections
                if (type === 'hospital') {
                    hospitalSelection.style.display = 'block';
                    hospitalFields.style.display = 'block';
                    reviewForm.action = '${pageContext.request.contextPath}/user/review/hospital/' + (document.getElementById('hospitalId').value || '0');
                } else if (type === 'product') {
                    productSelection.style.display = 'block';
                    productFields.style.display = 'block';
                    prosConsSection.style.display = 'block';
                    reviewForm.action = '${pageContext.request.contextPath}/user/review/product/' + (document.getElementById('productId').value || '0');
                } else if (type === 'website') {
                    productFields.style.display = 'block';
                    prosConsSection.style.display = 'block';
                    reviewForm.action = '${pageContext.request.contextPath}/user/review/website';
                }
            });
        });

        // Handle hospital/product selection change
        document.getElementById('hospitalId')?.addEventListener('change', function() {
            if (this.value) {
                reviewForm.action = '${pageContext.request.contextPath}/user/review/hospital/' + this.value;
            }
        });

        document.getElementById('productId')?.addEventListener('change', function() {
            if (this.value) {
                reviewForm.action = '${pageContext.request.contextPath}/user/review/product/' + this.value;
            }
        });

        // Star rating interaction
        ratingInputs.forEach(radio => {
            radio.addEventListener('change', function() {
                const rating = parseInt(this.value);
                const labels = Array.from(ratingStars).reverse();
                
                labels.forEach((label, index) => {
                    const starValue = index + 1;
                    if (starValue <= rating) {
                        label.style.color = '#ffc107';
                        label.classList.add('active');
                    } else {
                        label.style.color = '#ddd';
                        label.classList.remove('active');
                    }
                });
                
                // Update rating text
                const ratingTexts = ['', 'Poor', 'Fair', 'Good', 'Very Good', 'Excellent'];
                ratingText.textContent = rating + ' - ' + ratingTexts[rating];
            });
        });

        // Hover effect for stars
        ratingStars.forEach((star, index) => {
            star.addEventListener('mouseenter', function() {
                const hoverRating = 5 - index;
                ratingStars.forEach((s, i) => {
                    const starValue = 5 - i;
                    if (starValue <= hoverRating) {
                        s.style.color = '#ffc107';
                    } else {
                        s.style.color = '#ddd';
                    }
                });
            });
        });

        document.querySelector('.rating-input').addEventListener('mouseleave', function() {
            const checked = document.querySelector('input[name="rating"]:checked');
            if (checked) {
                const rating = parseInt(checked.value);
                ratingStars.forEach((star, index) => {
                    const starValue = 5 - index;
                    if (starValue <= rating) {
                        star.style.color = '#ffc107';
                    } else {
                        star.style.color = '#ddd';
                    }
                });
            } else {
                ratingStars.forEach(star => star.style.color = '#ddd');
                ratingText.textContent = 'Select a rating';
            }
        });

        // Form validation
        reviewForm.addEventListener('submit', function(e) {
            const reviewType = document.querySelector('input[name="reviewType"]:checked')?.value;
            const rating = document.querySelector('input[name="rating"]:checked')?.value;
            const reviewText = document.getElementById('reviewText').value.trim();

            if (!reviewType) {
                e.preventDefault();
                alert('Please select what you want to review');
                return false;
            }

            if (!rating) {
                e.preventDefault();
                alert('Please select a rating');
                return false;
            }

            if (reviewType === 'hospital' && !document.getElementById('hospitalId').value) {
                e.preventDefault();
                alert('Please select a hospital');
                return false;
            }

            if (reviewType === 'product' && !document.getElementById('productId').value) {
                e.preventDefault();
                alert('Please select a product');
                return false;
            }

            if (reviewText.length < 50) {
                e.preventDefault();
                alert('Please write at least 50 characters in your review');
                return false;
            }
        });
    });
</script>

<jsp:include page="/WEB-INF/views/user/layouts/user-dashboard-footer.jsp"/>

