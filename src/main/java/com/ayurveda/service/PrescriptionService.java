package com.ayurveda.service;

import com.ayurveda.entity.*;
import com.ayurveda.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class PrescriptionService {

    private final PrescriptionRepository prescriptionRepository;
    private final PrescriptionMedicineRepository prescriptionMedicineRepository;
    private final ConsultationRepository consultationRepository;
    private final MedicineRepository medicineRepository;

    @Autowired
    public PrescriptionService(PrescriptionRepository prescriptionRepository,
                             PrescriptionMedicineRepository prescriptionMedicineRepository,
                             ConsultationRepository consultationRepository,
                             MedicineRepository medicineRepository) {
        this.prescriptionRepository = prescriptionRepository;
        this.prescriptionMedicineRepository = prescriptionMedicineRepository;
        this.consultationRepository = consultationRepository;
        this.medicineRepository = medicineRepository;
    }

    // Create prescription
    @Transactional
    public Prescription createPrescription(Long consultationId, Prescription prescription, 
                                          List<PrescriptionMedicine> medicines) {
        Consultation consultation = consultationRepository.findById(consultationId)
                .orElseThrow(() -> new RuntimeException("Consultation not found"));

        prescription.setConsultation(consultation);
        prescription.setDoctor(consultation.getDoctor());
        prescription.setHospital(consultation.getHospital());
        
        // Copy patient info from consultation
        prescription.setPatientName(consultation.getPatientName());
        prescription.setPatientEmail(consultation.getPatientEmail());
        prescription.setPatientPhone(consultation.getPatientPhone());
        prescription.setPatientAge(consultation.getPatientAge());
        prescription.setPatientGender(consultation.getPatientGender());
        
        Prescription savedPrescription = prescriptionRepository.save(prescription);
        
        // Save medicines
        if (medicines != null && !medicines.isEmpty()) {
            for (PrescriptionMedicine medicine : medicines) {
                medicine.setPrescription(savedPrescription);
                prescriptionMedicineRepository.save(medicine);
            }
        }
        
        return savedPrescription;
    }

    // Update prescription
    @Transactional
    public Prescription updatePrescription(Long prescriptionId, Prescription updateData,
                                          List<PrescriptionMedicine> medicines) {
        Prescription prescription = prescriptionRepository.findById(prescriptionId)
                .orElseThrow(() -> new RuntimeException("Prescription not found"));
        
        if (updateData.getChiefComplaints() != null) prescription.setChiefComplaints(updateData.getChiefComplaints());
        if (updateData.getDiagnosis() != null) prescription.setDiagnosis(updateData.getDiagnosis());
        if (updateData.getDoshaImbalance() != null) prescription.setDoshaImbalance(updateData.getDoshaImbalance());
        if (updateData.getDietGuidelines() != null) prescription.setDietGuidelines(updateData.getDietGuidelines());
        if (updateData.getLifestyleGuidelines() != null) prescription.setLifestyleGuidelines(updateData.getLifestyleGuidelines());
        if (updateData.getYogaPranayama() != null) prescription.setYogaPranayama(updateData.getYogaPranayama());
        if (updateData.getOtherInstructions() != null) prescription.setOtherInstructions(updateData.getOtherInstructions());
        if (updateData.getFollowUpDate() != null) prescription.setFollowUpDate(updateData.getFollowUpDate());
        if (updateData.getFollowUpDays() != null) prescription.setFollowUpDays(updateData.getFollowUpDays());
        
        // Update medicines
        if (medicines != null) {
            // Delete existing medicines
            prescriptionMedicineRepository.deleteByPrescriptionId(prescriptionId);
            
            // Add new medicines
            for (PrescriptionMedicine medicine : medicines) {
                medicine.setPrescription(prescription);
                prescriptionMedicineRepository.save(medicine);
            }
        }
        
        return prescriptionRepository.save(prescription);
    }

    // Get prescription by ID
    public Optional<Prescription> findById(Long id) {
        return prescriptionRepository.findById(id);
    }

    // Get prescription by consultation
    public Optional<Prescription> findByConsultationId(Long consultationId) {
        List<Prescription> prescriptions = prescriptionRepository.findByConsultationId(consultationId);
        return prescriptions.isEmpty() ? Optional.empty() : Optional.of(prescriptions.get(0));
    }

    // Get prescriptions by doctor
    public List<Prescription> getPrescriptionsByDoctor(Long doctorId) {
        return prescriptionRepository.findByDoctorIdOrderByCreatedAtDesc(doctorId);
    }

    // Get prescriptions by patient email
    public List<Prescription> getPrescriptionsByPatient(String patientEmail) {
        return prescriptionRepository.findByPatientEmail(patientEmail);
    }

    // Search medicines
    public List<Medicine> searchMedicines(String query) {
        if (query == null || query.trim().isEmpty()) {
            return medicineRepository.findByIsActiveTrue();
        }
        return medicineRepository.searchMedicines(query);
    }

    // Get all active medicines
    public List<Medicine> getAllActiveMedicines() {
        return medicineRepository.findByIsActiveTrue();
    }

    // Get medicines by category
    public List<Medicine> getMedicinesByCategory(String category) {
        return medicineRepository.findByCategory(category);
    }
}

