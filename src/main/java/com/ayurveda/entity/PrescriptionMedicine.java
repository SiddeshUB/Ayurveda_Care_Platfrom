package com.ayurveda.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "prescription_medicines")
public class PrescriptionMedicine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "prescription_id", nullable = false)
    private Prescription prescription;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medicine_id")
    private Medicine medicine;

    // Custom medicine (if not in database)
    private String medicineName;
    private String medicineType; // Churna, Kashayam, Ghritham, etc.

    private String dosage; // e.g., "1 teaspoon", "2 tablets"
    private String frequency; // e.g., "Twice daily", "After meals"
    private String timing; // e.g., "Morning", "Evening", "Before food", "After food"
    private Integer durationDays; // How many days to take

    @Column(columnDefinition = "TEXT")
    private String instructions; // Special instructions

    private Integer quantity; // Number of units/packets

    @Column(columnDefinition = "TEXT")
    private String notes; // Additional notes

    public PrescriptionMedicine() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Prescription getPrescription() { return prescription; }
    public void setPrescription(Prescription prescription) { this.prescription = prescription; }

    public Medicine getMedicine() { return medicine; }
    public void setMedicine(Medicine medicine) { this.medicine = medicine; }

    public String getMedicineName() { return medicineName; }
    public void setMedicineName(String medicineName) { this.medicineName = medicineName; }

    public String getMedicineType() { return medicineType; }
    public void setMedicineType(String medicineType) { this.medicineType = medicineType; }

    public String getDosage() { return dosage; }
    public void setDosage(String dosage) { this.dosage = dosage; }

    public String getFrequency() { return frequency; }
    public void setFrequency(String frequency) { this.frequency = frequency; }

    public String getTiming() { return timing; }
    public void setTiming(String timing) { this.timing = timing; }

    public Integer getDurationDays() { return durationDays; }
    public void setDurationDays(Integer durationDays) { this.durationDays = durationDays; }

    public String getInstructions() { return instructions; }
    public void setInstructions(String instructions) { this.instructions = instructions; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}

