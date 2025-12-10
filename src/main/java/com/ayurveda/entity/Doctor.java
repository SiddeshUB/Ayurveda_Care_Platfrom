package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "doctors")
public class Doctor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Login Credentials
    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    // Personal Information
    @Column(nullable = false)
    private String name;

    private String gender; // MALE, FEMALE, OTHER

    private String phone;

    private String photoUrl;

    // Hospital Association (nullable - doctors can register independently)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id", nullable = true, insertable = true, updatable = true)
    private Hospital hospital;

    @Column(columnDefinition = "TEXT")
    private String qualifications;

    @Column(columnDefinition = "TEXT")
    private String specializations;

    private Integer experienceYears;

    @Column(columnDefinition = "TEXT")
    private String languagesSpoken;

    @Column(columnDefinition = "TEXT")
    private String biography;

    private String consultationTimings;
    private String consultationDays;

    private String registrationNumber;
    private String degreeUniversity;

    // Availability Settings
    private String availableLocations; // OPD, Online, Home Visit

    // Status Fields
    private Boolean isActive;
    private Boolean isAvailable;
    private Boolean isVerified; // Verified by hospital/admin
    private Boolean profileComplete;

    // Password Reset
    private String passwordResetToken;
    private LocalDateTime passwordResetTokenExpiry;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
    private LocalDateTime lastLoginAt;
    
    // Packages associated with this doctor
    @ManyToMany(mappedBy = "doctors", fetch = FetchType.LAZY)
    private List<TreatmentPackage> packages = new ArrayList<>();

    public Doctor() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (isActive == null) isActive = true;
        if (isAvailable == null) isAvailable = true;
        if (isVerified == null) isVerified = false;
        if (profileComplete == null) profileComplete = false;
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

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhotoUrl() { return photoUrl; }
    public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }

    public String getQualifications() { return qualifications; }
    public void setQualifications(String qualifications) { this.qualifications = qualifications; }

    public String getSpecializations() { return specializations; }
    public void setSpecializations(String specializations) { this.specializations = specializations; }

    public Integer getExperienceYears() { return experienceYears; }
    public void setExperienceYears(Integer experienceYears) { this.experienceYears = experienceYears; }

    public String getLanguagesSpoken() { return languagesSpoken; }
    public void setLanguagesSpoken(String languagesSpoken) { this.languagesSpoken = languagesSpoken; }

    public String getBiography() { return biography; }
    public void setBiography(String biography) { this.biography = biography; }

    public String getConsultationTimings() { return consultationTimings; }
    public void setConsultationTimings(String consultationTimings) { this.consultationTimings = consultationTimings; }

    public String getConsultationDays() { return consultationDays; }
    public void setConsultationDays(String consultationDays) { this.consultationDays = consultationDays; }

    public String getRegistrationNumber() { return registrationNumber; }
    public void setRegistrationNumber(String registrationNumber) { this.registrationNumber = registrationNumber; }

    public String getDegreeUniversity() { return degreeUniversity; }
    public void setDegreeUniversity(String degreeUniversity) { this.degreeUniversity = degreeUniversity; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public Boolean getIsAvailable() { return isAvailable; }
    public void setIsAvailable(Boolean isAvailable) { this.isAvailable = isAvailable; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    // New Getters and Setters
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAvailableLocations() { return availableLocations; }
    public void setAvailableLocations(String availableLocations) { this.availableLocations = availableLocations; }

    public Boolean getIsVerified() { return isVerified; }
    public void setIsVerified(Boolean isVerified) { this.isVerified = isVerified; }

    public Boolean getProfileComplete() { return profileComplete; }
    public void setProfileComplete(Boolean profileComplete) { this.profileComplete = profileComplete; }

    public LocalDateTime getLastLoginAt() { return lastLoginAt; }
    public void setLastLoginAt(LocalDateTime lastLoginAt) { this.lastLoginAt = lastLoginAt; }
    
    public List<TreatmentPackage> getPackages() { return packages; }
    public void setPackages(List<TreatmentPackage> packages) { this.packages = packages; }

    public String getPasswordResetToken() { return passwordResetToken; }
    public void setPasswordResetToken(String passwordResetToken) { this.passwordResetToken = passwordResetToken; }

    public LocalDateTime getPasswordResetTokenExpiry() { return passwordResetTokenExpiry; }
    public void setPasswordResetTokenExpiry(LocalDateTime passwordResetTokenExpiry) { this.passwordResetTokenExpiry = passwordResetTokenExpiry; }
}
