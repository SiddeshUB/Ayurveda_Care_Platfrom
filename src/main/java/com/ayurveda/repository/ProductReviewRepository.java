package com.ayurveda.repository;

import com.ayurveda.entity.ProductReview;
import com.ayurveda.entity.ProductReview.ReviewStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProductReviewRepository extends JpaRepository<ProductReview, Long> {

    // Find reviews by product
    List<ProductReview> findByProductIdAndStatusOrderByCreatedAtDesc(Long productId, ReviewStatus status);

    Page<ProductReview> findByProductIdAndStatus(Long productId, ReviewStatus status, Pageable pageable);

    // Find reviews by user
    List<ProductReview> findByUserIdOrderByCreatedAtDesc(Long userId);

    // Check if user already reviewed a product
    Optional<ProductReview> findByProductIdAndUserId(Long productId, Long userId);

    boolean existsByProductIdAndUserId(Long productId, Long userId);

    // Find reviews by vendor (all products of vendor)
    @Query("SELECT r FROM ProductReview r WHERE r.product.vendor.id = :vendorId ORDER BY r.createdAt DESC")
    Page<ProductReview> findByVendorId(@Param("vendorId") Long vendorId, Pageable pageable);

    // Count by status
    long countByStatus(ReviewStatus status);

    long countByProductIdAndStatus(Long productId, ReviewStatus status);

    // Average rating for product
    @Query("SELECT AVG(r.rating) FROM ProductReview r WHERE r.product.id = :productId AND r.status = 'APPROVED'")
    Double getAverageRatingByProductId(@Param("productId") Long productId);

    // Rating distribution for product
    @Query("SELECT r.rating, COUNT(r) FROM ProductReview r WHERE r.product.id = :productId AND r.status = 'APPROVED' GROUP BY r.rating ORDER BY r.rating DESC")
    List<Object[]> getRatingDistribution(@Param("productId") Long productId);

    // Pending reviews count
    @Query("SELECT COUNT(r) FROM ProductReview r WHERE r.status = 'PENDING'")
    long countPendingReviews();

    // Verified purchase reviews
    List<ProductReview> findByProductIdAndStatusAndIsVerifiedPurchaseTrueOrderByCreatedAtDesc(Long productId, ReviewStatus status);
}

