package com.ayurveda.service;

import com.ayurveda.entity.*;
import com.ayurveda.entity.Hospital.HospitalStatus;
import com.ayurveda.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

@Service
public class AdminService {

    private final AdminRepository adminRepository;
    private final HospitalRepository hospitalRepository;
    private final BookingRepository bookingRepository;
    private final ReviewRepository reviewRepository;
    private final UserRepository userRepository;
    private final DoctorRepository doctorRepository;
    private final ProductRepository productRepository;
    private final UserEnquiryRepository userEnquiryRepository;
    private final DoctorHospitalAssociationRepository associationRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public AdminService(AdminRepository adminRepository,
                       HospitalRepository hospitalRepository,
                       BookingRepository bookingRepository,
                       ReviewRepository reviewRepository,
                       UserRepository userRepository,
                       DoctorRepository doctorRepository,
                       ProductRepository productRepository,
                       UserEnquiryRepository userEnquiryRepository,
                       DoctorHospitalAssociationRepository associationRepository,
                       PasswordEncoder passwordEncoder) {
        this.adminRepository = adminRepository;
        this.hospitalRepository = hospitalRepository;
        this.bookingRepository = bookingRepository;
        this.reviewRepository = reviewRepository;
        this.userRepository = userRepository;
        this.doctorRepository = doctorRepository;
        this.productRepository = productRepository;
        this.userEnquiryRepository = userEnquiryRepository;
        this.associationRepository = associationRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public Optional<Admin> findByEmail(String email) {
        return adminRepository.findByEmail(email);
    }

    public Optional<Admin> findById(Long id) {
        return adminRepository.findById(id);
    }

    @Transactional
    public Admin registerAdmin(Admin admin) {
        // Check if email already exists
        if (adminRepository.existsByEmail(admin.getEmail())) {
            throw new RuntimeException("Email already registered");
        }
        
        // Encode password
        admin.setPassword(passwordEncoder.encode(admin.getPassword()));
        admin.setIsActive(true);
        
        return adminRepository.save(admin);
    }

    @Transactional
    public void updateLastLogin(Long adminId) {
        Admin admin = adminRepository.findById(adminId)
                .orElseThrow(() -> new RuntimeException("Admin not found"));
        admin.setLastLoginAt(LocalDateTime.now());
        adminRepository.save(admin);
    }

    // Dashboard Statistics
    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        
        List<Hospital> allHospitals = hospitalRepository.findAll();
        
        long totalHospitals = allHospitals.size();
        long pendingHospitals = allHospitals.stream()
                .filter(h -> h.getStatus() == HospitalStatus.PENDING).count();
        long approvedHospitals = allHospitals.stream()
                .filter(h -> h.getStatus() == HospitalStatus.APPROVED).count();
        long rejectedHospitals = allHospitals.stream()
                .filter(h -> h.getStatus() == HospitalStatus.REJECTED).count();
        long verifiedHospitals = allHospitals.stream()
                .filter(h -> Boolean.TRUE.equals(h.getIsVerified())).count();
        
        long totalBookings = bookingRepository.count();
        long totalReviews = reviewRepository.count();
        
        stats.put("totalHospitals", totalHospitals);
        stats.put("pendingHospitals", pendingHospitals);
        stats.put("approvedHospitals", approvedHospitals);
        stats.put("rejectedHospitals", rejectedHospitals);
        stats.put("verifiedHospitals", verifiedHospitals);
        stats.put("totalBookings", totalBookings);
        stats.put("totalReviews", totalReviews);
        
        return stats;
    }

    // Hospital Management
    public List<Hospital> getAllHospitals() {
        return hospitalRepository.findAll();
    }

    public List<Hospital> getHospitalsByStatus(HospitalStatus status) {
        return hospitalRepository.findAll().stream()
                .filter(h -> h.getStatus() == status)
                .toList();
    }

    public List<Hospital> getPendingHospitals() {
        return getHospitalsByStatus(HospitalStatus.PENDING);
    }

    public Optional<Hospital> getHospitalById(Long id) {
        return hospitalRepository.findById(id);
    }

    @Transactional
    public Hospital approveHospital(Long hospitalId) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        hospital.setStatus(HospitalStatus.APPROVED);
        hospital.setIsActive(true);
        
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public Hospital rejectHospital(Long hospitalId) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        hospital.setStatus(HospitalStatus.REJECTED);
        
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public Hospital verifyHospital(Long hospitalId) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        hospital.setIsVerified(true);
        
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public Hospital unverifyHospital(Long hospitalId) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        hospital.setIsVerified(false);
        
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public Hospital suspendHospital(Long hospitalId) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        hospital.setStatus(HospitalStatus.SUSPENDED);
        hospital.setIsActive(false);
        
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public Hospital activateHospital(Long hospitalId) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        hospital.setIsActive(true);
        if (hospital.getStatus() == HospitalStatus.SUSPENDED) {
            hospital.setStatus(HospitalStatus.APPROVED);
        }
        
        return hospitalRepository.save(hospital);
    }

    @Transactional
    public Hospital toggleFeatured(Long hospitalId) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        hospital.setIsFeatured(!Boolean.TRUE.equals(hospital.getIsFeatured()));
        
        return hospitalRepository.save(hospital);
    }

    // User Management (View Only)
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }

    // Doctor Management (View Only)
    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    public Optional<Doctor> getDoctorById(Long id) {
        // Use eager fetch to avoid LazyInitializationException when accessing hospital in JSP
        return doctorRepository.findByIdWithHospital(id).or(() -> doctorRepository.findById(id));
    }

    // Booking Management (View Only)
    public List<Booking> getAllBookings() {
        return bookingRepository.findAll();
    }

    public Optional<Booking> getBookingById(Long id) {
        return bookingRepository.findById(id);
    }

    // Product Management (View Only)
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public Optional<Product> getProductById(Long id) {
        // Use eager fetch to avoid LazyInitializationException when accessing vendor/category in JSP
        return productRepository.findByIdWithRelations(id).or(() -> productRepository.findById(id));
    }

    // Enquiry Management (View Only)
    public List<UserEnquiry> getAllEnquiries() {
        try {
            return userEnquiryRepository.findAll();
        } catch (Exception e) {
            // Table might not exist yet
            return new ArrayList<>();
        }
    }

    public Optional<UserEnquiry> getEnquiryById(Long id) {
        return userEnquiryRepository.findById(id);
    }

    // Enhanced Dashboard Stats
    public Map<String, Object> getEnhancedDashboardStats() {
        Map<String, Object> stats = getDashboardStats();
        
        // Safely count entities, handling cases where tables might not exist yet
        long totalUsers = 0;
        long totalDoctors = 0;
        long totalProducts = 0;
        long totalEnquiries = 0;
        long pendingEnquiries = 0;
        
        try {
            totalUsers = userRepository.count();
        } catch (Exception e) {
            // Table might not exist yet
        }
        
        try {
            totalDoctors = doctorRepository.count();
        } catch (Exception e) {
            // Table might not exist yet
        }
        
        try {
            totalProducts = productRepository.count();
        } catch (Exception e) {
            // Table might not exist yet
        }
        
        try {
            totalEnquiries = userEnquiryRepository.count();
            pendingEnquiries = userEnquiryRepository.findAll().stream()
                    .filter(e -> e.getStatus() == UserEnquiry.EnquiryStatus.PENDING)
                    .count();
        } catch (Exception e) {
            // Table might not exist yet
        }
        
        stats.put("totalUsers", totalUsers);
        stats.put("totalDoctors", totalDoctors);
        stats.put("totalProducts", totalProducts);
        stats.put("totalEnquiries", totalEnquiries);
        stats.put("pendingEnquiries", pendingEnquiries);
        
        return stats;
    }

    // Get Hospital Complete Details
    @Transactional(readOnly = true)
    public Map<String, Object> getHospitalCompleteDetails(Long hospitalId) {
        Map<String, Object> details = new HashMap<>();
        
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        // Get directly registered doctors
        List<Doctor> directDoctors = doctorRepository.findByHospitalId(hospitalId);
        
        // Get doctors from associations
        List<DoctorHospitalAssociation> associations = associationRepository.findByHospitalId(hospitalId);
        List<Doctor> associatedDoctors = associations.stream()
                .filter(a -> a.getDoctor() != null)
                .map(DoctorHospitalAssociation::getDoctor)
                .distinct()
                .toList();
        
        // Combine doctors (avoid duplicates)
        Set<Long> doctorIds = new HashSet<>();
        List<Doctor> allDoctors = new ArrayList<>();
        for (Doctor doc : directDoctors) {
            if (doctorIds.add(doc.getId())) {
                allDoctors.add(doc);
            }
        }
        for (Doctor doc : associatedDoctors) {
            if (doctorIds.add(doc.getId())) {
                allDoctors.add(doc);
            }
        }
        
        // Get bookings
        List<Booking> bookings = bookingRepository.findByHospitalId(hospitalId);
        
        // Get enquiries
        List<UserEnquiry> enquiries = userEnquiryRepository.findByHospitalId(hospitalId);
        
        // Get unique users from bookings and enquiries
        Set<Long> userIds = new HashSet<>();
        List<User> users = new ArrayList<>();
        for (Booking booking : bookings) {
            if (booking.getUser() != null && userIds.add(booking.getUser().getId())) {
                users.add(booking.getUser());
            }
        }
        for (UserEnquiry enquiry : enquiries) {
            if (enquiry.getUser() != null && userIds.add(enquiry.getUser().getId())) {
                users.add(enquiry.getUser());
            }
        }
        
        details.put("hospital", hospital);
        details.put("doctors", allDoctors);
        details.put("users", users);
        details.put("bookings", bookings);
        details.put("enquiries", enquiries);
        details.put("associations", associations);
        
        return details;
    }
}

