package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "rooms")
public class Room {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id", nullable = false)
    private Hospital hospital;

    @Column(nullable = false)
    private String roomType; // Standard, Deluxe, Suite, Cottage, etc.

    @Column(nullable = false)
    private String roomName; // e.g., "Standard Room", "Deluxe Cottage"

    @Column(columnDefinition = "TEXT")
    private String description;

    // Pricing
    @Column(nullable = false)
    private BigDecimal pricePerNight;

    // Room Details
    private Integer maxOccupancy; // Maximum number of guests
    private Integer roomSize; // in square feet
    
    @Column(columnDefinition = "TEXT")
    private String bedType; // Single, Double, Queen, King, Twin

    private Boolean hasAC; // AC / Non-AC
    private Boolean hasAttachedBathroom;
    private Boolean hasBalcony;
    private Boolean hasView; // Garden view, Mountain view, etc.

    @Column(columnDefinition = "TEXT")
    private String facilities; // Wi-Fi, TV, Mini-fridge, etc.

    @Column(columnDefinition = "TEXT")
    private String amenities; // Additional amenities

    // Availability & Occupancy
    private Integer totalRooms; // Total number of rooms of this type
    private Integer availableRooms; // Currently available rooms

    // Status
    private Boolean isActive = true;
    private Boolean isAvailable = true;

    // Images
    @Column(columnDefinition = "TEXT")
    private String imageUrls; // Comma-separated image URLs

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    // Relationships
    @OneToMany(mappedBy = "room", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<RoomBooking> roomBookings;

    public Room() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (isActive == null) isActive = true;
        if (isAvailable == null) isAvailable = true;
        if (availableRooms == null && totalRooms != null) {
            availableRooms = totalRooms;
        }
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

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public String getRoomName() { return roomName; }
    public void setRoomName(String roomName) { this.roomName = roomName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public BigDecimal getPricePerNight() { return pricePerNight; }
    public void setPricePerNight(BigDecimal pricePerNight) { this.pricePerNight = pricePerNight; }

    public Integer getMaxOccupancy() { return maxOccupancy; }
    public void setMaxOccupancy(Integer maxOccupancy) { this.maxOccupancy = maxOccupancy; }

    public Integer getRoomSize() { return roomSize; }
    public void setRoomSize(Integer roomSize) { this.roomSize = roomSize; }

    public String getBedType() { return bedType; }
    public void setBedType(String bedType) { this.bedType = bedType; }

    public Boolean getHasAC() { return hasAC; }
    public void setHasAC(Boolean hasAC) { this.hasAC = hasAC; }

    public Boolean getHasAttachedBathroom() { return hasAttachedBathroom; }
    public void setHasAttachedBathroom(Boolean hasAttachedBathroom) { this.hasAttachedBathroom = hasAttachedBathroom; }

    public Boolean getHasBalcony() { return hasBalcony; }
    public void setHasBalcony(Boolean hasBalcony) { this.hasBalcony = hasBalcony; }

    public Boolean getHasView() { return hasView; }
    public void setHasView(Boolean hasView) { this.hasView = hasView; }

    public String getFacilities() { return facilities; }
    public void setFacilities(String facilities) { this.facilities = facilities; }

    public String getAmenities() { return amenities; }
    public void setAmenities(String amenities) { this.amenities = amenities; }

    public Integer getTotalRooms() { return totalRooms; }
    public void setTotalRooms(Integer totalRooms) { this.totalRooms = totalRooms; }

    public Integer getAvailableRooms() { return availableRooms; }
    public void setAvailableRooms(Integer availableRooms) { this.availableRooms = availableRooms; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public Boolean getIsAvailable() { return isAvailable; }
    public void setIsAvailable(Boolean isAvailable) { this.isAvailable = isAvailable; }

    public String getImageUrls() { return imageUrls; }
    public void setImageUrls(String imageUrls) { this.imageUrls = imageUrls; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public List<RoomBooking> getRoomBookings() { return roomBookings; }
    public void setRoomBookings(List<RoomBooking> roomBookings) { this.roomBookings = roomBookings; }
}

