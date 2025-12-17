package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Vendor relationship (changed from Hospital)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id", nullable = false)
    private Vendor vendor;
    
    // Legacy hospital_id column - kept for database compatibility
    // Run fix_products_table.sql to remove constraint, then this field can be removed
    @Column(name = "hospital_id", nullable = true)
    private Long hospitalId;

    // Category relationship (changed from enum to entity)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private ProductCategory category;

    @Column(nullable = false)
    private String productName;

    @Column(unique = true)
    private String sku; // Stock Keeping Unit / Product Code

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(columnDefinition = "TEXT")
    private String shortDescription;

    // Pricing
    @Column(nullable = false)
    private BigDecimal price; // Selling price

    private BigDecimal mrp; // Maximum Retail Price (Original Price)

    private BigDecimal discountPrice; // Sale price (if on discount)

    private Integer discountPercentage; // Discount percentage

    private String offerBadge; // e.g., "20% OFF", "SALE", "NEW"

    // Inventory
    private Integer stockQuantity = 0;

    private Integer minStockLevel = 5; // Alert when stock goes below this

    private Boolean trackInventory = true; // Whether to track stock

    private Boolean allowBackorder = false; // Allow orders when out of stock

    // Product Details
    @Column(columnDefinition = "TEXT")
    private String ingredients; // For medicines/oils

    @Column(columnDefinition = "TEXT")
    private String benefits; // Health benefits

    @Column(columnDefinition = "TEXT")
    private String usageInstructions; // How to use

    @Column(columnDefinition = "TEXT")
    private String specifications; // Product specifications as JSON or text

    private String weight; // e.g., "100ml", "500g", "60 tablets"

    private String dimensions; // e.g., "10x5x3 cm"

    private String manufacturer;

    private String brand;

    private String countryOfOrigin = "India";

    private String expiryDate; // For medicines

    private String shelfLife; // e.g., "24 months"

    private String batchNumber;

    // Images - Main image
    private String imageUrl;

    // Status
    private Boolean isActive = true;

    private Boolean isFeatured = false;

    private Boolean isAvailable = true;

    private Boolean isNew = true; // Show "NEW" badge

    private Boolean isBestSeller = false;

    private Integer sortOrder = 0;

    // SEO & Marketing
    private String metaTitle;

    @Column(columnDefinition = "TEXT")
    private String metaDescription;

    private String slug; // URL-friendly name

    private String tags; // Comma-separated tags for search

    // Shipping
    private BigDecimal shippingWeight; // In kg

    private Boolean freeShipping = false;

    private BigDecimal shippingCharge;

    // Warranty & Services
    private String warrantyPeriod; // e.g., "1 Year", "2 Years"
    
    @Column(columnDefinition = "TEXT")
    private String warrantyDetails; // Detailed warranty information
    
    private String serviceCenterInfo; // Service center contact info
    
    private Boolean installationService = false; // If installation service available
    
    private BigDecimal installationCharge; // Installation service charge
    
    private Boolean extendedWarrantyAvailable = false; // Extended warranty option
    
    // EMI Options
    private Boolean emiAvailable = false;
    
    private String emiOptions; // JSON string: [{"months": 3, "interest": 0}, {"months": 6, "interest": 5}]
    
    private BigDecimal minEmiAmount; // Minimum amount for EMI
    
    // Delivery
    private Integer deliveryDaysMin = 3; // Minimum delivery days
    
    private Integer deliveryDaysMax = 7; // Maximum delivery days
    
    private Boolean expressDeliveryAvailable = false;
    
    private BigDecimal expressDeliveryCharge;
    
    private Integer expressDeliveryDays = 1;
    
    // Seller Policies
    private String returnPolicy; // Return policy description
    
    private Integer returnPeriodDays = 7; // Days within which return is allowed
    
    private String replacementPolicy; // Replacement policy description
    
    private Integer replacementPeriodDays = 7; // Days within which replacement is allowed
    
    private String cancellationPolicy; // Cancellation policy
    
    // Analytics
    private Long totalViews = 0L;

    private Long totalSales = 0L;

    private Double averageRating = 0.0;

    private Integer totalReviews = 0;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    // Relationships
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private List<ProductImage> images;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ProductReview> reviews;
    
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private List<ProductVariant> variants;
    
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private List<ProductQuestion> questions;
    
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private List<ProductOffer> offers;

    public Product() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (isActive == null) isActive = true;
        if (isFeatured == null) isFeatured = false;
        if (isAvailable == null) isAvailable = true;
        if (isNew == null) isNew = true;
        if (isBestSeller == null) isBestSeller = false;
        if (trackInventory == null) trackInventory = true;
        if (allowBackorder == null) allowBackorder = false;
        if (freeShipping == null) freeShipping = false;
        if (sortOrder == null) sortOrder = 0;
        if (totalViews == null) totalViews = 0L;
        if (totalSales == null) totalSales = 0L;
        if (averageRating == null) averageRating = 0.0;
        if (totalReviews == null) totalReviews = 0;
        if (stockQuantity == null) stockQuantity = 0;
        if (minStockLevel == null) minStockLevel = 5;
        if (countryOfOrigin == null) countryOfOrigin = "India";
        if (sku == null || sku.isEmpty()) {
            sku = "PRD" + System.currentTimeMillis();
        }
        if (slug == null || slug.isEmpty()) {
            slug = productName.toLowerCase().replaceAll("[^a-z0-9]+", "-");
        }
        if (freeShipping == null) freeShipping = false;
        if (installationService == null) installationService = false;
        if (extendedWarrantyAvailable == null) extendedWarrantyAvailable = false;
        if (emiAvailable == null) emiAvailable = false;
        if (expressDeliveryAvailable == null) expressDeliveryAvailable = false;
        if (returnPeriodDays == null) returnPeriodDays = 7;
        if (replacementPeriodDays == null) replacementPeriodDays = 7;
        if (deliveryDaysMin == null) deliveryDaysMin = 3;
        if (deliveryDaysMax == null) deliveryDaysMax = 7;
        if (expressDeliveryDays == null) expressDeliveryDays = 1;
        calculateDiscount();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
        calculateDiscount();
        // Auto disable if out of stock
        if (trackInventory && stockQuantity != null && stockQuantity <= 0 && !allowBackorder) {
            isAvailable = false;
        }
    }

    private void calculateDiscount() {
        if (mrp != null && price != null && mrp.compareTo(price) > 0) {
            BigDecimal discount = mrp.subtract(price);
            discountPercentage = discount.multiply(new BigDecimal(100)).divide(mrp, 0, java.math.RoundingMode.HALF_UP).intValue();
        }
    }

    // Helper method to get effective price
    public BigDecimal getEffectivePrice() {
        if (discountPrice != null && discountPrice.compareTo(BigDecimal.ZERO) > 0) {
            return discountPrice;
        }
        return price;
    }

    // Helper method to check if in stock
    public boolean isInStock() {
        if (!trackInventory) return true;
        return stockQuantity != null && stockQuantity > 0;
    }

    // Helper method to check if low stock
    public boolean isLowStock() {
        if (!trackInventory) return false;
        return stockQuantity != null && minStockLevel != null && stockQuantity <= minStockLevel && stockQuantity > 0;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Vendor getVendor() { return vendor; }
    public void setVendor(Vendor vendor) { this.vendor = vendor; }
    
    // Legacy hospitalId getter/setter (for database compatibility)
    public Long getHospitalId() { return hospitalId; }
    public void setHospitalId(Long hospitalId) { this.hospitalId = hospitalId; }

    public ProductCategory getCategory() { return category; }
    public void setCategory(ProductCategory category) { this.category = category; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getShortDescription() { return shortDescription; }
    public void setShortDescription(String shortDescription) { this.shortDescription = shortDescription; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public BigDecimal getMrp() { return mrp; }
    public void setMrp(BigDecimal mrp) { this.mrp = mrp; }

    public BigDecimal getDiscountPrice() { return discountPrice; }
    public void setDiscountPrice(BigDecimal discountPrice) { this.discountPrice = discountPrice; }

    public Integer getDiscountPercentage() { return discountPercentage; }
    public void setDiscountPercentage(Integer discountPercentage) { this.discountPercentage = discountPercentage; }

    public String getOfferBadge() { return offerBadge; }
    public void setOfferBadge(String offerBadge) { this.offerBadge = offerBadge; }

    public Integer getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(Integer stockQuantity) { this.stockQuantity = stockQuantity; }

    public Integer getMinStockLevel() { return minStockLevel; }
    public void setMinStockLevel(Integer minStockLevel) { this.minStockLevel = minStockLevel; }

    public Boolean getTrackInventory() { return trackInventory; }
    public void setTrackInventory(Boolean trackInventory) { this.trackInventory = trackInventory; }

    public Boolean getAllowBackorder() { return allowBackorder; }
    public void setAllowBackorder(Boolean allowBackorder) { this.allowBackorder = allowBackorder; }

    public String getIngredients() { return ingredients; }
    public void setIngredients(String ingredients) { this.ingredients = ingredients; }

    public String getBenefits() { return benefits; }
    public void setBenefits(String benefits) { this.benefits = benefits; }

    public String getUsageInstructions() { return usageInstructions; }
    public void setUsageInstructions(String usageInstructions) { this.usageInstructions = usageInstructions; }

    public String getSpecifications() { return specifications; }
    public void setSpecifications(String specifications) { this.specifications = specifications; }

    public String getWeight() { return weight; }
    public void setWeight(String weight) { this.weight = weight; }

    public String getDimensions() { return dimensions; }
    public void setDimensions(String dimensions) { this.dimensions = dimensions; }

    public String getManufacturer() { return manufacturer; }
    public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public String getCountryOfOrigin() { return countryOfOrigin; }
    public void setCountryOfOrigin(String countryOfOrigin) { this.countryOfOrigin = countryOfOrigin; }

    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }

    public String getShelfLife() { return shelfLife; }
    public void setShelfLife(String shelfLife) { this.shelfLife = shelfLife; }

    public String getBatchNumber() { return batchNumber; }
    public void setBatchNumber(String batchNumber) { this.batchNumber = batchNumber; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public Boolean getIsFeatured() { return isFeatured; }
    public void setIsFeatured(Boolean isFeatured) { this.isFeatured = isFeatured; }

    public Boolean getIsAvailable() { return isAvailable; }
    public void setIsAvailable(Boolean isAvailable) { this.isAvailable = isAvailable; }

    public Boolean getIsNew() { return isNew; }
    public void setIsNew(Boolean isNew) { this.isNew = isNew; }

    public Boolean getIsBestSeller() { return isBestSeller; }
    public void setIsBestSeller(Boolean isBestSeller) { this.isBestSeller = isBestSeller; }

    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }

    public String getMetaTitle() { return metaTitle; }
    public void setMetaTitle(String metaTitle) { this.metaTitle = metaTitle; }

    public String getMetaDescription() { return metaDescription; }
    public void setMetaDescription(String metaDescription) { this.metaDescription = metaDescription; }

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }

    public BigDecimal getShippingWeight() { return shippingWeight; }
    public void setShippingWeight(BigDecimal shippingWeight) { this.shippingWeight = shippingWeight; }

    public Boolean getFreeShipping() { return freeShipping; }
    public void setFreeShipping(Boolean freeShipping) { this.freeShipping = freeShipping; }

    public BigDecimal getShippingCharge() { return shippingCharge; }
    public void setShippingCharge(BigDecimal shippingCharge) { this.shippingCharge = shippingCharge; }

    public Long getTotalViews() { return totalViews; }
    public void setTotalViews(Long totalViews) { this.totalViews = totalViews; }

    public Long getTotalSales() { return totalSales; }
    public void setTotalSales(Long totalSales) { this.totalSales = totalSales; }

    public Double getAverageRating() { return averageRating; }
    public void setAverageRating(Double averageRating) { this.averageRating = averageRating; }

    public Integer getTotalReviews() { return totalReviews; }
    public void setTotalReviews(Integer totalReviews) { this.totalReviews = totalReviews; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public List<ProductImage> getImages() { return images; }
    public void setImages(List<ProductImage> images) { this.images = images; }

    public List<ProductReview> getReviews() { return reviews; }
    public void setReviews(List<ProductReview> reviews) { this.reviews = reviews; }

    public List<ProductVariant> getVariants() { return variants; }
    public void setVariants(List<ProductVariant> variants) { this.variants = variants; }

    public List<ProductQuestion> getQuestions() { return questions; }
    public void setQuestions(List<ProductQuestion> questions) { this.questions = questions; }

    public List<ProductOffer> getOffers() { return offers; }
    public void setOffers(List<ProductOffer> offers) { this.offers = offers; }

    // New field getters and setters
    public String getWarrantyPeriod() { return warrantyPeriod; }
    public void setWarrantyPeriod(String warrantyPeriod) { this.warrantyPeriod = warrantyPeriod; }

    public String getWarrantyDetails() { return warrantyDetails; }
    public void setWarrantyDetails(String warrantyDetails) { this.warrantyDetails = warrantyDetails; }

    public String getServiceCenterInfo() { return serviceCenterInfo; }
    public void setServiceCenterInfo(String serviceCenterInfo) { this.serviceCenterInfo = serviceCenterInfo; }

    public Boolean getInstallationService() { return installationService; }
    public void setInstallationService(Boolean installationService) { this.installationService = installationService; }

    public BigDecimal getInstallationCharge() { return installationCharge; }
    public void setInstallationCharge(BigDecimal installationCharge) { this.installationCharge = installationCharge; }

    public Boolean getExtendedWarrantyAvailable() { return extendedWarrantyAvailable; }
    public void setExtendedWarrantyAvailable(Boolean extendedWarrantyAvailable) { this.extendedWarrantyAvailable = extendedWarrantyAvailable; }

    public Boolean getEmiAvailable() { return emiAvailable; }
    public void setEmiAvailable(Boolean emiAvailable) { this.emiAvailable = emiAvailable; }

    public String getEmiOptions() { return emiOptions; }
    public void setEmiOptions(String emiOptions) { this.emiOptions = emiOptions; }

    public BigDecimal getMinEmiAmount() { return minEmiAmount; }
    public void setMinEmiAmount(BigDecimal minEmiAmount) { this.minEmiAmount = minEmiAmount; }

    public Integer getDeliveryDaysMin() { return deliveryDaysMin; }
    public void setDeliveryDaysMin(Integer deliveryDaysMin) { this.deliveryDaysMin = deliveryDaysMin; }

    public Integer getDeliveryDaysMax() { return deliveryDaysMax; }
    public void setDeliveryDaysMax(Integer deliveryDaysMax) { this.deliveryDaysMax = deliveryDaysMax; }

    public Boolean getExpressDeliveryAvailable() { return expressDeliveryAvailable; }
    public void setExpressDeliveryAvailable(Boolean expressDeliveryAvailable) { this.expressDeliveryAvailable = expressDeliveryAvailable; }

    public BigDecimal getExpressDeliveryCharge() { return expressDeliveryCharge; }
    public void setExpressDeliveryCharge(BigDecimal expressDeliveryCharge) { this.expressDeliveryCharge = expressDeliveryCharge; }

    public Integer getExpressDeliveryDays() { return expressDeliveryDays; }
    public void setExpressDeliveryDays(Integer expressDeliveryDays) { this.expressDeliveryDays = expressDeliveryDays; }

    public String getReturnPolicy() { return returnPolicy; }
    public void setReturnPolicy(String returnPolicy) { this.returnPolicy = returnPolicy; }

    public Integer getReturnPeriodDays() { return returnPeriodDays; }
    public void setReturnPeriodDays(Integer returnPeriodDays) { this.returnPeriodDays = returnPeriodDays; }

    public String getReplacementPolicy() { return replacementPolicy; }
    public void setReplacementPolicy(String replacementPolicy) { this.replacementPolicy = replacementPolicy; }

    public Integer getReplacementPeriodDays() { return replacementPeriodDays; }
    public void setReplacementPeriodDays(Integer replacementPeriodDays) { this.replacementPeriodDays = replacementPeriodDays; }

    public String getCancellationPolicy() { return cancellationPolicy; }
    public void setCancellationPolicy(String cancellationPolicy) { this.cancellationPolicy = cancellationPolicy; }
}
