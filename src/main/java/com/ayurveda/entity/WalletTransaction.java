package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "wallet_transactions")
public class WalletTransaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "wallet_id", nullable = false)
    private VendorWallet wallet;

    @Column(unique = true, nullable = false)
    private String transactionId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private TransactionType type;

    @Column(nullable = false)
    private BigDecimal amount;

    private BigDecimal commissionAmount; // If applicable

    private BigDecimal netAmount; // Amount after commission

    @Enumerated(EnumType.STRING)
    private TransactionStatus status = TransactionStatus.COMPLETED;

    @Column(columnDefinition = "TEXT")
    private String description;

    // Reference to related entities
    private Long orderId; // If related to an order

    private String orderNumber;

    // For payouts
    private String payoutReference; // Bank transaction reference

    private String payoutMethod; // Bank Transfer, UPI, etc.

    // Balance snapshot
    private BigDecimal balanceAfter; // Wallet balance after this transaction

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    public WalletTransaction() {}

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        if (transactionId == null) {
            transactionId = "TXN" + System.currentTimeMillis();
        }
        if (status == null) status = TransactionStatus.COMPLETED;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public VendorWallet getWallet() { return wallet; }
    public void setWallet(VendorWallet wallet) { this.wallet = wallet; }

    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

    public TransactionType getType() { return type; }
    public void setType(TransactionType type) { this.type = type; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public BigDecimal getCommissionAmount() { return commissionAmount; }
    public void setCommissionAmount(BigDecimal commissionAmount) { this.commissionAmount = commissionAmount; }

    public BigDecimal getNetAmount() { return netAmount; }
    public void setNetAmount(BigDecimal netAmount) { this.netAmount = netAmount; }

    public TransactionStatus getStatus() { return status; }
    public void setStatus(TransactionStatus status) { this.status = status; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Long getOrderId() { return orderId; }
    public void setOrderId(Long orderId) { this.orderId = orderId; }

    public String getOrderNumber() { return orderNumber; }
    public void setOrderNumber(String orderNumber) { this.orderNumber = orderNumber; }

    public String getPayoutReference() { return payoutReference; }
    public void setPayoutReference(String payoutReference) { this.payoutReference = payoutReference; }

    public String getPayoutMethod() { return payoutMethod; }
    public void setPayoutMethod(String payoutMethod) { this.payoutMethod = payoutMethod; }

    public BigDecimal getBalanceAfter() { return balanceAfter; }
    public void setBalanceAfter(BigDecimal balanceAfter) { this.balanceAfter = balanceAfter; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    // Enums
    public enum TransactionType {
        ORDER_CREDIT("Order Credit"),
        COMMISSION_DEDUCTION("Commission Deduction"),
        PAYOUT("Payout/Withdrawal"),
        REFUND_DEBIT("Refund Debit"),
        ADJUSTMENT("Adjustment"),
        BONUS("Bonus/Incentive");

        private final String displayName;

        TransactionType(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    public enum TransactionStatus {
        PENDING("Pending"),
        COMPLETED("Completed"),
        FAILED("Failed"),
        CANCELLED("Cancelled");

        private final String displayName;

        TransactionStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }
}

