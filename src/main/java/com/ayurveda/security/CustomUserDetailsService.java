package com.ayurveda.security;

import java.util.Collections;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.ayurveda.entity.Admin;
import com.ayurveda.entity.Doctor;
import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.User;
import com.ayurveda.repository.AdminRepository;
import com.ayurveda.repository.DoctorRepository;
import com.ayurveda.repository.HospitalRepository;
import com.ayurveda.repository.UserRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final HospitalRepository hospitalRepository;
    private final AdminRepository adminRepository;
    private final DoctorRepository doctorRepository;
    private final UserRepository userRepository;

    @Autowired
    public CustomUserDetailsService(HospitalRepository hospitalRepository, 
                                   AdminRepository adminRepository,
                                   DoctorRepository doctorRepository,
                                   UserRepository userRepository) {
        this.hospitalRepository = hospitalRepository;
        this.adminRepository = adminRepository;
        this.doctorRepository = doctorRepository;
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        // Normalize email to lowercase (same as registration)
        String normalizedEmail = email != null ? email.trim().toLowerCase() : null;
        if (normalizedEmail == null || normalizedEmail.isEmpty()) {
            throw new UsernameNotFoundException("Email cannot be empty");
        }

        // First check if it's an admin
        Optional<Admin> adminOpt = adminRepository.findByEmail(normalizedEmail);
        if (adminOpt.isPresent()) {
            Admin admin = adminOpt.get();
            return new org.springframework.security.core.userdetails.User(
                    admin.getEmail(),
                    admin.getPassword(),
                    admin.getIsActive() != null && admin.getIsActive(),
                    true,
                    true,
                    true,
                    Collections.singletonList(new SimpleGrantedAuthority("ROLE_ADMIN"))
            );
        }

        // Then check if it's a doctor
        Optional<Doctor> doctorOpt = doctorRepository.findByEmail(normalizedEmail);
        if (doctorOpt.isPresent()) {
            Doctor doctor = doctorOpt.get();
            // Log for debugging
            System.out.println("=== Doctor Login Attempt ===");
            System.out.println("Email: " + normalizedEmail);
            System.out.println("Doctor Found: " + doctor.getName());
            System.out.println("IsActive: " + doctor.getIsActive());
            System.out.println("IsVerified: " + doctor.getIsVerified());
            System.out.println("Password Hash: " + (doctor.getPassword() != null ? doctor.getPassword().substring(0, Math.min(20, doctor.getPassword().length())) + "..." : "NULL"));
            
            boolean isActive = doctor.getIsActive() != null && doctor.getIsActive();
            if (!isActive) {
                System.out.println("WARNING: Doctor account is not active!");
            }
            
            return new org.springframework.security.core.userdetails.User(
                    doctor.getEmail(),
                    doctor.getPassword(),
                    isActive,
                    true,
                    true,
                    isActive,
                    Collections.singletonList(new SimpleGrantedAuthority("ROLE_DOCTOR"))
            );
        }

        // Then check if it's a hospital
        Optional<Hospital> hospitalOpt = hospitalRepository.findByEmail(normalizedEmail);
        if (hospitalOpt.isPresent()) {
            Hospital hospital = hospitalOpt.get();
            return new org.springframework.security.core.userdetails.User(
                    hospital.getEmail(),
                    hospital.getPassword(),
                    hospital.getIsActive() != null && hospital.getIsActive(),
                    true,
                    true,
                    hospital.getStatus() != Hospital.HospitalStatus.SUSPENDED,
                    Collections.singletonList(new SimpleGrantedAuthority("ROLE_HOSPITAL"))
            );
        }

        // Finally check if it's a regular user
        Optional<User> userOpt = userRepository.findByEmail(normalizedEmail);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            return new org.springframework.security.core.userdetails.User(
                    user.getEmail(),
                    user.getPassword(),
                    user.getIsActive() != null && user.getIsActive(),
                    true,
                    true,
                    user.getIsActive() != null && user.getIsActive(),
                    Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"))
            );
        }

        throw new UsernameNotFoundException("User not found with email: " + email);
    }
}
