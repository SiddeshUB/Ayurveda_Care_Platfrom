package com.ayurveda.repository;

import com.ayurveda.entity.Booking;
import com.ayurveda.entity.Booking.BookingStatus;
import com.ayurveda.entity.Booking.RoomType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {
    
    List<Booking> findByHospitalId(Long hospitalId);
    
    Page<Booking> findByHospitalId(Long hospitalId, Pageable pageable);
    
    List<Booking> findByHospitalIdAndStatus(Long hospitalId, BookingStatus status);
    
    List<Booking> findByUserIdOrderByCreatedAtDesc(Long userId);
    
    @Query("SELECT b FROM Booking b WHERE b.user.id = :userId ORDER BY b.createdAt DESC")
    List<Booking> findBookingsByUserId(@Param("userId") Long userId);
    
    List<Booking> findByTreatmentPackageId(Long packageId);
    
    Optional<Booking> findByBookingNumber(String bookingNumber);
    
    Optional<Booking> findByRazorpayOrderId(String razorpayOrderId);
    
    Long countByHospitalIdAndStatus(Long hospitalId, BookingStatus status);
    
    @Query("SELECT b FROM Booking b WHERE b.hospital.id = :hospitalId AND b.status = :status ORDER BY b.createdAt DESC")
    List<Booking> findRecentBookingsByStatus(@Param("hospitalId") Long hospitalId, @Param("status") BookingStatus status);
    
    @Query("SELECT b FROM Booking b WHERE b.hospital.id = :hospitalId AND b.checkInDate BETWEEN :startDate AND :endDate")
    List<Booking> findBookingsByDateRange(@Param("hospitalId") Long hospitalId, 
                                          @Param("startDate") LocalDate startDate, 
                                          @Param("endDate") LocalDate endDate);
    
    @Query("SELECT COUNT(b) FROM Booking b WHERE b.hospital.id = :hospitalId AND b.createdAt >= :startDate")
    Long countBookingsThisMonth(@Param("hospitalId") Long hospitalId, @Param("startDate") LocalDateTime startDate);
    
    @Query("SELECT COALESCE(SUM(b.totalAmount), 0) FROM Booking b WHERE b.hospital.id = :hospitalId AND b.status = 'CONFIRMED' AND b.createdAt >= :startDate")
    BigDecimal calculateRevenueThisMonth(@Param("hospitalId") Long hospitalId, @Param("startDate") LocalDateTime startDate);
    
    // Find conflicting bookings for room availability check
    @Query("SELECT b FROM Booking b WHERE b.treatmentPackage.id = :packageId " +
           "AND b.roomType = :roomType " +
           "AND ((b.checkInDate <= :checkOut AND b.checkOutDate >= :checkIn))")
    List<Booking> findConflictingBookings(@Param("packageId") Long packageId,
                                         @Param("roomType") RoomType roomType,
                                         @Param("checkIn") LocalDate checkIn,
                                         @Param("checkOut") LocalDate checkOut);
}
