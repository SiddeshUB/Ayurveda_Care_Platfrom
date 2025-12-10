package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "vendor_documents")
public class VendorDocument {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id", nullable = false)
    private Vendor vendor;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DocumentType documentType;

    @Column(nullable = false)
    private String documentName; // Original file name

    @Column(nullable = false)
    private String documentUrl; // Stored file path/URL

    private String fileType; // PDF, JPG, PNG, etc.

    private Long fileSize; // In bytes

    @Enumerated(EnumType.STRING)
    private VerificationStatus verificationStatus = VerificationStatus.PENDING;

    private String verificationNotes; // Admin notes during verification

    private LocalDateTime verifiedAt;

    private String verifiedBy; // Admin who verified

    @Column(updatable = false)
    private LocalDateTime uploadedAt;

    public VendorDocument() {}

    @PrePersist
    protected void onCreate() {
        uploadedAt = LocalDateTime.now();
        if (verificationStatus == null) verificationStatus = VerificationStatus.PENDING;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Vendor getVendor() { return vendor; }
    public void setVendor(Vendor vendor) { this.vendor = vendor; }

    public DocumentType getDocumentType() { return documentType; }
    public void setDocumentType(DocumentType documentType) { this.documentType = documentType; }

    public String getDocumentName() { return documentName; }
    public void setDocumentName(String documentName) { this.documentName = documentName; }

    public String getDocumentUrl() { return documentUrl; }
    public void setDocumentUrl(String documentUrl) { this.documentUrl = documentUrl; }

    public String getFileType() { return fileType; }
    public void setFileType(String fileType) { this.fileType = fileType; }

    public Long getFileSize() { return fileSize; }
    public void setFileSize(Long fileSize) { this.fileSize = fileSize; }

    public VerificationStatus getVerificationStatus() { return verificationStatus; }
    public void setVerificationStatus(VerificationStatus verificationStatus) { this.verificationStatus = verificationStatus; }

    public String getVerificationNotes() { return verificationNotes; }
    public void setVerificationNotes(String verificationNotes) { this.verificationNotes = verificationNotes; }

    public LocalDateTime getVerifiedAt() { return verifiedAt; }
    public void setVerifiedAt(LocalDateTime verifiedAt) { this.verifiedAt = verifiedAt; }

    public String getVerifiedBy() { return verifiedBy; }
    public void setVerifiedBy(String verifiedBy) { this.verifiedBy = verifiedBy; }

    public LocalDateTime getUploadedAt() { return uploadedAt; }
    public void setUploadedAt(LocalDateTime uploadedAt) { this.uploadedAt = uploadedAt; }

    // Enums
    public enum DocumentType {
        PAN_CARD("PAN Card"),
        GST_CERTIFICATE("GST Certificate"),
        BUSINESS_REGISTRATION("Business Registration Certificate"),
        ADDRESS_PROOF("Address Proof"),
        ID_PROOF("ID Proof (Aadhaar/Passport/DL)"),
        CANCELLED_CHEQUE("Cancelled Cheque"),
        BANK_STATEMENT("Bank Statement"),
        FSSAI_CERTIFICATE("FSSAI Certificate"),
        AYUSH_LICENSE("Ayush License"),
        DRUG_LICENSE("Drug License"),
        OTHER("Other");

        private final String displayName;

        DocumentType(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    public enum VerificationStatus {
        PENDING("Pending"),
        VERIFIED("Verified"),
        REJECTED("Rejected");

        private final String displayName;

        VerificationStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }
}

