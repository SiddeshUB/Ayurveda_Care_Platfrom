package com.ayurveda.service;

import com.ayurveda.entity.Product;
import com.ayurveda.entity.ProductOrder;
import com.ayurveda.entity.ProductReview;
import com.ayurveda.entity.ProductReview.ReviewStatus;
import com.ayurveda.entity.User;
import com.ayurveda.repository.ProductReviewRepository;
import com.ayurveda.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class ProductReviewService {

    @Autowired
    private ProductReviewRepository reviewRepository;

    @Autowired
    private ProductRepository productRepository;

    // ==================== Create Review ====================

    public ProductReview createReview(User user, Long productId, ProductReview reviewData, Long orderId) {
        // Check if user already reviewed this product
        if (reviewRepository.existsByProductIdAndUserId(productId, user.getId())) {
            throw new RuntimeException("You have already reviewed this product");
        }

        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        ProductReview review = new ProductReview();
        review.setUser(user);
        review.setProduct(product);
        review.setRating(reviewData.getRating());
        review.setTitle(reviewData.getTitle());
        review.setComment(reviewData.getComment());
        review.setPros(reviewData.getPros());
        review.setCons(reviewData.getCons());
        review.setIsRecommended(reviewData.getIsRecommended());
        review.setImageUrls(reviewData.getImageUrls());
        review.setStatus(ReviewStatus.PENDING);

        // Check if verified purchase
        if (orderId != null) {
            review.setIsVerifiedPurchase(true);
        }

        ProductReview savedReview = reviewRepository.save(review);

        // Update product rating
        updateProductRating(productId);

        return savedReview;
    }

    // ==================== Update Review ====================

    public ProductReview updateReview(Long reviewId, Long userId, ProductReview reviewData) {
        ProductReview review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));

        // Verify user ownership
        if (!review.getUser().getId().equals(userId)) {
            throw new RuntimeException("Unauthorized");
        }

        review.setRating(reviewData.getRating());
        review.setTitle(reviewData.getTitle());
        review.setComment(reviewData.getComment());
        review.setPros(reviewData.getPros());
        review.setCons(reviewData.getCons());
        review.setIsRecommended(reviewData.getIsRecommended());
        review.setImageUrls(reviewData.getImageUrls());

        // Reset to pending if edited
        review.setStatus(ReviewStatus.PENDING);

        ProductReview savedReview = reviewRepository.save(review);

        // Update product rating
        updateProductRating(review.getProduct().getId());

        return savedReview;
    }

    // ==================== Delete Review ====================

    public void deleteReview(Long reviewId, Long userId) {
        ProductReview review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));

        // Verify user ownership
        if (!review.getUser().getId().equals(userId)) {
            throw new RuntimeException("Unauthorized");
        }

        Long productId = review.getProduct().getId();
        reviewRepository.delete(review);

        // Update product rating
        updateProductRating(productId);
    }

    // ==================== Get Reviews ====================

    public List<ProductReview> getProductReviews(Long productId) {
        return reviewRepository.findByProductIdAndStatusOrderByCreatedAtDesc(productId, ReviewStatus.APPROVED);
    }
    
    public List<ProductReview> getAllProductReviewsByProduct(Long productId) {
        return reviewRepository.findByProductIdOrderByCreatedAtDesc(productId);
    }

    public Page<ProductReview> getProductReviews(Long productId, Pageable pageable) {
        return reviewRepository.findByProductIdAndStatus(productId, ReviewStatus.APPROVED, pageable);
    }

    public List<ProductReview> getVerifiedReviews(Long productId) {
        return reviewRepository.findByProductIdAndStatusAndIsVerifiedPurchaseTrueOrderByCreatedAtDesc(
                productId, ReviewStatus.APPROVED);
    }

    public List<ProductReview> getUserReviews(Long userId) {
        return reviewRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }
    
    public List<ProductReview> getAllProductReviews() {
        return reviewRepository.findAllByOrderByCreatedAtDesc();
    }

    public Optional<ProductReview> getUserReviewForProduct(Long productId, Long userId) {
        return reviewRepository.findByProductIdAndUserId(productId, userId);
    }

    public boolean hasUserReviewed(Long productId, Long userId) {
        return reviewRepository.existsByProductIdAndUserId(productId, userId);
    }

    // ==================== Vendor Reviews ====================

    public Page<ProductReview> getVendorReviews(Long vendorId, Pageable pageable) {
        return reviewRepository.findByVendorId(vendorId, pageable);
    }

    public void addVendorResponse(Long reviewId, Long vendorId, String response) {
        ProductReview review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));

        // Verify vendor ownership
        if (!review.getProduct().getVendor().getId().equals(vendorId)) {
            throw new RuntimeException("Unauthorized");
        }

        review.setVendorResponse(response);
        review.setVendorRespondedAt(LocalDateTime.now());
        reviewRepository.save(review);
    }

    // ==================== Admin Moderation ====================

    public ProductReview approveReview(Long reviewId, String adminId) {
        ProductReview review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));

        review.setStatus(ReviewStatus.APPROVED);
        review.setModeratedAt(LocalDateTime.now());
        review.setModeratedBy(adminId);

        ProductReview savedReview = reviewRepository.save(review);

        // Update product rating
        updateProductRating(review.getProduct().getId());

        return savedReview;
    }

    public ProductReview rejectReview(Long reviewId, String reason, String adminId) {
        ProductReview review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));

        review.setStatus(ReviewStatus.REJECTED);
        review.setModerationNotes(reason);
        review.setModeratedAt(LocalDateTime.now());
        review.setModeratedBy(adminId);

        return reviewRepository.save(review);
    }

    public List<ProductReview> getPendingReviews() {
        return reviewRepository.findByProductIdAndStatusOrderByCreatedAtDesc(null, ReviewStatus.PENDING);
    }

    public long countPendingReviews() {
        return reviewRepository.countPendingReviews();
    }

    // ==================== Rating Statistics ====================

    public void updateProductRating(Long productId) {
        Double avgRating = reviewRepository.getAverageRatingByProductId(productId);
        long reviewCount = reviewRepository.countByProductIdAndStatus(productId, ReviewStatus.APPROVED);

        Product product = productRepository.findById(productId).orElse(null);
        if (product != null) {
            product.setAverageRating(avgRating != null ? avgRating : 0.0);
            product.setTotalReviews((int) reviewCount);
            productRepository.save(product);
        }
    }

    public Map<Integer, Long> getRatingDistribution(Long productId) {
        List<Object[]> distribution = reviewRepository.getRatingDistribution(productId);
        Map<Integer, Long> result = new HashMap<>();

        // Initialize all ratings with 0
        for (int i = 1; i <= 5; i++) {
            result.put(i, 0L);
        }

        // Fill in actual counts
        for (Object[] row : distribution) {
            Integer rating = (Integer) row[0];
            Long count = (Long) row[1];
            result.put(rating, count);
        }

        return result;
    }

    // ==================== Helpful Votes ====================

    public void markHelpful(Long reviewId) {
        ProductReview review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));
        review.setHelpfulCount(review.getHelpfulCount() + 1);
        reviewRepository.save(review);
    }

    public void markNotHelpful(Long reviewId) {
        ProductReview review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));
        review.setNotHelpfulCount(review.getNotHelpfulCount() + 1);
        reviewRepository.save(review);
    }
}

