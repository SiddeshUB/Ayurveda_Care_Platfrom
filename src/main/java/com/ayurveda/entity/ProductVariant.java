package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "product_variants")
public class ProductVariant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @Enumerated(EnumType.STRING)
    private VariantType variantType; // SIZE, COLOR, MODEL, YEAR, etc.

    private String variantName; // e.g., "20 inch", "Red", "2024", "500ml"

    private String variantValue; // e.g., "20", "red", "2024", "500"

    private String variantLabel; // Display label e.g., "Display Size", "Color", "Model Year"

    private String colorCode; // Hex color code for color variants

    private String imageUrl; // Variant-specific image

    private BigDecimal price; // Variant-specific price (null = same as product)

    private BigDecimal mrp; // Variant-specific MRP

    private BigDecimal discountPrice; // Variant-specific discount price

    private Integer stockQuantity; // Variant-specific stock

    private String sku; // Variant-specific SKU

    private Boolean isDefault = false; // Default variant

    private Boolean isActive = true;

    private Integer sortOrder = 0;

    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public ProductVariant() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (isDefault == null) isDefault = false;
        if (isActive == null) isActive = true;
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

    public VariantType getVariantType() { return variantType; }
    public void setVariantType(VariantType variantType) { this.variantType = variantType; }

    public String getVariantName() { return variantName; }
    public void setVariantName(String variantName) { this.variantName = variantName; }

    public String getVariantValue() { return variantValue; }
    public void setVariantValue(String variantValue) { this.variantValue = variantValue; }

    public String getVariantLabel() { return variantLabel; }
    public void setVariantLabel(String variantLabel) { this.variantLabel = variantLabel; }

    public String getColorCode() { return colorCode; }
    public void setColorCode(String colorCode) { this.colorCode = colorCode; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public BigDecimal getMrp() { return mrp; }
    public void setMrp(BigDecimal mrp) { this.mrp = mrp; }

    public BigDecimal getDiscountPrice() { return discountPrice; }
    public void setDiscountPrice(BigDecimal discountPrice) { this.discountPrice = discountPrice; }

    public Integer getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(Integer stockQuantity) { this.stockQuantity = stockQuantity; }

    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }

    public Boolean getIsDefault() { return isDefault; }
    public void setIsDefault(Boolean isDefault) { this.isDefault = isDefault; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public enum VariantType {
        SIZE("Size"),
        COLOR("Color"),
        MODEL("Model"),
        YEAR("Model Year"),
        WEIGHT("Weight/Pack Size"),
        OTHER("Other");

        private final String displayName;

        VariantType(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }
}

