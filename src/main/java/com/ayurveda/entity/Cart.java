package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "carts", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"user_id", "product_id"})
})
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id", nullable = false)
    private Vendor vendor;

    @Column(nullable = false)
    private Integer quantity = 1;

    @Column(nullable = false)
    private BigDecimal unitPrice; // Price at time of adding to cart

    private BigDecimal totalPrice; // quantity * unitPrice

    // For saved for later functionality
    private Boolean savedForLater = false;

    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public Cart() {}

    public Cart(User user, Product product, Vendor vendor, int quantity, BigDecimal unitPrice) {
        this.user = user;
        this.product = product;
        this.vendor = vendor;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        calculateTotal();
    }

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (quantity == null) quantity = 1;
        if (savedForLater == null) savedForLater = false;
        calculateTotal();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
        calculateTotal();
    }

    private void calculateTotal() {
        if (unitPrice != null && quantity != null) {
            totalPrice = unitPrice.multiply(new BigDecimal(quantity));
        }
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public Vendor getVendor() { return vendor; }
    public void setVendor(Vendor vendor) { this.vendor = vendor; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
        calculateTotal();
    }

    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
        calculateTotal();
    }

    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }

    public Boolean getSavedForLater() { return savedForLater; }
    public void setSavedForLater(Boolean savedForLater) { this.savedForLater = savedForLater; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
