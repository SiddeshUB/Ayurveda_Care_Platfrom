package com.ayurveda.repository;

import com.ayurveda.entity.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DoctorRepository extends JpaRepository<Doctor, Long> {
    
    @Query("SELECT d FROM Doctor d WHERE LOWER(d.email) = LOWER(:email)")
    Optional<Doctor> findByEmail(@Param("email") String email);
    
    @Query("SELECT CASE WHEN COUNT(d) > 0 THEN true ELSE false END FROM Doctor d WHERE LOWER(d.email) = LOWER(:email)")
    boolean existsByEmail(@Param("email") String email);
    
    List<Doctor> findByHospitalId(Long hospitalId);
    
    List<Doctor> findByHospitalIdAndIsActiveTrue(Long hospitalId);
    
    List<Doctor> findByIsActiveTrueAndIsVerifiedTrue();
    
    Optional<Doctor> findByPasswordResetToken(String token);
}
