package com.ayurveda.service;

import com.ayurveda.entity.*;
import com.ayurveda.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class HospitalService {

    private final HospitalRepository hospitalRepository;
    private final BookingRepository bookingRepository;
    private final ReviewRepository reviewRepository;
    private final UserEnquiryRepository enquiryRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public HospitalService(HospitalRepository hospitalRepository,
                          BookingRepository bookingRepository,
                          ReviewRepository reviewRepository,
                          UserEnquiryRepository enquiryRepository,
                          PasswordEncoder passwordEncoder) {
        this.hospitalRepository = hospitalRepository;
        this.bookingRepository = bookingRepository;
        this.reviewRepository = reviewRepository;
        this.enquiryRepository = enquiryRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public Optional<Hospital> findById(Long id) {
        return hospitalRepository.findById(id);
    }

    public Optional<Hospital> findByEmail(String email) {
        return hospitalRepository.findByEmail(email);
    }

    @Transactional
    public Hospital registerHospital(Hospital hospital) {
        // Check if email already exists
        if (hospitalRepository.findByEmail(hospital.getEmail()).isPresent()) {
            throw new RuntimeException("Email already registered");
        }
        
        // Encode password
        hospital.setPassword(passwordEncoder.encode(hospital.getPassword()));
        hospital.setStatus(Hospital.HospitalStatus.PENDING);
        hospital.setIsActive(true);
        hospital.setIsVerified(false);
        hospital.setProfileComplete(false);
        
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public Hospital updateHospital(Hospital hospital) {
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public Hospital updateBasicInfo(Long hospitalId, Hospital updateData) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        if (updateData.getCenterName() != null) hospital.setCenterName(updateData.getCenterName());
        if (updateData.getCenterType() != null) hospital.setCenterType(updateData.getCenterType());
        if (updateData.getYearEstablished() != null) hospital.setYearEstablished(updateData.getYearEstablished());
        if (updateData.getDescription() != null) hospital.setDescription(updateData.getDescription());
        
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public Hospital updateLocationDetails(Long hospitalId, Hospital updateData) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        if (updateData.getStreetAddress() != null) hospital.setStreetAddress(updateData.getStreetAddress());
        if (updateData.getCity() != null) hospital.setCity(updateData.getCity());
        if (updateData.getState() != null) hospital.setState(updateData.getState());
        if (updateData.getPinCode() != null) hospital.setPinCode(updateData.getPinCode());
        if (updateData.getGoogleMapsUrl() != null) hospital.setGoogleMapsUrl(updateData.getGoogleMapsUrl());
        
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public Hospital updateContactDetails(Long hospitalId, Hospital updateData) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        hospital.setReceptionPhone(updateData.getReceptionPhone());
        hospital.setEmergencyPhone(updateData.getEmergencyPhone());
        hospital.setBookingPhone(updateData.getBookingPhone());
        hospital.setPublicEmail(updateData.getPublicEmail());
        hospital.setWebsite(updateData.getWebsite());
        hospital.setInstagramUrl(updateData.getInstagramUrl());
        hospital.setFacebookUrl(updateData.getFacebookUrl());
        hospital.setYoutubeUrl(updateData.getYoutubeUrl());
        
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public Hospital updateSpecializations(Long hospitalId, Hospital updateData) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        hospital.setTherapiesOffered(updateData.getTherapiesOffered());
        hospital.setSpecialTreatments(updateData.getSpecialTreatments());
        hospital.setFacilitiesAvailable(updateData.getFacilitiesAvailable());
        hospital.setLanguagesSpoken(updateData.getLanguagesSpoken());
        
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public void updateLastLogin(Long hospitalId) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        hospital.setLastLoginAt(LocalDateTime.now());
        hospitalRepository.save(hospital);
    }

    @Transactional
    public void incrementViews(Long hospitalId) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        hospital.setTotalViews(hospital.getTotalViews() + 1);
        hospitalRepository.save(hospital);
    }

    public Hospital getPublicProfile(Long hospitalId) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        // Increment view count
        incrementViews(hospitalId);
        
        return hospital;
    }

    public Page<Hospital> searchHospitals(String query, Pageable pageable) {
        if (query == null || query.trim().isEmpty()) {
            return hospitalRepository.findByStatusAndIsActive(
                    Hospital.HospitalStatus.APPROVED, true, pageable);
        }
        return hospitalRepository.searchHospitals(query, pageable);
    }

    // Search all approved hospitals (all registered hospitals that have been approved)
    public Page<Hospital> searchAllApprovedHospitals(String query, Pageable pageable) {
        if (query == null || query.trim().isEmpty()) {
            return hospitalRepository.findByStatus(
                    Hospital.HospitalStatus.APPROVED, pageable);
        }
        return hospitalRepository.searchAllApprovedHospitals(query, pageable);
    }

    public List<Hospital> getFeaturedHospitals() {
        return hospitalRepository.findFeaturedHospitals();
    }

    @Transactional(readOnly = true)
    public Map<String, Object> getDashboardStats(Long hospitalId) {
        Map<String, Object> stats = new HashMap<>();
        
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        // Count pending bookings
        Long pendingBookings = bookingRepository.countByHospitalIdAndStatus(hospitalId, 
                Booking.BookingStatus.PENDING);
        
        // Count this month's bookings (all bookings created this month, regardless of status)
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime startOfMonth = now.withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0).withNano(0);
        
        // Count all bookings created this month - use direct count from repository
        Long monthlyBookings = bookingRepository.countBookingsThisMonth(hospitalId, startOfMonth);
        
        // If query returns null, use fallback method
        if (monthlyBookings == null) {
            // Fallback: count manually by fetching all bookings and filtering
            List<Booking> allBookings = bookingRepository.findByHospitalId(hospitalId);
            monthlyBookings = allBookings.stream()
                    .filter(b -> {
                        if (b.getCreatedAt() == null) return false;
                        LocalDateTime createdAt = b.getCreatedAt();
                        // Check if booking was created in current month
                        return createdAt.getYear() == now.getYear() && 
                               createdAt.getMonthValue() == now.getMonthValue();
                    })
                    .count();
        }
        
        // Calculate revenue this month
        BigDecimal monthlyRevenue = bookingRepository.calculateRevenueThisMonth(hospitalId, startOfMonth);
        
        // Average rating
        Double avgRating = reviewRepository.getAverageRating(hospitalId);
        
        // Count pending enquiries
        long pendingEnquiries = enquiryRepository.countByHospitalIdAndStatus(hospitalId, 
                com.ayurveda.entity.UserEnquiry.EnquiryStatus.PENDING);
        
        stats.put("totalViews", hospital.getTotalViews());
        stats.put("totalBookings", hospital.getTotalBookings());
        stats.put("pendingBookings", pendingBookings);
        stats.put("pendingEnquiries", pendingEnquiries);
        stats.put("thisMonthBookings", monthlyBookings != null ? monthlyBookings : 0L);
        stats.put("monthlyBookings", monthlyBookings != null ? monthlyBookings : 0L);
        stats.put("monthlyRevenue", monthlyRevenue != null ? monthlyRevenue : BigDecimal.ZERO);
        stats.put("averageRating", avgRating != null ? avgRating : 0.0);
        stats.put("totalReviews", hospital.getTotalReviews());
        
        return stats;
    }

    public List<Booking> getRecentBookings(Long hospitalId, int limit) {
        return bookingRepository.findRecentBookingsByStatus(hospitalId, Booking.BookingStatus.PENDING);
    }

    public List<Review> getRecentReviews(Long hospitalId, int limit) {
        return reviewRepository.findByHospitalIdOrderByCreatedAtDesc(hospitalId);
    }

    public List<Hospital> getAllHospitals() {
        return hospitalRepository.findAll();
    }

    public List<Hospital> getHospitalsByCity(String city) {
        return hospitalRepository.findByCity(city);
    }

    public List<Hospital> getHospitalsByState(String state) {
        return hospitalRepository.findByState(state);
    }

    @Transactional
    public Hospital setCoverPhoto(Long hospitalId, String photoUrl) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        hospital.setCoverPhotoUrl(photoUrl);
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public Hospital setLogo(Long hospitalId, String logoUrl) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        hospital.setLogoUrl(logoUrl);
        return hospitalRepository.save(hospital);
    }
}
