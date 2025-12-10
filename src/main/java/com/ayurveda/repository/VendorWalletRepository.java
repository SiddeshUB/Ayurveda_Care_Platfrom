package com.ayurveda.repository;

import com.ayurveda.entity.VendorWallet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Optional;

@Repository
public interface VendorWalletRepository extends JpaRepository<VendorWallet, Long> {

    Optional<VendorWallet> findByVendorId(Long vendorId);

    boolean existsByVendorId(Long vendorId);

    // Total platform earnings
    @Query("SELECT SUM(w.totalCommissionDeducted) FROM VendorWallet w")
    BigDecimal getTotalPlatformEarnings();

    // Total vendor payouts
    @Query("SELECT SUM(w.totalWithdrawn) FROM VendorWallet w")
    BigDecimal getTotalVendorPayouts();

    // Total pending balance across all vendors
    @Query("SELECT SUM(w.pendingBalance) FROM VendorWallet w")
    BigDecimal getTotalPendingBalance();

    // Vendors with balance above threshold
    @Query("SELECT w FROM VendorWallet w WHERE w.availableBalance >= :threshold")
    java.util.List<VendorWallet> findWalletsAboveThreshold(@Param("threshold") BigDecimal threshold);
}

