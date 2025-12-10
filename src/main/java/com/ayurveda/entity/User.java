package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Account Information
    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    // Personal Information
    @Column(nullable = false)
    private String fullName;

    private String phone;
    private String country;
    
    @Column(columnDefinition = "TEXT")
    private String purpose; // detox, panchakarma, yoga, healing etc.

    // Profile Information
    private String city;
    private String state;
    private String address;
    private String gender;
    private LocalDateTime dateOfBirth;

    // Status
    private Boolean isActive = true;
    private Boolean emailVerified = false;

    // Password Reset
    private String passwordResetToken;
    private LocalDateTime passwordResetTokenExpiry;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
    private LocalDateTime lastLoginAt;

    // Relationships
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<SavedCenter> savedCenters;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<UserEnquiry> enquiries;

    public User() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (isActive == null) isActive = true;
        if (emailVerified == null) emailVerified = false;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

    public String getPurpose() { return purpose; }
    public void setPurpose(String purpose) { this.purpose = purpose; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public LocalDateTime getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(LocalDateTime dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public Boolean getEmailVerified() { return emailVerified; }
    public void setEmailVerified(Boolean emailVerified) { this.emailVerified = emailVerified; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public LocalDateTime getLastLoginAt() { return lastLoginAt; }
    public void setLastLoginAt(LocalDateTime lastLoginAt) { this.lastLoginAt = lastLoginAt; }

    public List<SavedCenter> getSavedCenters() { return savedCenters; }
    public void setSavedCenters(List<SavedCenter> savedCenters) { this.savedCenters = savedCenters; }

    public List<UserEnquiry> getEnquiries() { return enquiries; }
    public void setEnquiries(List<UserEnquiry> enquiries) { this.enquiries = enquiries; }

    public String getPasswordResetToken() { return passwordResetToken; }
    public void setPasswordResetToken(String passwordResetToken) { this.passwordResetToken = passwordResetToken; }

    public LocalDateTime getPasswordResetTokenExpiry() { return passwordResetTokenExpiry; }
    public void setPasswordResetTokenExpiry(LocalDateTime passwordResetTokenExpiry) { this.passwordResetTokenExpiry = passwordResetTokenExpiry; }
}

