package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "reviews")
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id", nullable = false)
    private Hospital hospital;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "booking_id")
    private Booking booking;

    private String patientName;
    private String patientEmail;
    private String patientCountry;

    private Integer rating;

    @Column(columnDefinition = "TEXT")
    private String reviewText;

    @Column(columnDefinition = "TEXT")
    private String treatmentTaken;

    @Column(columnDefinition = "TEXT")
    private String photoUrls;

    private Integer treatmentRating;
    private Integer accommodationRating;
    private Integer staffRating;
    private Integer foodRating;
    private Integer valueForMoneyRating;

    @Column(columnDefinition = "TEXT")
    private String hospitalResponse;

    private LocalDateTime responseDate;

    private Boolean isVerified;
    private Boolean isVisible;
    private Boolean isFeatured;

    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public Review() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (isVerified == null) isVerified = false;
        if (isVisible == null) isVisible = true;
        if (isFeatured == null) isFeatured = false;
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

    public Booking getBooking() { return booking; }
    public void setBooking(Booking booking) { this.booking = booking; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getPatientEmail() { return patientEmail; }
    public void setPatientEmail(String patientEmail) { this.patientEmail = patientEmail; }

    public String getPatientCountry() { return patientCountry; }
    public void setPatientCountry(String patientCountry) { this.patientCountry = patientCountry; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }

    public String getReviewText() { return reviewText; }
    public void setReviewText(String reviewText) { this.reviewText = reviewText; }

    public String getTreatmentTaken() { return treatmentTaken; }
    public void setTreatmentTaken(String treatmentTaken) { this.treatmentTaken = treatmentTaken; }

    public String getPhotoUrls() { return photoUrls; }
    public void setPhotoUrls(String photoUrls) { this.photoUrls = photoUrls; }

    public Integer getTreatmentRating() { return treatmentRating; }
    public void setTreatmentRating(Integer treatmentRating) { this.treatmentRating = treatmentRating; }

    public Integer getAccommodationRating() { return accommodationRating; }
    public void setAccommodationRating(Integer accommodationRating) { this.accommodationRating = accommodationRating; }

    public Integer getStaffRating() { return staffRating; }
    public void setStaffRating(Integer staffRating) { this.staffRating = staffRating; }

    public Integer getFoodRating() { return foodRating; }
    public void setFoodRating(Integer foodRating) { this.foodRating = foodRating; }

    public Integer getValueForMoneyRating() { return valueForMoneyRating; }
    public void setValueForMoneyRating(Integer valueForMoneyRating) { this.valueForMoneyRating = valueForMoneyRating; }

    public String getHospitalResponse() { return hospitalResponse; }
    public void setHospitalResponse(String hospitalResponse) { this.hospitalResponse = hospitalResponse; }

    public LocalDateTime getResponseDate() { return responseDate; }
    public void setResponseDate(LocalDateTime responseDate) { this.responseDate = responseDate; }

    public Boolean getIsVerified() { return isVerified; }
    public void setIsVerified(Boolean isVerified) { this.isVerified = isVerified; }

    public Boolean getIsVisible() { return isVisible; }
    public void setIsVisible(Boolean isVisible) { this.isVisible = isVisible; }

    public Boolean getIsFeatured() { return isFeatured; }
    public void setIsFeatured(Boolean isFeatured) { this.isFeatured = isFeatured; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
