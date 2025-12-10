package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "hospital_documents")
public class HospitalDocument {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id", nullable = false)
    private Hospital hospital;

    @Column(nullable = false)
    private String documentUrl;

    private String originalFileName;

    @Enumerated(EnumType.STRING)
    private DocumentType documentType;

    private String description;

    @Enumerated(EnumType.STRING)
    private VerificationStatus verificationStatus = VerificationStatus.PENDING;

    private String verificationNotes;
    private LocalDateTime verifiedAt;

    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public HospitalDocument() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (verificationStatus == null) verificationStatus = VerificationStatus.PENDING;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public String getDocumentUrl() { return documentUrl; }
    public void setDocumentUrl(String documentUrl) { this.documentUrl = documentUrl; }

    public String getOriginalFileName() { return originalFileName; }
    public void setOriginalFileName(String originalFileName) { this.originalFileName = originalFileName; }

    public DocumentType getDocumentType() { return documentType; }
    public void setDocumentType(DocumentType documentType) { this.documentType = documentType; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public VerificationStatus getVerificationStatus() { return verificationStatus; }
    public void setVerificationStatus(VerificationStatus verificationStatus) { this.verificationStatus = verificationStatus; }

    public String getVerificationNotes() { return verificationNotes; }
    public void setVerificationNotes(String verificationNotes) { this.verificationNotes = verificationNotes; }

    public LocalDateTime getVerifiedAt() { return verifiedAt; }
    public void setVerifiedAt(LocalDateTime verifiedAt) { this.verifiedAt = verifiedAt; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public enum DocumentType {
        REGISTRATION_CERTIFICATE, MEDICAL_LICENSE, AYUSH_CERTIFICATE,
        NABH_CERTIFICATE, ISO_CERTIFICATE, DOCTOR_DEGREE,
        OWNER_ID_PROOF, OTHER
    }

    public enum VerificationStatus {
        PENDING, VERIFIED, REJECTED
    }
}
