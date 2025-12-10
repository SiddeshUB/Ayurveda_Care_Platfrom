package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "patient_health_records")
public class PatientHealthRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String recordNumber;

    // Patient Information (can be linked to a Patient entity in future)
    private String patientName;
    private String patientEmail;
    private String patientPhone;
    private LocalDate dateOfBirth;
    private String gender;
    private String bloodGroup;

    // Medical History
    @Column(columnDefinition = "TEXT")
    private String allergies; // Known allergies

    @Column(columnDefinition = "TEXT")
    private String chronicConditions; // Chronic diseases

    @Column(columnDefinition = "TEXT")
    private String pastSurgeries; // Past surgical history

    @Column(columnDefinition = "TEXT")
    private String familyHistory; // Family medical history

    @Column(columnDefinition = "TEXT")
    private String currentMedications; // Current medications

    // Vital Signs (Latest)
    private Double height; // in cm
    private Double weight; // in kg
    private Double bmi; // Body Mass Index
    private String bloodPressure; // e.g., "120/80"
    private Double temperature; // in Celsius
    private Integer pulseRate; // beats per minute
    private Integer respiratoryRate; // breaths per minute

    // Ayurvedic Assessment
    private String prakriti; // Vata, Pitta, Kapha, or combination
    private String vikriti; // Current dosha imbalance
    private String agni; // Digestive fire status
    private String ama; // Toxin accumulation status

    // Lifestyle Information
    private String dietType; // Vegetarian, Non-vegetarian, etc.
    private String sleepPattern; // Sleep hours, quality
    private String exerciseRoutine; // Exercise habits
    private String stressLevel; // Low, Medium, High
    private String occupation;

    // Associated Entities
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id")
    private Doctor doctor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id")
    private Hospital hospital;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
    private LocalDateTime lastUpdatedBy;

    public PatientHealthRecord() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (recordNumber == null) {
            recordNumber = "PHR" + System.currentTimeMillis();
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getRecordNumber() { return recordNumber; }
    public void setRecordNumber(String recordNumber) { this.recordNumber = recordNumber; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getPatientEmail() { return patientEmail; }
    public void setPatientEmail(String patientEmail) { this.patientEmail = patientEmail; }

    public String getPatientPhone() { return patientPhone; }
    public void setPatientPhone(String patientPhone) { this.patientPhone = patientPhone; }

    public LocalDate getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(LocalDate dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getBloodGroup() { return bloodGroup; }
    public void setBloodGroup(String bloodGroup) { this.bloodGroup = bloodGroup; }

    public String getAllergies() { return allergies; }
    public void setAllergies(String allergies) { this.allergies = allergies; }

    public String getChronicConditions() { return chronicConditions; }
    public void setChronicConditions(String chronicConditions) { this.chronicConditions = chronicConditions; }

    public String getPastSurgeries() { return pastSurgeries; }
    public void setPastSurgeries(String pastSurgeries) { this.pastSurgeries = pastSurgeries; }

    public String getFamilyHistory() { return familyHistory; }
    public void setFamilyHistory(String familyHistory) { this.familyHistory = familyHistory; }

    public String getCurrentMedications() { return currentMedications; }
    public void setCurrentMedications(String currentMedications) { this.currentMedications = currentMedications; }

    public Double getHeight() { return height; }
    public void setHeight(Double height) { this.height = height; }

    public Double getWeight() { return weight; }
    public void setWeight(Double weight) { this.weight = weight; }

    public Double getBmi() { return bmi; }
    public void setBmi(Double bmi) { this.bmi = bmi; }

    public String getBloodPressure() { return bloodPressure; }
    public void setBloodPressure(String bloodPressure) { this.bloodPressure = bloodPressure; }

    public Double getTemperature() { return temperature; }
    public void setTemperature(Double temperature) { this.temperature = temperature; }

    public Integer getPulseRate() { return pulseRate; }
    public void setPulseRate(Integer pulseRate) { this.pulseRate = pulseRate; }

    public Integer getRespiratoryRate() { return respiratoryRate; }
    public void setRespiratoryRate(Integer respiratoryRate) { this.respiratoryRate = respiratoryRate; }

    public String getPrakriti() { return prakriti; }
    public void setPrakriti(String prakriti) { this.prakriti = prakriti; }

    public String getVikriti() { return vikriti; }
    public void setVikriti(String vikriti) { this.vikriti = vikriti; }

    public String getAgni() { return agni; }
    public void setAgni(String agni) { this.agni = agni; }

    public String getAma() { return ama; }
    public void setAma(String ama) { this.ama = ama; }

    public String getDietType() { return dietType; }
    public void setDietType(String dietType) { this.dietType = dietType; }

    public String getSleepPattern() { return sleepPattern; }
    public void setSleepPattern(String sleepPattern) { this.sleepPattern = sleepPattern; }

    public String getExerciseRoutine() { return exerciseRoutine; }
    public void setExerciseRoutine(String exerciseRoutine) { this.exerciseRoutine = exerciseRoutine; }

    public String getStressLevel() { return stressLevel; }
    public void setStressLevel(String stressLevel) { this.stressLevel = stressLevel; }

    public String getOccupation() { return occupation; }
    public void setOccupation(String occupation) { this.occupation = occupation; }

    public Doctor getDoctor() { return doctor; }
    public void setDoctor(Doctor doctor) { this.doctor = doctor; }

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public LocalDateTime getLastUpdatedBy() { return lastUpdatedBy; }
    public void setLastUpdatedBy(LocalDateTime lastUpdatedBy) { this.lastUpdatedBy = lastUpdatedBy; }
}

