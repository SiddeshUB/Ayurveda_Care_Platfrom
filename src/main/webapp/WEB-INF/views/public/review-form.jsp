<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Review - Ayurveda Wellness</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-dark: #1a2e1a;
            --primary-green: #2d4a2d;
            --accent-gold: #c9a227;
            --accent-gold-light: #e6b55c;
            --text-light: #f5f0e8;
            --bg-cream: #fdfaf4;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--bg-cream);
            color: #333;
        }
        
        h1, h2, h3 {
            font-family: 'Cormorant Garamond', serif;
        }
        
        .review-form-container {
            max-width: 800px;
            margin: 40px auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 30px rgba(0,0,0,0.1);
            padding: 40px;
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #eee;
        }
        
        .rating-input {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 20px 0;
        }
        
        .rating-input input[type="radio"] {
            display: none;
        }
        
        .rating-input label {
            font-size: 2rem;
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s;
        }
        
        .rating-input label:hover,
        .rating-input input[type="radio"]:checked ~ label,
        .rating-input label:hover ~ label {
            color: #ffc107;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 8px;
        }
        
        .form-control, .form-select {
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            padding: 12px 15px;
            transition: border-color 0.3s;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--accent-gold);
            box-shadow: 0 0 0 3px rgba(201, 162, 39, 0.1);
        }
        
        .btn-submit {
            background: linear-gradient(135deg, var(--accent-gold), var(--accent-gold-light));
            color: var(--primary-dark);
            border: none;
            padding: 12px 40px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(201, 162, 39, 0.3);
            color: var(--primary-dark);
        }
        
        .review-item-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        
        .review-item-info h4 {
            color: var(--primary-dark);
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-leaf text-success"></i> Ayurveda Wellness
            </a>
            <div class="d-flex">
                <c:if test="${not empty user}">
                    <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-outline-primary me-2">
                        <i class="fas fa-user"></i> Dashboard
                    </a>
                </c:if>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <div class="review-form-container">
            <div class="form-header">
                <h1><i class="fas fa-star text-warning"></i> Submit Your Review</h1>
                <p class="text-muted">Share your experience with our community</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Review Item Info -->
            <c:if test="${reviewType == 'hospital' && not empty hospital}">
                <div class="review-item-info">
                    <h4><i class="fas fa-hospital"></i> ${hospital.centerName}</h4>
                    <p class="text-muted mb-0">${hospital.address}</p>
                </div>
                
                <form action="${pageContext.request.contextPath}/user/review/hospital/${hospital.id}" method="post">
                    <div class="form-group">
                        <label class="form-label">Overall Rating *</label>
                        <div class="rating-input">
                            <input type="radio" id="rating5" name="rating" value="5" required>
                            <label for="rating5"><i class="fas fa-star"></i></label>
                            <input type="radio" id="rating4" name="rating" value="4">
                            <label for="rating4"><i class="fas fa-star"></i></label>
                            <input type="radio" id="rating3" name="rating" value="3">
                            <label for="rating3"><i class="fas fa-star"></i></label>
                            <input type="radio" id="rating2" name="rating" value="2">
                            <label for="rating2"><i class="fas fa-star"></i></label>
                            <input type="radio" id="rating1" name="rating" value="1">
                            <label for="rating1"><i class="fas fa-star"></i></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="reviewText" class="form-label">Your Review *</label>
                        <textarea class="form-control" id="reviewText" name="reviewText" rows="5" required placeholder="Share your experience..."></textarea>
                    </div>

                    <div class="form-group">
                        <label for="treatmentTaken" class="form-label">Treatment Taken</label>
                        <input type="text" class="form-control" id="treatmentTaken" name="treatmentTaken" placeholder="e.g., Panchakarma, Abhyanga">
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
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
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
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
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
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
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
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
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="valueForMoneyRating" class="form-label">Value for Money Rating</label>
                        <select class="form-select" id="valueForMoneyRating" name="valueForMoneyRating">
                            <option value="">Select rating</option>
                            <option value="5">5 - Excellent</option>
                            <option value="4">4 - Very Good</option>
                            <option value="3">3 - Good</option>
                            <option value="2">2 - Fair</option>
                            <option value="1">1 - Poor</option>
                        </select>
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-submit">
                            <i class="fas fa-paper-plane"></i> Submit Review
                        </button>
                    </div>
                </form>
            </c:if>

            <c:if test="${reviewType == 'product' && not empty product}">
                <div class="review-item-info">
                    <div class="d-flex align-items-center">
                        <c:if test="${not empty product.imageUrl}">
                            <img src="${pageContext.request.contextPath}${product.imageUrl}" 
                                 alt="${product.productName}" 
                                 style="width: 80px; height: 80px; object-fit: cover; border-radius: 8px; margin-right: 15px;">
                        </c:if>
                        <div>
                            <h4>${product.productName}</h4>
                            <p class="text-muted mb-0">${product.vendor.storeDisplayName}</p>
                        </div>
                    </div>
                </div>
                
                <form action="${pageContext.request.contextPath}/user/review/product/${product.id}" method="post">
                    <div class="form-group">
                        <label class="form-label">Overall Rating *</label>
                        <div class="rating-input">
                            <input type="radio" id="rating5" name="rating" value="5" required>
                            <label for="rating5"><i class="fas fa-star"></i></label>
                            <input type="radio" id="rating4" name="rating" value="4">
                            <label for="rating4"><i class="fas fa-star"></i></label>
                            <input type="radio" id="rating3" name="rating" value="3">
                            <label for="rating3"><i class="fas fa-star"></i></label>
                            <input type="radio" id="rating2" name="rating" value="2">
                            <label for="rating2"><i class="fas fa-star"></i></label>
                            <input type="radio" id="rating1" name="rating" value="1">
                            <label for="rating1"><i class="fas fa-star"></i></label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="title" class="form-label">Review Title</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Give your review a title">
                    </div>

                    <div class="form-group">
                        <label for="comment" class="form-label">Your Review *</label>
                        <textarea class="form-control" id="comment" name="comment" rows="5" required placeholder="Share your experience with this product..."></textarea>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="pros" class="form-label">What you liked</label>
                                <textarea class="form-control" id="pros" name="pros" rows="3" placeholder="Pros..."></textarea>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="cons" class="form-label">What could be better</label>
                                <textarea class="form-control" id="cons" name="cons" rows="3" placeholder="Cons..."></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="isRecommended" name="isRecommended" value="true" checked>
                            <label class="form-check-label" for="isRecommended">
                                I recommend this product
                            </label>
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-submit">
                            <i class="fas fa-paper-plane"></i> Submit Review
                        </button>
                    </div>
                </form>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

