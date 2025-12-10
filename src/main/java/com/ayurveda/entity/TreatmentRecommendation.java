package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "treatment_recommendations")
public class TreatmentRecommendation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consultation_id", nullable = false)
    private Consultation consultation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id")
    private Hospital hospital;

    // Treatment Details
    @Enumerated(EnumType.STRING)
    private TreatmentType treatmentType;

    private String treatmentName; // e.g., "Panchakarma", "Abhyanga", "Shirodhara"

    @Column(columnDefinition = "TEXT")
    private String description;

    private Integer numberOfSessions; // Total sessions recommended

    private Integer sessionDurationMinutes; // Duration per session

    private Integer sessionsPerWeek; // How many sessions per week

    private LocalDate startDate;
    private LocalDate endDate;

    @Column(columnDefinition = "TEXT")
    private String treatmentPlan; // Detailed treatment plan

    @Column(columnDefinition = "TEXT")
    private String expectedBenefits; // Expected outcomes

    @Column(columnDefinition = "TEXT")
    private String precautions; // Precautions during treatment

    // Status
    @Enumerated(EnumType.STRING)
    private RecommendationStatus status = RecommendationStatus.RECOMMENDED;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public TreatmentRecommendation() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (status == null) {
            status = RecommendationStatus.RECOMMENDED;
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Consultation getConsultation() { return consultation; }
    public void setConsultation(Consultation consultation) { this.consultation = consultation; }

    public Doctor getDoctor() { return doctor; }
    public void setDoctor(Doctor doctor) { this.doctor = doctor; }

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public TreatmentType getTreatmentType() { return treatmentType; }
    public void setTreatmentType(TreatmentType treatmentType) { this.treatmentType = treatmentType; }

    public String getTreatmentName() { return treatmentName; }
    public void setTreatmentName(String treatmentName) { this.treatmentName = treatmentName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Integer getNumberOfSessions() { return numberOfSessions; }
    public void setNumberOfSessions(Integer numberOfSessions) { this.numberOfSessions = numberOfSessions; }

    public Integer getSessionDurationMinutes() { return sessionDurationMinutes; }
    public void setSessionDurationMinutes(Integer sessionDurationMinutes) { this.sessionDurationMinutes = sessionDurationMinutes; }

    public Integer getSessionsPerWeek() { return sessionsPerWeek; }
    public void setSessionsPerWeek(Integer sessionsPerWeek) { this.sessionsPerWeek = sessionsPerWeek; }

    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }

    public String getTreatmentPlan() { return treatmentPlan; }
    public void setTreatmentPlan(String treatmentPlan) { this.treatmentPlan = treatmentPlan; }

    public String getExpectedBenefits() { return expectedBenefits; }
    public void setExpectedBenefits(String expectedBenefits) { this.expectedBenefits = expectedBenefits; }

    public String getPrecautions() { return precautions; }
    public void setPrecautions(String precautions) { this.precautions = precautions; }

    public RecommendationStatus getStatus() { return status; }
    public void setStatus(RecommendationStatus status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public enum TreatmentType {
        PANCHAKARMA,
        ABHYANGA,           // Oil massage
        SHIRODHARA,         // Oil pouring on forehead
        BASTI,              // Enema therapy
        UDWARTHANA,         // Dry powder massage
        NASYA,              // Nasal therapy
        RAKTAMOKSHANA,      // Bloodletting
        SWEDANA,            // Sweating therapy
        KATI_BASTI,         // Lower back treatment
        NETRA_TARPANA,      // Eye treatment
        WELLNESS_PROGRAM,
        DETOX_PROGRAM,
        REJUVENATION,       // Rasayana therapy
        IMMUNITY_BOOST,
        OTHER
    }

    public enum RecommendationStatus {
        RECOMMENDED,        // Doctor recommended
        ACCEPTED,           // Patient accepted
        IN_PROGRESS,        // Treatment ongoing
        COMPLETED,          // Treatment completed
        DECLINED            // Patient declined
    }
}

