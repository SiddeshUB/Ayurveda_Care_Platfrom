package com.ayurveda.service;

import com.ayurveda.entity.Doctor;
import com.ayurveda.entity.Hospital;
import com.ayurveda.entity.PatientHealthRecord;
import com.ayurveda.repository.DoctorRepository;
import com.ayurveda.repository.HospitalRepository;
import com.ayurveda.repository.PatientHealthRecordRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class HealthRecordService {

    private final PatientHealthRecordRepository healthRecordRepository;
    private final DoctorRepository doctorRepository;
    private final HospitalRepository hospitalRepository;

    @Autowired
    public HealthRecordService(PatientHealthRecordRepository healthRecordRepository,
                              DoctorRepository doctorRepository,
                              HospitalRepository hospitalRepository) {
        this.healthRecordRepository = healthRecordRepository;
        this.doctorRepository = doctorRepository;
        this.hospitalRepository = hospitalRepository;
    }

    // Create health record
    @Transactional
    public PatientHealthRecord createHealthRecord(Long doctorId, Long hospitalId, PatientHealthRecord record) {
        if (doctorId != null) {
            Doctor doctor = doctorRepository.findById(doctorId)
                    .orElseThrow(() -> new RuntimeException("Doctor not found"));
            record.setDoctor(doctor);
        }
        
        if (hospitalId != null) {
            Hospital hospital = hospitalRepository.findById(hospitalId)
                    .orElseThrow(() -> new RuntimeException("Hospital not found"));
            record.setHospital(hospital);
        }
        
        // Calculate BMI if height and weight are provided
        if (record.getHeight() != null && record.getWeight() != null && record.getHeight() > 0) {
            double heightInMeters = record.getHeight() / 100.0;
            double bmi = record.getWeight() / (heightInMeters * heightInMeters);
            record.setBmi(Math.round(bmi * 100.0) / 100.0);
        }
        
        return healthRecordRepository.save(record);
    }

    // Update health record
    @Transactional
    public PatientHealthRecord updateHealthRecord(Long recordId, PatientHealthRecord updateData) {
        PatientHealthRecord record = healthRecordRepository.findById(recordId)
                .orElseThrow(() -> new RuntimeException("Health record not found"));
        
        // Update fields
        if (updateData.getPatientName() != null) record.setPatientName(updateData.getPatientName());
        if (updateData.getPatientEmail() != null) record.setPatientEmail(updateData.getPatientEmail());
        if (updateData.getPatientPhone() != null) record.setPatientPhone(updateData.getPatientPhone());
        if (updateData.getDateOfBirth() != null) record.setDateOfBirth(updateData.getDateOfBirth());
        if (updateData.getGender() != null) record.setGender(updateData.getGender());
        if (updateData.getBloodGroup() != null) record.setBloodGroup(updateData.getBloodGroup());
        if (updateData.getAllergies() != null) record.setAllergies(updateData.getAllergies());
        if (updateData.getChronicConditions() != null) record.setChronicConditions(updateData.getChronicConditions());
        if (updateData.getPastSurgeries() != null) record.setPastSurgeries(updateData.getPastSurgeries());
        if (updateData.getFamilyHistory() != null) record.setFamilyHistory(updateData.getFamilyHistory());
        if (updateData.getCurrentMedications() != null) record.setCurrentMedications(updateData.getCurrentMedications());
        if (updateData.getHeight() != null) record.setHeight(updateData.getHeight());
        if (updateData.getWeight() != null) record.setWeight(updateData.getWeight());
        if (updateData.getBloodPressure() != null) record.setBloodPressure(updateData.getBloodPressure());
        if (updateData.getTemperature() != null) record.setTemperature(updateData.getTemperature());
        if (updateData.getPulseRate() != null) record.setPulseRate(updateData.getPulseRate());
        if (updateData.getRespiratoryRate() != null) record.setRespiratoryRate(updateData.getRespiratoryRate());
        if (updateData.getPrakriti() != null) record.setPrakriti(updateData.getPrakriti());
        if (updateData.getVikriti() != null) record.setVikriti(updateData.getVikriti());
        if (updateData.getAgni() != null) record.setAgni(updateData.getAgni());
        if (updateData.getAma() != null) record.setAma(updateData.getAma());
        if (updateData.getDietType() != null) record.setDietType(updateData.getDietType());
        if (updateData.getSleepPattern() != null) record.setSleepPattern(updateData.getSleepPattern());
        if (updateData.getExerciseRoutine() != null) record.setExerciseRoutine(updateData.getExerciseRoutine());
        if (updateData.getStressLevel() != null) record.setStressLevel(updateData.getStressLevel());
        if (updateData.getOccupation() != null) record.setOccupation(updateData.getOccupation());
        
        // Recalculate BMI if height or weight changed
        if (record.getHeight() != null && record.getWeight() != null && record.getHeight() > 0) {
            double heightInMeters = record.getHeight() / 100.0;
            double bmi = record.getWeight() / (heightInMeters * heightInMeters);
            record.setBmi(Math.round(bmi * 100.0) / 100.0);
        }
        
        return healthRecordRepository.save(record);
    }

    // Get health record by ID
    public Optional<PatientHealthRecord> findById(Long id) {
        return healthRecordRepository.findById(id);
    }

    // Get health record by patient email
    public Optional<PatientHealthRecord> findByPatientEmail(String email) {
        return healthRecordRepository.findByPatientEmail(email);
    }

    // Get health records by doctor
    public List<PatientHealthRecord> getHealthRecordsByDoctor(Long doctorId) {
        return healthRecordRepository.findByDoctorId(doctorId);
    }

    // Get health records by hospital
    public List<PatientHealthRecord> getHealthRecordsByHospital(Long hospitalId) {
        return healthRecordRepository.findByHospitalId(hospitalId);
    }

    // Get health records by patient email (all records)
    public List<PatientHealthRecord> getHealthRecordsByPatient(String patientEmail) {
        return healthRecordRepository.findByPatientEmailOrderByUpdatedAtDesc(patientEmail);
    }
}

