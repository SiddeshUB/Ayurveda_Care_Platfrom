package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "order_items")
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private ProductOrder order;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id", nullable = false)
    private Vendor vendor;

    @Column(nullable = false)
    private Integer quantity;

    @Column(nullable = false)
    private BigDecimal unitPrice; // Price at time of order

    @Column(nullable = false)
    private BigDecimal totalPrice; // quantity * unitPrice

    // Commission calculation
    private BigDecimal commissionPercentage; // Vendor's commission at order time

    private BigDecimal commissionAmount; // Commission deducted

    private BigDecimal vendorEarning; // Amount vendor receives

    // Product snapshot at time of order
    private String productName;

    private String productSku;

    private String productImageUrl;

    // Item status (for individual item tracking in multi-vendor orders)
    @Enumerated(EnumType.STRING)
    private ItemStatus status = ItemStatus.PENDING;

    private String trackingNumber; // If shipped separately

    public OrderItem() {}

    @PrePersist
    protected void onCreate() {
        if (status == null) status = ItemStatus.PENDING;
        calculateTotals();
    }

    private void calculateTotals() {
        if (unitPrice != null && quantity != null) {
            totalPrice = unitPrice.multiply(new BigDecimal(quantity));
            
            if (commissionPercentage != null) {
                commissionAmount = totalPrice.multiply(commissionPercentage).divide(new BigDecimal(100), 2, java.math.RoundingMode.HALF_UP);
                vendorEarning = totalPrice.subtract(commissionAmount);
            } else {
                vendorEarning = totalPrice;
            }
        }
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public ProductOrder getOrder() { return order; }
    public void setOrder(ProductOrder order) { this.order = order; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public Vendor getVendor() { return vendor; }
    public void setVendor(Vendor vendor) { this.vendor = vendor; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { 
        this.quantity = quantity;
        calculateTotals();
    }

    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { 
        this.unitPrice = unitPrice;
        calculateTotals();
    }

    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }

    public BigDecimal getCommissionPercentage() { return commissionPercentage; }
    public void setCommissionPercentage(BigDecimal commissionPercentage) { 
        this.commissionPercentage = commissionPercentage;
        calculateTotals();
    }

    public BigDecimal getCommissionAmount() { return commissionAmount; }
    public void setCommissionAmount(BigDecimal commissionAmount) { this.commissionAmount = commissionAmount; }

    public BigDecimal getVendorEarning() { return vendorEarning; }
    public void setVendorEarning(BigDecimal vendorEarning) { this.vendorEarning = vendorEarning; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getProductSku() { return productSku; }
    public void setProductSku(String productSku) { this.productSku = productSku; }

    public String getProductImageUrl() { return productImageUrl; }
    public void setProductImageUrl(String productImageUrl) { this.productImageUrl = productImageUrl; }

    public ItemStatus getStatus() { return status; }
    public void setStatus(ItemStatus status) { this.status = status; }

    public String getTrackingNumber() { return trackingNumber; }
    public void setTrackingNumber(String trackingNumber) { this.trackingNumber = trackingNumber; }

    // Enum for item-level status
    public enum ItemStatus {
        PENDING("Pending"),
        CONFIRMED("Confirmed"),
        PACKED("Packed"),
        SHIPPED("Shipped"),
        DELIVERED("Delivered"),
        CANCELLED("Cancelled"),
        RETURNED("Returned");

        private final String displayName;

        ItemStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }
}
