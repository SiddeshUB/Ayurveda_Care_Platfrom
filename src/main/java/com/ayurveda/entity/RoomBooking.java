package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "room_bookings")
public class RoomBooking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String bookingNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "room_id", nullable = false)
    private Room room;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id", nullable = false)
    private Hospital hospital;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "booking_id")
    private Booking booking; // Link to main booking if part of package

    // Guest Information
    private String guestName;
    private String guestEmail;
    private String guestPhone;
    private String guestCountry;
    private Integer numberOfGuests;

    // Booking Dates
    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private Integer numberOfNights;

    // Pricing
    private BigDecimal pricePerNight;
    private BigDecimal totalAmount;

    // Status
    @Enumerated(EnumType.STRING)
    private BookingStatus status = BookingStatus.PENDING;

    @Column(columnDefinition = "TEXT")
    private String specialRequests;

    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
    private LocalDateTime confirmedAt;
    private LocalDateTime cancelledAt;

    public RoomBooking() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (bookingNumber == null) {
            bookingNumber = "RB" + System.currentTimeMillis();
        }
        if (status == null) {
            status = BookingStatus.PENDING;
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getBookingNumber() { return bookingNumber; }
    public void setBookingNumber(String bookingNumber) { this.bookingNumber = bookingNumber; }

    public Room getRoom() { return room; }
    public void setRoom(Room room) { this.room = room; }

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Booking getBooking() { return booking; }
    public void setBooking(Booking booking) { this.booking = booking; }

    public String getGuestName() { return guestName; }
    public void setGuestName(String guestName) { this.guestName = guestName; }

    public String getGuestEmail() { return guestEmail; }
    public void setGuestEmail(String guestEmail) { this.guestEmail = guestEmail; }

    public String getGuestPhone() { return guestPhone; }
    public void setGuestPhone(String guestPhone) { this.guestPhone = guestPhone; }

    public String getGuestCountry() { return guestCountry; }
    public void setGuestCountry(String guestCountry) { this.guestCountry = guestCountry; }

    public Integer getNumberOfGuests() { return numberOfGuests; }
    public void setNumberOfGuests(Integer numberOfGuests) { this.numberOfGuests = numberOfGuests; }

    public LocalDate getCheckInDate() { return checkInDate; }
    public void setCheckInDate(LocalDate checkInDate) { this.checkInDate = checkInDate; }

    public LocalDate getCheckOutDate() { return checkOutDate; }
    public void setCheckOutDate(LocalDate checkOutDate) { this.checkOutDate = checkOutDate; }

    public Integer getNumberOfNights() { return numberOfNights; }
    public void setNumberOfNights(Integer numberOfNights) { this.numberOfNights = numberOfNights; }

    public BigDecimal getPricePerNight() { return pricePerNight; }
    public void setPricePerNight(BigDecimal pricePerNight) { this.pricePerNight = pricePerNight; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public BookingStatus getStatus() { return status; }
    public void setStatus(BookingStatus status) { this.status = status; }

    public String getSpecialRequests() { return specialRequests; }
    public void setSpecialRequests(String specialRequests) { this.specialRequests = specialRequests; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public LocalDateTime getConfirmedAt() { return confirmedAt; }
    public void setConfirmedAt(LocalDateTime confirmedAt) { this.confirmedAt = confirmedAt; }

    public LocalDateTime getCancelledAt() { return cancelledAt; }
    public void setCancelledAt(LocalDateTime cancelledAt) { this.cancelledAt = cancelledAt; }

    public enum BookingStatus {
        PENDING, CONFIRMED, CANCELLED, COMPLETED, CHECKED_IN, CHECKED_OUT
    }
}

