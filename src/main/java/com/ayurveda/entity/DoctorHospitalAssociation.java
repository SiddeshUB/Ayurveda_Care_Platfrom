package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "doctor_hospital_associations")
public class DoctorHospitalAssociation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id", nullable = false)
    private Hospital hospital;

    @Enumerated(EnumType.STRING)
    private AssociationStatus status = AssociationStatus.PENDING;

    // Availability settings specific to this hospital
    private String consultationDays; // e.g., "Monday, Wednesday, Friday"
    private String consultationTimings; // e.g., "9:00 AM - 1:00 PM"
    private String availableLocations; // OPD, Online, Home Visit

    // Doctor's role/designation at this hospital
    private String designation; // e.g., "Senior Consultant", "Chief Ayurvedic Physician"

    @Column(columnDefinition = "TEXT")
    private String hospitalNotes; // Notes from hospital about this doctor

    @Column(columnDefinition = "TEXT")
    private String requestMessage; // Message from doctor when requesting association

    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
    private LocalDateTime approvedAt;
    private LocalDateTime rejectedAt;

    public DoctorHospitalAssociation() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (status == null) {
            status = AssociationStatus.PENDING;
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

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public AssociationStatus getStatus() { return status; }
    public void setStatus(AssociationStatus status) { this.status = status; }

    public String getConsultationDays() { return consultationDays; }
    public void setConsultationDays(String consultationDays) { this.consultationDays = consultationDays; }

    public String getConsultationTimings() { return consultationTimings; }
    public void setConsultationTimings(String consultationTimings) { this.consultationTimings = consultationTimings; }

    public String getAvailableLocations() { return availableLocations; }
    public void setAvailableLocations(String availableLocations) { this.availableLocations = availableLocations; }

    public String getDesignation() { return designation; }
    public void setDesignation(String designation) { this.designation = designation; }

    public String getHospitalNotes() { return hospitalNotes; }
    public void setHospitalNotes(String hospitalNotes) { this.hospitalNotes = hospitalNotes; }

    public String getRequestMessage() { return requestMessage; }
    public void setRequestMessage(String requestMessage) { this.requestMessage = requestMessage; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public LocalDateTime getApprovedAt() { return approvedAt; }
    public void setApprovedAt(LocalDateTime approvedAt) { this.approvedAt = approvedAt; }

    public LocalDateTime getRejectedAt() { return rejectedAt; }
    public void setRejectedAt(LocalDateTime rejectedAt) { this.rejectedAt = rejectedAt; }

    public enum AssociationStatus {
        PENDING,    // Doctor has requested association
        APPROVED,   // Hospital has approved
        REJECTED,   // Hospital has rejected
        SUSPENDED   // Association suspended by hospital
    }
}

