package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "hospitals")
public class Hospital {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Account Information
    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    private String contactPersonName;
    private String contactPersonPhone;

    // Basic Information
    @Column(nullable = false)
    private String centerName;

    @Enumerated(EnumType.STRING)
    private CenterType centerType;

    private Integer yearEstablished;

    @Column(columnDefinition = "TEXT")
    private String description;

    // Location Details
    private String streetAddress;
    private String city;
    private String state;
    private String pinCode;
    private String country;
    private String googleMapsUrl;
    private Double latitude;
    private Double longitude;

    // Contact Information
    private String receptionPhone;
    private String emergencyPhone;
    private String bookingPhone;
    private String publicEmail;
    private String website;
    private String instagramUrl;
    private String facebookUrl;
    private String youtubeUrl;

    // Medical Credentials
    private Boolean ayushCertified;
    private Boolean nabhCertified;
    private Boolean isoCertified;
    private Boolean stateGovtApproved;
    private String medicalLicenseNumber;
    private Integer doctorsCount;
    private Integer therapistsCount;
    private Integer bedsCapacity;

    // Specializations
    @Column(columnDefinition = "TEXT")
    private String therapiesOffered;

    @Column(columnDefinition = "TEXT")
    private String specialTreatments;

    @Column(columnDefinition = "TEXT")
    private String facilitiesAvailable;

    @Column(columnDefinition = "TEXT")
    private String languagesSpoken;

    // Profile Settings
    private String coverPhotoUrl;
    private String logoUrl;

    // Status
    @Enumerated(EnumType.STRING)
    private HospitalStatus status = HospitalStatus.PENDING;

    private Boolean isVerified;
    private Boolean isActive;
    private Boolean profileComplete;
    private Boolean isFeatured;

    // Analytics
    private Long totalViews;
    private Long totalBookings;
    private Double averageRating;
    private Integer totalReviews;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
    private LocalDateTime lastLoginAt;

    // Relationships
    @OneToMany(mappedBy = "hospital", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Doctor> doctors;

    @OneToMany(mappedBy = "hospital", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<TreatmentPackage> packages;

    @OneToMany(mappedBy = "hospital", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Booking> bookings;

    @OneToMany(mappedBy = "hospital", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Review> reviews;

    @OneToMany(mappedBy = "hospital", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<HospitalPhoto> photos;

    @OneToMany(mappedBy = "hospital", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<HospitalDocument> documents;

    @OneToMany(mappedBy = "hospital", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Room> rooms;

    public Hospital() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (isActive == null) isActive = true;
        if (isVerified == null) isVerified = false;
        if (profileComplete == null) profileComplete = false;
        if (isFeatured == null) isFeatured = false;
        if (totalViews == null) totalViews = 0L;
        if (totalBookings == null) totalBookings = 0L;
        if (averageRating == null) averageRating = 0.0;
        if (totalReviews == null) totalReviews = 0;
        if (status == null) status = HospitalStatus.PENDING;
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

    public String getContactPersonName() { return contactPersonName; }
    public void setContactPersonName(String contactPersonName) { this.contactPersonName = contactPersonName; }

    public String getContactPersonPhone() { return contactPersonPhone; }
    public void setContactPersonPhone(String contactPersonPhone) { this.contactPersonPhone = contactPersonPhone; }

    public String getCenterName() { return centerName; }
    public void setCenterName(String centerName) { this.centerName = centerName; }

    public CenterType getCenterType() { return centerType; }
    public void setCenterType(CenterType centerType) { this.centerType = centerType; }

    public Integer getYearEstablished() { return yearEstablished; }
    public void setYearEstablished(Integer yearEstablished) { this.yearEstablished = yearEstablished; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStreetAddress() { return streetAddress; }
    public void setStreetAddress(String streetAddress) { this.streetAddress = streetAddress; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public String getPinCode() { return pinCode; }
    public void setPinCode(String pinCode) { this.pinCode = pinCode; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

    public String getGoogleMapsUrl() { return googleMapsUrl; }
    public void setGoogleMapsUrl(String googleMapsUrl) { this.googleMapsUrl = googleMapsUrl; }

    public Double getLatitude() { return latitude; }
    public void setLatitude(Double latitude) { this.latitude = latitude; }

    public Double getLongitude() { return longitude; }
    public void setLongitude(Double longitude) { this.longitude = longitude; }

    public String getReceptionPhone() { return receptionPhone; }
    public void setReceptionPhone(String receptionPhone) { this.receptionPhone = receptionPhone; }

    public String getEmergencyPhone() { return emergencyPhone; }
    public void setEmergencyPhone(String emergencyPhone) { this.emergencyPhone = emergencyPhone; }

    public String getBookingPhone() { return bookingPhone; }
    public void setBookingPhone(String bookingPhone) { this.bookingPhone = bookingPhone; }

    public String getPublicEmail() { return publicEmail; }
    public void setPublicEmail(String publicEmail) { this.publicEmail = publicEmail; }

    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }

    public String getInstagramUrl() { return instagramUrl; }
    public void setInstagramUrl(String instagramUrl) { this.instagramUrl = instagramUrl; }

    public String getFacebookUrl() { return facebookUrl; }
    public void setFacebookUrl(String facebookUrl) { this.facebookUrl = facebookUrl; }

    public String getYoutubeUrl() { return youtubeUrl; }
    public void setYoutubeUrl(String youtubeUrl) { this.youtubeUrl = youtubeUrl; }

    public Boolean getAyushCertified() { return ayushCertified; }
    public void setAyushCertified(Boolean ayushCertified) { this.ayushCertified = ayushCertified; }

    public Boolean getNabhCertified() { return nabhCertified; }
    public void setNabhCertified(Boolean nabhCertified) { this.nabhCertified = nabhCertified; }

    public Boolean getIsoCertified() { return isoCertified; }
    public void setIsoCertified(Boolean isoCertified) { this.isoCertified = isoCertified; }

    public Boolean getStateGovtApproved() { return stateGovtApproved; }
    public void setStateGovtApproved(Boolean stateGovtApproved) { this.stateGovtApproved = stateGovtApproved; }

    public String getMedicalLicenseNumber() { return medicalLicenseNumber; }
    public void setMedicalLicenseNumber(String medicalLicenseNumber) { this.medicalLicenseNumber = medicalLicenseNumber; }

    public Integer getDoctorsCount() { return doctorsCount; }
    public void setDoctorsCount(Integer doctorsCount) { this.doctorsCount = doctorsCount; }

    public Integer getTherapistsCount() { return therapistsCount; }
    public void setTherapistsCount(Integer therapistsCount) { this.therapistsCount = therapistsCount; }

    public Integer getBedsCapacity() { return bedsCapacity; }
    public void setBedsCapacity(Integer bedsCapacity) { this.bedsCapacity = bedsCapacity; }

    public String getTherapiesOffered() { return therapiesOffered; }
    public void setTherapiesOffered(String therapiesOffered) { this.therapiesOffered = therapiesOffered; }

    public String getSpecialTreatments() { return specialTreatments; }
    public void setSpecialTreatments(String specialTreatments) { this.specialTreatments = specialTreatments; }

    public String getFacilitiesAvailable() { return facilitiesAvailable; }
    public void setFacilitiesAvailable(String facilitiesAvailable) { this.facilitiesAvailable = facilitiesAvailable; }

    public String getLanguagesSpoken() { return languagesSpoken; }
    public void setLanguagesSpoken(String languagesSpoken) { this.languagesSpoken = languagesSpoken; }

    public String getCoverPhotoUrl() { return coverPhotoUrl; }
    public void setCoverPhotoUrl(String coverPhotoUrl) { this.coverPhotoUrl = coverPhotoUrl; }

    public String getLogoUrl() { return logoUrl; }
    public void setLogoUrl(String logoUrl) { this.logoUrl = logoUrl; }

    public HospitalStatus getStatus() { return status; }
    public void setStatus(HospitalStatus status) { this.status = status; }

    public Boolean getIsVerified() { return isVerified; }
    public void setIsVerified(Boolean isVerified) { this.isVerified = isVerified; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public Boolean getProfileComplete() { return profileComplete; }
    public void setProfileComplete(Boolean profileComplete) { this.profileComplete = profileComplete; }

    public Boolean getIsFeatured() { return isFeatured; }
    public void setIsFeatured(Boolean isFeatured) { this.isFeatured = isFeatured; }

    public Long getTotalViews() { return totalViews; }
    public void setTotalViews(Long totalViews) { this.totalViews = totalViews; }

    public Long getTotalBookings() { return totalBookings; }
    public void setTotalBookings(Long totalBookings) { this.totalBookings = totalBookings; }

    public Double getAverageRating() { return averageRating; }
    public void setAverageRating(Double averageRating) { this.averageRating = averageRating; }

    public Integer getTotalReviews() { return totalReviews; }
    public void setTotalReviews(Integer totalReviews) { this.totalReviews = totalReviews; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public LocalDateTime getLastLoginAt() { return lastLoginAt; }
    public void setLastLoginAt(LocalDateTime lastLoginAt) { this.lastLoginAt = lastLoginAt; }

    public List<Doctor> getDoctors() { return doctors; }
    public void setDoctors(List<Doctor> doctors) { this.doctors = doctors; }

    public List<TreatmentPackage> getPackages() { return packages; }
    public void setPackages(List<TreatmentPackage> packages) { this.packages = packages; }

    public List<Booking> getBookings() { return bookings; }
    public void setBookings(List<Booking> bookings) { this.bookings = bookings; }

    public List<Review> getReviews() { return reviews; }
    public void setReviews(List<Review> reviews) { this.reviews = reviews; }

    public List<HospitalPhoto> getPhotos() { return photos; }
    public void setPhotos(List<HospitalPhoto> photos) { this.photos = photos; }

    public List<HospitalDocument> getDocuments() { return documents; }
    public void setDocuments(List<HospitalDocument> documents) { this.documents = documents; }

    public List<Room> getRooms() { return rooms; }
    public void setRooms(List<Room> rooms) { this.rooms = rooms; }

    public enum CenterType {
        HOSPITAL, ASHRAM, CLINIC, RETREAT, WELLNESS_CENTER
    }

    public enum HospitalStatus {
        PENDING, APPROVED, REJECTED, SUSPENDED
    }
}
