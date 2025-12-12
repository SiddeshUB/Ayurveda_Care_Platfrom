package com.ayurveda.service;

import com.ayurveda.entity.Consultation;
import com.ayurveda.entity.Doctor;
import com.ayurveda.entity.DoctorReview;
import com.ayurveda.entity.DoctorReview.ReviewStatus;
import com.ayurveda.entity.Hospital;
import com.ayurveda.repository.ConsultationRepository;
import com.ayurveda.repository.DoctorRepository;
import com.ayurveda.repository.DoctorReviewRepository;
import com.ayurveda.repository.HospitalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class DoctorReviewService {

    private final DoctorReviewRepository reviewRepository;
    private final DoctorRepository doctorRepository;
    private final ConsultationRepository consultationRepository;
    private final HospitalRepository hospitalRepository;

    @Autowired
    public DoctorReviewService(DoctorReviewRepository reviewRepository,
                             DoctorRepository doctorRepository,
                             ConsultationRepository consultationRepository,
                             HospitalRepository hospitalRepository) {
        this.reviewRepository = reviewRepository;
        this.doctorRepository = doctorRepository;
        this.consultationRepository = consultationRepository;
        this.hospitalRepository = hospitalRepository;
    }

    // Create review
    @Transactional
    public DoctorReview createReview(Long doctorId, Long consultationId, DoctorReview review) {
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        review.setDoctor(doctor);
        review.setStatus(ReviewStatus.PENDING);
        
        if (consultationId != null) {
            Consultation consultation = consultationRepository.findById(consultationId)
                    .orElseThrow(() -> new RuntimeException("Consultation not found"));
            review.setConsultation(consultation);
            review.setHospital(consultation.getHospital());
            
            // Verify if reviewer email matches consultation patient email
            if (consultation.getPatientEmail() != null && 
                consultation.getPatientEmail().equals(review.getReviewerEmail())) {
                review.setIsVerified(true);
            }
        }
        
        return reviewRepository.save(review);
    }

    // Update review status (for moderation)
    @Transactional
    public DoctorReview updateReviewStatus(Long reviewId, ReviewStatus status) {
        DoctorReview review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));
        
        review.setStatus(status);
        if (status == ReviewStatus.APPROVED && review.getPublishedAt() == null) {
            review.setPublishedAt(LocalDateTime.now());
        }
        
        return reviewRepository.save(review);
    }

    // Doctor responds to review
    @Transactional
    public DoctorReview respondToReview(Long reviewId, String response) {
        DoctorReview review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));
        
        review.setDoctorResponse(response);
        review.setDoctorResponseDate(LocalDateTime.now());
        
        return reviewRepository.save(review);
    }

    // Get reviews by doctor
    public List<DoctorReview> getReviewsByDoctor(Long doctorId) {
        return reviewRepository.findByDoctorId(doctorId);
    }

    // Get approved reviews by doctor
    public List<DoctorReview> getApprovedReviewsByDoctor(Long doctorId) {
        return reviewRepository.findByDoctorIdAndStatus(doctorId, ReviewStatus.APPROVED);
    }

    // Get reviews by consultation
    public List<DoctorReview> getReviewsByConsultation(Long consultationId) {
        return reviewRepository.findByConsultationId(consultationId);
    }

    // Get average rating for doctor
    public Double getAverageRating(Long doctorId) {
        Double avg = reviewRepository.getAverageRatingByDoctorId(doctorId);
        return avg != null ? avg : 0.0;
    }

    // Get review count for doctor
    public Long getReviewCount(Long doctorId) {
        return reviewRepository.getReviewCountByDoctorId(doctorId);
    }

    // Get rating distribution
    public Long getRatingCount(Long doctorId, Integer rating) {
        return reviewRepository.getRatingCountByDoctorIdAndRating(doctorId, rating);
    }

    // Get review by ID
    public Optional<DoctorReview> findById(Long id) {
        return reviewRepository.findById(id);
    }

    // Delete review
    @Transactional
    public void deleteReview(Long reviewId) {
        reviewRepository.deleteById(reviewId);
    }

    // Get all reviews
    public List<DoctorReview> getAllReviews() {
        return reviewRepository.findAllByOrderByCreatedAtDesc();
    }
}

