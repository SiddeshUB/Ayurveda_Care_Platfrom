package com.ayurveda.repository;

import com.ayurveda.entity.Vendor;
import com.ayurveda.entity.Vendor.VendorStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VendorRepository extends JpaRepository<Vendor, Long> {

    Optional<Vendor> findByEmail(String email);

    boolean existsByEmail(String email);

    boolean existsByGstNumber(String gstNumber);

    boolean existsByPanNumber(String panNumber);

    Optional<Vendor> findByEmailAndPassword(String email, String password);

    // Find by status
    List<Vendor> findByStatus(VendorStatus status);

    Page<Vendor> findByStatus(VendorStatus status, Pageable pageable);

    // Find active vendors
    List<Vendor> findByIsActiveTrue();

    Page<Vendor> findByIsActiveTrueAndStatus(VendorStatus status, Pageable pageable);

    // Search vendors
    @Query("SELECT v FROM Vendor v WHERE " +
           "(LOWER(v.businessName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(v.storeDisplayName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(v.ownerFullName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(v.email) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    Page<Vendor> searchVendors(@Param("keyword") String keyword, Pageable pageable);

    // Count by status
    long countByStatus(VendorStatus status);

    // Pending approvals count
    @Query("SELECT COUNT(v) FROM Vendor v WHERE v.status = 'PENDING'")
    long countPendingApprovals();

    // Find vendors with low-stock products
    @Query("SELECT DISTINCT v FROM Vendor v JOIN v.products p WHERE p.stockQuantity <= p.minStockLevel AND p.isActive = true")
    List<Vendor> findVendorsWithLowStockProducts();

    // Top vendors by revenue
    @Query("SELECT v FROM Vendor v WHERE v.isActive = true ORDER BY v.totalRevenue DESC")
    List<Vendor> findTopVendorsByRevenue(Pageable pageable);

    // Top vendors by orders
    @Query("SELECT v FROM Vendor v WHERE v.isActive = true ORDER BY v.totalOrders DESC")
    List<Vendor> findTopVendorsByOrders(Pageable pageable);
    
    Optional<Vendor> findByPasswordResetToken(String token);
}

