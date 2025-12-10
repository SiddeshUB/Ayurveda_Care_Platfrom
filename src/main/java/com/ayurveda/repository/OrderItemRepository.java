package com.ayurveda.repository;

import com.ayurveda.entity.OrderItem;
import com.ayurveda.entity.OrderItem.ItemStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {

    // Find by order
    List<OrderItem> findByOrderId(Long orderId);

    // Find by vendor
    List<OrderItem> findByVendorIdOrderByOrderCreatedAtDesc(Long vendorId);

    Page<OrderItem> findByVendorId(Long vendorId, Pageable pageable);

    // Find by vendor and status
    List<OrderItem> findByVendorIdAndStatus(Long vendorId, ItemStatus status);

    // Find by product
    List<OrderItem> findByProductId(Long productId);

    // Count by vendor
    long countByVendorId(Long vendorId);

    // Vendor earnings
    @Query("SELECT SUM(oi.vendorEarning) FROM OrderItem oi WHERE oi.vendor.id = :vendorId AND oi.status = 'DELIVERED'")
    BigDecimal getTotalVendorEarnings(@Param("vendorId") Long vendorId);

    // Vendor commission paid
    @Query("SELECT SUM(oi.commissionAmount) FROM OrderItem oi WHERE oi.vendor.id = :vendorId AND oi.status = 'DELIVERED'")
    BigDecimal getTotalCommissionPaid(@Param("vendorId") Long vendorId);

    // Sales count by vendor
    @Query("SELECT SUM(oi.quantity) FROM OrderItem oi WHERE oi.vendor.id = :vendorId AND oi.status = 'DELIVERED'")
    Long getTotalSalesByVendor(@Param("vendorId") Long vendorId);

    // Vendor orders in date range
    @Query("SELECT oi FROM OrderItem oi WHERE oi.vendor.id = :vendorId AND oi.order.createdAt BETWEEN :startDate AND :endDate")
    List<OrderItem> findByVendorIdAndDateRange(@Param("vendorId") Long vendorId, 
                                                @Param("startDate") LocalDateTime startDate, 
                                                @Param("endDate") LocalDateTime endDate);

    // Best selling products for vendor
    @Query("SELECT oi.product.id, oi.productName, SUM(oi.quantity) as totalQty FROM OrderItem oi " +
           "WHERE oi.vendor.id = :vendorId AND oi.status = 'DELIVERED' " +
           "GROUP BY oi.product.id, oi.productName ORDER BY totalQty DESC")
    List<Object[]> findBestSellingProductsByVendor(@Param("vendorId") Long vendorId, Pageable pageable);

    // Platform total commission
    @Query("SELECT SUM(oi.commissionAmount) FROM OrderItem oi WHERE oi.status = 'DELIVERED'")
    BigDecimal getTotalPlatformCommission();
}
