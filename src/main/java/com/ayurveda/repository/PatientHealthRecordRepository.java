package com.ayurveda.repository;

import com.ayurveda.entity.PatientHealthRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PatientHealthRecordRepository extends JpaRepository<PatientHealthRecord, Long> {
    
    Optional<PatientHealthRecord> findByRecordNumber(String recordNumber);
    
    Optional<PatientHealthRecord> findByPatientEmail(String patientEmail);
    
    List<PatientHealthRecord> findByDoctorId(Long doctorId);
    
    List<PatientHealthRecord> findByHospitalId(Long hospitalId);
    
    @Query("SELECT r FROM PatientHealthRecord r WHERE r.patientEmail = :email ORDER BY r.updatedAt DESC")
    List<PatientHealthRecord> findByPatientEmailOrderByUpdatedAtDesc(@Param("email") String email);
}

