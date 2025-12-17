package com.ayurveda.service;

import com.ayurveda.entity.Doctor;
import com.ayurveda.entity.Hospital;
import com.ayurveda.repository.DoctorRepository;
import com.ayurveda.repository.HospitalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class DoctorService {

    private final DoctorRepository doctorRepository;
    private final HospitalRepository hospitalRepository;
    private final FileStorageService fileStorageService;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public DoctorService(DoctorRepository doctorRepository,
                        HospitalRepository hospitalRepository,
                        FileStorageService fileStorageService,
                        PasswordEncoder passwordEncoder) {
        this.doctorRepository = doctorRepository;
        this.hospitalRepository = hospitalRepository;
        this.fileStorageService = fileStorageService;
        this.passwordEncoder = passwordEncoder;
    }

    // Registration & Authentication
    public Optional<Doctor> findByEmail(String email) {
        return doctorRepository.findByEmail(email);
    }

    @Transactional
    public Doctor registerDoctor(Doctor doctor) {
        // Validate required fields
        if (doctor.getEmail() == null || doctor.getEmail().trim().isEmpty()) {
            throw new RuntimeException("Email is required");
        }
        if (doctor.getPassword() == null || doctor.getPassword().trim().isEmpty()) {
            throw new RuntimeException("Password is required");
        }
        if (doctor.getName() == null || doctor.getName().trim().isEmpty()) {
            throw new RuntimeException("Name is required");
        }
        
        // Trim and normalize email
        String email = doctor.getEmail().trim().toLowerCase();
        doctor.setEmail(email);
        
        // Check if email already exists (with better error message)
        if (doctorRepository.existsByEmail(email)) {
            Optional<Doctor> existingDoctor = doctorRepository.findByEmail(email);
            if (existingDoctor.isPresent()) {
                throw new RuntimeException("This email address (" + email + ") is already registered. Please use a different email or try logging in.");
            }
            throw new RuntimeException("Email already registered. Please use a different email.");
        }
        
        // Encode password
        doctor.setPassword(passwordEncoder.encode(doctor.getPassword()));
        
        // Set default values
        doctor.setIsActive(true);
        doctor.setIsAvailable(true);
        doctor.setIsVerified(false); // Will be verified by hospital/admin later
        doctor.setProfileComplete(false);
        
        // Ensure hospital is null (doctors register independently)
        doctor.setHospital(null);
        
        // Convert empty strings to null for optional fields
        if (doctor.getGender() != null && doctor.getGender().trim().isEmpty()) {
            doctor.setGender(null);
        }
        if (doctor.getPhone() != null && doctor.getPhone().trim().isEmpty()) {
            doctor.setPhone(null);
        }
        if (doctor.getQualifications() != null && doctor.getQualifications().trim().isEmpty()) {
            doctor.setQualifications(null);
        }
        if (doctor.getSpecializations() != null && doctor.getSpecializations().trim().isEmpty()) {
            doctor.setSpecializations(null);
        }
        if (doctor.getRegistrationNumber() != null && doctor.getRegistrationNumber().trim().isEmpty()) {
            doctor.setRegistrationNumber(null);
        }
        if (doctor.getDegreeUniversity() != null && doctor.getDegreeUniversity().trim().isEmpty()) {
            doctor.setDegreeUniversity(null);
        }
        if (doctor.getLanguagesSpoken() != null && doctor.getLanguagesSpoken().trim().isEmpty()) {
            doctor.setLanguagesSpoken(null);
        }
        if (doctor.getBiography() != null && doctor.getBiography().trim().isEmpty()) {
            doctor.setBiography(null);
        }
        if (doctor.getConsultationDays() != null && doctor.getConsultationDays().trim().isEmpty()) {
            doctor.setConsultationDays(null);
        }
        if (doctor.getConsultationTimings() != null && doctor.getConsultationTimings().trim().isEmpty()) {
            doctor.setConsultationTimings(null);
        }
        if (doctor.getAvailableLocations() != null && doctor.getAvailableLocations().trim().isEmpty()) {
            doctor.setAvailableLocations(null);
        }
        
        // Debug: Print doctor object before saving
        System.out.println("=== Doctor Registration Debug ===");
        System.out.println("Name: " + doctor.getName());
        System.out.println("Email: " + doctor.getEmail());
        System.out.println("Password: " + (doctor.getPassword() != null ? "[SET]" : "[NULL]"));
        System.out.println("Gender: " + doctor.getGender());
        System.out.println("Phone: " + doctor.getPhone());
        System.out.println("Qualifications: " + doctor.getQualifications());
        System.out.println("Registration Number: " + doctor.getRegistrationNumber());
        System.out.println("IsActive: " + doctor.getIsActive());
        System.out.println("IsAvailable: " + doctor.getIsAvailable());
        System.out.println("Hospital: " + (doctor.getHospital() != null ? doctor.getHospital().getId() : "null"));
        
        try {
            // Double-check email doesn't exist before saving
            if (doctorRepository.existsByEmail(doctor.getEmail())) {
                throw new RuntimeException("Email '" + doctor.getEmail() + "' is already registered. Please use a different email or try logging in.");
            }
            
            return doctorRepository.save(doctor);
        } catch (org.springframework.dao.DataIntegrityViolationException e) {
            Throwable rootCause = e.getRootCause();
            String errorMsg = rootCause != null ? rootCause.getMessage() : e.getMessage();
            
            System.err.println("=== DataIntegrityViolationException ===");
            System.err.println("Root Cause: " + (rootCause != null ? rootCause.getClass().getName() : "null"));
            System.err.println("Error Message: " + errorMsg);
            System.err.println("Doctor Email: " + doctor.getEmail());
            e.printStackTrace();
            
            if (errorMsg != null) {
                if (errorMsg.contains("Duplicate entry") || errorMsg.contains("1062") || 
                    errorMsg.toLowerCase().contains("email") || errorMsg.contains("unique")) {
                    throw new RuntimeException("Email '" + doctor.getEmail() + "' is already registered. Please use a different email.");
                }
                if (errorMsg.contains("cannot be null") || errorMsg.contains("NOT NULL")) {
                    throw new RuntimeException("Required field is missing. Please fill all required fields: Name, Email, Password, Qualifications, Registration Number.");
                }
            }
            throw new RuntimeException("Database constraint violation: " + (errorMsg != null ? errorMsg : "Unknown error"));
        } catch (jakarta.persistence.PersistenceException e) {
            Throwable rootCause = e.getCause();
            String errorMsg = rootCause != null ? rootCause.getMessage() : e.getMessage();
            
            System.err.println("=== PersistenceException ===");
            System.err.println("Error: " + errorMsg);
            System.err.println("Doctor Email: " + doctor.getEmail());
            e.printStackTrace();
            
            throw new RuntimeException("Registration failed: " + (errorMsg != null ? errorMsg : e.getClass().getSimpleName()));
        } catch (RuntimeException e) {
            // Re-throw our custom exceptions
            throw e;
        } catch (Exception e) {
            // Log the full error for debugging
            System.err.println("=== Exception during registration ===");
            System.err.println("Error: " + e.getMessage());
            System.err.println("Error Type: " + e.getClass().getName());
            System.err.println("Email being registered: " + doctor.getEmail());
            e.printStackTrace();
            throw new RuntimeException("Registration failed: " + e.getMessage());
        }
    }

    @Transactional
    public void updateLastLogin(Long doctorId) {
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        doctor.setLastLoginAt(LocalDateTime.now());
        doctorRepository.save(doctor);
    }

    public List<Doctor> getDoctorsByHospital(Long hospitalId) {
        return doctorRepository.findByHospitalId(hospitalId);
    }

    public List<Doctor> getActiveDoctorsByHospital(Long hospitalId) {
        return doctorRepository.findByHospitalIdAndIsActiveTrue(hospitalId);
    }

    public List<Doctor> getAllActiveVerifiedDoctors() {
        return doctorRepository.findByIsActiveTrueAndIsVerifiedTrue();
    }

    public List<Doctor> searchDoctors(String searchTerm) {
        List<Doctor> allDoctors = getAllActiveVerifiedDoctors();
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return allDoctors;
        }
        
        String lowerSearch = searchTerm.toLowerCase().trim();
        return allDoctors.stream()
                .filter(doctor -> 
                    (doctor.getName() != null && doctor.getName().toLowerCase().contains(lowerSearch)) ||
                    (doctor.getSpecializations() != null && doctor.getSpecializations().toLowerCase().contains(lowerSearch)) ||
                    (doctor.getQualifications() != null && doctor.getQualifications().toLowerCase().contains(lowerSearch)) ||
                    (doctor.getHospital() != null && doctor.getHospital().getCenterName() != null && 
                     doctor.getHospital().getCenterName().toLowerCase().contains(lowerSearch))
                )
                .toList();
    }

    public Optional<Doctor> findById(Long id) {
        return doctorRepository.findById(id);
    }

    public Optional<Doctor> getPublicDoctorProfile(Long id) {
        Optional<Doctor> doctorOpt = doctorRepository.findById(id);
        if (doctorOpt.isPresent()) {
            Doctor doctor = doctorOpt.get();
            // Only return if active and verified
            if (Boolean.TRUE.equals(doctor.getIsActive()) && Boolean.TRUE.equals(doctor.getIsVerified())) {
                return Optional.of(doctor);
            }
        }
        return Optional.empty();
    }

    @Transactional
    public Doctor createDoctor(Long hospitalId, Doctor doctor) {
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));
        
        // Validate required fields for registration
        if (doctor.getEmail() == null || doctor.getEmail().trim().isEmpty()) {
            throw new RuntimeException("Email is required for doctor registration");
        }
        if (doctor.getPassword() == null || doctor.getPassword().trim().isEmpty()) {
            throw new RuntimeException("Password is required for doctor registration");
        }
        if (doctor.getName() == null || doctor.getName().trim().isEmpty()) {
            throw new RuntimeException("Doctor name is required");
        }
        
        // Trim and normalize email
        String email = doctor.getEmail().trim().toLowerCase();
        doctor.setEmail(email);
        
        // Check if email already exists
        if (doctorRepository.existsByEmail(email)) {
            throw new RuntimeException("Email '" + email + "' is already registered. Please use a different email.");
        }
        
        // Encode password
        doctor.setPassword(passwordEncoder.encode(doctor.getPassword()));
        
        // Set hospital association
        doctor.setHospital(hospital);
        
        // Set default values
        doctor.setIsActive(true);
        doctor.setIsAvailable(true);
        doctor.setIsVerified(true); // Verified by hospital
        doctor.setProfileComplete(false);
        
        // Convert empty strings to null for optional fields
        if (doctor.getGender() != null && doctor.getGender().trim().isEmpty()) {
            doctor.setGender(null);
        }
        if (doctor.getPhone() != null && doctor.getPhone().trim().isEmpty()) {
            doctor.setPhone(null);
        }
        if (doctor.getQualifications() != null && doctor.getQualifications().trim().isEmpty()) {
            doctor.setQualifications(null);
        }
        if (doctor.getSpecializations() != null && doctor.getSpecializations().trim().isEmpty()) {
            doctor.setSpecializations(null);
        }
        if (doctor.getRegistrationNumber() != null && doctor.getRegistrationNumber().trim().isEmpty()) {
            doctor.setRegistrationNumber(null);
        }
        if (doctor.getDegreeUniversity() != null && doctor.getDegreeUniversity().trim().isEmpty()) {
            doctor.setDegreeUniversity(null);
        }
        if (doctor.getLanguagesSpoken() != null && doctor.getLanguagesSpoken().trim().isEmpty()) {
            doctor.setLanguagesSpoken(null);
        }
        if (doctor.getBiography() != null && doctor.getBiography().trim().isEmpty()) {
            doctor.setBiography(null);
        }
        if (doctor.getConsultationDays() != null && doctor.getConsultationDays().trim().isEmpty()) {
            doctor.setConsultationDays(null);
        }
        if (doctor.getConsultationTimings() != null && doctor.getConsultationTimings().trim().isEmpty()) {
            doctor.setConsultationTimings(null);
        }
        if (doctor.getAvailableLocations() != null && doctor.getAvailableLocations().trim().isEmpty()) {
            doctor.setAvailableLocations(null);
        }
        
        try {
            return doctorRepository.save(doctor);
        } catch (org.springframework.dao.DataIntegrityViolationException e) {
            Throwable rootCause = e.getRootCause();
            String errorMsg = rootCause != null ? rootCause.getMessage() : e.getMessage();
            
            if (errorMsg != null && (errorMsg.contains("Duplicate entry") || errorMsg.contains("1062") || 
                errorMsg.toLowerCase().contains("email") || errorMsg.contains("unique"))) {
                throw new RuntimeException("Email '" + email + "' is already registered. Please use a different email.");
            }
            throw new RuntimeException("Registration failed: " + (errorMsg != null ? errorMsg : "Database constraint violation"));
        }
    }

    @Transactional
    public Doctor updateDoctor(Long doctorId, Doctor updateData) {
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        if (updateData.getName() != null) doctor.setName(updateData.getName());
        if (updateData.getGender() != null) doctor.setGender(updateData.getGender());
        if (updateData.getPhone() != null) doctor.setPhone(updateData.getPhone());
        if (updateData.getQualifications() != null) doctor.setQualifications(updateData.getQualifications());
        if (updateData.getSpecializations() != null) doctor.setSpecializations(updateData.getSpecializations());
        if (updateData.getExperienceYears() != null) doctor.setExperienceYears(updateData.getExperienceYears());
        if (updateData.getLanguagesSpoken() != null) doctor.setLanguagesSpoken(updateData.getLanguagesSpoken());
        if (updateData.getBiography() != null) doctor.setBiography(updateData.getBiography());
        if (updateData.getConsultationTimings() != null) doctor.setConsultationTimings(updateData.getConsultationTimings());
        if (updateData.getConsultationDays() != null) doctor.setConsultationDays(updateData.getConsultationDays());
        if (updateData.getRegistrationNumber() != null) doctor.setRegistrationNumber(updateData.getRegistrationNumber());
        if (updateData.getDegreeUniversity() != null) doctor.setDegreeUniversity(updateData.getDegreeUniversity());
        if (updateData.getAvailableLocations() != null) doctor.setAvailableLocations(updateData.getAvailableLocations());
        if (updateData.getIsActive() != null) doctor.setIsActive(updateData.getIsActive());
        if (updateData.getIsAvailable() != null) doctor.setIsAvailable(updateData.getIsAvailable());
        
        return doctorRepository.save(doctor);
    }

    @Transactional
    public void deleteDoctor(Long doctorId) {
        doctorRepository.deleteById(doctorId);
    }

    @Transactional
    public void toggleDoctorStatus(Long doctorId) {
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        doctor.setIsActive(!doctor.getIsActive());
        doctorRepository.save(doctor);
    }

    @Transactional
    public Doctor uploadDoctorPhoto(Long doctorId, MultipartFile file) throws IOException {
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        String fileName = fileStorageService.storeFile(file, "doctors");
        doctor.setPhotoUrl("/uploads/doctors/" + fileName);
        
        return doctorRepository.save(doctor);
    }

    // Password Reset
    @Transactional
    public void generatePasswordResetToken(String email, String phone) {
        Doctor doctor = doctorRepository.findByEmail(email.toLowerCase().trim())
                .orElseThrow(() -> new RuntimeException("Doctor not found with this email"));

        if (doctor.getPhone() == null || !doctor.getPhone().equals(phone)) {
            throw new RuntimeException("Phone number does not match the registered phone number");
        }

        String token = java.util.UUID.randomUUID().toString();
        doctor.setPasswordResetToken(token);
        doctor.setPasswordResetTokenExpiry(LocalDateTime.now().plusHours(1));
        doctorRepository.save(doctor);
    }

    public Optional<Doctor> findByPasswordResetToken(String token) {
        return doctorRepository.findByPasswordResetToken(token)
                .filter(doctor -> doctor.getPasswordResetTokenExpiry() != null &&
                        doctor.getPasswordResetTokenExpiry().isAfter(LocalDateTime.now()));
    }

    @Transactional
    public void resetPassword(String token, String newPassword) {
        Doctor doctor = findByPasswordResetToken(token)
                .orElseThrow(() -> new RuntimeException("Invalid or expired reset token"));

        doctor.setPassword(passwordEncoder.encode(newPassword));
        doctor.setPasswordResetToken(null);
        doctor.setPasswordResetTokenExpiry(null);
        doctorRepository.save(doctor);
    }
}
