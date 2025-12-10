package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "hospital_photos")
public class HospitalPhoto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id", nullable = false)
    private Hospital hospital;

    @Column(nullable = false)
    private String photoUrl;

    private String thumbnailUrl;

    private String title;
    private String description;

    @Enumerated(EnumType.STRING)
    private PhotoCategory category;

    private Integer sortOrder;
    private Boolean isActive;
    private Boolean isCoverPhoto;

    @Column(updatable = false)
    private LocalDateTime createdAt;

    public HospitalPhoto() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        if (isActive == null) isActive = true;
        if (isCoverPhoto == null) isCoverPhoto = false;
        if (sortOrder == null) sortOrder = 0;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public String getPhotoUrl() { return photoUrl; }
    public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }

    public String getThumbnailUrl() { return thumbnailUrl; }
    public void setThumbnailUrl(String thumbnailUrl) { this.thumbnailUrl = thumbnailUrl; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public PhotoCategory getCategory() { return category; }
    public void setCategory(PhotoCategory category) { this.category = category; }

    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public Boolean getIsCoverPhoto() { return isCoverPhoto; }
    public void setIsCoverPhoto(Boolean isCoverPhoto) { this.isCoverPhoto = isCoverPhoto; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public enum PhotoCategory {
        EXTERIOR, LOBBY, ROOMS, THERAPY_AREA, YOGA_HALL, GARDEN, 
        DINING, KITCHEN, FOOD, POOL, SPA, AYURVEDA, OTHER
    }
}
