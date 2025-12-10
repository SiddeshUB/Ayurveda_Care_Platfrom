package com.ayurveda.service;

import com.ayurveda.entity.Doctor;
import com.ayurveda.entity.DoctorHospitalAssociation;
import com.ayurveda.entity.DoctorHospitalAssociation.AssociationStatus;
import com.ayurveda.entity.Hospital;
import com.ayurveda.repository.DoctorHospitalAssociationRepository;
import com.ayurveda.repository.DoctorRepository;
import com.ayurveda.repository.HospitalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class DoctorHospitalAssociationService {

    private final DoctorHospitalAssociationRepository associationRepository;
    private final DoctorRepository doctorRepository;
    private final HospitalRepository hospitalRepository;

    @Autowired
    public DoctorHospitalAssociationService(DoctorHospitalAssociationRepository associationRepository,
                                           DoctorRepository doctorRepository,
                                           HospitalRepository hospitalRepository) {
        this.associationRepository = associationRepository;
        this.doctorRepository = doctorRepository;
        this.hospitalRepository = hospitalRepository;
    }

    // Doctor requests association with hospital
    @Transactional
    public DoctorHospitalAssociation requestAssociation(Long doctorId, Long hospitalId, String requestMessage) {
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        Hospital hospital = hospitalRepository.findById(hospitalId)
                .orElseThrow(() -> new RuntimeException("Hospital not found"));

        // Check if association already exists
        Optional<DoctorHospitalAssociation> existing = associationRepository
                .findByDoctorIdAndHospitalId(doctorId, hospitalId);
        
        if (existing.isPresent()) {
            DoctorHospitalAssociation assoc = existing.get();
            if (assoc.getStatus() == AssociationStatus.APPROVED) {
                throw new RuntimeException("You are already associated with this hospital");
            }
            if (assoc.getStatus() == AssociationStatus.PENDING) {
                throw new RuntimeException("Association request is already pending");
            }
            // If rejected or suspended, create new request
            if (assoc.getStatus() == AssociationStatus.REJECTED || 
                assoc.getStatus() == AssociationStatus.SUSPENDED) {
                assoc.setStatus(AssociationStatus.PENDING);
                assoc.setRequestMessage(requestMessage);
                return associationRepository.save(assoc);
            }
        }

        // Create new association request
        DoctorHospitalAssociation association = new DoctorHospitalAssociation();
        association.setDoctor(doctor);
        association.setHospital(hospital);
        association.setStatus(AssociationStatus.PENDING);
        association.setRequestMessage(requestMessage);
        
        return associationRepository.save(association);
    }

    // Hospital approves doctor association
    @Transactional
    public DoctorHospitalAssociation approveAssociation(Long associationId, String designation, 
                                                       String consultationDays, String consultationTimings,
                                                       String availableLocations, String hospitalNotes) {
        DoctorHospitalAssociation association = associationRepository.findById(associationId)
                .orElseThrow(() -> new RuntimeException("Association not found"));

        association.setStatus(AssociationStatus.APPROVED);
        association.setApprovedAt(LocalDateTime.now());
        association.setDesignation(designation);
        association.setConsultationDays(consultationDays);
        association.setConsultationTimings(consultationTimings);
        association.setAvailableLocations(availableLocations);
        association.setHospitalNotes(hospitalNotes);
        
        // Set doctor's primary hospital if not set
        Doctor doctor = association.getDoctor();
        if (doctor.getHospital() == null) {
            doctor.setHospital(association.getHospital());
            doctorRepository.save(doctor);
        }

        return associationRepository.save(association);
    }

    // Hospital rejects doctor association
    @Transactional
    public DoctorHospitalAssociation rejectAssociation(Long associationId, String reason) {
        DoctorHospitalAssociation association = associationRepository.findById(associationId)
                .orElseThrow(() -> new RuntimeException("Association not found"));

        association.setStatus(AssociationStatus.REJECTED);
        association.setRejectedAt(LocalDateTime.now());
        association.setHospitalNotes(reason);
        
        return associationRepository.save(association);
    }

    // Hospital suspends doctor association
    @Transactional
    public DoctorHospitalAssociation suspendAssociation(Long associationId, String reason) {
        DoctorHospitalAssociation association = associationRepository.findById(associationId)
                .orElseThrow(() -> new RuntimeException("Association not found"));

        association.setStatus(AssociationStatus.SUSPENDED);
        association.setHospitalNotes(reason);
        
        return associationRepository.save(association);
    }

    // Update association details
    @Transactional
    public DoctorHospitalAssociation updateAssociation(Long associationId, String designation,
                                                       String consultationDays, String consultationTimings,
                                                       String availableLocations, String hospitalNotes) {
        DoctorHospitalAssociation association = associationRepository.findById(associationId)
                .orElseThrow(() -> new RuntimeException("Association not found"));

        if (designation != null) association.setDesignation(designation);
        if (consultationDays != null) association.setConsultationDays(consultationDays);
        if (consultationTimings != null) association.setConsultationTimings(consultationTimings);
        if (availableLocations != null) association.setAvailableLocations(availableLocations);
        if (hospitalNotes != null) association.setHospitalNotes(hospitalNotes);
        
        return associationRepository.save(association);
    }

    // Get all associations for a hospital
    public List<DoctorHospitalAssociation> getAssociationsByHospital(Long hospitalId) {
        return associationRepository.findByHospitalId(hospitalId);
    }

    // Get pending requests for a hospital
    public List<DoctorHospitalAssociation> getPendingRequestsByHospital(Long hospitalId) {
        return associationRepository.findByHospitalIdAndStatus(hospitalId, AssociationStatus.PENDING);
    }

    // Get approved associations for a hospital
    public List<DoctorHospitalAssociation> getApprovedAssociationsByHospital(Long hospitalId) {
        return associationRepository.findByHospitalIdAndStatusOrderByApprovedAtDesc(
                hospitalId, AssociationStatus.APPROVED);
    }

    // Get all associations for a doctor
    public List<DoctorHospitalAssociation> getAssociationsByDoctor(Long doctorId) {
        return associationRepository.findByDoctorId(doctorId);
    }

    // Get approved associations for a doctor
    public List<DoctorHospitalAssociation> getApprovedAssociationsByDoctor(Long doctorId) {
        return associationRepository.findByDoctorIdAndStatusOrderByApprovedAtDesc(
                doctorId, AssociationStatus.APPROVED);
    }

    // Get specific association
    public Optional<DoctorHospitalAssociation> getAssociation(Long doctorId, Long hospitalId) {
        return associationRepository.findByDoctorIdAndHospitalId(doctorId, hospitalId);
    }

    // Check if association exists
    public boolean associationExists(Long doctorId, Long hospitalId) {
        return associationRepository.existsByDoctorIdAndHospitalId(doctorId, hospitalId);
    }

    // Doctor removes association (withdraws request or leaves hospital)
    @Transactional
    public void removeAssociation(Long associationId) {
        DoctorHospitalAssociation association = associationRepository.findById(associationId)
                .orElseThrow(() -> new RuntimeException("Association not found"));
        
        // Only allow removal if pending or approved
        if (association.getStatus() == AssociationStatus.PENDING || 
            association.getStatus() == AssociationStatus.APPROVED) {
            associationRepository.delete(association);
        } else {
            throw new RuntimeException("Cannot remove association in current status");
        }
    }
}

