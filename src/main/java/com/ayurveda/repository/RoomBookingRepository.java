package com.ayurveda.repository;

import com.ayurveda.entity.RoomBooking;
import com.ayurveda.entity.RoomBooking.BookingStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface RoomBookingRepository extends JpaRepository<RoomBooking, Long> {
    
    List<RoomBooking> findByHospitalId(Long hospitalId);
    
    List<RoomBooking> findByRoomId(Long roomId);
    
    List<RoomBooking> findByUserId(Long userId);
    
    Optional<RoomBooking> findByBookingNumber(String bookingNumber);
    
    List<RoomBooking> findByRoomIdAndStatus(Long roomId, BookingStatus status);
    
    // Find bookings that overlap with given date range
    List<RoomBooking> findByRoomIdAndCheckInDateLessThanEqualAndCheckOutDateGreaterThanEqualAndStatus(
            Long roomId, LocalDate checkOutDate, LocalDate checkInDate, BookingStatus status);
}

