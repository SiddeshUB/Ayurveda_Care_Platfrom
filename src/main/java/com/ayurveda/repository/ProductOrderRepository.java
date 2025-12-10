package com.ayurveda.repository;

import com.ayurveda.entity.ProductOrder;
import com.ayurveda.entity.ProductOrder.OrderStatus;
import com.ayurveda.entity.ProductOrder.PaymentStatus;
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
public interface ProductOrderRepository extends JpaRepository<ProductOrder, Long> {

    // Find by user
    List<ProductOrder> findByUserId(Long userId);

    Page<ProductOrder> findByUserId(Long userId, Pageable pageable);

    List<ProductOrder> findByUserIdOrderByCreatedAtDesc(Long userId);

    // Find by order number
    Optional<ProductOrder> findByOrderNumber(String orderNumber);

    // Find by Razorpay order ID
    Optional<ProductOrder> findByRazorpayOrderId(String razorpayOrderId);

    // Find by status
    List<ProductOrder> findByStatus(OrderStatus status);

    Page<ProductOrder> findByStatus(OrderStatus status, Pageable pageable);

    List<ProductOrder> findByUserIdAndStatus(Long userId, OrderStatus status);

    // Find by payment status
    List<ProductOrder> findByPaymentStatus(PaymentStatus paymentStatus);

    // Find orders containing products from a vendor
    @Query("SELECT DISTINCT o FROM ProductOrder o JOIN o.orderItems oi WHERE oi.vendor.id = :vendorId ORDER BY o.createdAt DESC")
    List<ProductOrder> findByVendorId(@Param("vendorId") Long vendorId);

    @Query("SELECT DISTINCT o FROM ProductOrder o JOIN o.orderItems oi WHERE oi.vendor.id = :vendorId ORDER BY o.createdAt DESC")
    Page<ProductOrder> findByVendorId(@Param("vendorId") Long vendorId, Pageable pageable);

    // Count orders by user
    long countByUserId(Long userId);

    // Count by status
    long countByStatus(OrderStatus status);

    // Orders in date range
    @Query("SELECT o FROM ProductOrder o WHERE o.createdAt BETWEEN :startDate AND :endDate ORDER BY o.createdAt DESC")
    List<ProductOrder> findByDateRange(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

    // Recent orders
    @Query("SELECT o FROM ProductOrder o ORDER BY o.createdAt DESC")
    List<ProductOrder> findRecentOrders(Pageable pageable);

    // Total revenue
    @Query("SELECT SUM(o.totalAmount) FROM ProductOrder o WHERE o.paymentStatus = 'PAID'")
    BigDecimal getTotalRevenue();

    // Revenue in date range
    @Query("SELECT SUM(o.totalAmount) FROM ProductOrder o WHERE o.paymentStatus = 'PAID' AND o.createdAt BETWEEN :startDate AND :endDate")
    BigDecimal getRevenueInDateRange(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

    // Count orders in date range
    @Query("SELECT COUNT(o) FROM ProductOrder o WHERE o.createdAt BETWEEN :startDate AND :endDate")
    long countOrdersInDateRange(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

    // Pending orders count
    @Query("SELECT COUNT(o) FROM ProductOrder o WHERE o.status IN ('PENDING', 'CONFIRMED', 'PROCESSING')")
    long countPendingOrders();

    // Search orders
    @Query("SELECT o FROM ProductOrder o WHERE " +
           "LOWER(o.orderNumber) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(o.shippingName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(o.shippingEmail) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(o.shippingPhone) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    Page<ProductOrder> searchOrders(@Param("keyword") String keyword, Pageable pageable);
}
