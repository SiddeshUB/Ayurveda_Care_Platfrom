package com.ayurveda.repository;

import com.ayurveda.entity.WalletTransaction;
import com.ayurveda.entity.WalletTransaction.TransactionType;
import com.ayurveda.entity.WalletTransaction.TransactionStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface WalletTransactionRepository extends JpaRepository<WalletTransaction, Long> {

    Optional<WalletTransaction> findByTransactionId(String transactionId);

    // Find by wallet
    List<WalletTransaction> findByWalletIdOrderByCreatedAtDesc(Long walletId);

    Page<WalletTransaction> findByWalletId(Long walletId, Pageable pageable);

    // Find by wallet and type
    List<WalletTransaction> findByWalletIdAndTypeOrderByCreatedAtDesc(Long walletId, TransactionType type);

    // Find by wallet and date range
    @Query("SELECT t FROM WalletTransaction t WHERE t.wallet.id = :walletId AND t.createdAt BETWEEN :startDate AND :endDate ORDER BY t.createdAt DESC")
    List<WalletTransaction> findByWalletIdAndDateRange(@Param("walletId") Long walletId, 
                                                        @Param("startDate") LocalDateTime startDate, 
                                                        @Param("endDate") LocalDateTime endDate);

    // Sum by type for a wallet
    @Query("SELECT SUM(t.amount) FROM WalletTransaction t WHERE t.wallet.id = :walletId AND t.type = :type AND t.status = 'COMPLETED'")
    BigDecimal sumByWalletIdAndType(@Param("walletId") Long walletId, @Param("type") TransactionType type);

    // Find by order
    List<WalletTransaction> findByOrderIdOrderByCreatedAtDesc(Long orderId);

    // Pending payouts
    List<WalletTransaction> findByTypeAndStatusOrderByCreatedAtAsc(TransactionType type, TransactionStatus status);
}

