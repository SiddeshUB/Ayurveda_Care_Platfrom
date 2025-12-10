package com.ayurveda.service;

import com.ayurveda.entity.*;
import com.ayurveda.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class RoomService {

    private final RoomRepository roomRepository;
    private final RoomBookingRepository roomBookingRepository;
    private final HospitalRepository hospitalRepository;
    private final UserRepository userRepository;

    @Autowired
    public RoomService(RoomRepository roomRepository,
                      RoomBookingRepository roomBookingRepository,
                      HospitalRepository hospitalRepository,
                      UserRepository userRepository) {
        this.roomRepository = roomRepository;
        this.roomBookingRepository = roomBookingRepository;
        this.hospitalRepository = hospitalRepository;
        this.userRepository = userRepository;
    }

    // Room Management
    public List<Room> getRoomsByHospital(Long hospitalId) {
        return roomRepository.findByHospitalId(hospitalId);
    }

    public List<Room> getActiveRoomsByHospital(Long hospitalId) {
        return roomRepository.findByHospitalIdAndIsActive(hospitalId, true);
    }

    public List<Room> getAvailableRoomsByHospital(Long hospitalId) {
        return roomRepository.findByHospitalIdAndIsActiveAndIsAvailable(hospitalId, true, true);
    }

    public Optional<Room> findById(Long roomId) {
        return roomRepository.findById(roomId);
    }

    @Transactional
    public Room createRoom(Long hospitalId, Room room) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));

        room.setHospital(hospital);
        room.setIsActive(true);
        
        if (room.getAvailableRooms() == null && room.getTotalRooms() != null) {
            room.setAvailableRooms(room.getTotalRooms());
        }

        return roomRepository.save(room);
    }

    @Transactional
    public Room updateRoom(Long roomId, Room updateData) {
        Room room = roomRepository.findById(roomId)
                .orElseThrow(() -> new RuntimeException("Room not found"));

        if (updateData.getRoomType() != null) room.setRoomType(updateData.getRoomType());
        if (updateData.getRoomName() != null) room.setRoomName(updateData.getRoomName());
        if (updateData.getDescription() != null) room.setDescription(updateData.getDescription());
        if (updateData.getPricePerNight() != null) room.setPricePerNight(updateData.getPricePerNight());
        if (updateData.getMaxOccupancy() != null) room.setMaxOccupancy(updateData.getMaxOccupancy());
        if (updateData.getRoomSize() != null) room.setRoomSize(updateData.getRoomSize());
        if (updateData.getBedType() != null) room.setBedType(updateData.getBedType());
        if (updateData.getHasAC() != null) room.setHasAC(updateData.getHasAC());
        if (updateData.getHasAttachedBathroom() != null) room.setHasAttachedBathroom(updateData.getHasAttachedBathroom());
        if (updateData.getHasBalcony() != null) room.setHasBalcony(updateData.getHasBalcony());
        if (updateData.getHasView() != null) room.setHasView(updateData.getHasView());
        if (updateData.getFacilities() != null) room.setFacilities(updateData.getFacilities());
        if (updateData.getAmenities() != null) room.setAmenities(updateData.getAmenities());
        if (updateData.getTotalRooms() != null) {
            room.setTotalRooms(updateData.getTotalRooms());
            // Recalculate available rooms
            if (room.getAvailableRooms() == null || room.getAvailableRooms() > updateData.getTotalRooms()) {
                room.setAvailableRooms(updateData.getTotalRooms());
            }
        }
        if (updateData.getAvailableRooms() != null) room.setAvailableRooms(updateData.getAvailableRooms());
        if (updateData.getIsActive() != null) room.setIsActive(updateData.getIsActive());
        if (updateData.getIsAvailable() != null) room.setIsAvailable(updateData.getIsAvailable());
        if (updateData.getImageUrls() != null) room.setImageUrls(updateData.getImageUrls());

        return roomRepository.save(room);
    }

    @Transactional
    public void deleteRoom(Long roomId) {
        Room room = roomRepository.findById(roomId)
                .orElseThrow(() -> new RuntimeException("Room not found"));
        roomRepository.delete(room);
    }

    // Check room availability for date range
    public boolean checkRoomAvailability(Long roomId, LocalDate checkIn, LocalDate checkOut) {
        Room room = roomRepository.findById(roomId)
                .orElseThrow(() -> new RuntimeException("Room not found"));

        if (!room.getIsActive() || !room.getIsAvailable()) {
            return false;
        }

        // Check for overlapping bookings
        List<RoomBooking> overlappingBookings = roomBookingRepository.findByRoomIdAndCheckInDateLessThanEqualAndCheckOutDateGreaterThanEqualAndStatus(
                roomId, checkOut, checkIn, RoomBooking.BookingStatus.CONFIRMED);

        // Calculate how many rooms are already booked
        int bookedRooms = overlappingBookings.size();
        
        // Check if there are enough available rooms
        int availableCount = room.getAvailableRooms() != null ? room.getAvailableRooms() : 0;
        return availableCount > bookedRooms;
    }

    // Room Booking Management
    public List<RoomBooking> getRoomBookingsByHospital(Long hospitalId) {
        return roomBookingRepository.findByHospitalId(hospitalId);
    }

    public Optional<RoomBooking> findRoomBookingById(Long bookingId) {
        return roomBookingRepository.findById(bookingId);
    }

    public Optional<RoomBooking> findRoomBookingByBookingNumber(String bookingNumber) {
        return roomBookingRepository.findByBookingNumber(bookingNumber);
    }

    public List<RoomBooking> getRoomBookingsByUser(Long userId) {
        return roomBookingRepository.findByUserId(userId);
    }

    @Transactional
    public RoomBooking createRoomBooking(Long roomId, Long userId, RoomBooking booking) {
        Room room = roomRepository.findById(roomId)
                .orElseThrow(() -> new RuntimeException("Room not found"));

        if (!room.getIsActive() || !room.getIsAvailable()) {
            throw new RuntimeException("Room is not available for booking");
        }

        // Check availability
        if (!checkRoomAvailability(roomId, booking.getCheckInDate(), booking.getCheckOutDate())) {
            throw new RuntimeException("Room is not available for the selected dates");
        }

        // Validate dates
        if (booking.getCheckInDate().isBefore(LocalDate.now())) {
            throw new RuntimeException("Check-in date cannot be in the past");
        }
        if (booking.getCheckOutDate().isBefore(booking.getCheckInDate()) || 
            booking.getCheckOutDate().equals(booking.getCheckInDate())) {
            throw new RuntimeException("Check-out date must be after check-in date");
        }

        // Set room and hospital
        booking.setRoom(room);
        booking.setHospital(room.getHospital());

        // Set user if provided
        if (userId != null) {
            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            booking.setUser(user);
        }

        // Calculate number of nights
        long nights = java.time.temporal.ChronoUnit.DAYS.between(booking.getCheckInDate(), booking.getCheckOutDate());
        booking.setNumberOfNights((int) nights);

        // Calculate total amount
        if (booking.getPricePerNight() == null) {
            booking.setPricePerNight(room.getPricePerNight());
        }
        booking.setTotalAmount(booking.getPricePerNight().multiply(new java.math.BigDecimal(nights)));

        // Generate booking number if not set
        if (booking.getBookingNumber() == null) {
            booking.setBookingNumber("RB" + System.currentTimeMillis());
        }

        // Set status
        booking.setStatus(RoomBooking.BookingStatus.PENDING);

        return roomBookingRepository.save(booking);
    }

    @Transactional
    public RoomBooking updateRoomBooking(RoomBooking booking) {
        return roomBookingRepository.save(booking);
    }
}

