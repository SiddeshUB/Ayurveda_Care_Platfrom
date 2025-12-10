package com.ayurveda.service;

import com.ayurveda.entity.Coupon;
import com.ayurveda.entity.Coupon.DiscountType;
import com.ayurveda.repository.CouponRepository;
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
public class CouponService {

    @Autowired
    private CouponRepository couponRepository;

    // ==================== CRUD Operations ====================

    public Coupon save(Coupon coupon) {
        return couponRepository.save(coupon);
    }

    public Optional<Coupon> findById(Long id) {
        return couponRepository.findById(id);
    }

    public Optional<Coupon> findByCode(String code) {
        return couponRepository.findByCode(code.toUpperCase());
    }

    public List<Coupon> findAll() {
        return couponRepository.findAll();
    }

    public Page<Coupon> findAll(Pageable pageable) {
        return couponRepository.findAll(pageable);
    }

    public void delete(Long id) {
        couponRepository.deleteById(id);
    }

    // ==================== Validation ====================

    public boolean existsByCode(String code) {
        return couponRepository.existsByCode(code.toUpperCase());
    }

    // ==================== Active Coupons ====================

    public List<Coupon> findActiveCoupons() {
        return couponRepository.findByIsActiveTrueOrderByCreatedAtDesc();
    }

    public List<Coupon> findValidCoupons() {
        return couponRepository.findValidCoupons(LocalDateTime.now());
    }

    // ==================== Apply Coupon ====================

    public CouponValidationResult validateCoupon(String code, BigDecimal orderAmount, 
                                                  Long userId, boolean isFirstOrder, boolean isNewUser) {
        CouponValidationResult result = new CouponValidationResult();

        Optional<Coupon> couponOpt = couponRepository.findValidCouponByCode(code.toUpperCase(), LocalDateTime.now());

        if (couponOpt.isEmpty()) {
            result.setValid(false);
            result.setMessage("Invalid or expired coupon code");
            return result;
        }

        Coupon coupon = couponOpt.get();

        // Check minimum order amount
        if (coupon.getMinOrderAmount() != null && orderAmount.compareTo(coupon.getMinOrderAmount()) < 0) {
            result.setValid(false);
            result.setMessage("Minimum order amount of ₹" + coupon.getMinOrderAmount() + " required");
            return result;
        }

        // Check first order only
        if (coupon.getForFirstOrderOnly() && !isFirstOrder) {
            result.setValid(false);
            result.setMessage("This coupon is valid for first order only");
            return result;
        }

        // Check new users only
        if (coupon.getForNewUsersOnly() && !isNewUser) {
            result.setValid(false);
            result.setMessage("This coupon is valid for new users only");
            return result;
        }

        // TODO: Check per-user usage limit

        // Calculate discount
        BigDecimal discount = coupon.calculateDiscount(orderAmount);

        result.setValid(true);
        result.setCoupon(coupon);
        result.setDiscount(discount);
        result.setMessage("Coupon applied successfully! You saved ₹" + discount);

        return result;
    }

    public BigDecimal applyCoupon(String code, BigDecimal orderAmount) {
        Optional<Coupon> couponOpt = couponRepository.findValidCouponByCode(code.toUpperCase(), LocalDateTime.now());

        if (couponOpt.isEmpty()) {
            return BigDecimal.ZERO;
        }

        Coupon coupon = couponOpt.get();

        // Check minimum order amount
        if (coupon.getMinOrderAmount() != null && orderAmount.compareTo(coupon.getMinOrderAmount()) < 0) {
            return BigDecimal.ZERO;
        }

        return coupon.calculateDiscount(orderAmount);
    }

    public void incrementUsage(String code) {
        Optional<Coupon> couponOpt = couponRepository.findByCode(code.toUpperCase());
        if (couponOpt.isPresent()) {
            Coupon coupon = couponOpt.get();
            coupon.setUsedCount(coupon.getUsedCount() + 1);
            couponRepository.save(coupon);
        }
    }

    // ==================== Toggle Status ====================

    public Coupon toggleActive(Long couponId) {
        Coupon coupon = couponRepository.findById(couponId)
                .orElseThrow(() -> new RuntimeException("Coupon not found"));
        coupon.setIsActive(!coupon.getIsActive());
        return couponRepository.save(coupon);
    }

    // ==================== Special Coupons ====================

    public List<Coupon> getFirstOrderCoupons() {
        return couponRepository.findByIsActiveTrueAndForFirstOrderOnlyTrue();
    }

    public List<Coupon> getNewUserCoupons() {
        return couponRepository.findByIsActiveTrueAndForNewUsersOnlyTrue();
    }

    // ==================== Expired Coupons ====================

    public List<Coupon> getExpiredCoupons() {
        return couponRepository.findExpiredCoupons(LocalDateTime.now());
    }

    // ==================== Result Class ====================

    public static class CouponValidationResult {
        private boolean valid;
        private String message;
        private Coupon coupon;
        private BigDecimal discount;

        public boolean isValid() { return valid; }
        public void setValid(boolean valid) { this.valid = valid; }

        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }

        public Coupon getCoupon() { return coupon; }
        public void setCoupon(Coupon coupon) { this.coupon = coupon; }

        public BigDecimal getDiscount() { return discount; }
        public void setDiscount(BigDecimal discount) { this.discount = discount; }
    }
}

