package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "treatment_packages")
public class TreatmentPackage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospital_id", nullable = false)
    private Hospital hospital;

    @Column(nullable = false)
    private String packageName;

    @Enumerated(EnumType.STRING)
    private PackageType packageType;

    @Column(name = "custom_type")
    private String customType; // For storing custom type when OTHERS is selected

    private Integer durationDays;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(columnDefinition = "TEXT")
    private String shortDescription;

    // Room Details - Counts
    private Integer budgetRoomCount;
    private Integer standardRoomCount;
    private Integer deluxeRoomCount;
    private Integer suiteRoomCount;
    private Integer villaCount;
    private Integer vipRoomCount;
    
    // Room Prices - Base Prices
    private BigDecimal budgetRoomPrice;
    private BigDecimal standardRoomPrice;
    private BigDecimal deluxeRoomPrice;
    private BigDecimal suiteRoomPrice;
    private BigDecimal villaPrice;
    private BigDecimal vipRoomPrice;
    
    // Taxes per Room Type - GST %
    private BigDecimal budgetRoomGstPercent;
    private BigDecimal standardRoomGstPercent;
    private BigDecimal deluxeRoomGstPercent;
    private BigDecimal suiteRoomGstPercent;
    private BigDecimal villaGstPercent;
    private BigDecimal vipRoomGstPercent;
    
    // Taxes per Room Type - CGST %
    private BigDecimal budgetRoomCgstPercent;
    private BigDecimal standardRoomCgstPercent;
    private BigDecimal deluxeRoomCgstPercent;
    private BigDecimal suiteRoomCgstPercent;
    private BigDecimal villaCgstPercent;
    private BigDecimal vipRoomCgstPercent;

    @Column(columnDefinition = "TEXT")
    private String inclusions;

    @Column(columnDefinition = "TEXT")
    private String exclusions;

    @Column(columnDefinition = "TEXT")
    private String expectedResults;

    @Column(columnDefinition = "TEXT")
    private String suitableFor;

    private String imageUrl;

    private Boolean isActive;
    private Boolean isFeatured;
    private Integer sortOrder;

    @Column(columnDefinition = "TEXT")
    private String dayWiseSchedule;

    @OneToMany(mappedBy = "treatmentPackage", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Booking> bookings;
    
    // Package-Doctor Many-to-Many Relationship
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "package_doctors",
        joinColumns = @JoinColumn(name = "package_id"),
        inverseJoinColumns = @JoinColumn(name = "doctor_id")
    )
    private List<Doctor> doctors = new ArrayList<>();

    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public TreatmentPackage() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (isActive == null) isActive = true;
        if (isFeatured == null) isFeatured = false;
        if (sortOrder == null) sortOrder = 0;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Hospital getHospital() { return hospital; }
    public void setHospital(Hospital hospital) { this.hospital = hospital; }

    public String getPackageName() { return packageName; }
    public void setPackageName(String packageName) { this.packageName = packageName; }

    public PackageType getPackageType() { return packageType; }
    public void setPackageType(PackageType packageType) { this.packageType = packageType; }

    public Integer getDurationDays() { return durationDays; }
    public void setDurationDays(Integer durationDays) { this.durationDays = durationDays; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getShortDescription() { return shortDescription; }
    public void setShortDescription(String shortDescription) { this.shortDescription = shortDescription; }

    public BigDecimal getBudgetRoomPrice() { return budgetRoomPrice; }
    public void setBudgetRoomPrice(BigDecimal budgetRoomPrice) { this.budgetRoomPrice = budgetRoomPrice; }

    public BigDecimal getStandardRoomPrice() { return standardRoomPrice; }
    public void setStandardRoomPrice(BigDecimal standardRoomPrice) { this.standardRoomPrice = standardRoomPrice; }

    public BigDecimal getDeluxeRoomPrice() { return deluxeRoomPrice; }
    public void setDeluxeRoomPrice(BigDecimal deluxeRoomPrice) { this.deluxeRoomPrice = deluxeRoomPrice; }

    public BigDecimal getSuiteRoomPrice() { return suiteRoomPrice; }
    public void setSuiteRoomPrice(BigDecimal suiteRoomPrice) { this.suiteRoomPrice = suiteRoomPrice; }

    public String getInclusions() { return inclusions; }
    public void setInclusions(String inclusions) { this.inclusions = inclusions; }

    public String getExclusions() { return exclusions; }
    public void setExclusions(String exclusions) { this.exclusions = exclusions; }

    public String getExpectedResults() { return expectedResults; }
    public void setExpectedResults(String expectedResults) { this.expectedResults = expectedResults; }

    public String getSuitableFor() { return suitableFor; }
    public void setSuitableFor(String suitableFor) { this.suitableFor = suitableFor; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public Boolean getIsFeatured() { return isFeatured; }
    public void setIsFeatured(Boolean isFeatured) { this.isFeatured = isFeatured; }

    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }

    public String getDayWiseSchedule() { return dayWiseSchedule; }
    public void setDayWiseSchedule(String dayWiseSchedule) { this.dayWiseSchedule = dayWiseSchedule; }

    public List<Booking> getBookings() { return bookings; }
    public void setBookings(List<Booking> bookings) { this.bookings = bookings; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public String getCustomType() { return customType; }
    public void setCustomType(String customType) { this.customType = customType; }
    
    // Room Count Getters and Setters
    public Integer getBudgetRoomCount() { return budgetRoomCount; }
    public void setBudgetRoomCount(Integer budgetRoomCount) { this.budgetRoomCount = budgetRoomCount; }
    
    public Integer getStandardRoomCount() { return standardRoomCount; }
    public void setStandardRoomCount(Integer standardRoomCount) { this.standardRoomCount = standardRoomCount; }
    
    public Integer getDeluxeRoomCount() { return deluxeRoomCount; }
    public void setDeluxeRoomCount(Integer deluxeRoomCount) { this.deluxeRoomCount = deluxeRoomCount; }
    
    public Integer getSuiteRoomCount() { return suiteRoomCount; }
    public void setSuiteRoomCount(Integer suiteRoomCount) { this.suiteRoomCount = suiteRoomCount; }
    
    public Integer getVillaCount() { return villaCount; }
    public void setVillaCount(Integer villaCount) { this.villaCount = villaCount; }
    
    public Integer getVipRoomCount() { return vipRoomCount; }
    public void setVipRoomCount(Integer vipRoomCount) { this.vipRoomCount = vipRoomCount; }
    
    // Villa and VIP Room Price Getters and Setters
    public BigDecimal getVillaPrice() { return villaPrice; }
    public void setVillaPrice(BigDecimal villaPrice) { this.villaPrice = villaPrice; }
    
    public BigDecimal getVipRoomPrice() { return vipRoomPrice; }
    public void setVipRoomPrice(BigDecimal vipRoomPrice) { this.vipRoomPrice = vipRoomPrice; }
    
    // GST Percent Getters and Setters
    public BigDecimal getBudgetRoomGstPercent() { return budgetRoomGstPercent; }
    public void setBudgetRoomGstPercent(BigDecimal budgetRoomGstPercent) { this.budgetRoomGstPercent = budgetRoomGstPercent; }
    
    public BigDecimal getStandardRoomGstPercent() { return standardRoomGstPercent; }
    public void setStandardRoomGstPercent(BigDecimal standardRoomGstPercent) { this.standardRoomGstPercent = standardRoomGstPercent; }
    
    public BigDecimal getDeluxeRoomGstPercent() { return deluxeRoomGstPercent; }
    public void setDeluxeRoomGstPercent(BigDecimal deluxeRoomGstPercent) { this.deluxeRoomGstPercent = deluxeRoomGstPercent; }
    
    public BigDecimal getSuiteRoomGstPercent() { return suiteRoomGstPercent; }
    public void setSuiteRoomGstPercent(BigDecimal suiteRoomGstPercent) { this.suiteRoomGstPercent = suiteRoomGstPercent; }
    
    public BigDecimal getVillaGstPercent() { return villaGstPercent; }
    public void setVillaGstPercent(BigDecimal villaGstPercent) { this.villaGstPercent = villaGstPercent; }
    
    public BigDecimal getVipRoomGstPercent() { return vipRoomGstPercent; }
    public void setVipRoomGstPercent(BigDecimal vipRoomGstPercent) { this.vipRoomGstPercent = vipRoomGstPercent; }
    
    // CGST Percent Getters and Setters
    public BigDecimal getBudgetRoomCgstPercent() { return budgetRoomCgstPercent; }
    public void setBudgetRoomCgstPercent(BigDecimal budgetRoomCgstPercent) { this.budgetRoomCgstPercent = budgetRoomCgstPercent; }
    
    public BigDecimal getStandardRoomCgstPercent() { return standardRoomCgstPercent; }
    public void setStandardRoomCgstPercent(BigDecimal standardRoomCgstPercent) { this.standardRoomCgstPercent = standardRoomCgstPercent; }
    
    public BigDecimal getDeluxeRoomCgstPercent() { return deluxeRoomCgstPercent; }
    public void setDeluxeRoomCgstPercent(BigDecimal deluxeRoomCgstPercent) { this.deluxeRoomCgstPercent = deluxeRoomCgstPercent; }
    
    public BigDecimal getSuiteRoomCgstPercent() { return suiteRoomCgstPercent; }
    public void setSuiteRoomCgstPercent(BigDecimal suiteRoomCgstPercent) { this.suiteRoomCgstPercent = suiteRoomCgstPercent; }
    
    public BigDecimal getVillaCgstPercent() { return villaCgstPercent; }
    public void setVillaCgstPercent(BigDecimal villaCgstPercent) { this.villaCgstPercent = villaCgstPercent; }
    
    public BigDecimal getVipRoomCgstPercent() { return vipRoomCgstPercent; }
    public void setVipRoomCgstPercent(BigDecimal vipRoomCgstPercent) { this.vipRoomCgstPercent = vipRoomCgstPercent; }
    
    // Doctors Getters and Setters
    public List<Doctor> getDoctors() { return doctors; }
    public void setDoctors(List<Doctor> doctors) { this.doctors = doctors; }

    public enum PackageType {
        YOGA,
        THERAPEUTIC_YOGA,
        ASHTANGA_YOGA,
        HATHA_YOGA,
        KUNDALINI_YOGA,
        IYENGAR_YOGA,
        RESTORATIVE_YOGA,
        PRANAYAMA,
        MEDITATION,
        YOGA_NIDRA,
        VIPASSANA,
        MINDFULNESS_THERAPY,
        AQUA_THERAPY,
        HYDROTHERAPY,
        SWIMMING_THERAPY,
        DETOX_THERAPY,
        NATUROPATHY,
        AYURVEDA,
        PANCHAKARMA,
        SHIRODHARA,
        ABHYANGA,
        PIZHICHIL,
        NAVARAKIZHI,
        KATI_BASTI,
        GREEVA_BASTI,
        JANU_BASTI,
        AROMATHERAPY,
        AYURVEDIC_MASSAGES,
        AYURVEDIC_TREATMENTS,
        HERBAL_STEAM_SWEDANA,
        HERBAL_WRAPS,
        HERBAL_POULTICE_MASSAGE_KIZHI,
        LEPANAM,
        ACUPRESSURE,
        REFLEXOLOGY,
        ACUPUNCTURE,
        CUPPING,
        HIJAMA,
        GUA_SHA,
        MOXIBUSTION,
        REIKI,
        PRANIC_HEALING,
        ENERGY_HEALING,
        CHAKRA_BALANCING,
        SOUND_HEALING,
        CRYSTAL_HEALING,
        MAGNET_THERAPY,
        QUANTUM_TOUCH,
        PHYSIOTHERAPY,
        OSTEOPATHY,
        CHIROPRACTIC,
        MYOFASCIAL_RELEASE,
        TRIGGER_POINT_THERAPY,
        THAI_YOGA_MASSAGE,
        DEEP_TISSUE_MASSAGE,
        SWEDISH_MASSAGE,
        BALINESE_MASSAGE,
        SPORTS_MASSAGE,
        LOMI_LOMI_MASSAGE,
        ICE_THERAPY,
        CRYOTHERAPY,
        HOT_STONE_THERAPY,
        INFRARED_THERAPY,
        SALT_ROOM_THERAPY_HALOTHERAPY,
        MUD_THERAPY,
        SAND_THERAPY,
        SUNBATHING_THERAPY,
        FOREST_BATHING,
        LAUGHTER_THERAPY,
        LAUGHTER_PILATES,
        CBT_NATURAL_RETREATS,
        BREATHWORK_HEALING,
        GUIDED_IMAGERY_HEALING,
        HOMEOPATHY,
        UNANI_MEDICINE,
        SIDDHA_MEDICINE,
        TIBETAN_MEDICINE_SOWA_RIGPA,
        CHINESE_TRADITIONAL_MEDICINE_TCM_TECHNIQUES,
        COLON_HYDROTHERAPY,
        FASTING_THERAPY,
        JUICE_DETOX,
        RAW_DIET_THERAPY,
        SATVIK_YOGIC_DIET,
        DOSHA_BASED_AYURVEDIC_DIET,
        PLANT_BASED_HEALING,
        LIFESTYLE_THERAPY,
        STRESS_MANAGEMENT_PROGRAMS,
        SLEEP_THERAPY,
        PAIN_RELIEF_NATURAL_THERAPIES,
        POSTURE_CORRECTION_THERAPY,
        ANTI_AGING_AYURVEDIC_PROGRAMS,
        FERTILITY_NATURAL_TREATMENTS,
        MARMA_THERAPY,
        HEAD_NECK_SHOULDER_MASSAGE,
        FOOT_MASSAGE_PADABHYANGA,
        EYE_THERAPY_NETRA_TARPANA,
        NASAL_CLEANSING_JAL_NETI,
        SWEAT_DETOX_PROGRAMS,
        DIGITAL_DETOX_RETREATS,
        WELLNESS_RETREAT_PROGRAMS,
        FIVE_ELEMENT_HEALING_PANCHA_BHOOTA_THERAPY,
        MANTRA_CHANTING_HEALING,
        BHAKTI_THERAPY,
        KIRTAN_HEALING,
        BAREFOOT_GROUNDING_THERAPY,
        AYURVEDIC_BEAUTY_SKIN_TREATMENTS,
        HAIR_SCALP_AYURVEDIC_THERAPIES,
        IMMUNITY_BOOSTING_AYURVEDIC_TREATMENTS,
        AYURVEDIC_REJUVENATION_RASAYANA_CHIKITSA,
        NATURE_CURE_TREATMENT_PACKAGES,
        THERMAL_THERAPY,
        COLOR_THERAPY,
        LIGHT_THERAPY,
        VIBRATION_THERAPY,
        EMOTIONAL_HEALING_WORKSHOPS,
        HOLISTIC_COUNSELING,
        BODY_MIND_ALIGNMENT_THERAPY,
        OTHERS
    }
}
