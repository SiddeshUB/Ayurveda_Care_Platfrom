package com.ayurveda.service;

import com.ayurveda.entity.Booking;
import com.ayurveda.entity.Booking.BookingStatus;
import com.ayurveda.entity.Booking.RoomType;
import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.TreatmentPackage;
import com.ayurveda.repository.BookingRepository;
import com.ayurveda.repository.HospitalRepository;
import com.ayurveda.repository.TreatmentPackageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class BookingService {

    private final BookingRepository bookingRepository;
    private final HospitalRepository hospitalRepository;
    private final TreatmentPackageRepository packageRepository;

    @Autowired
    public BookingService(BookingRepository bookingRepository,
                         HospitalRepository hospitalRepository,
                         TreatmentPackageRepository packageRepository) {
        this.bookingRepository = bookingRepository;
        this.hospitalRepository = hospitalRepository;
        this.packageRepository = packageRepository;
    }

    public List<Booking> getBookingsByHospital(Long hospitalId) {
        return bookingRepository.findByHospitalId(hospitalId);
    }

    public Page<Booking> getBookingsByHospital(Long hospitalId, Pageable pageable) {
        return bookingRepository.findByHospitalId(hospitalId, pageable);
    }

    public List<Booking> getBookingsByStatus(Long hospitalId, BookingStatus status) {
        return bookingRepository.findByHospitalIdAndStatus(hospitalId, status);
    }
    
    public List<Booking> getBookingsByPackage(Long packageId) {
        return bookingRepository.findByTreatmentPackageId(packageId);
    }
    
    public List<Booking> getBookingsByUser(Long userId) {
        // Use custom query to ensure we get all bookings for the user
        return bookingRepository.findBookingsByUserId(userId);
    }

    public List<Booking> getPendingBookings(Long hospitalId) {
        return bookingRepository.findRecentBookingsByStatus(hospitalId, BookingStatus.PENDING);
    }

    public Optional<Booking> findById(Long id) {
        return bookingRepository.findById(id);
    }

    public Optional<Booking> findByBookingNumber(String bookingNumber) {
        return bookingRepository.findByBookingNumber(bookingNumber);
    }

    @Transactional
    public Booking createBooking(Long hospitalId, Long packageId, Booking booking, com.ayurveda.entity.User user) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));

        booking.setHospital(hospital);
        booking.setUser(user); // Link booking to logged-in user
        booking.setStatus(BookingStatus.PENDING);

        if (packageId != null) {
            TreatmentPackage pkg = packageRepository.findById(packageId)
                    .orElseThrow(() -> new RuntimeException("Package not found"));
            booking.setTreatmentPackage(pkg);

            // Check room availability and block room
            if (booking.getRoomType() != null && booking.getCheckInDate() != null && booking.getCheckOutDate() != null) {
                if (!checkRoomAvailability(pkg, booking.getRoomType(), booking.getCheckInDate(), booking.getCheckOutDate(), null)) {
                    throw new RuntimeException("Room type " + booking.getRoomType() + " is not available for the selected dates");
                }
            }

            // Calculate price breakdown with GST/CGST
            calculatePriceBreakdown(pkg, booking);
        }

        Booking savedBooking = bookingRepository.save(booking);

        // Update hospital booking count
        hospital.setTotalBookings(hospital.getTotalBookings() + 1);
        hospitalRepository.save(hospital);

        return savedBooking;
    }

    private void calculatePriceBreakdown(TreatmentPackage pkg, Booking booking) {
        RoomType roomType = booking.getRoomType();
        if (roomType == null) {
            roomType = RoomType.BUDGET;
        }

        BigDecimal basePrice = null;
        BigDecimal gstPercent = null;
        BigDecimal cgstPercent = null;

        switch (roomType) {
            case BUDGET:
                basePrice = pkg.getBudgetRoomPrice();
                gstPercent = pkg.getBudgetRoomGstPercent();
                cgstPercent = pkg.getBudgetRoomCgstPercent();
                break;
            case STANDARD:
                basePrice = pkg.getStandardRoomPrice();
                gstPercent = pkg.getStandardRoomGstPercent();
                cgstPercent = pkg.getStandardRoomCgstPercent();
                break;
            case DELUXE:
                basePrice = pkg.getDeluxeRoomPrice();
                gstPercent = pkg.getDeluxeRoomGstPercent();
                cgstPercent = pkg.getDeluxeRoomCgstPercent();
                break;
            case SUITE:
                basePrice = pkg.getSuiteRoomPrice();
                gstPercent = pkg.getSuiteRoomGstPercent();
                cgstPercent = pkg.getSuiteRoomCgstPercent();
                break;
            case VILLA:
                basePrice = pkg.getVillaPrice();
                gstPercent = pkg.getVillaGstPercent();
                cgstPercent = pkg.getVillaCgstPercent();
                break;
            case VIP:
                basePrice = pkg.getVipRoomPrice();
                gstPercent = pkg.getVipRoomGstPercent();
                cgstPercent = pkg.getVipRoomCgstPercent();
                break;
            default:
                basePrice = pkg.getBudgetRoomPrice();
                gstPercent = pkg.getBudgetRoomGstPercent();
                cgstPercent = pkg.getBudgetRoomCgstPercent();
        }

        if (basePrice == null) {
            basePrice = BigDecimal.ZERO;
        }
        if (gstPercent == null) {
            gstPercent = BigDecimal.ZERO;
        }
        if (cgstPercent == null) {
            cgstPercent = BigDecimal.ZERO;
        }

        // Calculate GST and CGST amounts
        BigDecimal gstAmount = basePrice.multiply(gstPercent).divide(new BigDecimal("100"), 2, java.math.RoundingMode.HALF_UP);
        BigDecimal cgstAmount = basePrice.multiply(cgstPercent).divide(new BigDecimal("100"), 2, java.math.RoundingMode.HALF_UP);
        BigDecimal totalAmount = basePrice.add(gstAmount).add(cgstAmount);

        // Set price breakdown
        booking.setBasePrice(basePrice);
        booking.setGstAmount(gstAmount);
        booking.setCgstAmount(cgstAmount);
        booking.setTotalAmount(totalAmount);
    }

    private boolean checkRoomAvailability(TreatmentPackage pkg, RoomType roomType, LocalDate checkIn, LocalDate checkOut, Long excludeBookingId) {
        // Get room count for this room type
        Integer availableCount = getRoomCountForType(pkg, roomType);
        if (availableCount == null || availableCount <= 0) {
            return false;
        }

        // Count existing bookings for this room type in the date range
        List<Booking> conflictingBookings = bookingRepository.findConflictingBookings(
            pkg.getId(), roomType, checkIn, checkOut
        );

        // Exclude current booking if updating
        if (excludeBookingId != null) {
            conflictingBookings = conflictingBookings.stream()
                .filter(b -> !b.getId().equals(excludeBookingId))
                .collect(java.util.stream.Collectors.toList());
        }

        // Filter only confirmed and pending bookings (not cancelled or rejected)
        long bookedCount = conflictingBookings.stream()
            .filter(b -> b.getStatus() == BookingStatus.CONFIRMED || b.getStatus() == BookingStatus.PENDING)
            .count();

        return bookedCount < availableCount;
    }

    private Integer getRoomCountForType(TreatmentPackage pkg, RoomType roomType) {
        switch (roomType) {
            case BUDGET:
                return pkg.getBudgetRoomCount();
            case STANDARD:
                return pkg.getStandardRoomCount();
            case DELUXE:
                return pkg.getDeluxeRoomCount();
            case SUITE:
                return pkg.getSuiteRoomCount();
            case VILLA:
                return pkg.getVillaCount();
            case VIP:
                return pkg.getVipRoomCount();
            default:
                return pkg.getBudgetRoomCount();
        }
    }

    @Transactional
    public Booking confirmBooking(Long bookingId, String hospitalNotes) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        booking.setStatus(BookingStatus.CONFIRMED);
        booking.setConfirmedAt(LocalDateTime.now());
        booking.setHospitalNotes(hospitalNotes);

        return bookingRepository.save(booking);
    }

    @Transactional
    public Booking rejectBooking(Long bookingId, String reason) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        booking.setStatus(BookingStatus.REJECTED);
        booking.setRejectionReason(reason);

        return bookingRepository.save(booking);
    }

    @Transactional
    public Booking cancelBooking(Long bookingId, String reason) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        booking.setStatus(BookingStatus.CANCELLED);
        booking.setCancellationReason(reason);
        booking.setCancelledAt(LocalDateTime.now());

        return bookingRepository.save(booking);
    }

    @Transactional
    public Booking completeBooking(Long bookingId) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        booking.setStatus(BookingStatus.COMPLETED);

        return bookingRepository.save(booking);
    }

    @Transactional
    public Booking updateBookingNotes(Long bookingId, String notes) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        booking.setHospitalNotes(notes);

        return bookingRepository.save(booking);
    }

    public List<Booking> getBookingsByDateRange(Long hospitalId, LocalDate startDate, LocalDate endDate) {
        return bookingRepository.findBookingsByDateRange(hospitalId, startDate, endDate);
    }

    public Long countPendingBookings(Long hospitalId) {
        return bookingRepository.countByHospitalIdAndStatus(hospitalId, BookingStatus.PENDING);
    }

    public Long countConfirmedBookings(Long hospitalId) {
        return bookingRepository.countByHospitalIdAndStatus(hospitalId, BookingStatus.CONFIRMED);
    }

    public BigDecimal calculateMonthlyRevenue(Long hospitalId) {
        LocalDateTime startOfMonth = LocalDateTime.now().withDayOfMonth(1).withHour(0).withMinute(0);
        return bookingRepository.calculateRevenueThisMonth(hospitalId, startOfMonth);
    }

    @Transactional
    public Booking updatePaymentDetails(Long bookingId, String razorpayOrderId, String razorpayPaymentId, String razorpaySignature) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));
        
        booking.setRazorpayOrderId(razorpayOrderId);
        booking.setRazorpayPaymentId(razorpayPaymentId);
        booking.setRazorpaySignature(razorpaySignature);
        booking.setPaymentStatus(Booking.PaymentStatus.PAID);
        booking.setAdvancePaid(booking.getTotalAmount());
        booking.setPaymentReference(razorpayPaymentId);
        
        return bookingRepository.save(booking);
    }

    public Optional<Booking> findByRazorpayOrderId(String razorpayOrderId) {
        return bookingRepository.findByRazorpayOrderId(razorpayOrderId);
    }

    @Transactional
    public Booking save(Booking booking) {
        return bookingRepository.save(booking);
    }
}
