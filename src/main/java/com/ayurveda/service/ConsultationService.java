package com.ayurveda.service;

import com.ayurveda.entity.Consultation;
import com.ayurveda.entity.Consultation.ConsultationStatus;
import com.ayurveda.entity.ConsultationSlot;
import com.ayurveda.entity.Doctor;
import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.User;
import com.ayurveda.repository.ConsultationRepository;
import com.ayurveda.repository.ConsultationSlotRepository;
import com.ayurveda.repository.DoctorRepository;
import com.ayurveda.repository.HospitalRepository;
import com.ayurveda.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Service
public class ConsultationService {

    private final ConsultationRepository consultationRepository;
    private final ConsultationSlotRepository slotRepository;
    private final DoctorRepository doctorRepository;
    private final HospitalRepository hospitalRepository;
    private final UserRepository userRepository;

    @Autowired
    public ConsultationService(ConsultationRepository consultationRepository,
                              ConsultationSlotRepository slotRepository,
                              DoctorRepository doctorRepository,
                              HospitalRepository hospitalRepository,
                              UserRepository userRepository) {
        this.consultationRepository = consultationRepository;
        this.slotRepository = slotRepository;
        this.doctorRepository = doctorRepository;
        this.hospitalRepository = hospitalRepository;
        this.userRepository = userRepository;
    }

    // Create consultation booking
    @Transactional
    public Consultation createConsultation(Long doctorId, Long hospitalId, Consultation consultation) {
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        consultation.setDoctor(doctor);
        consultation.setStatus(ConsultationStatus.PENDING);
        
        if (hospitalId != null) {
            Hospital hospital = hospitalRepository.findById(hospitalId)
                    .orElseThrow(() -> new RuntimeException("Hospital not found"));
            consultation.setHospital(hospital);
        }
        
        return consultationRepository.save(consultation);
    }

    // Create direct consultation booking by user
    @Transactional
    public Consultation createDirectConsultation(Long doctorId, Long userId, Consultation consultation) {
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        if (userId != null) {
            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found"));
            consultation.setUser(user);
            // Auto-fill patient details from user if not provided
            if (consultation.getPatientName() == null || consultation.getPatientName().isEmpty()) {
                consultation.setPatientName(user.getFullName());
            }
            if (consultation.getPatientEmail() == null || consultation.getPatientEmail().isEmpty()) {
                consultation.setPatientEmail(user.getEmail());
            }
            if (consultation.getPatientPhone() == null || consultation.getPatientPhone().isEmpty()) {
                consultation.setPatientPhone(user.getPhone());
            }
        }
        
        consultation.setDoctor(doctor);
        // Set hospital from doctor's association
        if (doctor.getHospital() != null) {
            consultation.setHospital(doctor.getHospital());
        }
        consultation.setStatus(ConsultationStatus.PENDING);
        consultation.setPaymentStatus(Consultation.PaymentStatus.PENDING);
        
        return consultationRepository.save(consultation);
    }

    // Confirm consultation
    @Transactional
    public Consultation confirmConsultation(Long consultationId) {
        Consultation consultation = consultationRepository.findById(consultationId)
                .orElseThrow(() -> new RuntimeException("Consultation not found"));
        
        consultation.setStatus(ConsultationStatus.CONFIRMED);
        consultation.setConfirmedAt(LocalDateTime.now());
        
        return consultationRepository.save(consultation);
    }

    // Complete consultation
    @Transactional
    public Consultation completeConsultation(Long consultationId, String doctorNotes, 
                                            String prescriptionNotes, Boolean requiresFollowUp, 
                                            LocalDate followUpDate) {
        Consultation consultation = consultationRepository.findById(consultationId)
                .orElseThrow(() -> new RuntimeException("Consultation not found"));
        
        consultation.setStatus(ConsultationStatus.COMPLETED);
        consultation.setCompletedAt(LocalDateTime.now());
        if (doctorNotes != null) consultation.setDoctorNotes(doctorNotes);
        if (prescriptionNotes != null) consultation.setPrescriptionNotes(prescriptionNotes);
        if (requiresFollowUp != null) consultation.setRequiresFollowUp(requiresFollowUp);
        if (followUpDate != null) consultation.setFollowUpDate(followUpDate);
        
        return consultationRepository.save(consultation);
    }

    // Cancel consultation
    @Transactional
    public Consultation cancelConsultation(Long consultationId, String reason) {
        Consultation consultation = consultationRepository.findById(consultationId)
                .orElseThrow(() -> new RuntimeException("Consultation not found"));
        
        consultation.setStatus(ConsultationStatus.CANCELLED);
        consultation.setCancelledAt(LocalDateTime.now());
        consultation.setCancellationReason(reason);
        
        return consultationRepository.save(consultation);
    }

    // Reschedule consultation
    @Transactional
    public Consultation rescheduleConsultation(Long consultationId, LocalDate newDate, LocalTime newTime) {
        Consultation consultation = consultationRepository.findById(consultationId)
                .orElseThrow(() -> new RuntimeException("Consultation not found"));
        
        consultation.setConsultationDate(newDate);
        consultation.setConsultationTime(newTime);
        consultation.setStatus(ConsultationStatus.RESCHEDULED);
        
        return consultationRepository.save(consultation);
    }

    // Get consultations by doctor
    public List<Consultation> getConsultationsByDoctor(Long doctorId) {
        return consultationRepository.findByDoctorId(doctorId);
    }

    // Get today's appointments
    public List<Consultation> getTodayAppointments(Long doctorId) {
        return consultationRepository.findTodayAppointments(doctorId, LocalDate.now());
    }

    // Get upcoming consultations
    public List<Consultation> getUpcomingConsultations(Long doctorId) {
        return consultationRepository.findUpcomingConsultations(doctorId, LocalDate.now());
    }

    // Get consultations by status
    public List<Consultation> getConsultationsByStatus(Long doctorId, ConsultationStatus status) {
        return consultationRepository.findByDoctorIdAndStatus(doctorId, status);
    }

    // Get consultations by user (for user dashboard)
    public List<Consultation> getConsultationsByUser(Long userId) {
        return consultationRepository.findByUserId(userId);
    }

    // Get consultation by ID
    public Optional<Consultation> findById(Long id) {
        return consultationRepository.findById(id);
    }

    // Slot Management
    @Transactional
    public ConsultationSlot createSlot(Long doctorId, Long hospitalId, ConsultationSlot slot) {
        Doctor doctor = doctorRepository.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));
        
        slot.setDoctor(doctor);
        
        if (hospitalId != null) {
            Hospital hospital = hospitalRepository.findById(hospitalId)
                    .orElseThrow(() -> new RuntimeException("Hospital not found"));
            slot.setHospital(hospital);
        }
        
        if (slot.getIsAvailable() == null) {
            slot.setIsAvailable(true);
        }
        
        return slotRepository.save(slot);
    }

    // Get slots by doctor
    public List<ConsultationSlot> getSlotsByDoctor(Long doctorId) {
        return slotRepository.findByDoctorId(doctorId);
    }

    // Get slots by doctor and hospital
    public List<ConsultationSlot> getSlotsByDoctorAndHospital(Long doctorId, Long hospitalId) {
        return slotRepository.findByDoctorIdAndHospitalId(doctorId, hospitalId);
    }

    // Delete slot
    @Transactional
    public void deleteSlot(Long slotId) {
        slotRepository.deleteById(slotId);
    }

    // Update slot
    @Transactional
    public ConsultationSlot updateSlot(Long slotId, ConsultationSlot updateData) {
        ConsultationSlot slot = slotRepository.findById(slotId)
                .orElseThrow(() -> new RuntimeException("Slot not found"));
        
        if (updateData.getDayOfWeek() != null) slot.setDayOfWeek(updateData.getDayOfWeek());
        if (updateData.getStartTime() != null) slot.setStartTime(updateData.getStartTime());
        if (updateData.getEndTime() != null) slot.setEndTime(updateData.getEndTime());
        if (updateData.getDurationMinutes() != null) slot.setDurationMinutes(updateData.getDurationMinutes());
        if (updateData.getMaxBookingsPerSlot() != null) slot.setMaxBookingsPerSlot(updateData.getMaxBookingsPerSlot());
        if (updateData.getIsAvailable() != null) slot.setIsAvailable(updateData.getIsAvailable());
        if (updateData.getSlotType() != null) slot.setSlotType(updateData.getSlotType());
        if (updateData.getNotes() != null) slot.setNotes(updateData.getNotes());
        
        return slotRepository.save(slot);
    }
}

