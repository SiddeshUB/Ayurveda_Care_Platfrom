package com.ayurveda.service;

import com.ayurveda.entity.*;
import com.ayurveda.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final SavedCenterRepository savedCenterRepository;
    private final UserEnquiryRepository enquiryRepository;
    private final HospitalRepository hospitalRepository;
    private final BookingRepository bookingRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepository userRepository,
                      SavedCenterRepository savedCenterRepository,
                      UserEnquiryRepository enquiryRepository,
                      HospitalRepository hospitalRepository,
                      BookingRepository bookingRepository,
                      PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.savedCenterRepository = savedCenterRepository;
        this.enquiryRepository = enquiryRepository;
        this.hospitalRepository = hospitalRepository;
        this.bookingRepository = bookingRepository;
        this.passwordEncoder = passwordEncoder;
    }

    // User Registration
    @Transactional
    public User registerUser(User user) {
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            throw new RuntimeException("Email is required");
        }
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            throw new RuntimeException("Password is required");
        }
        if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
            throw new RuntimeException("Full name is required");
        }

        String email = user.getEmail().trim().toLowerCase();
        user.setEmail(email);

        if (userRepository.existsByEmail(email)) {
            throw new RuntimeException("Email already registered. Please use a different email or try logging in.");
        }

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setIsActive(true);
        user.setEmailVerified(false);

        return userRepository.save(user);
    }

    // Find User
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }

    // Update Last Login
    @Transactional
    public void updateLastLogin(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        user.setLastLoginAt(LocalDateTime.now());
        userRepository.save(user);
    }

    // Update Profile
    @Transactional
    public User updateProfile(Long userId, User updateData) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (updateData.getFullName() != null) user.setFullName(updateData.getFullName());
        if (updateData.getPhone() != null) user.setPhone(updateData.getPhone());
        if (updateData.getCountry() != null) user.setCountry(updateData.getCountry());
        if (updateData.getCity() != null) user.setCity(updateData.getCity());
        if (updateData.getState() != null) user.setState(updateData.getState());
        if (updateData.getAddress() != null) user.setAddress(updateData.getAddress());
        if (updateData.getGender() != null) user.setGender(updateData.getGender());
        if (updateData.getDateOfBirth() != null) user.setDateOfBirth(updateData.getDateOfBirth());
        if (updateData.getPurpose() != null) user.setPurpose(updateData.getPurpose());

        return userRepository.save(user);
    }

    // Change Password
    @Transactional
    public void changePassword(Long userId, String oldPassword, String newPassword) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            throw new RuntimeException("Current password is incorrect");
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
    }

    // Saved Centers
    @Transactional
    public SavedCenter saveCenter(Long userId, Long hospitalId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));

        if (savedCenterRepository.existsByUserIdAndHospitalId(userId, hospitalId)) {
            throw new RuntimeException("Hospital already saved");
        }

        SavedCenter savedCenter = new SavedCenter();
        savedCenter.setUser(user);
        savedCenter.setHospital(hospital);

        return savedCenterRepository.save(savedCenter);
    }

    public List<SavedCenter> getSavedCenters(Long userId) {
        return savedCenterRepository.findByUserId(userId);
    }

    @Transactional
    public void removeSavedCenter(Long userId, Long savedCenterId) {
        SavedCenter savedCenter = savedCenterRepository.findById(savedCenterId)
                .orElseThrow(() -> new RuntimeException("Saved center not found"));

        if (!savedCenter.getUser().getId().equals(userId)) {
            throw new RuntimeException("Unauthorized");
        }

        savedCenterRepository.delete(savedCenter);
    }

    // User Enquiries
    @Transactional
    public UserEnquiry createEnquiry(Long userId, Long hospitalId, UserEnquiry enquiry) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));

        enquiry.setHospital(hospital);
        enquiry.setStatus(UserEnquiry.EnquiryStatus.PENDING);

        if (userId != null) {
            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            enquiry.setUser(user);
            // Auto-fill from user profile if not provided
            if (enquiry.getName() == null) enquiry.setName(user.getFullName());
            if (enquiry.getEmail() == null) enquiry.setEmail(user.getEmail());
            if (enquiry.getPhone() == null) enquiry.setPhone(user.getPhone());
            if (enquiry.getCountry() == null) enquiry.setCountry(user.getCountry());
        }

        return enquiryRepository.save(enquiry);
    }

    public List<UserEnquiry> getUserEnquiries(Long userId) {
        try {
            return enquiryRepository.findByUserId(userId);
        } catch (Exception e) {
            // Table might not exist yet
            return new ArrayList<>();
        }
    }

    public Optional<UserEnquiry> getEnquiryById(Long enquiryId) {
        return enquiryRepository.findById(enquiryId);
    }

    // Dashboard Stats
    public Map<String, Object> getDashboardStats(Long userId) {
        long savedCentersCount = 0;
        long enquiriesCount = 0;
        long pendingEnquiriesCount = 0;
        long totalBookings = 0;
        long pendingBookings = 0;
        long confirmedBookings = 0;
        
        try {
            savedCentersCount = savedCenterRepository.findByUserId(userId).size();
        } catch (Exception e) {
            // Table might not exist yet
        }
        
        try {
            List<UserEnquiry> enquiries = enquiryRepository.findByUserId(userId);
            enquiriesCount = enquiries.size();
            pendingEnquiriesCount = enquiries.stream()
                    .filter(e -> e.getStatus() == UserEnquiry.EnquiryStatus.PENDING)
                    .count();
        } catch (Exception e) {
            // Table might not exist yet
        }
        
        try {
            List<Booking> bookings = bookingRepository.findByUserIdOrderByCreatedAtDesc(userId);
            totalBookings = bookings.size();
            pendingBookings = bookings.stream()
                    .filter(b -> b.getStatus() == Booking.BookingStatus.PENDING)
                    .count();
            confirmedBookings = bookings.stream()
                    .filter(b -> b.getStatus() == Booking.BookingStatus.CONFIRMED)
                    .count();
        } catch (Exception e) {
            // Table might not exist yet
        }

        Map<String, Object> stats = new java.util.HashMap<>();
        stats.put("savedCenters", savedCentersCount);
        stats.put("totalEnquiries", enquiriesCount);
        stats.put("pendingEnquiries", pendingEnquiriesCount);
        stats.put("totalBookings", totalBookings);
        stats.put("pendingBookings", pendingBookings);
        stats.put("confirmedBookings", confirmedBookings);
        
        return stats;
    }

    // Password Reset
    @Transactional
    public void generatePasswordResetToken(String email, String phone) {
        User user = userRepository.findByEmail(email.toLowerCase().trim())
                .orElseThrow(() -> new RuntimeException("User not found with this email"));

        if (user.getPhone() == null || !user.getPhone().equals(phone)) {
            throw new RuntimeException("Phone number does not match the registered phone number");
        }

        String token = java.util.UUID.randomUUID().toString();
        user.setPasswordResetToken(token);
        user.setPasswordResetTokenExpiry(LocalDateTime.now().plusHours(1));
        userRepository.save(user);
    }

    public Optional<User> findByPasswordResetToken(String token) {
        return userRepository.findByPasswordResetToken(token)
                .filter(user -> user.getPasswordResetTokenExpiry() != null &&
                        user.getPasswordResetTokenExpiry().isAfter(LocalDateTime.now()));
    }

    @Transactional
    public void resetPassword(String token, String newPassword) {
        User user = findByPasswordResetToken(token)
                .orElseThrow(() -> new RuntimeException("Invalid or expired reset token"));

        user.setPassword(passwordEncoder.encode(newPassword));
        user.setPasswordResetToken(null);
        user.setPasswordResetTokenExpiry(null);
        userRepository.save(user);
    }
}

