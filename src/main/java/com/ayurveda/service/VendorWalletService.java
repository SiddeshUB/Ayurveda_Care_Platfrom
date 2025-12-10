package com.ayurveda.service;

import com.ayurveda.entity.Vendor;
import com.ayurveda.entity.VendorWallet;
import com.ayurveda.entity.WalletTransaction;
import com.ayurveda.entity.WalletTransaction.TransactionType;
import com.ayurveda.entity.WalletTransaction.TransactionStatus;
import com.ayurveda.repository.VendorWalletRepository;
import com.ayurveda.repository.WalletTransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class VendorWalletService {

    @Autowired
    private VendorWalletRepository walletRepository;

    @Autowired
    private WalletTransactionRepository transactionRepository;

    // ==================== Get Wallet ====================

    public VendorWallet getOrCreateWallet(Vendor vendor) {
        return walletRepository.findByVendorId(vendor.getId())
                .orElseGet(() -> {
                    VendorWallet wallet = new VendorWallet(vendor);
                    return walletRepository.save(wallet);
                });
    }

    public Optional<VendorWallet> getWallet(Long vendorId) {
        return walletRepository.findByVendorId(vendorId);
    }

    // ==================== Credit Operations ====================

    public void creditPendingBalance(Long vendorId, BigDecimal amount, BigDecimal commission, 
                                     Long orderId, String orderNumber) {
        VendorWallet wallet = walletRepository.findByVendorId(vendorId)
                .orElseThrow(() -> new RuntimeException("Wallet not found"));

        // Add to pending balance (released after delivery)
        wallet.addPendingBalance(amount);

        // Record commission
        if (commission != null) {
            wallet.deductCommission(commission);
        }

        walletRepository.save(wallet);

        // Create transaction record
        WalletTransaction transaction = new WalletTransaction();
        transaction.setWallet(wallet);
        transaction.setType(TransactionType.ORDER_CREDIT);
        transaction.setAmount(amount.add(commission != null ? commission : BigDecimal.ZERO));
        transaction.setCommissionAmount(commission);
        transaction.setNetAmount(amount);
        transaction.setStatus(TransactionStatus.PENDING);
        transaction.setDescription("Order credit (pending delivery) - " + orderNumber);
        transaction.setOrderId(orderId);
        transaction.setOrderNumber(orderNumber);
        transaction.setBalanceAfter(wallet.getAvailableBalance());

        transactionRepository.save(transaction);
    }

    public void releasePendingBalance(Long vendorId, BigDecimal amount, Long orderId) {
        VendorWallet wallet = walletRepository.findByVendorId(vendorId)
                .orElseThrow(() -> new RuntimeException("Wallet not found"));

        // Move from pending to available
        wallet.releasePendingToAvailable(amount);
        walletRepository.save(wallet);

        // Update transaction status
        List<WalletTransaction> transactions = transactionRepository.findByOrderIdOrderByCreatedAtDesc(orderId);
        for (WalletTransaction txn : transactions) {
            if (txn.getWallet().getId().equals(wallet.getId()) && 
                txn.getStatus() == TransactionStatus.PENDING) {
                txn.setStatus(TransactionStatus.COMPLETED);
                txn.setBalanceAfter(wallet.getAvailableBalance());
                txn.setDescription(txn.getDescription().replace("(pending delivery)", "(delivered)"));
                transactionRepository.save(txn);
            }
        }
    }

    // ==================== Debit Operations ====================

    public boolean processWithdrawal(Long vendorId, BigDecimal amount, String payoutMethod, String payoutReference) {
        VendorWallet wallet = walletRepository.findByVendorId(vendorId)
                .orElseThrow(() -> new RuntimeException("Wallet not found"));

        // Check available balance
        if (wallet.getAvailableBalance().compareTo(amount) < 0) {
            throw new RuntimeException("Insufficient balance");
        }

        // Process withdrawal
        wallet.processWithdrawal(amount);
        walletRepository.save(wallet);

        // Create transaction record
        WalletTransaction transaction = new WalletTransaction();
        transaction.setWallet(wallet);
        transaction.setType(TransactionType.PAYOUT);
        transaction.setAmount(amount);
        transaction.setNetAmount(amount);
        transaction.setStatus(TransactionStatus.COMPLETED);
        transaction.setDescription("Payout to bank account");
        transaction.setPayoutMethod(payoutMethod);
        transaction.setPayoutReference(payoutReference);
        transaction.setBalanceAfter(wallet.getAvailableBalance());

        transactionRepository.save(transaction);

        return true;
    }

    public void processRefundDebit(Long vendorId, BigDecimal amount, Long orderId, String orderNumber) {
        VendorWallet wallet = walletRepository.findByVendorId(vendorId)
                .orElseThrow(() -> new RuntimeException("Wallet not found"));

        // Deduct from available balance
        wallet.setAvailableBalance(wallet.getAvailableBalance().subtract(amount));
        if (wallet.getAvailableBalance().compareTo(BigDecimal.ZERO) < 0) {
            wallet.setAvailableBalance(BigDecimal.ZERO);
        }
        walletRepository.save(wallet);

        // Create transaction record
        WalletTransaction transaction = new WalletTransaction();
        transaction.setWallet(wallet);
        transaction.setType(TransactionType.REFUND_DEBIT);
        transaction.setAmount(amount);
        transaction.setNetAmount(amount);
        transaction.setStatus(TransactionStatus.COMPLETED);
        transaction.setDescription("Refund debit for order - " + orderNumber);
        transaction.setOrderId(orderId);
        transaction.setOrderNumber(orderNumber);
        transaction.setBalanceAfter(wallet.getAvailableBalance());

        transactionRepository.save(transaction);
    }

    // ==================== Transactions ====================

    public List<WalletTransaction> getTransactions(Long walletId) {
        return transactionRepository.findByWalletIdOrderByCreatedAtDesc(walletId);
    }

    public Page<WalletTransaction> getTransactions(Long walletId, Pageable pageable) {
        return transactionRepository.findByWalletId(walletId, pageable);
    }

    public List<WalletTransaction> getTransactionsByType(Long walletId, TransactionType type) {
        return transactionRepository.findByWalletIdAndTypeOrderByCreatedAtDesc(walletId, type);
    }

    public List<WalletTransaction> getTransactionsInDateRange(Long walletId, 
                                                               LocalDateTime startDate, 
                                                               LocalDateTime endDate) {
        return transactionRepository.findByWalletIdAndDateRange(walletId, startDate, endDate);
    }

    // ==================== Statistics ====================

    public BigDecimal getTotalEarnings(Long walletId, TransactionType type) {
        BigDecimal sum = transactionRepository.sumByWalletIdAndType(walletId, type);
        return sum != null ? sum : BigDecimal.ZERO;
    }

    public BigDecimal getTotalPlatformEarnings() {
        BigDecimal total = walletRepository.getTotalPlatformEarnings();
        return total != null ? total : BigDecimal.ZERO;
    }

    public BigDecimal getTotalVendorPayouts() {
        BigDecimal total = walletRepository.getTotalVendorPayouts();
        return total != null ? total : BigDecimal.ZERO;
    }

    public BigDecimal getTotalPendingBalance() {
        BigDecimal total = walletRepository.getTotalPendingBalance();
        return total != null ? total : BigDecimal.ZERO;
    }

    // ==================== Payout Processing ====================

    public List<VendorWallet> getWalletsReadyForPayout(BigDecimal threshold) {
        return walletRepository.findWalletsAboveThreshold(threshold);
    }

    // ==================== Credit Vendor Wallets for Order ====================

    public void creditVendorWallets(com.ayurveda.entity.ProductOrder order) {
        if (order.getOrderItems() == null || order.getOrderItems().isEmpty()) {
            return;
        }

        for (com.ayurveda.entity.OrderItem item : order.getOrderItems()) {
            if (item.getVendor() != null) {
                BigDecimal vendorEarning = item.getVendorEarning();
                BigDecimal commission = item.getCommissionAmount();
                
                creditPendingBalance(
                    item.getVendor().getId(),
                    vendorEarning,
                    commission,
                    order.getId(),
                    order.getOrderNumber()
                );
            }
        }
    }
}

