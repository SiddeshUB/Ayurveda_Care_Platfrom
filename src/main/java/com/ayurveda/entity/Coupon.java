package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "coupons")
public class Coupon {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String code; // e.g., "SAVE10", "WELCOME20"

    private String name; // Display name

    @Column(columnDefinition = "TEXT")
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DiscountType discountType;

    @Column(nullable = false)
    private BigDecimal discountValue; // Amount or percentage based on type

    private BigDecimal maxDiscountAmount; // Max discount cap for percentage type

    private BigDecimal minOrderAmount; // Minimum order value to apply coupon

    // Usage limits
    private Integer usageLimit; // Total times this coupon can be used (null = unlimited)

    private Integer usagePerUser = 1; // Times a single user can use

    private Integer usedCount = 0; // How many times it's been used

    // Validity
    private LocalDateTime startDate;

    private LocalDateTime endDate;

    // Applicability
    private Boolean isActive = true;

    @Column(columnDefinition = "TEXT")
    private String applicableCategories; // Comma-separated category IDs (null = all)

    @Column(columnDefinition = "TEXT")
    private String applicableProducts; // Comma-separated product IDs (null = all)

    @Column(columnDefinition = "TEXT")
    private String applicableVendors; // Comma-separated vendor IDs (null = all)

    private Boolean forNewUsersOnly = false;

    private Boolean forFirstOrderOnly = false;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private String createdBy;

    public Coupon() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (isActive == null) isActive = true;
        if (usagePerUser == null) usagePerUser = 1;
        if (usedCount == null) usedCount = 0;
        if (forNewUsersOnly == null) forNewUsersOnly = false;
        if (forFirstOrderOnly == null) forFirstOrderOnly = false;
        if (code != null) {
            code = code.toUpperCase();
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Helper method to check if coupon is valid
    public boolean isValid() {
        if (!isActive) return false;
        LocalDateTime now = LocalDateTime.now();
        if (startDate != null && now.isBefore(startDate)) return false;
        if (endDate != null && now.isAfter(endDate)) return false;
        if (usageLimit != null && usedCount >= usageLimit) return false;
        return true;
    }

    // Calculate discount
    public BigDecimal calculateDiscount(BigDecimal orderAmount) {
        if (!isValid()) return BigDecimal.ZERO;
        if (minOrderAmount != null && orderAmount.compareTo(minOrderAmount) < 0) {
            return BigDecimal.ZERO;
        }

        BigDecimal discount;
        if (discountType == DiscountType.PERCENTAGE) {
            discount = orderAmount.multiply(discountValue).divide(new BigDecimal(100), 2, java.math.RoundingMode.HALF_UP);
            if (maxDiscountAmount != null && discount.compareTo(maxDiscountAmount) > 0) {
                discount = maxDiscountAmount;
            }
        } else {
            discount = discountValue;
        }

        // Discount cannot be more than order amount
        if (discount.compareTo(orderAmount) > 0) {
            discount = orderAmount;
        }

        return discount;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code != null ? code.toUpperCase() : null; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public DiscountType getDiscountType() { return discountType; }
    public void setDiscountType(DiscountType discountType) { this.discountType = discountType; }

    public BigDecimal getDiscountValue() { return discountValue; }
    public void setDiscountValue(BigDecimal discountValue) { this.discountValue = discountValue; }

    public BigDecimal getMaxDiscountAmount() { return maxDiscountAmount; }
    public void setMaxDiscountAmount(BigDecimal maxDiscountAmount) { this.maxDiscountAmount = maxDiscountAmount; }

    public BigDecimal getMinOrderAmount() { return minOrderAmount; }
    public void setMinOrderAmount(BigDecimal minOrderAmount) { this.minOrderAmount = minOrderAmount; }

    public Integer getUsageLimit() { return usageLimit; }
    public void setUsageLimit(Integer usageLimit) { this.usageLimit = usageLimit; }

    public Integer getUsagePerUser() { return usagePerUser; }
    public void setUsagePerUser(Integer usagePerUser) { this.usagePerUser = usagePerUser; }

    public Integer getUsedCount() { return usedCount; }
    public void setUsedCount(Integer usedCount) { this.usedCount = usedCount; }

    public LocalDateTime getStartDate() { return startDate; }
    public void setStartDate(LocalDateTime startDate) { this.startDate = startDate; }

    public LocalDateTime getEndDate() { return endDate; }
    public void setEndDate(LocalDateTime endDate) { this.endDate = endDate; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public String getApplicableCategories() { return applicableCategories; }
    public void setApplicableCategories(String applicableCategories) { this.applicableCategories = applicableCategories; }

    public String getApplicableProducts() { return applicableProducts; }
    public void setApplicableProducts(String applicableProducts) { this.applicableProducts = applicableProducts; }

    public String getApplicableVendors() { return applicableVendors; }
    public void setApplicableVendors(String applicableVendors) { this.applicableVendors = applicableVendors; }

    public Boolean getForNewUsersOnly() { return forNewUsersOnly; }
    public void setForNewUsersOnly(Boolean forNewUsersOnly) { this.forNewUsersOnly = forNewUsersOnly; }

    public Boolean getForFirstOrderOnly() { return forFirstOrderOnly; }
    public void setForFirstOrderOnly(Boolean forFirstOrderOnly) { this.forFirstOrderOnly = forFirstOrderOnly; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }

    // Enum
    public enum DiscountType {
        PERCENTAGE("Percentage"),
        FIXED("Fixed Amount");

        private final String displayName;

        DiscountType(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }
}

