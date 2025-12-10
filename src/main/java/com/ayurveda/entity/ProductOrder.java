package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "product_orders")
public class ProductOrder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String orderNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    // Legacy hospital_id column - kept for database compatibility
    @Column(name = "hospital_id", nullable = true)
    private Long hospitalId;

    // Order Items
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<OrderItem> orderItems;

    // Pricing
    @Column(nullable = false)
    private BigDecimal subtotal; // Sum of all items

    private BigDecimal shippingCharges = BigDecimal.ZERO;

    private BigDecimal discount = BigDecimal.ZERO;

    private BigDecimal couponDiscount = BigDecimal.ZERO;

    private String couponCode; // Applied coupon code

    private BigDecimal tax = BigDecimal.ZERO;

    @Column(nullable = false)
    private BigDecimal totalAmount; // subtotal + shipping + tax - discount

    // Shipping Address
    private String shippingName;

    private String shippingPhone;

    private String shippingEmail;

    private String shippingAddressLine1;

    private String shippingAddressLine2;

    private String shippingCity;

    private String shippingState;

    private String shippingPostalCode;

    private String shippingCountry = "India";

    // Billing Address (if different)
    private Boolean billingAddressSame = true;

    private String billingName;

    private String billingAddressLine1;

    private String billingAddressLine2;

    private String billingCity;

    private String billingState;

    private String billingPostalCode;

    // Status
    @Enumerated(EnumType.STRING)
    private OrderStatus status = OrderStatus.PENDING;

    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus = PaymentStatus.PENDING;

    // Payment
    @Enumerated(EnumType.STRING)
    private PaymentMethod paymentMethod;

    private String razorpayOrderId; // Razorpay order ID

    private String razorpayPaymentId; // Razorpay payment ID

    private String razorpaySignature; // Razorpay signature

    private String paymentReference; // Transaction ID

    private LocalDateTime paymentDate;

    // Shipping
    private String trackingNumber;

    private String shippingProvider; // e.g., "Delhivery", "BlueDart"

    private LocalDateTime shippedDate;

    private LocalDateTime deliveredDate;

    private LocalDateTime expectedDeliveryDate;

    // Notes
    @Column(columnDefinition = "TEXT")
    private String customerNotes;

    @Column(columnDefinition = "TEXT")
    private String adminNotes;

    // Cancellation/Refund
    private String cancellationReason;

    private LocalDateTime cancelledAt;

    private String refundReference;

    private BigDecimal refundAmount;

    private LocalDateTime refundedAt;

    // Invoice
    private String invoiceNumber;

    private String invoiceUrl;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public ProductOrder() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (orderNumber == null) {
            orderNumber = "ORD" + System.currentTimeMillis();
        }
        if (status == null) {
            status = OrderStatus.PENDING;
        }
        if (paymentStatus == null) {
            paymentStatus = PaymentStatus.PENDING;
        }
        if (shippingCountry == null) {
            shippingCountry = "India";
        }
        if (billingAddressSame == null) {
            billingAddressSame = true;
        }
        calculateTotal();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
        calculateTotal();
    }

    private void calculateTotal() {
        if (subtotal == null) subtotal = BigDecimal.ZERO;
        if (shippingCharges == null) shippingCharges = BigDecimal.ZERO;
        if (discount == null) discount = BigDecimal.ZERO;
        if (couponDiscount == null) couponDiscount = BigDecimal.ZERO;
        if (tax == null) tax = BigDecimal.ZERO;

        totalAmount = subtotal.add(shippingCharges).add(tax).subtract(discount).subtract(couponDiscount);
        if (totalAmount.compareTo(BigDecimal.ZERO) < 0) {
            totalAmount = BigDecimal.ZERO;
        }
    }

    // Generate invoice number
    public void generateInvoiceNumber() {
        if (invoiceNumber == null && paymentStatus == PaymentStatus.PAID) {
            invoiceNumber = "INV" + System.currentTimeMillis();
        }
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getOrderNumber() { return orderNumber; }
    public void setOrderNumber(String orderNumber) { this.orderNumber = orderNumber; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    
    // Legacy hospitalId getter/setter (for database compatibility)
    public Long getHospitalId() { return hospitalId; }
    public void setHospitalId(Long hospitalId) { this.hospitalId = hospitalId; }

    public List<OrderItem> getOrderItems() { return orderItems; }
    public void setOrderItems(List<OrderItem> orderItems) { this.orderItems = orderItems; }

    public BigDecimal getSubtotal() { return subtotal; }
    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
        calculateTotal();
    }

    public BigDecimal getShippingCharges() { return shippingCharges; }
    public void setShippingCharges(BigDecimal shippingCharges) {
        this.shippingCharges = shippingCharges;
        calculateTotal();
    }

    public BigDecimal getDiscount() { return discount; }
    public void setDiscount(BigDecimal discount) {
        this.discount = discount;
        calculateTotal();
    }

    public BigDecimal getCouponDiscount() { return couponDiscount; }
    public void setCouponDiscount(BigDecimal couponDiscount) {
        this.couponDiscount = couponDiscount;
        calculateTotal();
    }

    public String getCouponCode() { return couponCode; }
    public void setCouponCode(String couponCode) { this.couponCode = couponCode; }

    public BigDecimal getTax() { return tax; }
    public void setTax(BigDecimal tax) {
        this.tax = tax;
        calculateTotal();
    }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public String getShippingName() { return shippingName; }
    public void setShippingName(String shippingName) { this.shippingName = shippingName; }

    public String getShippingPhone() { return shippingPhone; }
    public void setShippingPhone(String shippingPhone) { this.shippingPhone = shippingPhone; }

    public String getShippingEmail() { return shippingEmail; }
    public void setShippingEmail(String shippingEmail) { this.shippingEmail = shippingEmail; }

    public String getShippingAddressLine1() { return shippingAddressLine1; }
    public void setShippingAddressLine1(String shippingAddressLine1) { this.shippingAddressLine1 = shippingAddressLine1; }

    public String getShippingAddressLine2() { return shippingAddressLine2; }
    public void setShippingAddressLine2(String shippingAddressLine2) { this.shippingAddressLine2 = shippingAddressLine2; }

    public String getShippingCity() { return shippingCity; }
    public void setShippingCity(String shippingCity) { this.shippingCity = shippingCity; }

    public String getShippingState() { return shippingState; }
    public void setShippingState(String shippingState) { this.shippingState = shippingState; }

    public String getShippingPostalCode() { return shippingPostalCode; }
    public void setShippingPostalCode(String shippingPostalCode) { this.shippingPostalCode = shippingPostalCode; }

    public String getShippingCountry() { return shippingCountry; }
    public void setShippingCountry(String shippingCountry) { this.shippingCountry = shippingCountry; }

    public Boolean getBillingAddressSame() { return billingAddressSame; }
    public void setBillingAddressSame(Boolean billingAddressSame) { this.billingAddressSame = billingAddressSame; }

    public String getBillingName() { return billingName; }
    public void setBillingName(String billingName) { this.billingName = billingName; }

    public String getBillingAddressLine1() { return billingAddressLine1; }
    public void setBillingAddressLine1(String billingAddressLine1) { this.billingAddressLine1 = billingAddressLine1; }

    public String getBillingAddressLine2() { return billingAddressLine2; }
    public void setBillingAddressLine2(String billingAddressLine2) { this.billingAddressLine2 = billingAddressLine2; }

    public String getBillingCity() { return billingCity; }
    public void setBillingCity(String billingCity) { this.billingCity = billingCity; }

    public String getBillingState() { return billingState; }
    public void setBillingState(String billingState) { this.billingState = billingState; }

    public String getBillingPostalCode() { return billingPostalCode; }
    public void setBillingPostalCode(String billingPostalCode) { this.billingPostalCode = billingPostalCode; }

    public OrderStatus getStatus() { return status; }
    public void setStatus(OrderStatus status) { this.status = status; }

    public PaymentStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; }

    public PaymentMethod getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(PaymentMethod paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getRazorpayOrderId() { return razorpayOrderId; }
    public void setRazorpayOrderId(String razorpayOrderId) { this.razorpayOrderId = razorpayOrderId; }

    public String getRazorpayPaymentId() { return razorpayPaymentId; }
    public void setRazorpayPaymentId(String razorpayPaymentId) { this.razorpayPaymentId = razorpayPaymentId; }

    public String getRazorpaySignature() { return razorpaySignature; }
    public void setRazorpaySignature(String razorpaySignature) { this.razorpaySignature = razorpaySignature; }

    public String getPaymentReference() { return paymentReference; }
    public void setPaymentReference(String paymentReference) { this.paymentReference = paymentReference; }

    public LocalDateTime getPaymentDate() { return paymentDate; }
    public void setPaymentDate(LocalDateTime paymentDate) { this.paymentDate = paymentDate; }

    public String getTrackingNumber() { return trackingNumber; }
    public void setTrackingNumber(String trackingNumber) { this.trackingNumber = trackingNumber; }

    public String getShippingProvider() { return shippingProvider; }
    public void setShippingProvider(String shippingProvider) { this.shippingProvider = shippingProvider; }

    public LocalDateTime getShippedDate() { return shippedDate; }
    public void setShippedDate(LocalDateTime shippedDate) { this.shippedDate = shippedDate; }

    public LocalDateTime getDeliveredDate() { return deliveredDate; }
    public void setDeliveredDate(LocalDateTime deliveredDate) { this.deliveredDate = deliveredDate; }

    public LocalDateTime getExpectedDeliveryDate() { return expectedDeliveryDate; }
    public void setExpectedDeliveryDate(LocalDateTime expectedDeliveryDate) { this.expectedDeliveryDate = expectedDeliveryDate; }

    public String getCustomerNotes() { return customerNotes; }
    public void setCustomerNotes(String customerNotes) { this.customerNotes = customerNotes; }

    public String getAdminNotes() { return adminNotes; }
    public void setAdminNotes(String adminNotes) { this.adminNotes = adminNotes; }

    public String getCancellationReason() { return cancellationReason; }
    public void setCancellationReason(String cancellationReason) { this.cancellationReason = cancellationReason; }

    public LocalDateTime getCancelledAt() { return cancelledAt; }
    public void setCancelledAt(LocalDateTime cancelledAt) { this.cancelledAt = cancelledAt; }

    public String getRefundReference() { return refundReference; }
    public void setRefundReference(String refundReference) { this.refundReference = refundReference; }

    public BigDecimal getRefundAmount() { return refundAmount; }
    public void setRefundAmount(BigDecimal refundAmount) { this.refundAmount = refundAmount; }

    public LocalDateTime getRefundedAt() { return refundedAt; }
    public void setRefundedAt(LocalDateTime refundedAt) { this.refundedAt = refundedAt; }

    public String getInvoiceNumber() { return invoiceNumber; }
    public void setInvoiceNumber(String invoiceNumber) { this.invoiceNumber = invoiceNumber; }

    public String getInvoiceUrl() { return invoiceUrl; }
    public void setInvoiceUrl(String invoiceUrl) { this.invoiceUrl = invoiceUrl; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    // Enums
    public enum OrderStatus {
        PENDING("Pending"),
        CONFIRMED("Confirmed"),
        PROCESSING("Processing"),
        PACKED("Packed"),
        SHIPPED("Shipped"),
        OUT_FOR_DELIVERY("Out for Delivery"),
        DELIVERED("Delivered"),
        CANCELLED("Cancelled"),
        RETURNED("Returned"),
        REFUNDED("Refunded");

        private final String displayName;

        OrderStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    public enum PaymentStatus {
        PENDING("Pending"),
        PAID("Paid"),
        FAILED("Failed"),
        REFUNDED("Refunded"),
        PARTIALLY_REFUNDED("Partially Refunded"),
        COD_PENDING("COD Pending");

        private final String displayName;

        PaymentStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    public enum PaymentMethod {
        COD("Cash on Delivery"),
        RAZORPAY("Online Payment (Razorpay)"),
        UPI("UPI"),
        CARD("Debit/Credit Card"),
        NET_BANKING("Net Banking"),
        WALLET("Wallet");

        private final String displayName;

        PaymentMethod(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }
}
