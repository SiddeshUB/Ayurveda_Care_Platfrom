package com.ayurveda.repository;

import com.ayurveda.entity.Prescription;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PrescriptionRepository extends JpaRepository<Prescription, Long> {
    
    Optional<Prescription> findByPrescriptionNumber(String prescriptionNumber);
    
    List<Prescription> findByDoctorId(Long doctorId);
    
    List<Prescription> findByConsultationId(Long consultationId);
    
    List<Prescription> findByPatientEmail(String patientEmail);
    
    List<Prescription> findByDoctorIdOrderByCreatedAtDesc(Long doctorId);
}

