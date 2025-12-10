package com.ayurveda.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "product_categories")
public class ProductCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String name;

    private String displayName;

    @Column(columnDefinition = "TEXT")
    private String description;

    private String imageUrl; // Category image

    private String iconClass; // Font Awesome or similar icon class

    // Parent-Child for subcategories
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private ProductCategory parent;

    @OneToMany(mappedBy = "parent", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ProductCategory> subcategories;

    // Status
    private Boolean isActive = true;

    private Boolean isDefault = false; // System default categories

    private Boolean isCustom = false; // Added via "Other" option by vendors

    private Integer sortOrder = 0;

    // SEO
    private String slug; // URL-friendly name

    private String metaTitle;

    @Column(columnDefinition = "TEXT")
    private String metaDescription;

    // Analytics
    private Long productCount = 0L;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private String createdBy; // Admin or Vendor who created

    // Products in this category
    @OneToMany(mappedBy = "category", fetch = FetchType.LAZY)
    private List<Product> products;

    public ProductCategory() {}

    public ProductCategory(String name, String displayName, boolean isDefault) {
        this.name = name;
        this.displayName = displayName;
        this.isDefault = isDefault;
        this.isActive = true;
        this.slug = name.toLowerCase().replace(" ", "-").replace("&", "and");
    }

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (isActive == null) isActive = true;
        if (isDefault == null) isDefault = false;
        if (isCustom == null) isCustom = false;
        if (sortOrder == null) sortOrder = 0;
        if (productCount == null) productCount = 0L;
        if (slug == null || slug.isEmpty()) {
            slug = name.toLowerCase().replace(" ", "-").replace("&", "and");
        }
        if (displayName == null || displayName.isEmpty()) {
            displayName = name;
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDisplayName() { return displayName; }
    public void setDisplayName(String displayName) { this.displayName = displayName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getIconClass() { return iconClass; }
    public void setIconClass(String iconClass) { this.iconClass = iconClass; }

    public ProductCategory getParent() { return parent; }
    public void setParent(ProductCategory parent) { this.parent = parent; }

    public List<ProductCategory> getSubcategories() { return subcategories; }
    public void setSubcategories(List<ProductCategory> subcategories) { this.subcategories = subcategories; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public Boolean getIsDefault() { return isDefault; }
    public void setIsDefault(Boolean isDefault) { this.isDefault = isDefault; }

    public Boolean getIsCustom() { return isCustom; }
    public void setIsCustom(Boolean isCustom) { this.isCustom = isCustom; }

    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public String getMetaTitle() { return metaTitle; }
    public void setMetaTitle(String metaTitle) { this.metaTitle = metaTitle; }

    public String getMetaDescription() { return metaDescription; }
    public void setMetaDescription(String metaDescription) { this.metaDescription = metaDescription; }

    public Long getProductCount() { return productCount; }
    public void setProductCount(Long productCount) { this.productCount = productCount; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }

    public List<Product> getProducts() { return products; }
    public void setProducts(List<Product> products) { this.products = products; }
}

