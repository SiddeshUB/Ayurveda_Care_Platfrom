package com.ayurveda.repository;

import com.ayurveda.entity.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {

    // Find cart items by user
    List<Cart> findByUserIdOrderByCreatedAtDesc(Long userId);

    // Find active cart items (not saved for later)
    List<Cart> findByUserIdAndSavedForLaterFalseOrderByCreatedAtDesc(Long userId);

    // Find saved for later items
    List<Cart> findByUserIdAndSavedForLaterTrueOrderByCreatedAtDesc(Long userId);

    // Find by user and product
    Optional<Cart> findByUserIdAndProductId(Long userId, Long productId);

    // Check if product is in user's cart
    boolean existsByUserIdAndProductId(Long userId, Long productId);

    // Count items in cart
    long countByUserId(Long userId);

    long countByUserIdAndSavedForLaterFalse(Long userId);

    // Get cart total
    @Query("SELECT SUM(c.totalPrice) FROM Cart c WHERE c.user.id = :userId AND c.savedForLater = false")
    BigDecimal getCartTotal(@Param("userId") Long userId);

    // Delete cart item
    @Modifying
    void deleteByUserIdAndProductId(Long userId, Long productId);

    // Clear user cart
    @Modifying
    @Query("DELETE FROM Cart c WHERE c.user.id = :userId AND c.savedForLater = false")
    void clearUserCart(@Param("userId") Long userId);

    // Clear all items
    @Modifying
    void deleteByUserId(Long userId);

    // Find by vendor (for vendor-specific cart views)
    List<Cart> findByUserIdAndVendorIdAndSavedForLaterFalse(Long userId, Long vendorId);

    // Group cart by vendor
    @Query("SELECT c.vendor.id, COUNT(c), SUM(c.totalPrice) FROM Cart c WHERE c.user.id = :userId AND c.savedForLater = false GROUP BY c.vendor.id")
    List<Object[]> getCartGroupedByVendor(@Param("userId") Long userId);
}
