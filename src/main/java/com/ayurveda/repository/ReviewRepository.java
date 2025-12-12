package com.ayurveda.repository;

import com.ayurveda.entity.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    
    List<Review> findByHospitalIdOrderByCreatedAtDesc(Long hospitalId);
    
    Page<Review> findByHospitalIdAndIsVisibleTrue(Long hospitalId, Pageable pageable);
    
    Long countByHospitalId(Long hospitalId);
    
    Long countByHospitalIdAndRating(Long hospitalId, Integer rating);
    
    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.hospital.id = :hospitalId")
    Double getAverageRating(@Param("hospitalId") Long hospitalId);
    
    @Query("SELECT r FROM Review r WHERE r.hospital.id = :hospitalId AND r.isFeatured = true AND r.isVisible = true ORDER BY r.createdAt DESC")
    List<Review> findFeaturedReviews(@Param("hospitalId") Long hospitalId);
    
    List<Review> findByPatientEmailOrderByCreatedAtDesc(String patientEmail);
    
    List<Review> findAllByOrderByCreatedAtDesc();
}
