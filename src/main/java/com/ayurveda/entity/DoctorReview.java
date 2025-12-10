package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "doctor_reviews")
public class DoctorReview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consultation_id")
    private Consultation consultation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id")
    private Hospital hospital;

    // Reviewer Information
    private String reviewerName;
    private String reviewerEmail;
    private String reviewerPhone;

    // Rating (1-5 stars)
    @Column(nullable = false)
    private Integer rating; // 1 to 5

    // Review Details
    @Column(columnDefinition = "TEXT")
    private String reviewText;

    // Rating Breakdown (Optional detailed ratings)
    private Integer treatmentRating; // Treatment effectiveness (1-5)
    private Integer communicationRating; // Doctor's communication (1-5)
    private Integer punctualityRating; // Punctuality (1-5)
    private Integer cleanlinessRating; // Clinic/hospital cleanliness (1-5)
    private Integer valueRating; // Value for money (1-5)

    // Review Status
    @Enumerated(EnumType.STRING)
    private ReviewStatus status = ReviewStatus.PENDING;

    // Verification
    private Boolean isVerified; // Verified patient
    private Boolean isAnonymous; // Anonymous review

    // Helpful Count (for future feature)
    private Integer helpfulCount = 0;

    // Doctor Response
    @Column(columnDefinition = "TEXT")
    private String doctorResponse;

    private LocalDateTime doctorResponseDate;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
    private LocalDateTime publishedAt;

    public DoctorReview() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (status == null) {
            status = ReviewStatus.PENDING;
        }
        if (helpfulCount == null) {
            helpfulCount = 0;
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Doctor getDoctor() { return doctor; }
    public void setDoctor(Doctor doctor) { this.doctor = doctor; }

    public Consultation getConsultation() { return consultation; }
    public void setConsultation(Consultation consultation) { this.consultation = consultation; }

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public String getReviewerName() { return reviewerName; }
    public void setReviewerName(String reviewerName) { this.reviewerName = reviewerName; }

    public String getReviewerEmail() { return reviewerEmail; }
    public void setReviewerEmail(String reviewerEmail) { this.reviewerEmail = reviewerEmail; }

    public String getReviewerPhone() { return reviewerPhone; }
    public void setReviewerPhone(String reviewerPhone) { this.reviewerPhone = reviewerPhone; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }

    public String getReviewText() { return reviewText; }
    public void setReviewText(String reviewText) { this.reviewText = reviewText; }

    public Integer getTreatmentRating() { return treatmentRating; }
    public void setTreatmentRating(Integer treatmentRating) { this.treatmentRating = treatmentRating; }

    public Integer getCommunicationRating() { return communicationRating; }
    public void setCommunicationRating(Integer communicationRating) { this.communicationRating = communicationRating; }

    public Integer getPunctualityRating() { return punctualityRating; }
    public void setPunctualityRating(Integer punctualityRating) { this.punctualityRating = punctualityRating; }

    public Integer getCleanlinessRating() { return cleanlinessRating; }
    public void setCleanlinessRating(Integer cleanlinessRating) { this.cleanlinessRating = cleanlinessRating; }

    public Integer getValueRating() { return valueRating; }
    public void setValueRating(Integer valueRating) { this.valueRating = valueRating; }

    public ReviewStatus getStatus() { return status; }
    public void setStatus(ReviewStatus status) { this.status = status; }

    public Boolean getIsVerified() { return isVerified; }
    public void setIsVerified(Boolean isVerified) { this.isVerified = isVerified; }

    public Boolean getIsAnonymous() { return isAnonymous; }
    public void setIsAnonymous(Boolean isAnonymous) { this.isAnonymous = isAnonymous; }

    public Integer getHelpfulCount() { return helpfulCount; }
    public void setHelpfulCount(Integer helpfulCount) { this.helpfulCount = helpfulCount; }

    public String getDoctorResponse() { return doctorResponse; }
    public void setDoctorResponse(String doctorResponse) { this.doctorResponse = doctorResponse; }

    public LocalDateTime getDoctorResponseDate() { return doctorResponseDate; }
    public void setDoctorResponseDate(LocalDateTime doctorResponseDate) { this.doctorResponseDate = doctorResponseDate; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public LocalDateTime getPublishedAt() { return publishedAt; }
    public void setPublishedAt(LocalDateTime publishedAt) { this.publishedAt = publishedAt; }

    public enum ReviewStatus {
        PENDING,    // Awaiting moderation
        APPROVED,   // Published
        REJECTED,   // Rejected by admin
        HIDDEN      // Hidden by doctor/admin
    }
}

