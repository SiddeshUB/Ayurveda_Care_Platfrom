package com.ayurveda.repository;

import com.ayurveda.entity.Coupon;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface CouponRepository extends JpaRepository<Coupon, Long> {

    Optional<Coupon> findByCode(String code);

    boolean existsByCode(String code);

    // Active coupons
    List<Coupon> findByIsActiveTrueOrderByCreatedAtDesc();

    Page<Coupon> findByIsActiveTrue(Pageable pageable);

    // Valid coupons (active and within date range)
    @Query("SELECT c FROM Coupon c WHERE c.isActive = true AND " +
           "(c.startDate IS NULL OR c.startDate <= :now) AND " +
           "(c.endDate IS NULL OR c.endDate >= :now) AND " +
           "(c.usageLimit IS NULL OR c.usedCount < c.usageLimit)")
    List<Coupon> findValidCoupons(@Param("now") LocalDateTime now);

    // Find valid coupon by code
    @Query("SELECT c FROM Coupon c WHERE c.code = :code AND c.isActive = true AND " +
           "(c.startDate IS NULL OR c.startDate <= :now) AND " +
           "(c.endDate IS NULL OR c.endDate >= :now) AND " +
           "(c.usageLimit IS NULL OR c.usedCount < c.usageLimit)")
    Optional<Coupon> findValidCouponByCode(@Param("code") String code, @Param("now") LocalDateTime now);

    // Expired coupons
    @Query("SELECT c FROM Coupon c WHERE c.endDate < :now")
    List<Coupon> findExpiredCoupons(@Param("now") LocalDateTime now);

    // Coupons for first order
    List<Coupon> findByIsActiveTrueAndForFirstOrderOnlyTrue();

    // Coupons for new users
    List<Coupon> findByIsActiveTrueAndForNewUsersOnlyTrue();
}

