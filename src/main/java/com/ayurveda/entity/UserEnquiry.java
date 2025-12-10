package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "user_enquiries")
public class UserEnquiry {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String enquiryNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id", nullable = false)
    private Hospital hospital;

    // User Information (can be from user account or filled manually)
    private String name;
    private String email;
    private String phone;
    private String country;

    // Enquiry Details
    private LocalDate preferredStartDate;
    private LocalDate preferredEndDate;
    
    @Column(name = "medical_condition", columnDefinition = "TEXT")
    private String condition; // Medical condition
    
    @Column(columnDefinition = "TEXT")
    private String therapyRequired; // Therapy required
    
    @Column(columnDefinition = "TEXT")
    private String message; // Additional message

    // Status
    @Enumerated(EnumType.STRING)
    private EnquiryStatus status = EnquiryStatus.PENDING;

    // Hospital Response
    @Column(columnDefinition = "TEXT")
    private String hospitalReply;

    @Column(columnDefinition = "TEXT")
    private String quotation; // Quotation sent by hospital

    private LocalDateTime repliedAt;
    private LocalDateTime closedAt;

    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public UserEnquiry() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (enquiryNumber == null) {
            enquiryNumber = "ENQ" + System.currentTimeMillis();
        }
        if (status == null) {
            status = EnquiryStatus.PENDING;
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getEnquiryNumber() { return enquiryNumber; }
    public void setEnquiryNumber(String enquiryNumber) { this.enquiryNumber = enquiryNumber; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

    public LocalDate getPreferredStartDate() { return preferredStartDate; }
    public void setPreferredStartDate(LocalDate preferredStartDate) { this.preferredStartDate = preferredStartDate; }

    public LocalDate getPreferredEndDate() { return preferredEndDate; }
    public void setPreferredEndDate(LocalDate preferredEndDate) { this.preferredEndDate = preferredEndDate; }

    public String getCondition() { return condition; }
    public void setCondition(String condition) { this.condition = condition; }

    public String getTherapyRequired() { return therapyRequired; }
    public void setTherapyRequired(String therapyRequired) { this.therapyRequired = therapyRequired; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public EnquiryStatus getStatus() { return status; }
    public void setStatus(EnquiryStatus status) { this.status = status; }

    public String getHospitalReply() { return hospitalReply; }
    public void setHospitalReply(String hospitalReply) { this.hospitalReply = hospitalReply; }

    public String getQuotation() { return quotation; }
    public void setQuotation(String quotation) { this.quotation = quotation; }

    public LocalDateTime getRepliedAt() { return repliedAt; }
    public void setRepliedAt(LocalDateTime repliedAt) { this.repliedAt = repliedAt; }

    public LocalDateTime getClosedAt() { return closedAt; }
    public void setClosedAt(LocalDateTime closedAt) { this.closedAt = closedAt; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public enum EnquiryStatus {
        PENDING,        // Waiting for hospital response
        REPLIED,        // Hospital has replied
        QUOTATION_SENT, // Hospital sent quotation
        CLOSED,         // Enquiry closed
        CANCELLED       // User cancelled
    }
}

