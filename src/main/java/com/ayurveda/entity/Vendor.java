package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "vendors")
public class Vendor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // ==================== SECTION 1: Basic Information ====================
    @Column(nullable = false)
    private String ownerFullName;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String mobileNumber;

    private String alternatePhone;

    // ==================== SECTION 2: Business Details ====================
    @Column(nullable = false)
    private String businessName;

    @Enumerated(EnumType.STRING)
    private BusinessType businessType;

    private Integer yearEstablished;

    @Column(length = 15)
    private String gstNumber;

    @Column(length = 10)
    private String panNumber;

    private String tradeLicenseNumber;

    private String fssaiLicense; // For food/supplements

    private String ayushLicense; // For Ayurvedic products

    private String drugLicense; // For medicines

    // ==================== SECTION 3: Business Address ====================
    @Column(nullable = false)
    private String businessAddressLine1;

    private String businessAddressLine2;

    @Column(nullable = false)
    private String businessCity;

    @Column(nullable = false)
    private String businessState;

    @Column(nullable = false, length = 6)
    private String businessPinCode;

    private String businessCountry = "India";

    // ==================== SECTION 4: Warehouse/Pickup Address ====================
    private Boolean sameAsBusinessAddress = true;

    private String warehouseAddressLine1;

    private String warehouseAddressLine2;

    private String warehouseCity;

    private String warehouseState;

    private String warehousePinCode;

    // ==================== SECTION 5: Bank Details ====================
    @Column(nullable = false)
    private String bankName;

    @Column(nullable = false)
    private String accountHolderName;

    @Column(nullable = false)
    private String accountNumber;

    @Column(nullable = false, length = 11)
    private String ifscCode;

    private String branchName;

    @Enumerated(EnumType.STRING)
    private AccountType accountType;

    // ==================== SECTION 6: Store Information ====================
    @Column(nullable = false)
    private String storeDisplayName;

    @Column(columnDefinition = "TEXT")
    private String storeDescription;

    private String storeLogoUrl;

    private String storeBannerUrl;

    @Column(columnDefinition = "TEXT")
    private String productCategories; // Comma-separated category IDs

    // ==================== SECTION 7: Social Links (Optional) ====================
    private String websiteUrl;

    private String facebookUrl;

    private String instagramHandle;

    private String youtubeUrl;

    // ==================== SECTION 8: Commission & Payment Settings ====================
    @Column(precision = 5, scale = 2)
    private BigDecimal commissionPercentage; // Set by Admin (e.g., 10.00 for 10%)

    @Enumerated(EnumType.STRING)
    private PaymentCycle paymentCycle = PaymentCycle.MONTHLY;

    private BigDecimal minPayoutThreshold = new BigDecimal("500.00"); // Minimum amount for payout

    // ==================== SECTION 9: Status & Verification ====================
    @Enumerated(EnumType.STRING)
    private VendorStatus status = VendorStatus.PENDING;

    private Boolean isActive = false;

    private Boolean isVerified = false;

    private Boolean emailVerified = false;

    private Boolean phoneVerified = false;

    private Boolean documentsVerified = false;

    private Boolean bankVerified = false;

    private String rejectionReason; // If admin rejects

    private LocalDateTime approvedAt;

    private String approvedBy; // Admin who approved

    // ==================== SECTION 10: Terms Agreement ====================
    private Boolean agreedToTerms = false;

    private Boolean agreedToSellerAgreement = false;

    private Boolean agreedToReturnPolicy = false;

    private LocalDateTime termsAgreedAt;

    // ==================== SECTION 11: Analytics ====================
    private Long totalProducts = 0L;

    private Long totalOrders = 0L;

    private Long totalSales = 0L;

    private BigDecimal totalRevenue = BigDecimal.ZERO;

    private BigDecimal totalCommissionPaid = BigDecimal.ZERO;

    private Double averageRating = 0.0;

    private Integer totalReviews = 0;

    // ==================== SECTION 12: Password Reset ====================
    private String passwordResetToken;
    private LocalDateTime passwordResetTokenExpiry;

    // ==================== SECTION 13: Timestamps ====================
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private LocalDateTime lastLoginAt;

    // ==================== Relationships ====================
    @OneToMany(mappedBy = "vendor", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<VendorDocument> documents;

    @OneToMany(mappedBy = "vendor", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Product> products;

    public Vendor() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (status == null) status = VendorStatus.PENDING;
        if (isActive == null) isActive = false;
        if (isVerified == null) isVerified = false;
        if (businessCountry == null) businessCountry = "India";
        if (totalProducts == null) totalProducts = 0L;
        if (totalOrders == null) totalOrders = 0L;
        if (totalSales == null) totalSales = 0L;
        if (totalRevenue == null) totalRevenue = BigDecimal.ZERO;
        if (totalCommissionPaid == null) totalCommissionPaid = BigDecimal.ZERO;
        if (averageRating == null) averageRating = 0.0;
        if (totalReviews == null) totalReviews = 0;
        if (minPayoutThreshold == null) minPayoutThreshold = new BigDecimal("500.00");
        if (paymentCycle == null) paymentCycle = PaymentCycle.MONTHLY;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // ==================== Getters and Setters ====================
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getOwnerFullName() { return ownerFullName; }
    public void setOwnerFullName(String ownerFullName) { this.ownerFullName = ownerFullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }

    public String getAlternatePhone() { return alternatePhone; }
    public void setAlternatePhone(String alternatePhone) { this.alternatePhone = alternatePhone; }

    public String getBusinessName() { return businessName; }
    public void setBusinessName(String businessName) { this.businessName = businessName; }

    public BusinessType getBusinessType() { return businessType; }
    public void setBusinessType(BusinessType businessType) { this.businessType = businessType; }

    public Integer getYearEstablished() { return yearEstablished; }
    public void setYearEstablished(Integer yearEstablished) { this.yearEstablished = yearEstablished; }

    public String getGstNumber() { return gstNumber; }
    public void setGstNumber(String gstNumber) { this.gstNumber = gstNumber; }

    public String getPanNumber() { return panNumber; }
    public void setPanNumber(String panNumber) { this.panNumber = panNumber; }

    public String getTradeLicenseNumber() { return tradeLicenseNumber; }
    public void setTradeLicenseNumber(String tradeLicenseNumber) { this.tradeLicenseNumber = tradeLicenseNumber; }

    public String getFssaiLicense() { return fssaiLicense; }
    public void setFssaiLicense(String fssaiLicense) { this.fssaiLicense = fssaiLicense; }

    public String getAyushLicense() { return ayushLicense; }
    public void setAyushLicense(String ayushLicense) { this.ayushLicense = ayushLicense; }

    public String getDrugLicense() { return drugLicense; }
    public void setDrugLicense(String drugLicense) { this.drugLicense = drugLicense; }

    public String getBusinessAddressLine1() { return businessAddressLine1; }
    public void setBusinessAddressLine1(String businessAddressLine1) { this.businessAddressLine1 = businessAddressLine1; }

    public String getBusinessAddressLine2() { return businessAddressLine2; }
    public void setBusinessAddressLine2(String businessAddressLine2) { this.businessAddressLine2 = businessAddressLine2; }

    public String getBusinessCity() { return businessCity; }
    public void setBusinessCity(String businessCity) { this.businessCity = businessCity; }

    public String getBusinessState() { return businessState; }
    public void setBusinessState(String businessState) { this.businessState = businessState; }

    public String getBusinessPinCode() { return businessPinCode; }
    public void setBusinessPinCode(String businessPinCode) { this.businessPinCode = businessPinCode; }

    public String getBusinessCountry() { return businessCountry; }
    public void setBusinessCountry(String businessCountry) { this.businessCountry = businessCountry; }

    public Boolean getSameAsBusinessAddress() { return sameAsBusinessAddress; }
    public void setSameAsBusinessAddress(Boolean sameAsBusinessAddress) { this.sameAsBusinessAddress = sameAsBusinessAddress; }

    public String getWarehouseAddressLine1() { return warehouseAddressLine1; }
    public void setWarehouseAddressLine1(String warehouseAddressLine1) { this.warehouseAddressLine1 = warehouseAddressLine1; }

    public String getWarehouseAddressLine2() { return warehouseAddressLine2; }
    public void setWarehouseAddressLine2(String warehouseAddressLine2) { this.warehouseAddressLine2 = warehouseAddressLine2; }

    public String getWarehouseCity() { return warehouseCity; }
    public void setWarehouseCity(String warehouseCity) { this.warehouseCity = warehouseCity; }

    public String getWarehouseState() { return warehouseState; }
    public void setWarehouseState(String warehouseState) { this.warehouseState = warehouseState; }

    public String getWarehousePinCode() { return warehousePinCode; }
    public void setWarehousePinCode(String warehousePinCode) { this.warehousePinCode = warehousePinCode; }

    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public String getAccountHolderName() { return accountHolderName; }
    public void setAccountHolderName(String accountHolderName) { this.accountHolderName = accountHolderName; }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public String getIfscCode() { return ifscCode; }
    public void setIfscCode(String ifscCode) { this.ifscCode = ifscCode; }

    public String getBranchName() { return branchName; }
    public void setBranchName(String branchName) { this.branchName = branchName; }

    public AccountType getAccountType() { return accountType; }
    public void setAccountType(AccountType accountType) { this.accountType = accountType; }

    public String getStoreDisplayName() { return storeDisplayName; }
    public void setStoreDisplayName(String storeDisplayName) { this.storeDisplayName = storeDisplayName; }

    public String getStoreDescription() { return storeDescription; }
    public void setStoreDescription(String storeDescription) { this.storeDescription = storeDescription; }

    public String getStoreLogoUrl() { return storeLogoUrl; }
    public void setStoreLogoUrl(String storeLogoUrl) { this.storeLogoUrl = storeLogoUrl; }

    public String getStoreBannerUrl() { return storeBannerUrl; }
    public void setStoreBannerUrl(String storeBannerUrl) { this.storeBannerUrl = storeBannerUrl; }

    public String getProductCategories() { return productCategories; }
    public void setProductCategories(String productCategories) { this.productCategories = productCategories; }

    public String getWebsiteUrl() { return websiteUrl; }
    public void setWebsiteUrl(String websiteUrl) { this.websiteUrl = websiteUrl; }

    public String getFacebookUrl() { return facebookUrl; }
    public void setFacebookUrl(String facebookUrl) { this.facebookUrl = facebookUrl; }

    public String getInstagramHandle() { return instagramHandle; }
    public void setInstagramHandle(String instagramHandle) { this.instagramHandle = instagramHandle; }

    public String getYoutubeUrl() { return youtubeUrl; }
    public void setYoutubeUrl(String youtubeUrl) { this.youtubeUrl = youtubeUrl; }

    public BigDecimal getCommissionPercentage() { return commissionPercentage; }
    public void setCommissionPercentage(BigDecimal commissionPercentage) { this.commissionPercentage = commissionPercentage; }

    public PaymentCycle getPaymentCycle() { return paymentCycle; }
    public void setPaymentCycle(PaymentCycle paymentCycle) { this.paymentCycle = paymentCycle; }

    public BigDecimal getMinPayoutThreshold() { return minPayoutThreshold; }
    public void setMinPayoutThreshold(BigDecimal minPayoutThreshold) { this.minPayoutThreshold = minPayoutThreshold; }

    public VendorStatus getStatus() { return status; }
    public void setStatus(VendorStatus status) { this.status = status; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public Boolean getIsVerified() { return isVerified; }
    public void setIsVerified(Boolean isVerified) { this.isVerified = isVerified; }

    public Boolean getEmailVerified() { return emailVerified; }
    public void setEmailVerified(Boolean emailVerified) { this.emailVerified = emailVerified; }

    public Boolean getPhoneVerified() { return phoneVerified; }
    public void setPhoneVerified(Boolean phoneVerified) { this.phoneVerified = phoneVerified; }

    public Boolean getDocumentsVerified() { return documentsVerified; }
    public void setDocumentsVerified(Boolean documentsVerified) { this.documentsVerified = documentsVerified; }

    public Boolean getBankVerified() { return bankVerified; }
    public void setBankVerified(Boolean bankVerified) { this.bankVerified = bankVerified; }

    public String getRejectionReason() { return rejectionReason; }
    public void setRejectionReason(String rejectionReason) { this.rejectionReason = rejectionReason; }

    public LocalDateTime getApprovedAt() { return approvedAt; }
    public void setApprovedAt(LocalDateTime approvedAt) { this.approvedAt = approvedAt; }

    public String getApprovedBy() { return approvedBy; }
    public void setApprovedBy(String approvedBy) { this.approvedBy = approvedBy; }

    public Boolean getAgreedToTerms() { return agreedToTerms; }
    public void setAgreedToTerms(Boolean agreedToTerms) { this.agreedToTerms = agreedToTerms; }

    public Boolean getAgreedToSellerAgreement() { return agreedToSellerAgreement; }
    public void setAgreedToSellerAgreement(Boolean agreedToSellerAgreement) { this.agreedToSellerAgreement = agreedToSellerAgreement; }

    public Boolean getAgreedToReturnPolicy() { return agreedToReturnPolicy; }
    public void setAgreedToReturnPolicy(Boolean agreedToReturnPolicy) { this.agreedToReturnPolicy = agreedToReturnPolicy; }

    public LocalDateTime getTermsAgreedAt() { return termsAgreedAt; }
    public void setTermsAgreedAt(LocalDateTime termsAgreedAt) { this.termsAgreedAt = termsAgreedAt; }

    public Long getTotalProducts() { return totalProducts; }
    public void setTotalProducts(Long totalProducts) { this.totalProducts = totalProducts; }

    public Long getTotalOrders() { return totalOrders; }
    public void setTotalOrders(Long totalOrders) { this.totalOrders = totalOrders; }

    public Long getTotalSales() { return totalSales; }
    public void setTotalSales(Long totalSales) { this.totalSales = totalSales; }

    public BigDecimal getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(BigDecimal totalRevenue) { this.totalRevenue = totalRevenue; }

    public BigDecimal getTotalCommissionPaid() { return totalCommissionPaid; }
    public void setTotalCommissionPaid(BigDecimal totalCommissionPaid) { this.totalCommissionPaid = totalCommissionPaid; }

    public Double getAverageRating() { return averageRating; }
    public void setAverageRating(Double averageRating) { this.averageRating = averageRating; }

    public Integer getTotalReviews() { return totalReviews; }
    public void setTotalReviews(Integer totalReviews) { this.totalReviews = totalReviews; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public LocalDateTime getLastLoginAt() { return lastLoginAt; }
    public void setLastLoginAt(LocalDateTime lastLoginAt) { this.lastLoginAt = lastLoginAt; }

    public String getPasswordResetToken() { return passwordResetToken; }
    public void setPasswordResetToken(String passwordResetToken) { this.passwordResetToken = passwordResetToken; }

    public LocalDateTime getPasswordResetTokenExpiry() { return passwordResetTokenExpiry; }
    public void setPasswordResetTokenExpiry(LocalDateTime passwordResetTokenExpiry) { this.passwordResetTokenExpiry = passwordResetTokenExpiry; }

    public List<VendorDocument> getDocuments() { return documents; }
    public void setDocuments(List<VendorDocument> documents) { this.documents = documents; }

    public List<Product> getProducts() { return products; }
    public void setProducts(List<Product> products) { this.products = products; }

    // ==================== Enums ====================
    public enum BusinessType {
        INDIVIDUAL("Individual/Proprietorship"),
        PROPRIETORSHIP("Proprietorship"),
        PARTNERSHIP("Partnership"),
        PRIVATE_LIMITED("Private Limited"),
        LLP("Limited Liability Partnership"),
        PUBLIC_LIMITED("Public Limited"),
        OTHER("Other");

        private final String displayName;

        BusinessType(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    public enum AccountType {
        SAVINGS("Savings"),
        CURRENT("Current");

        private final String displayName;

        AccountType(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    public enum VendorStatus {
        PENDING("Pending Approval"),
        APPROVED("Approved"),
        REJECTED("Rejected"),
        SUSPENDED("Suspended"),
        BLOCKED("Blocked");

        private final String displayName;

        VendorStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    public enum PaymentCycle {
        WEEKLY("Weekly"),
        BIWEEKLY("Bi-Weekly"),
        MONTHLY("Monthly");

        private final String displayName;

        PaymentCycle(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }
}

