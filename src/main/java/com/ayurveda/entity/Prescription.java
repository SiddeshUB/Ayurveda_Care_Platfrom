package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "prescriptions")
public class Prescription {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String prescriptionNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consultation_id", nullable = false)
    private Consultation consultation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id")
    private Hospital hospital;

    // Patient Information (denormalized for easy access)
    private String patientName;
    private String patientEmail;
    private String patientPhone;
    private Integer patientAge;
    private String patientGender;

    // Prescription Details
    @Column(columnDefinition = "TEXT")
    private String chiefComplaints;

    @Column(columnDefinition = "TEXT")
    private String diagnosis;

    @Column(columnDefinition = "TEXT")
    private String doshaImbalance; // Vata, Pitta, Kapha imbalance

    // Medicines
    @OneToMany(mappedBy = "prescription", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<PrescriptionMedicine> medicines;

    // Lifestyle & Diet Guidelines
    @Column(columnDefinition = "TEXT")
    private String dietGuidelines;

    @Column(columnDefinition = "TEXT")
    private String lifestyleGuidelines;

    @Column(columnDefinition = "TEXT")
    private String yogaPranayama; // Yoga and breathing exercises

    @Column(columnDefinition = "TEXT")
    private String otherInstructions;

    // Follow-up
    private LocalDate followUpDate;
    private Integer followUpDays; // Days after which follow-up is needed

    // PDF Prescription
    private String pdfUrl;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public Prescription() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (prescriptionNumber == null) {
            prescriptionNumber = "RX" + System.currentTimeMillis();
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getPrescriptionNumber() { return prescriptionNumber; }
    public void setPrescriptionNumber(String prescriptionNumber) { this.prescriptionNumber = prescriptionNumber; }

    public Consultation getConsultation() { return consultation; }
    public void setConsultation(Consultation consultation) { this.consultation = consultation; }

    public Doctor getDoctor() { return doctor; }
    public void setDoctor(Doctor doctor) { this.doctor = doctor; }

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getPatientEmail() { return patientEmail; }
    public void setPatientEmail(String patientEmail) { this.patientEmail = patientEmail; }

    public String getPatientPhone() { return patientPhone; }
    public void setPatientPhone(String patientPhone) { this.patientPhone = patientPhone; }

    public Integer getPatientAge() { return patientAge; }
    public void setPatientAge(Integer patientAge) { this.patientAge = patientAge; }

    public String getPatientGender() { return patientGender; }
    public void setPatientGender(String patientGender) { this.patientGender = patientGender; }

    public String getChiefComplaints() { return chiefComplaints; }
    public void setChiefComplaints(String chiefComplaints) { this.chiefComplaints = chiefComplaints; }

    public String getDiagnosis() { return diagnosis; }
    public void setDiagnosis(String diagnosis) { this.diagnosis = diagnosis; }

    public String getDoshaImbalance() { return doshaImbalance; }
    public void setDoshaImbalance(String doshaImbalance) { this.doshaImbalance = doshaImbalance; }

    public List<PrescriptionMedicine> getMedicines() { return medicines; }
    public void setMedicines(List<PrescriptionMedicine> medicines) { this.medicines = medicines; }

    public String getDietGuidelines() { return dietGuidelines; }
    public void setDietGuidelines(String dietGuidelines) { this.dietGuidelines = dietGuidelines; }

    public String getLifestyleGuidelines() { return lifestyleGuidelines; }
    public void setLifestyleGuidelines(String lifestyleGuidelines) { this.lifestyleGuidelines = lifestyleGuidelines; }

    public String getYogaPranayama() { return yogaPranayama; }
    public void setYogaPranayama(String yogaPranayama) { this.yogaPranayama = yogaPranayama; }

    public String getOtherInstructions() { return otherInstructions; }
    public void setOtherInstructions(String otherInstructions) { this.otherInstructions = otherInstructions; }

    public LocalDate getFollowUpDate() { return followUpDate; }
    public void setFollowUpDate(LocalDate followUpDate) { this.followUpDate = followUpDate; }

    public Integer getFollowUpDays() { return followUpDays; }
    public void setFollowUpDays(Integer followUpDays) { this.followUpDays = followUpDays; }

    public String getPdfUrl() { return pdfUrl; }
    public void setPdfUrl(String pdfUrl) { this.pdfUrl = pdfUrl; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}

