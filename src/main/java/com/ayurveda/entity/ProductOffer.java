package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "product_offers")
public class ProductOffer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product; // Null for global offers

    @Enumerated(EnumType.STRING)
    private OfferType offerType;

    private String title; // e.g., "5% cashback on Axis Bank"

    @Column(columnDefinition = "TEXT")
    private String description;

    private String bankName; // For bank offers

    private String cardType; // e.g., "Debit Card", "Credit Card", "EMI Card"

    private BigDecimal discountAmount; // Fixed discount amount

    private Integer discountPercentage; // Percentage discount

    private BigDecimal maxDiscountAmount; // Maximum discount cap

    private BigDecimal minPurchaseAmount; // Minimum purchase required

    private String couponCode; // If applicable

    @Enumerated(EnumType.STRING)
    private OfferStatus status = OfferStatus.ACTIVE;

    private LocalDateTime validFrom;

    private LocalDateTime validUntil;

    private Integer sortOrder = 0;

    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public ProductOffer() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (status == null) status = OfferStatus.ACTIVE;
        if (sortOrder == null) sortOrder = 0;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public OfferType getOfferType() { return offerType; }
    public void setOfferType(OfferType offerType) { this.offerType = offerType; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public String getCardType() { return cardType; }
    public void setCardType(String cardType) { this.cardType = cardType; }

    public BigDecimal getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(BigDecimal discountAmount) { this.discountAmount = discountAmount; }

    public Integer getDiscountPercentage() { return discountPercentage; }
    public void setDiscountPercentage(Integer discountPercentage) { this.discountPercentage = discountPercentage; }

    public BigDecimal getMaxDiscountAmount() { return maxDiscountAmount; }
    public void setMaxDiscountAmount(BigDecimal maxDiscountAmount) { this.maxDiscountAmount = maxDiscountAmount; }

    public BigDecimal getMinPurchaseAmount() { return minPurchaseAmount; }
    public void setMinPurchaseAmount(BigDecimal minPurchaseAmount) { this.minPurchaseAmount = minPurchaseAmount; }

    public String getCouponCode() { return couponCode; }
    public void setCouponCode(String couponCode) { this.couponCode = couponCode; }

    public OfferStatus getStatus() { return status; }
    public void setStatus(OfferStatus status) { this.status = status; }

    public LocalDateTime getValidFrom() { return validFrom; }
    public void setValidFrom(LocalDateTime validFrom) { this.validFrom = validFrom; }

    public LocalDateTime getValidUntil() { return validUntil; }
    public void setValidUntil(LocalDateTime validUntil) { this.validUntil = validUntil; }

    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public enum OfferType {
        BANK_OFFER("Bank Offer"),
        PARTNER_OFFER("Partner Offer"),
        COUPON("Coupon Code"),
        EMI("EMI Option"),
        CASHBACK("Cashback"),
        DISCOUNT("Discount");

        private final String displayName;

        OfferType(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    public enum OfferStatus {
        ACTIVE, INACTIVE, EXPIRED
    }
}

