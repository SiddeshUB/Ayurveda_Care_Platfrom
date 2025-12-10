package com.ayurveda.repository;

import com.ayurveda.entity.TreatmentRecommendation;
import com.ayurveda.entity.TreatmentRecommendation.RecommendationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TreatmentRecommendationRepository extends JpaRepository<TreatmentRecommendation, Long> {
    
    List<TreatmentRecommendation> findByConsultationId(Long consultationId);
    
    List<TreatmentRecommendation> findByDoctorId(Long doctorId);
    
    List<TreatmentRecommendation> findByDoctorIdAndStatus(Long doctorId, RecommendationStatus status);
    
    List<TreatmentRecommendation> findByConsultationIdOrderByCreatedAtDesc(Long consultationId);
}

