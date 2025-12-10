package com.ayurveda.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "vendor_wallets")
public class VendorWallet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id", nullable = false, unique = true)
    private Vendor vendor;

    // Current balance available for payout
    @Column(nullable = false)
    private BigDecimal availableBalance = BigDecimal.ZERO;

    // Pending balance (orders not yet delivered/completed)
    private BigDecimal pendingBalance = BigDecimal.ZERO;

    // Total earnings (lifetime)
    private BigDecimal totalEarnings = BigDecimal.ZERO;

    // Total commission deducted (lifetime)
    private BigDecimal totalCommissionDeducted = BigDecimal.ZERO;

    // Total amount withdrawn (lifetime)
    private BigDecimal totalWithdrawn = BigDecimal.ZERO;

    // Last payout info
    private LocalDateTime lastPayoutDate;

    private BigDecimal lastPayoutAmount;

    // Timestamps
    @Column(updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    // Transactions
    @OneToMany(mappedBy = "wallet", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<WalletTransaction> transactions;

    public VendorWallet() {}

    public VendorWallet(Vendor vendor) {
        this.vendor = vendor;
    }

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (availableBalance == null) availableBalance = BigDecimal.ZERO;
        if (pendingBalance == null) pendingBalance = BigDecimal.ZERO;
        if (totalEarnings == null) totalEarnings = BigDecimal.ZERO;
        if (totalCommissionDeducted == null) totalCommissionDeducted = BigDecimal.ZERO;
        if (totalWithdrawn == null) totalWithdrawn = BigDecimal.ZERO;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Helper methods
    public void addPendingBalance(BigDecimal amount) {
        this.pendingBalance = this.pendingBalance.add(amount);
    }

    public void releasePendingToAvailable(BigDecimal amount) {
        this.pendingBalance = this.pendingBalance.subtract(amount);
        this.availableBalance = this.availableBalance.add(amount);
        this.totalEarnings = this.totalEarnings.add(amount);
    }

    public void deductCommission(BigDecimal commission) {
        this.totalCommissionDeducted = this.totalCommissionDeducted.add(commission);
    }

    public void processWithdrawal(BigDecimal amount) {
        this.availableBalance = this.availableBalance.subtract(amount);
        this.totalWithdrawn = this.totalWithdrawn.add(amount);
        this.lastPayoutDate = LocalDateTime.now();
        this.lastPayoutAmount = amount;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Vendor getVendor() { return vendor; }
    public void setVendor(Vendor vendor) { this.vendor = vendor; }

    public BigDecimal getAvailableBalance() { return availableBalance; }
    public void setAvailableBalance(BigDecimal availableBalance) { this.availableBalance = availableBalance; }

    public BigDecimal getPendingBalance() { return pendingBalance; }
    public void setPendingBalance(BigDecimal pendingBalance) { this.pendingBalance = pendingBalance; }

    public BigDecimal getTotalEarnings() { return totalEarnings; }
    public void setTotalEarnings(BigDecimal totalEarnings) { this.totalEarnings = totalEarnings; }

    public BigDecimal getTotalCommissionDeducted() { return totalCommissionDeducted; }
    public void setTotalCommissionDeducted(BigDecimal totalCommissionDeducted) { this.totalCommissionDeducted = totalCommissionDeducted; }

    public BigDecimal getTotalWithdrawn() { return totalWithdrawn; }
    public void setTotalWithdrawn(BigDecimal totalWithdrawn) { this.totalWithdrawn = totalWithdrawn; }

    public LocalDateTime getLastPayoutDate() { return lastPayoutDate; }
    public void setLastPayoutDate(LocalDateTime lastPayoutDate) { this.lastPayoutDate = lastPayoutDate; }

    public BigDecimal getLastPayoutAmount() { return lastPayoutAmount; }
    public void setLastPayoutAmount(BigDecimal lastPayoutAmount) { this.lastPayoutAmount = lastPayoutAmount; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public List<WalletTransaction> getTransactions() { return transactions; }
    public void setTransactions(List<WalletTransaction> transactions) { this.transactions = transactions; }
}

