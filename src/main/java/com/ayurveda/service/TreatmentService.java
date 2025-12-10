package com.ayurveda.service;

import com.ayurveda.entity.Consultation;
import com.ayurveda.entity.TreatmentRecommendation;
import com.ayurveda.entity.TreatmentRecommendation.TreatmentType;
import com.ayurveda.repository.ConsultationRepository;
import com.ayurveda.repository.TreatmentRecommendationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class TreatmentService {

    private final TreatmentRecommendationRepository treatmentRepository;
    private final ConsultationRepository consultationRepository;

    @Autowired
    public TreatmentService(TreatmentRecommendationRepository treatmentRepository,
                           ConsultationRepository consultationRepository) {
        this.treatmentRepository = treatmentRepository;
        this.consultationRepository = consultationRepository;
    }

    // Create treatment recommendation
    @Transactional
    public TreatmentRecommendation createTreatmentRecommendation(Long consultationId, 
                                                                 TreatmentRecommendation treatment) {
        Consultation consultation = consultationRepository.findById(consultationId)
                .orElseThrow(() -> new RuntimeException("Consultation not found"));

        treatment.setConsultation(consultation);
        treatment.setDoctor(consultation.getDoctor());
        treatment.setHospital(consultation.getHospital());
        
        return treatmentRepository.save(treatment);
    }

    // Update treatment recommendation
    @Transactional
    public TreatmentRecommendation updateTreatmentRecommendation(Long treatmentId, 
                                                                 TreatmentRecommendation updateData) {
        TreatmentRecommendation treatment = treatmentRepository.findById(treatmentId)
                .orElseThrow(() -> new RuntimeException("Treatment recommendation not found"));
        
        if (updateData.getTreatmentType() != null) treatment.setTreatmentType(updateData.getTreatmentType());
        if (updateData.getTreatmentName() != null) treatment.setTreatmentName(updateData.getTreatmentName());
        if (updateData.getDescription() != null) treatment.setDescription(updateData.getDescription());
        if (updateData.getNumberOfSessions() != null) treatment.setNumberOfSessions(updateData.getNumberOfSessions());
        if (updateData.getSessionDurationMinutes() != null) treatment.setSessionDurationMinutes(updateData.getSessionDurationMinutes());
        if (updateData.getSessionsPerWeek() != null) treatment.setSessionsPerWeek(updateData.getSessionsPerWeek());
        if (updateData.getStartDate() != null) treatment.setStartDate(updateData.getStartDate());
        if (updateData.getEndDate() != null) treatment.setEndDate(updateData.getEndDate());
        if (updateData.getTreatmentPlan() != null) treatment.setTreatmentPlan(updateData.getTreatmentPlan());
        if (updateData.getExpectedBenefits() != null) treatment.setExpectedBenefits(updateData.getExpectedBenefits());
        if (updateData.getPrecautions() != null) treatment.setPrecautions(updateData.getPrecautions());
        if (updateData.getStatus() != null) treatment.setStatus(updateData.getStatus());
        
        return treatmentRepository.save(treatment);
    }

    // Get treatment by ID
    public Optional<TreatmentRecommendation> findById(Long id) {
        return treatmentRepository.findById(id);
    }

    // Get treatments by consultation
    public List<TreatmentRecommendation> getTreatmentsByConsultation(Long consultationId) {
        return treatmentRepository.findByConsultationIdOrderByCreatedAtDesc(consultationId);
    }

    // Get treatments by doctor
    public List<TreatmentRecommendation> getTreatmentsByDoctor(Long doctorId) {
        return treatmentRepository.findByDoctorId(doctorId);
    }

    // Delete treatment recommendation
    @Transactional
    public void deleteTreatmentRecommendation(Long treatmentId) {
        treatmentRepository.deleteById(treatmentId);
    }

    // Get all treatment types
    public TreatmentType[] getAllTreatmentTypes() {
        return TreatmentType.values();
    }
}

