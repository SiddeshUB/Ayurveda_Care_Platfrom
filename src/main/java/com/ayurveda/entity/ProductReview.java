package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "product_reviews")
public class ProductReview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    private ProductOrder order; // Optional: link to the order for verified purchase

    @Column(nullable = false)
    private Integer rating; // 1-5 stars

    private String title; // Review title

    @Column(columnDefinition = "TEXT")
    private String comment;

    @Column(columnDefinition = "TEXT")
    private String pros; // What user liked

    @Column(columnDefinition = "TEXT")
    private String cons; // What user didn't like

    // Review Images (optional)
    @Column(columnDefinition = "TEXT")
    private String imageUrls; // Comma-separated image URLs

    // Status
    @Enumerated(EnumType.STRING)
    private ReviewStatus status = ReviewStatus.PENDING;

    private Boolean isVerifiedPurchase = false;

    private Boolean isRecommended = true;

    // Helpful votes
    private Integer helpfulCount = 0;

    private Integer notHelpfulCount = 0;

    // Admin moderation
    private String moderationNotes;

    private LocalDateTime moderatedAt;

    private String moderatedBy;

    // Vendor response
    @Column(columnDefinition = "TEXT")
    private String vendorResponse;

    private LocalDateTime vendorRespondedAt;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public ProductReview() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (status == null) status = ReviewStatus.PENDING;
        if (isVerifiedPurchase == null) isVerifiedPurchase = false;
        if (isRecommended == null) isRecommended = true;
        if (helpfulCount == null) helpfulCount = 0;
        if (notHelpfulCount == null) notHelpfulCount = 0;
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

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public ProductOrder getOrder() { return order; }
    public void setOrder(ProductOrder order) { this.order = order; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public String getPros() { return pros; }
    public void setPros(String pros) { this.pros = pros; }

    public String getCons() { return cons; }
    public void setCons(String cons) { this.cons = cons; }

    public String getImageUrls() { return imageUrls; }
    public void setImageUrls(String imageUrls) { this.imageUrls = imageUrls; }

    public ReviewStatus getStatus() { return status; }
    public void setStatus(ReviewStatus status) { this.status = status; }

    public Boolean getIsVerifiedPurchase() { return isVerifiedPurchase; }
    public void setIsVerifiedPurchase(Boolean isVerifiedPurchase) { this.isVerifiedPurchase = isVerifiedPurchase; }

    public Boolean getIsRecommended() { return isRecommended; }
    public void setIsRecommended(Boolean isRecommended) { this.isRecommended = isRecommended; }

    public Integer getHelpfulCount() { return helpfulCount; }
    public void setHelpfulCount(Integer helpfulCount) { this.helpfulCount = helpfulCount; }

    public Integer getNotHelpfulCount() { return notHelpfulCount; }
    public void setNotHelpfulCount(Integer notHelpfulCount) { this.notHelpfulCount = notHelpfulCount; }

    public String getModerationNotes() { return moderationNotes; }
    public void setModerationNotes(String moderationNotes) { this.moderationNotes = moderationNotes; }

    public LocalDateTime getModeratedAt() { return moderatedAt; }
    public void setModeratedAt(LocalDateTime moderatedAt) { this.moderatedAt = moderatedAt; }

    public String getModeratedBy() { return moderatedBy; }
    public void setModeratedBy(String moderatedBy) { this.moderatedBy = moderatedBy; }

    public String getVendorResponse() { return vendorResponse; }
    public void setVendorResponse(String vendorResponse) { this.vendorResponse = vendorResponse; }

    public LocalDateTime getVendorRespondedAt() { return vendorRespondedAt; }
    public void setVendorRespondedAt(LocalDateTime vendorRespondedAt) { this.vendorRespondedAt = vendorRespondedAt; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    // Enum
    public enum ReviewStatus {
        PENDING("Pending Approval"),
        APPROVED("Approved"),
        REJECTED("Rejected"),
        FLAGGED("Flagged for Review");

        private final String displayName;

        ReviewStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }
}

