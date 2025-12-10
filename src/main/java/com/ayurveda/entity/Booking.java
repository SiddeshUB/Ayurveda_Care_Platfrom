package com.ayurveda.entity;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "bookings")
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String bookingNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id", nullable = false)
    private Hospital hospital;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "package_id")
    private TreatmentPackage treatmentPackage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user; // Optional - booking can be anonymous or linked to user account

    private String patientName;
    private String patientEmail;
    private String patientPhone;
    private String patientCountry;
    private String patientCity;
    private Integer patientAge;
    private String patientGender;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkInDate;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkOutDate;

    @Enumerated(EnumType.STRING)
    private RoomType roomType;

    private Integer numberOfGuests;
    
    // Price Breakdown
    private BigDecimal basePrice;
    private BigDecimal gstAmount;
    private BigDecimal cgstAmount;
    private BigDecimal totalAmount;

    @Column(columnDefinition = "TEXT")
    private String specialRequests;

    @Column(columnDefinition = "TEXT")
    private String medicalConditions;

    @Column(columnDefinition = "TEXT")
    private String currentMedications;

    @Enumerated(EnumType.STRING)
    private BookingStatus status = BookingStatus.PENDING;

    private String cancellationReason;
    private String rejectionReason;

    @Column(columnDefinition = "TEXT")
    private String hospitalNotes;

    @Column(columnDefinition = "TEXT")
    private String patientNotes;

    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus;

    private BigDecimal advancePaid;
    private String paymentReference;
    
    // Razorpay payment fields
    private String razorpayOrderId; // Razorpay order ID
    private String razorpayPaymentId; // Razorpay payment ID
    private String razorpaySignature; // Razorpay signature

    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
    private LocalDateTime confirmedAt;
    private LocalDateTime cancelledAt;

    public Booking() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (bookingNumber == null) {
            bookingNumber = "BK" + System.currentTimeMillis();
        }
        if (paymentStatus == null) {
            paymentStatus = PaymentStatus.PENDING;
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

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public TreatmentPackage getTreatmentPackage() { return treatmentPackage; }
    public void setTreatmentPackage(TreatmentPackage treatmentPackage) { this.treatmentPackage = treatmentPackage; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getPatientEmail() { return patientEmail; }
    public void setPatientEmail(String patientEmail) { this.patientEmail = patientEmail; }

    public String getPatientPhone() { return patientPhone; }
    public void setPatientPhone(String patientPhone) { this.patientPhone = patientPhone; }

    public String getPatientCountry() { return patientCountry; }
    public void setPatientCountry(String patientCountry) { this.patientCountry = patientCountry; }

    public String getPatientCity() { return patientCity; }
    public void setPatientCity(String patientCity) { this.patientCity = patientCity; }

    public Integer getPatientAge() { return patientAge; }
    public void setPatientAge(Integer patientAge) { this.patientAge = patientAge; }

    public String getPatientGender() { return patientGender; }
    public void setPatientGender(String patientGender) { this.patientGender = patientGender; }

    public LocalDate getCheckInDate() { return checkInDate; }
    public void setCheckInDate(LocalDate checkInDate) { this.checkInDate = checkInDate; }

    public LocalDate getCheckOutDate() { return checkOutDate; }
    public void setCheckOutDate(LocalDate checkOutDate) { this.checkOutDate = checkOutDate; }

    public RoomType getRoomType() { return roomType; }
    public void setRoomType(RoomType roomType) { this.roomType = roomType; }

    public Integer getNumberOfGuests() { return numberOfGuests; }
    public void setNumberOfGuests(Integer numberOfGuests) { this.numberOfGuests = numberOfGuests; }

    public BigDecimal getBasePrice() { return basePrice; }
    public void setBasePrice(BigDecimal basePrice) { this.basePrice = basePrice; }

    public BigDecimal getGstAmount() { return gstAmount; }
    public void setGstAmount(BigDecimal gstAmount) { this.gstAmount = gstAmount; }

    public BigDecimal getCgstAmount() { return cgstAmount; }
    public void setCgstAmount(BigDecimal cgstAmount) { this.cgstAmount = cgstAmount; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public String getSpecialRequests() { return specialRequests; }
    public void setSpecialRequests(String specialRequests) { this.specialRequests = specialRequests; }

    public String getMedicalConditions() { return medicalConditions; }
    public void setMedicalConditions(String medicalConditions) { this.medicalConditions = medicalConditions; }

    public String getCurrentMedications() { return currentMedications; }
    public void setCurrentMedications(String currentMedications) { this.currentMedications = currentMedications; }

    public BookingStatus getStatus() { return status; }
    public void setStatus(BookingStatus status) { this.status = status; }

    public String getCancellationReason() { return cancellationReason; }
    public void setCancellationReason(String cancellationReason) { this.cancellationReason = cancellationReason; }

    public String getRejectionReason() { return rejectionReason; }
    public void setRejectionReason(String rejectionReason) { this.rejectionReason = rejectionReason; }

    public String getHospitalNotes() { return hospitalNotes; }
    public void setHospitalNotes(String hospitalNotes) { this.hospitalNotes = hospitalNotes; }

    public String getPatientNotes() { return patientNotes; }
    public void setPatientNotes(String patientNotes) { this.patientNotes = patientNotes; }

    public PaymentStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; }

    public BigDecimal getAdvancePaid() { return advancePaid; }
    public void setAdvancePaid(BigDecimal advancePaid) { this.advancePaid = advancePaid; }

    public String getPaymentReference() { return paymentReference; }
    public void setPaymentReference(String paymentReference) { this.paymentReference = paymentReference; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public LocalDateTime getConfirmedAt() { return confirmedAt; }
    public void setConfirmedAt(LocalDateTime confirmedAt) { this.confirmedAt = confirmedAt; }

    public LocalDateTime getCancelledAt() { return cancelledAt; }
    public void setCancelledAt(LocalDateTime cancelledAt) { this.cancelledAt = cancelledAt; }

    public String getRazorpayOrderId() { return razorpayOrderId; }
    public void setRazorpayOrderId(String razorpayOrderId) { this.razorpayOrderId = razorpayOrderId; }

    public String getRazorpayPaymentId() { return razorpayPaymentId; }
    public void setRazorpayPaymentId(String razorpayPaymentId) { this.razorpayPaymentId = razorpayPaymentId; }

    public String getRazorpaySignature() { return razorpaySignature; }
    public void setRazorpaySignature(String razorpaySignature) { this.razorpaySignature = razorpaySignature; }

    public enum RoomType {
        BUDGET, STANDARD, DELUXE, SUITE, VILLA, VIP
    }

    public enum BookingStatus {
        PENDING, CONFIRMED, REJECTED, CANCELLED, COMPLETED, NO_SHOW
    }

    public enum PaymentStatus {
        PENDING, PARTIAL, PAID, REFUNDED
    }
}
