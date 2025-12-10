package com.ayurveda.repository;

import com.ayurveda.entity.DoctorHospitalAssociation;
import com.ayurveda.entity.DoctorHospitalAssociation.AssociationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DoctorHospitalAssociationRepository extends JpaRepository<DoctorHospitalAssociation, Long> {
    
    // Find associations by hospital
    List<DoctorHospitalAssociation> findByHospitalId(Long hospitalId);
    
    // Find associations by doctor
    List<DoctorHospitalAssociation> findByDoctorId(Long doctorId);
    
    // Find associations by status
    List<DoctorHospitalAssociation> findByHospitalIdAndStatus(Long hospitalId, AssociationStatus status);
    
    List<DoctorHospitalAssociation> findByDoctorIdAndStatus(Long doctorId, AssociationStatus status);
    
    // Find specific association
    Optional<DoctorHospitalAssociation> findByDoctorIdAndHospitalId(Long doctorId, Long hospitalId);
    
    // Check if association exists
    boolean existsByDoctorIdAndHospitalId(Long doctorId, Long hospitalId);
    
    // Find approved associations
    List<DoctorHospitalAssociation> findByHospitalIdAndStatusOrderByApprovedAtDesc(Long hospitalId, AssociationStatus status);
    
    List<DoctorHospitalAssociation> findByDoctorIdAndStatusOrderByApprovedAtDesc(Long doctorId, AssociationStatus status);
}

