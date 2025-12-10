package com.ayurveda.service;

import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.Review;
import com.ayurveda.repository.HospitalRepository;
import com.ayurveda.repository.ReviewRepository;
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
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final HospitalRepository hospitalRepository;

    @Autowired
    public ReviewService(ReviewRepository reviewRepository,
                        HospitalRepository hospitalRepository) {
        this.reviewRepository = reviewRepository;
        this.hospitalRepository = hospitalRepository;
    }

    public List<Review> getReviewsByHospital(Long hospitalId) {
        return reviewRepository.findByHospitalIdOrderByCreatedAtDesc(hospitalId);
    }

    public Page<Review> getPublicReviews(Long hospitalId, Pageable pageable) {
        return reviewRepository.findByHospitalIdAndIsVisibleTrue(hospitalId, pageable);
    }

    public List<Review> getFeaturedReviews(Long hospitalId) {
        return reviewRepository.findFeaturedReviews(hospitalId);
    }

    public Optional<Review> findById(Long id) {
        return reviewRepository.findById(id);
    }

    @Transactional
    public Review createReview(Long hospitalId, Review review) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        review.setHospital(hospital);
        review.setIsVerified(false);
        review.setIsVisible(true);
        
        Review savedReview = reviewRepository.save(review);
        
        // Update hospital rating
        updateHospitalRating(hospitalId);
        
        return savedReview;
    }

    @Transactional
    public Review addHospitalResponse(Long reviewId, String response) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));
        
        review.setHospitalResponse(response);
        review.setResponseDate(LocalDateTime.now());
        
        return reviewRepository.save(review);
    }

    @Transactional
    public void toggleVisibility(Long reviewId) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));
        review.setIsVisible(!review.getIsVisible());
        reviewRepository.save(review);
    }

    @Transactional
    public void toggleFeatured(Long reviewId) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));
        review.setIsFeatured(!review.getIsFeatured());
        reviewRepository.save(review);
    }

    public Map<String, Object> getRatingBreakdown(Long hospitalId) {
        Map<String, Object> breakdown = new HashMap<>();
        
        Double avgRating = reviewRepository.getAverageRating(hospitalId);
        Long totalReviews = reviewRepository.countByHospitalId(hospitalId);
        
        breakdown.put("averageRating", avgRating != null ? avgRating : 0.0);
        breakdown.put("totalReviews", totalReviews);
        
        // Count by rating
        for (int i = 1; i <= 5; i++) {
            Long count = reviewRepository.countByHospitalIdAndRating(hospitalId, i);
            breakdown.put("rating" + i, count);
        }
        
        return breakdown;
    }

    @Transactional
    public void updateHospitalRating(Long hospitalId) {
        Double avgRating = reviewRepository.getAverageRating(hospitalId);
        Long totalReviews = reviewRepository.countByHospitalId(hospitalId);
        
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        hospital.setAverageRating(avgRating != null ? avgRating : 0.0);
        hospital.setTotalReviews(totalReviews != null ? totalReviews.intValue() : 0);
        
        hospitalRepository.save(hospital);
    }
}
