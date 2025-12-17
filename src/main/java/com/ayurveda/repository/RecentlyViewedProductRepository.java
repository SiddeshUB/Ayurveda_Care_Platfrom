package com.ayurveda.repository;

import com.ayurveda.entity.RecentlyViewedProduct;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RecentlyViewedProductRepository extends JpaRepository<RecentlyViewedProduct, Long> {
    
    List<RecentlyViewedProduct> findByUserIdOrderByViewedAtDesc(Long userId);
    
    @Query("SELECT rvp FROM RecentlyViewedProduct rvp WHERE rvp.user.id = :userId ORDER BY rvp.viewedAt DESC")
    List<RecentlyViewedProduct> findRecentByUserId(@Param("userId") Long userId);
    
    @Query("SELECT rvp FROM RecentlyViewedProduct rvp WHERE rvp.user.id = :userId ORDER BY rvp.viewedAt DESC LIMIT :limit")
    List<RecentlyViewedProduct> findRecentByUserIdLimit(@Param("userId") Long userId, @Param("limit") int limit);
    
    Optional<RecentlyViewedProduct> findByUserIdAndProductId(Long userId, Long productId);
    
    @Modifying
    @Query("DELETE FROM RecentlyViewedProduct rvp WHERE rvp.user.id = :userId AND rvp.product.id = :productId")
    void deleteByUserIdAndProductId(@Param("userId") Long userId, @Param("productId") Long productId);
    
    @Modifying
    @Query("DELETE FROM RecentlyViewedProduct rvp WHERE rvp.user.id = :userId AND rvp.viewedAt < :cutoffDate")
    void deleteOldViews(@Param("userId") Long userId, @Param("cutoffDate") java.time.LocalDateTime cutoffDate);
}

