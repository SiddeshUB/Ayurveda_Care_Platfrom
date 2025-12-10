package com.ayurveda.entity;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Entity
@Table(name = "consultations")
public class Consultation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String consultationNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id")
    private Hospital hospital;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user; // User who booked this consultation (for direct bookings)

    // Patient Information
    private String patientName;
    private String patientEmail;
    private String patientPhone;
    private Integer patientAge;
    private String patientGender;
    
    // Health Details (for doctor reference)
    private String patientHeight; // e.g., "170 cm" or "5'7\""
    private String patientWeight; // e.g., "70 kg" or "154 lbs"
    private String bloodPressure; // e.g., "120/80"
    private String allergies; // Comma-separated or text

    // Consultation Details
    @Enumerated(EnumType.STRING)
    private ConsultationType consultationType; // ONLINE, OFFLINE, HOME_VISIT

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate consultationDate;
    
    @DateTimeFormat(pattern = "HH:mm")
    private LocalTime consultationTime;
    private Integer durationMinutes; // 30, 60, 90, etc.

    @Column(columnDefinition = "TEXT")
    private String reasonForVisit;

    @Column(columnDefinition = "TEXT")
    private String symptoms;

    @Column(columnDefinition = "TEXT")
    private String medicalHistory;

    @Column(columnDefinition = "TEXT")
    private String currentMedications;

    // Consultation Status
    @Enumerated(EnumType.STRING)
    private ConsultationStatus status = ConsultationStatus.PENDING;

    // Payment
    private BigDecimal consultationFee;
    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus;

    // Consultation Notes
    @Column(columnDefinition = "TEXT")
    private String doctorNotes;

    @Column(columnDefinition = "TEXT")
    private String prescriptionNotes;

    // Follow-up
    private LocalDate followUpDate;
    private Boolean requiresFollowUp;

    // Video Consultation (if online)
    private String videoCallLink;
    private String meetingId;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
    private LocalDateTime confirmedAt;
    private LocalDateTime completedAt;
    private LocalDateTime cancelledAt;

    private String cancellationReason;

    public Consultation() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (consultationNumber == null) {
            consultationNumber = "CN" + System.currentTimeMillis();
        }
        if (status == null) {
            status = ConsultationStatus.PENDING;
        }
        if (paymentStatus == null) {
            paymentStatus = PaymentStatus.PENDING;
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getConsultationNumber() { return consultationNumber; }
    public void setConsultationNumber(String consultationNumber) { this.consultationNumber = consultationNumber; }

    public Doctor getDoctor() { return doctor; }
    public void setDoctor(Doctor doctor) { this.doctor = doctor; }

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getPatientEmail() { return patientEmail; }
    public void setPatientEmail(String patientEmail) { this.patientEmail = patientEmail; }

    public String getPatientPhone() { return patientPhone; }
    public void setPatientPhone(String patientPhone) { this.patientPhone = patientPhone; }

    public Integer getPatientAge() { return patientAge; }
    public void setPatientAge(Integer patientAge) { this.patientAge = patientAge; }

    public String getPatientGender() { return patientGender; }
    public void setPatientGender(String patientGender) { this.patientGender = patientGender; }

    public ConsultationType getConsultationType() { return consultationType; }
    public void setConsultationType(ConsultationType consultationType) { this.consultationType = consultationType; }

    public LocalDate getConsultationDate() { return consultationDate; }
    public void setConsultationDate(LocalDate consultationDate) { this.consultationDate = consultationDate; }

    public LocalTime getConsultationTime() { return consultationTime; }
    public void setConsultationTime(LocalTime consultationTime) { this.consultationTime = consultationTime; }

    public Integer getDurationMinutes() { return durationMinutes; }
    public void setDurationMinutes(Integer durationMinutes) { this.durationMinutes = durationMinutes; }

    public String getReasonForVisit() { return reasonForVisit; }
    public void setReasonForVisit(String reasonForVisit) { this.reasonForVisit = reasonForVisit; }

    public String getSymptoms() { return symptoms; }
    public void setSymptoms(String symptoms) { this.symptoms = symptoms; }

    public String getMedicalHistory() { return medicalHistory; }
    public void setMedicalHistory(String medicalHistory) { this.medicalHistory = medicalHistory; }

    public String getCurrentMedications() { return currentMedications; }
    public void setCurrentMedications(String currentMedications) { this.currentMedications = currentMedications; }

    public ConsultationStatus getStatus() { return status; }
    public void setStatus(ConsultationStatus status) { this.status = status; }

    public BigDecimal getConsultationFee() { return consultationFee; }
    public void setConsultationFee(BigDecimal consultationFee) { this.consultationFee = consultationFee; }

    public PaymentStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; }

    public String getDoctorNotes() { return doctorNotes; }
    public void setDoctorNotes(String doctorNotes) { this.doctorNotes = doctorNotes; }

    public String getPrescriptionNotes() { return prescriptionNotes; }
    public void setPrescriptionNotes(String prescriptionNotes) { this.prescriptionNotes = prescriptionNotes; }

    public LocalDate getFollowUpDate() { return followUpDate; }
    public void setFollowUpDate(LocalDate followUpDate) { this.followUpDate = followUpDate; }

    public Boolean getRequiresFollowUp() { return requiresFollowUp; }
    public void setRequiresFollowUp(Boolean requiresFollowUp) { this.requiresFollowUp = requiresFollowUp; }

    public String getVideoCallLink() { return videoCallLink; }
    public void setVideoCallLink(String videoCallLink) { this.videoCallLink = videoCallLink; }

    public String getMeetingId() { return meetingId; }
    public void setMeetingId(String meetingId) { this.meetingId = meetingId; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public LocalDateTime getConfirmedAt() { return confirmedAt; }
    public void setConfirmedAt(LocalDateTime confirmedAt) { this.confirmedAt = confirmedAt; }

    public LocalDateTime getCompletedAt() { return completedAt; }
    public void setCompletedAt(LocalDateTime completedAt) { this.completedAt = completedAt; }

    public LocalDateTime getCancelledAt() { return cancelledAt; }
    public void setCancelledAt(LocalDateTime cancelledAt) { this.cancelledAt = cancelledAt; }

    public String getCancellationReason() { return cancellationReason; }
    public void setCancellationReason(String cancellationReason) { this.cancellationReason = cancellationReason; }

    public String getPatientHeight() { return patientHeight; }
    public void setPatientHeight(String patientHeight) { this.patientHeight = patientHeight; }

    public String getPatientWeight() { return patientWeight; }
    public void setPatientWeight(String patientWeight) { this.patientWeight = patientWeight; }

    public String getBloodPressure() { return bloodPressure; }
    public void setBloodPressure(String bloodPressure) { this.bloodPressure = bloodPressure; }

    public String getAllergies() { return allergies; }
    public void setAllergies(String allergies) { this.allergies = allergies; }

    public enum ConsultationType {
        ONLINE, IN_PERSON, HOME_VISIT
    }

    public enum ConsultationStatus {
        PENDING, CONFIRMED, COMPLETED, CANCELLED, NO_SHOW, RESCHEDULED
    }

    public enum PaymentStatus {
        PENDING, PAID, REFUNDED
    }
}

