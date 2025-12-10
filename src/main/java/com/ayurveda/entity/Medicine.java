package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "medicines")
public class Medicine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    private String category; // Churna, Kashayam, Ghritham, Lehyam, Vati, etc.

    private String manufacturer;

    private String composition; // Ingredients

    @Column(columnDefinition = "TEXT")
    private String indications; // What it's used for

    @Column(columnDefinition = "TEXT")
    private String dosage; // Standard dosage

    @Column(columnDefinition = "TEXT")
    private String contraindications; // When not to use

    private Boolean isActive;

    public Medicine() {}

    @PrePersist
    protected void onCreate() {
        if (isActive == null) isActive = true;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getManufacturer() { return manufacturer; }
    public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }

    public String getComposition() { return composition; }
    public void setComposition(String composition) { this.composition = composition; }

    public String getIndications() { return indications; }
    public void setIndications(String indications) { this.indications = indications; }

    public String getDosage() { return dosage; }
    public void setDosage(String dosage) { this.dosage = dosage; }

    public String getContraindications() { return contraindications; }
    public void setContraindications(String contraindications) { this.contraindications = contraindications; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }
}

