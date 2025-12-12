package com.ayurveda.repository;

import com.ayurveda.entity.DoctorReview;
import com.ayurveda.entity.DoctorReview.ReviewStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DoctorReviewRepository extends JpaRepository<DoctorReview, Long> {
    
    List<DoctorReview> findByDoctorId(Long doctorId);
    
    List<DoctorReview> findByDoctorIdAndStatus(Long doctorId, ReviewStatus status);
    
    List<DoctorReview> findByConsultationId(Long consultationId);
    
    List<DoctorReview> findByHospitalId(Long hospitalId);
    
    @Query("SELECT AVG(r.rating) FROM DoctorReview r WHERE r.doctor.id = :doctorId AND r.status = 'APPROVED'")
    Double getAverageRatingByDoctorId(@Param("doctorId") Long doctorId);
    
    @Query("SELECT COUNT(r) FROM DoctorReview r WHERE r.doctor.id = :doctorId AND r.status = 'APPROVED'")
    Long getReviewCountByDoctorId(@Param("doctorId") Long doctorId);
    
    @Query("SELECT COUNT(r) FROM DoctorReview r WHERE r.doctor.id = :doctorId AND r.rating = :rating AND r.status = 'APPROVED'")
    Long getRatingCountByDoctorIdAndRating(@Param("doctorId") Long doctorId, @Param("rating") Integer rating);
    
    List<DoctorReview> findAllByOrderByCreatedAtDesc();
}

